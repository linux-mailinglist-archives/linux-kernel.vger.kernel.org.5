Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11302784ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjHWCp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjHWCpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:45:22 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B7D1A5;
        Tue, 22 Aug 2023 19:45:20 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 09DC780BE;
        Wed, 23 Aug 2023 10:45:18 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 23 Aug
 2023 10:45:18 +0800
Received: from [192.168.125.113] (113.72.145.205) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 23 Aug
 2023 10:45:16 +0800
Message-ID: <c9ac528a-e1c2-0f64-c50e-30fc1eb6e9ac@starfivetech.com>
Date:   Wed, 23 Aug 2023 10:45:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 4/5] riscv: dts: starfive: pinfunc: Fix the pins name
 of I2STX1
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Jose Abreu <joabreu@synopsys.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-riscv@lists.infradead.org>
References: <20230821144151.207339-1-xingyu.wu@starfivetech.com>
 <20230821144151.207339-5-xingyu.wu@starfivetech.com>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <20230821144151.207339-5-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.205]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/21 22:41, Xingyu Wu wrote:
> These pins are actually I2STX1 clock input, not I2STX0,
> so their names should be changed.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110-pinfunc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
> index fb0139b56723..256de17f5261 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
> +++ b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
> @@ -240,8 +240,8 @@
>  #define GPI_SYS_MCLK_EXT			30
>  #define GPI_SYS_I2SRX_BCLK			31
>  #define GPI_SYS_I2SRX_LRCK			32
> -#define GPI_SYS_I2STX0_BCLK			33
> -#define GPI_SYS_I2STX0_LRCK			34
> +#define GPI_SYS_I2STX1_BCLK			33
> +#define GPI_SYS_I2STX1_LRCK			34
>  #define GPI_SYS_TDM_CLK				35
>  #define GPI_SYS_TDM_RXD				36
>  #define GPI_SYS_TDM_SYNC			37

Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Thanks!
