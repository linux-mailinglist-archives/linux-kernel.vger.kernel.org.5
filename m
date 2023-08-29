Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C4478C1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjH2Jlj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 05:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjH2Jlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:41:31 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBA2E1;
        Tue, 29 Aug 2023 02:41:25 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0CC2124E250;
        Tue, 29 Aug 2023 17:41:23 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 29 Aug
 2023 17:41:23 +0800
Received: from [192.168.120.76] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 29 Aug
 2023 17:41:21 +0800
Message-ID: <503bbb09-2886-9dbb-808a-65422bab712c@starfivetech.com>
Date:   Tue, 29 Aug 2023 17:41:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC v4 4/4] riscv: dts: starfive: jh7100: Add PWM node and pins
 configuration
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>
References: <20230825081328.204442-1-william.qiu@starfivetech.com>
 <20230825081328.204442-5-william.qiu@starfivetech.com>
 <CAJM55Z-Ab1DAQyQC9TRFFBidus6wCRns9RQjx-iyYyNK1e-e6A@mail.gmail.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CAJM55Z-Ab1DAQyQC9TRFFBidus6wCRns9RQjx-iyYyNK1e-e6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/29 17:38, Emil Renner Berthing wrote:
> On Fri, 25 Aug 2023 at 10:16, William Qiu <william.qiu@starfivetech.com> wrote:
>> Add StarFive JH7100 PWM controller node and add PWM pins configuration
>> on VisionFive 2 board.
> 
> Hi William,
> 
> This is the VisionFive V1 board right?
> 
> /Emil
> 
Hi Emil,

Yes， it's VisionFive V1, I wrote it wrong.

B.R.
William
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
>>  arch/riscv/boot/dts/starfive/jh7100.dtsi      |  9 +++++++
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>> index b93ce351a90f..746867b882b0 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>> @@ -84,6 +84,24 @@ GPO_I2C2_PAD_SDA_OEN,
>>                 };
>>         };
>>
>> +       pwm_pins: pwm-0 {
>> +               pwm-pins {
>> +                       pinmux = <GPIOMUX(7,
>> +                                 GPO_PWM_PAD_OUT_BIT0,
>> +                                 GPO_PWM_PAD_OE_N_BIT0,
>> +                                 GPI_NONE)>,
>> +                                <GPIOMUX(5,
>> +                                 GPO_PWM_PAD_OUT_BIT1,
>> +                                 GPO_PWM_PAD_OE_N_BIT1,
>> +                                 GPI_NONE)>;
>> +                       bias-disable;
>> +                       drive-strength = <35>;
>> +                       input-disable;
>> +                       input-schmitt-disable;
>> +                       slew-rate = <0>;
>> +               };
>> +       };
>> +
>>         uart3_pins: uart3-0 {
>>                 rx-pins {
>>                         pinmux = <GPIOMUX(13, GPO_LOW, GPO_DISABLE,
>> @@ -154,6 +172,12 @@ &osc_aud {
>>         clock-frequency = <27000000>;
>>  };
>>
>> +&ptc {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pwm_pins>;
>> +       status = "okay";
>> +};
>> +
>>  &uart3 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&uart3_pins>;
>> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
>> index 4218621ea3b9..7f5bb19e636e 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
>> @@ -248,5 +248,14 @@ watchdog@12480000 {
>>                         resets = <&rstgen JH7100_RSTN_WDTIMER_APB>,
>>                                  <&rstgen JH7100_RSTN_WDT>;
>>                 };
>> +
>> +               ptc: pwm@12490000 {
>> +                       compatible = "starfive,jh7100-pwm";
>> +                       reg = <0x0 0x12490000 0x0 0x10000>;
>> +                       clocks = <&clkgen JH7100_CLK_PWM_APB>;
>> +                       resets = <&rstgen JH7100_RSTN_PWM_APB>;
>> +                       #pwm-cells = <3>;
>> +                       status = "disabled";
>> +               };
>>         };
>>  };
>> --
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
