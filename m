Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5137580A68A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574136AbjLHPGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574121AbjLHPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:06:19 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDF2122;
        Fri,  8 Dec 2023 07:06:24 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCDF440007;
        Fri,  8 Dec 2023 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702047983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IXV0DYoRQotwA20i111wDe8hYdhC1f2YduLzVN5R2tA=;
        b=j5tsOrKqA3qIr0oG1AwXQOLwYrcPTn0nWpWWO3ojA1yo09CuZ9qq1egetdd/dkHRro9N1T
        6RKjzZQFqMTSyRWZHgSIEWlmUeOREkfmG2yLumqmBgPF4vHMr7eCldF0hLZFDDTykXxeTT
        TRhQU6TNSpZmQ2DThOmorRfTwvM2hTez3C2AW9I239Vcqz5yy1ybTzpUMFT1gxsQSDHndX
        irJRO9VpWe+x2qwqP2rLgnUpZYEzzHIbQcmNPt36O9zw8er7FKR53Gi3hlkxOJxMozl9uT
        /QeJF6RnL+/qkv6Tk0ozl4k7w28T2FE5k4mlUzmdSvQe1aKI+jWuTI5cEv1lfQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Marvell MBus driver to Marvell EBU
 SoCs support
In-Reply-To: <20231121093414.11926-1-lukas.bulwahn@gmail.com>
References: <20231121093414.11926-1-lukas.bulwahn@gmail.com>
Date:   Fri, 08 Dec 2023 16:06:21 +0100
Message-ID: <87cyvgente.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> While doing some code cleanup in drivers/bus/, I noticed that the file
> drivers/bus/mvebu-mbus.c has no maintainer.
>
> Although the file has not been touched a lot lately, the git history tells
> us that Gregory Clement and Andrew Lunn integrated patches specific to
> this driver code. Further, the driver's config depends on config
> PLAT_ORION, and the code for this platform is defined in
> arch/arm/plat-orion/, which is part of ARM/Marvell Dove/MV78xx0/Orion SOC
> support with Gregory and Andrew already being its maintainer.
>
> Add drivers/bus/mvebu-mbus.c to ARM/Marvell Dove/MV78xx0/Orion SOC support.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied on mvebu/arm

Thanks,

Gregory
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9cbf6e353bd..9613c9c3cc97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2317,6 +2317,7 @@ F:	arch/arm/mach-dove/
>  F:	arch/arm/mach-mv78xx0/
>  F:	arch/arm/mach-orion5x/
>  F:	arch/arm/plat-orion/
> +F:	drivers/bus/mvebu-mbus.c
>  F:	drivers/soc/dove/
>  
>  ARM/Marvell Kirkwood and Armada 370, 375, 38x, 39x, XP, 3700, 7K/8K, CN9130 SOC support
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
