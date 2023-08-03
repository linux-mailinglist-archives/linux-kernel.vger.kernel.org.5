Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E569876E04E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjHCGew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjHCGev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:34:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1CBE7D;
        Wed,  2 Aug 2023 23:34:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3736YY05084557;
        Thu, 3 Aug 2023 01:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691044474;
        bh=l/dJL8sYApap4cmNcA7wUrOOxRli0l2lUdTGCW+hBTI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=sOgsooCQodMlFzxrchLC7ojEei8pZwJ0w536P2/Bvd7/YAlvqiJ401BEBY1/coPJ4
         bdhV8BqAPUrbJZROtkCrwTdZSTSKArIIbbmd9DibtkP7I0laH9+ReOT5Wq+3xAqoNX
         uV548Na94kRKVC3393CUD9lj3YNQeOIpgnrKAcR8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3736YYSo127960
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 01:34:34 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 01:34:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 01:34:33 -0500
Received: from [10.249.128.142] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3736YRsM047295;
        Thu, 3 Aug 2023 01:34:28 -0500
Message-ID: <eea30962-0ec6-b967-7764-e57c9d6c75fa@ti.com>
Date:   Thu, 3 Aug 2023 12:04:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/8] arm64: dts: ti: k3-am62x-sk-common: Update
 main-i2c1 frequency
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230728173438.12995-1-a-bhatia1@ti.com>
 <20230728173438.12995-2-a-bhatia1@ti.com>
 <20230730163052.w5y5a25xgpxzuhzs@serving>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20230730163052.w5y5a25xgpxzuhzs@serving>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 30-Jul-23 22:00, Nishanth Menon wrote:
> On 23:04-20230728, Aradhya Bhatia wrote:
>> The Display Data Channel (DDC) transactions between an HDMI transmitter
>> (SIL9022A in this case) and an HDMI monitor, occur at a maximum of
>> 100KHz. That's the maximum supported frequency within DDC standards.
>>
>> While the SIL9022A can transact with the core at 400KHz, it needs to
>> drop the frequency to 100KHz when communicating with the monitor,
>> otherwise, the i2c controller times out and shows warning like this.
>>
>> [  985.773431] omap_i2c 20010000.i2c: controller timed out
>>
>> That feature, however, has not been enabled in the SIL9022 driver.
>>
>> Since, dropping the frequency doesn't affect any other devices on the
>> bus, drop the main-i2c1 frequency from 400KHz to 100KHz.
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> index 34c8ffc553ec..540ed8a0d7fb 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> @@ -300,7 +300,7 @@ &main_i2c1 {
>>  	status = "okay";
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&main_i2c1_pins_default>;
>> -	clock-frequency = <400000>;
>> +	clock-frequency = <100000>;
>>  
>>  	tlv320aic3106: audio-codec@1b {
>>  		#sound-dai-cells = <0>;
>> -- 
>> 2.40.1
>>
> 
> I know we had issues with level shifters on the dev platform previously,
> but do we need this patch anymore with the production boards?
> 
> if so, use Fixes and I can pick for next.
> 

This doesn't have anything to do with the level shifter issue we have
had previously. The DDC communication between the monitor and the HDMI
bridge requires that the bus frequency be 100KHz. Some monitors still
end up supporting higher frequencies on higher quality HDMI cables,
but to support a larger variety, we need to ensure that it doesn't
exceed 100KHz. Hence, this is just as much applicable on the production
boards.

Since the capability of the SIL9022 to drop down the transaction
frequency to 100KHz has not been enabled in the driver, I am changing
the bus frequency for the whole i2c-1 bus.

And this patch is not required if display is not being used, so I don't
think we need to back-port to older versions via "Fixes" tag... unless I
am missing a deeper point you were trying to make?

If so, let me know, and I will post a new version with the said tag.


Regards
Aradhya
