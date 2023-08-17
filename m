Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FFC77F216
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348905AbjHQI2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348937AbjHQI1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:27:39 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB24E30EA;
        Thu, 17 Aug 2023 01:27:35 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id AE14B24E2B1;
        Thu, 17 Aug 2023 16:27:34 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 17 Aug
 2023 16:27:34 +0800
Received: from [192.168.125.113] (183.27.97.249) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 17 Aug
 2023 16:27:33 +0800
Message-ID: <d241515f-f5c7-f2aa-0c78-80f0c5b569f3@starfivetech.com>
Date:   Thu, 17 Aug 2023 16:27:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 3/3] riscv: dts: jh7110: starfive: Add timer node
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
References: <20230814101603.166951-1-xingyu.wu@starfivetech.com>
 <20230814101603.166951-4-xingyu.wu@starfivetech.com>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <20230814101603.166951-4-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/8/14 18:16, Xingyu Wu wrote:
> Add the timer node for the Starfive JH7110 SoC.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index ec2e70011a73..84bb9717be13 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -502,6 +502,26 @@ sysgpio: pinctrl@13040000 {
>  			#gpio-cells = <2>;
>  		};
>  
> +		timer@13050000 {
> +			compatible = "starfive,jh7110-timer";
> +			reg = <0x0 0x13050000 0x0 0x10000>;
> +			interrupts = <69>, <70>, <71> ,<72>;
> +			clocks = <&syscrg JH7110_SYSCLK_TIMER_APB>,
> +				 <&syscrg JH7110_SYSCLK_TIMER0>,
> +				 <&syscrg JH7110_SYSCLK_TIMER1>,
> +				 <&syscrg JH7110_SYSCLK_TIMER2>,
> +				 <&syscrg JH7110_SYSCLK_TIMER3>;
> +			clock-names = "apb", "ch0", "ch1",
> +				      "ch2", "ch3";
> +			resets = <&syscrg JH7110_SYSRST_TIMER_APB>,
> +				 <&syscrg JH7110_SYSRST_TIMER0>,
> +				 <&syscrg JH7110_SYSRST_TIMER1>,
> +				 <&syscrg JH7110_SYSRST_TIMER2>,
> +				 <&syscrg JH7110_SYSRST_TIMER3>;
> +			reset-names = "apb", "ch0", "ch1",
> +				      "ch2", "ch3";
> +		};
> +
>  		watchdog@13070000 {
>  			compatible = "starfive,jh7110-wdt";
>  			reg = <0x0 0x13070000 0x0 0x10000>;

Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Thanks!
