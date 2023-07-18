Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D077573E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjGRGOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjGRGOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:14:23 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078CB2139;
        Mon, 17 Jul 2023 23:13:24 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E33CF24E22F;
        Tue, 18 Jul 2023 14:12:41 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Jul
 2023 14:12:41 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Jul
 2023 14:12:41 +0800
Message-ID: <018b8bd3-ede0-d6ad-d50e-b4c959ac1660@starfivetech.com>
Date:   Tue, 18 Jul 2023 14:12:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/3] riscv: dts: starfive: Add QSPI controller node for
 StarFive JH7110 SoC
Content-Language: en-US
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230704090453.83980-1-william.qiu@starfivetech.com>
 <20230704090453.83980-4-william.qiu@starfivetech.com>
 <ZLV2vqycWIA5TanD@aurel32.net>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <ZLV2vqycWIA5TanD@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/18 1:13, Aurelien Jarno wrote:
> Hi,
> 
> On 2023-07-04 17:04, William Qiu wrote:
>> Add the quad spi controller node for the StarFive JH7110 SoC.
>> 
>> Co-developed-by: Ziv Xu <ziv.xu@starfivetech.com>
>> Signed-off-by: Ziv Xu <ziv.xu@starfivetech.com>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../jh7110-starfive-visionfive-2.dtsi         | 32 +++++++++++++++++++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 18 +++++++++++
>>  2 files changed, 50 insertions(+)
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> index 2a6d81609284..983b683e2f27 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> @@ -126,6 +126,38 @@ &i2c6 {
>>  	status = "okay";
>>  };
>>  
>> +&qspi {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	nor_flash: flash@0 {
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0>;
>> +		cdns,read-delay = <5>;
>> +		spi-max-frequency = <12000000>;
>> +		cdns,tshsl-ns = <1>;
>> +		cdns,tsd2d-ns = <1>;
>> +		cdns,tchsh-ns = <1>;
>> +		cdns,tslch-ns = <1>;
>> +
>> +		partitions {
>> +			compatible = "fixed-partitions";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			spl@0 {
>> +				reg = <0x0 0x20000>;
>> +			};
>> +			uboot@100000 {
>> +				reg = <0x100000 0x300000>;
>> +			};
>> +			data@f00000 {
>> +				reg = <0xf00000 0x100000>;
>> +			};
> 
> It appears that this uses the old layout for the SPI flash. The new
> layout is described there:
> 
> https://doc-en.rvspace.org/VisionFive2/Boot_UG/JH7110_SDK/boot_address_allocation.html
> 
> Regards
> Aurelien
> 
I'll take a look, and use it then.
Thanks for your comments.

Best regards,
William
