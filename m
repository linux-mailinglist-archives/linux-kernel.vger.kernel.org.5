Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7959F7F06F0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 15:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjKSOk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 09:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjKSOkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 09:40:47 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B515F2;
        Sun, 19 Nov 2023 06:40:44 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c79d8b67f3so43499781fa.0;
        Sun, 19 Nov 2023 06:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700404842; x=1701009642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5ZI6+aQ9+c+bpfwBYIcSU777SeZBaK2MLQMxaHGRpFI=;
        b=OiEUm9QFSNEg91mUf5F9nvElGp3BqlxbGkMmoFkVZQjSIl3Cc+J6oI+PYFjH1Yktft
         8cocuDDr8/2JOlz+29xLDOOa+6GFXgui9m9qNzQ4xE6yIj+6kMwtm8pzOIQik5pefzrk
         jJZMolZ/D5RdutkZGDc83NluZUstx4LSLRHfJmO7w6fSNl6za5wBD6cqsN5vbngXlDy6
         TvdyhfaTEsZn63URdl8r0MqG7f2g+eSUwiMGctTO+arwKgvYOuXjxj7VEoai0cSAuzEK
         8KPoynhIVv+iQOfzLbLlnAJkzdtKsq4f6xLPCfpVHpKcRtY8Npc4aQLD6+epgi3lQ41f
         FTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700404842; x=1701009642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZI6+aQ9+c+bpfwBYIcSU777SeZBaK2MLQMxaHGRpFI=;
        b=bD79H/fpnTiv5p+vtxExhG3uWKzfEk/OQksRjR8/K8nhOOrrpd5Jkc0ORrXy9O27T0
         rILJwr7T8/gxfEO0mq0jNYWa9b3QrxnKwe3q1SrDQlihDT58SfY9Kpg4uSkuXCum/nLz
         /NFIy3naX3+By2O5zamkuEywdNVlhR/sQ6Ufa1uGzSnbyCXWo/3cgff9ET1r79kRQ49U
         0p6LZ1BNZwVFeIfBhd1ekew2no5PRVeZTwjN01CjdVilD0gvIDkGUPcGRdpZTiHZK050
         Pvi27AaezJKBDbbRzBRyb+4RbIn6idVlEiOPHueIwvvyaM90SmSCo1cxQFKuBpSgTnDN
         zbqA==
X-Gm-Message-State: AOJu0Yzb+evu48fuN3kl8OjgVnYZ7uW0Pn0ZdLpQliqJkXPQSeT2dsXg
        3FYaz9lpaxZ1gINn0+fjK4E=
X-Google-Smtp-Source: AGHT+IGz3Am6v44VUwMqk25WU74XtddrbbJsFHcdTLt3huXceX43GKRCbBwubtG0I1e4Th/6uBbTrg==
X-Received: by 2002:a2e:2245:0:b0:2c8:713c:b506 with SMTP id i66-20020a2e2245000000b002c8713cb506mr3263978lji.43.1700404842251;
        Sun, 19 Nov 2023 06:40:42 -0800 (PST)
Received: from skbuf ([188.26.185.114])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c348300b0040a5e69482esm14598744wmq.11.2023.11.19.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 06:40:42 -0800 (PST)
Date:   Sun, 19 Nov 2023 16:40:39 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 02/15] net: dsa: mt7530: use p5_interface_select
 as data type for p5_intf_sel
Message-ID: <20231119144039.gvbima26zhktf6bd@skbuf>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-3-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231118123205.266819-3-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 03:31:52PM +0300, Arınç ÜNAL wrote:
> Use the p5_interface_select enumeration as the data type for the
> p5_intf_sel field. This ensures p5_intf_sel can only take the values
> defined in the p5_interface_select enumeration.
> 
> Remove the explicit assignment of 0 to P5_DISABLED as the first enum item
> is automatically assigned 0.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
