Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F72A762829
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGZBbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGZBbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:31:18 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF102699
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:31:09 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8D27124E207;
        Wed, 26 Jul 2023 09:31:01 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Jul
 2023 09:31:01 +0800
Received: from [192.168.125.107] (183.27.99.135) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Jul
 2023 09:31:00 +0800
Message-ID: <cbc5b6e6-c706-b251-9a8e-0eecbc9871a8@starfivetech.com>
Date:   Wed, 26 Jul 2023 09:30:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] phy: starfive: StarFive PHYs should depend on
 ARCH_STARFIVE
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Roger Quadros <rogerq@kernel.org>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <12097f6107a18e2f7cfb80f47ac7b27808e062c4.1690300076.git.geert+renesas@glider.be>
Content-Language: en-US
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <12097f6107a18e2f7cfb80f47ac7b27808e062c4.1690300076.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.99.135]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/25 23:49, Geert Uytterhoeven wrote:
> The various StarFive PHYs are only present on StarFive SoCs.  Hence add
> a dependency on ARCH_STARFIVE, to prevent asking the user about these
> drivers when configuring a kernel without StarFive SoC support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/phy/starfive/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
> index a560533a674ee0a5..4457b3872aa146a4 100644
> --- a/drivers/phy/starfive/Kconfig
> +++ b/drivers/phy/starfive/Kconfig
> @@ -3,6 +3,8 @@
>  # Phy drivers for StarFive platforms
>  #
>  
> +if ARCH_STARFIVE || COMPILE_TEST
> +
>  config PHY_STARFIVE_JH7110_DPHY_RX
>  	tristate "StarFive JH7110 D-PHY RX support"
>  	select GENERIC_PHY
> @@ -31,3 +33,5 @@ config PHY_STARFIVE_JH7110_USB
>  	  used with the Cadence USB controller.
>  	  If M is selected, the module will be called
>  	  phy-jh7110-usb.ko.
> +
> +endif # ARCH_STARFIVE || COMPILE_TEST

For dphy rx parts:

Acked-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Thanks,
Changhuang
