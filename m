Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E48778554
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjHKCUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHKCUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:20:13 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C4D2D55;
        Thu, 10 Aug 2023 19:20:12 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DB63C823D;
        Fri, 11 Aug 2023 10:20:10 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 11 Aug
 2023 10:20:11 +0800
Received: from [192.168.120.59] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 11 Aug
 2023 10:20:10 +0800
Message-ID: <a0373acd-a364-3b4e-8e7a-d274d2421c49@starfivetech.com>
Date:   Fri, 11 Aug 2023 10:20:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/2] riscv: dts: starfive: enable DCDC1&ALDO4 node in
 axp15060
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230809013917.81674-1-william.qiu@starfivetech.com>
 <20230809013917.81674-2-william.qiu@starfivetech.com>
 <CAJM55Z8EtUjfjF04jcNwdyPzx3VmEWZs14Fr-9PDiqXcHDOe9Q@mail.gmail.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CAJM55Z8EtUjfjF04jcNwdyPzx3VmEWZs14Fr-9PDiqXcHDOe9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/10 19:31, Emil Renner Berthing wrote:
> On Wed, 9 Aug 2023 at 03:41, William Qiu <william.qiu@starfivetech.com> wrote:
>>
>> Enable DCDC1 node for vmmc-supply and enable ALDO4 node for
>> vqmmc-supply.
>>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  .../starfive/jh7110-starfive-visionfive-2.dtsi   | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> index d2f3b9eb859b..d67e26b9c791 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> @@ -165,12 +165,28 @@ axp15060: pmic@36 {
>>                 #interrupt-cells = <1>;
>>
>>                 regulators {
>> +                       vcc_3v3: dcdc1 {
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
>> +                               regulator-min-microvolt = <3300000>;
>> +                               regulator-max-microvolt = <3300000>;
>> +                               regulator-name = "vcc_3v3";
>> +                       };
>> +
>>                         vdd_cpu: dcdc2 {
>>                                 regulator-always-on;
>>                                 regulator-min-microvolt = <500000>;
>>                                 regulator-max-microvolt = <1540000>;
>>                                 regulator-name = "vdd-cpu";
>>                         };
>> +
>> +                       emmc_vdd: aldo4 {
>> +                               regulator-boot-on;
>> +                               regulator-always-on;
> 
> Hi William,
> 
> Just a question: You mark these regulators as always-on, so they'll
> never be shut off even if the device is suspended. Is that because the
> mmc driver can't deal with reinitializing the mmc/sd-card if the card
> has been shut off while suspended or is there some other reason to
> mark them always-on?
> 

Hi Emil,

Because now hibernation's storage medium is currently SD/eMMC, so we need
to mark SD/eMMC always-on.

Best Regards,
William
>> +                               regulator-min-microvolt = <1800000>;
>> +                               regulator-max-microvolt = <1800000>;
>> +                               regulator-name = "emmc_vdd";
>> +                       };
>>                 };
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
