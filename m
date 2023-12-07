Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C93809200
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443854AbjLGUBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:01:31 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CC510F7;
        Thu,  7 Dec 2023 12:01:37 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1db6c63028so151999266b.2;
        Thu, 07 Dec 2023 12:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701979296; x=1702584096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxKQalM2XsdeZ6LbLxJy5cCkk6wpAYdzkOBgji/EH9U=;
        b=M3+sAbO47F8/nZw15naHvPabJAA5sCwgIl9JssmMSOCImtRdnPxLqX630boLHzVbZ9
         5ylt2/cfAtUYEwzUDN2LNPRG8yCv8oy1B4NJdFtmrILYGsqMD06Lx8UqEPSfiPlqzlpf
         45vnBiWFXyDbtOmIqZZoewD2aCTp6X+pckrOMXnU8yxn5KwzsCUaX7BoVfzte0rjZP5d
         +SjQVa1VN6oU17j9gBkvUJFidutekc4j52PC17xhTQShq72ewPwwK/Tj6tHLsrNDiB3f
         /f5CpItUA2zAvkGW7nETL5EoFCvWTTQhl79+L+hs1MLp1Yqkce9tkEzy0yIxDRDaJKMN
         qYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701979296; x=1702584096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxKQalM2XsdeZ6LbLxJy5cCkk6wpAYdzkOBgji/EH9U=;
        b=VtLX7+8KPcme3ILX9LUPpcGQ9dwGfthB38WK30fJtev0HZm6ro3Em/fyLRoCzJBrxr
         M76LhWp8niRV0nD2q3PMOn0FuAK6Tva2vDnLFjXX0YIG0H86yvID6N6N5pE4efc0tFI4
         n2ltekANdpobfXP7dAdWiUqw7FaPJiGeqySXkkS/DupzK73ogEx7CGeWnNOLJNtS2Fcp
         AqI3xORF8zrEBgwUpKKgEBCEV0h1Ehm4LJasQbMzMIKle2AjoBe/H6HZwuGmnxHup8nV
         PNSKaAcc6vEXgAn0MNkB+jAphbHojtg7UNSz6+/6X2SMOWycXlxGY0jgp+Kddjfz16Ov
         KeOQ==
X-Gm-Message-State: AOJu0YzbT64rQO4InonWCSpOCXH5l4GwXfM/rMKi3038OwE1EIte5/yx
        tjfcfYsl7FHxm2LMprCQbBI=
X-Google-Smtp-Source: AGHT+IHjp1aCJEXZp+EHs5Gft8fX73EKJgH1YZLg6gizzxEd99zvXmS2xooHm5ZJUX0mJmsyTvN7pQ==
X-Received: by 2002:a17:906:5185:b0:a19:a19a:ea9a with SMTP id y5-20020a170906518500b00a19a19aea9amr1705134ejk.83.1701979295685;
        Thu, 07 Dec 2023 12:01:35 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id cu12-20020a170906ba8c00b00a10f3030e11sm141937ejd.1.2023.12.07.12.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:01:35 -0800 (PST)
Date:   Thu, 7 Dec 2023 22:01:32 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <horms@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
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
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Message-ID: <20231207200132.772h3t3l6coan6ht@skbuf>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-8-arinc.unal@arinc9.com>
 <20231121185358.GA16629@kernel.org>
 <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
 <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
 <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 08:40:15PM +0200, Vladimir Oltean wrote:
> Also, reducing the indentation level of for_each_child_of_node() by one
> can't be bad. Maybe even by more. There's this pattern:
> 
> for_each_child_of_node(dn, mac_np) {
> 	// do stuff with mac_np
> 	break;
> }
> 
> aka we only care about the first child of dn. We could find the mac_np
> as the only operation inside for_each_child_of_node(), break directly,
> and "do stuff with mac_np" could be done outside, further reducing the
> indentation by 1 level.

I noticed just now that there is further filtering on the child OF node
by of_device_is_compatible(). In that case, of_get_compatible_child()
could be used to eliminate for_each_child_of_node() completely.
