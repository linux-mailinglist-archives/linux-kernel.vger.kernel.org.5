Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039D67EE772
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345499AbjKPT0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPT0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:26:22 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FD718B;
        Thu, 16 Nov 2023 11:26:19 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-58a03280aa7so605938eaf.2;
        Thu, 16 Nov 2023 11:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162779; x=1700767579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcZwCjQ4JrwVYAwfxeJR9lgNCrE0p4rX4/iJLdX3krg=;
        b=cBbHgrjsn2cgwriS1aEZmiLxvQtQ8xe80S4I9Lxt5BX4I+oDMudrXpb4dKd2cSmXIb
         Z1wF20eQE4zYW9tXVR2py9r737ciyWqfOW5DRBKQZTMIrtRcYh5ED5gaq1BFIjP6QpYu
         Z2pM/js86S6vUWalkwdFol9YQbRZKke4Tr88D1zqyPTXFwv9RKTDTOJ7AAsXLFVoXmft
         vBuHQVer0PevGvPwJM2c+SRcilTE63wWz12XwDOFjwKcF/bm27UMW6rDu8ijC2cH7b82
         CBJV5GLlQIWdaBqYQiSh85vIE5Jy0I3nxabeePItJgg5TmNq8hPmJZZ1IrL35Ejpwot8
         cTkQ==
X-Gm-Message-State: AOJu0YzRHzm3BmKWlNnCOdDRfbvoTRB99BPMoUudQ3cYa7iAfNnGgehK
        P7MLc20NnYWu4YDxNFZ14Q==
X-Google-Smtp-Source: AGHT+IGSTth+hP2mmYGFO8yjKtjUWI7ZiE2Wb5+MqaNsG99C+yIPf6hkTRBp8Wbxr+QbyVOYwjXPNQ==
X-Received: by 2002:a4a:9181:0:b0:589:d6c7:8573 with SMTP id d1-20020a4a9181000000b00589d6c78573mr16344725ooh.3.1700162778694;
        Thu, 16 Nov 2023 11:26:18 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a2-20020a4a9882000000b0057b74352e3asm12380ooj.25.2023.11.16.11.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:26:18 -0800 (PST)
Received: (nullmailer pid 3049422 invoked by uid 1000);
        Thu, 16 Nov 2023 19:26:16 -0000
Date:   Thu, 16 Nov 2023 13:26:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Yan <andyshrk@163.com>
Cc:     robh+dt@kernel.org, sebastian.reichel@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>, hjc@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, chris.obbard@collabora.com,
        s.hauer@pengutronix.de, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, kever.yang@rock-chips.com
Subject: Re: [PATCH 07/11] dt-bindings: soc: rockchip: add rk3588 vop/vo
 syscon
Message-ID: <170016277633.3049138.9769922490771899888.robh@kernel.org>
References: <20231114112534.1770731-1-andyshrk@163.com>
 <20231114112820.1771240-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114112820.1771240-1-andyshrk@163.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Nov 2023 19:28:20 +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Add VOP and VO GRF syscon compatibles for RK3588
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

