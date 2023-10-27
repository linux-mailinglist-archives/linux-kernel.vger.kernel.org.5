Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE76F7D8E45
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345179AbjJ0Fos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjJ0Foq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:44:46 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312761B2;
        Thu, 26 Oct 2023 22:44:42 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 6873440474;
        Fri, 27 Oct 2023 10:44:37 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698385477; bh=Rpor7KoZoeEC/K2ptmWwufpCeaKiSvUOZItVny41+Ac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B/6zyogFsrhzuWczOZs3MmESEPTb3PCgT2sWxAfoqTSJJyxp4HXnxto3oFHi/jpf8
         iPzibrD8x4P1pUnYFPGSz+0VVXUSMi7GB5siNPwOqxRxasoLxURIOOh26Wu1qLXpo2
         S3VLEQJ+NlEjmRsgxcm18Q3llP109inVS7Ce+jYUMbMEloG/wFpQSmL7PqSt9chYMQ
         oC347ahewIswR+aQXn1j/AMdFk0vlTdFHbPJ8tsbLCDJHyi2WP2oyavbrpTEURv8Qb
         yEY0NzJQPSmpQ5+qRoXZjRb5NldEiBCc0Vep7lACcqPQM6xPh1Kz48W42TRdYL+uTX
         jhCVrtzcOzQdA==
MIME-Version: 1.0
Date:   Fri, 27 Oct 2023 10:44:34 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: pm8916: Add BMS and charger
In-Reply-To: <e56bec85-46be-4c88-ae88-199e7272ccdd@linaro.org>
References: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
 <20231023-pm8916-dtsi-bms-lbc-v2-2-343e3dbf423e@trvn.ru>
 <3dff444b-c439-4c40-9d21-1e390f449840@linaro.org>
 <b9c7f8662e4c02a4f9f275d27469f3be@trvn.ru>
 <f3c215a3-579a-4b4f-92bf-092c91234180@linaro.org>
 <ZTq7XGz4Ux8lYQho@gerhold.net>
 <e56bec85-46be-4c88-ae88-199e7272ccdd@linaro.org>
Message-ID: <bd1da1d81f1345e25c37995af3014308@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 27.10.2023 01:03:
> On 10/26/23 21:17, Stephan Gerhold wrote:
>> On Thu, Oct 26, 2023 at 08:54:00PM +0200, Konrad Dybcio wrote:
>>> On 10/24/23 11:29, Nikita Travkin wrote:
>>>> Konrad Dybcio писал(а) 24.10.2023 13:34:
>>>>> On 10/23/23 08:20, Nikita Travkin wrote:
>>>>>> pm8916 contains some hardware blocks for battery powered devices:
>>>>>>
>>>>>> - VM-BMS: Battery voltage monitoring block.
>>>>>> - LBC: Linear battery charger.
>>>>>>
>>>>>> Add them to the pmic dtsi so the devices that make use of those blocks
>>>>>> can enable them.
>>>>>>
>>>>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/qcom/pm8916.dtsi | 48 ++++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 48 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
>>>>>> index f4de86787743..4b2e8fb47d2d 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
>>>>>> @@ -41,6 +41,35 @@ watchdog {
>>>>>>     			};
>>>>>>     		};
>>>>>>     +		pm8916_charger: charger@1000 {
>>>>>> +			compatible = "qcom,pm8916-lbc";
>>>>>> +			reg = <0x1000>, <0x1200>, <0x1300>, <0x1600>;
>>>>>> +			reg-names = "chgr", "bat_if", "usb", "misc";
>>>>>> +
>>>>>> +			interrupts = <0x0 0x10 0 IRQ_TYPE_EDGE_BOTH>,
>>>>>> +				     <0x0 0x10 5 IRQ_TYPE_EDGE_BOTH>,
>>>>>> +				     <0x0 0x10 6 IRQ_TYPE_EDGE_BOTH>,
>>>>>> +				     <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
>>>>>> +				     <0x0 0x12 0 IRQ_TYPE_EDGE_BOTH>,
>>>>>> +				     <0x0 0x12 1 IRQ_TYPE_EDGE_BOTH>,
>>>>>> +				     <0x0 0x13 0 IRQ_TYPE_EDGE_BOTH>,
>>>>>> +				     <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>,
>>>>>> +				     <0x0 0x13 2 IRQ_TYPE_EDGE_BOTH>,
>>>>>> +				     <0x0 0x13 4 IRQ_TYPE_EDGE_BOTH>;
>>>>>> +			interrupt-names = "vbat_det",
>>>>>> +					  "fast_chg",
>>>>>> +					  "chg_fail",
>>>>>> +					  "chg_done",
>>>>>> +					  "bat_pres",
>>>>>> +					  "temp_ok",
>>>>>> +					  "coarse_det",
>>>>>> +					  "usb_vbus",
>>>>> So, both the charger and the USBIN driver use the same irq? :/
>>>>>
>>>>
>>>> AFAIU the usbin extcon driver pretty much just tracks the state
>>>> of the IRQ to report extcon. It happens to assume the same part
>>>> of the pmic though, yes, which also means there will be no user
>>>> that would enable both charger and vbus extcon, since charger
>>>> driver provides this functionality as well.
>>> So, should USBIN be removed from PM8916 dt since it's essentially
>>> a part of the charger block?
>>>
>>
>> The "USB_IN" pad of the PM8916 seems to be connected on pretty much all
>> devices, even if they are using external chargers and the charging
>> functionality of PM8916 is completely disabled. For those devices, the
>> &pm8916_usbin device provides a convenient way to detect the USB state,
>> even without a working charger driver.
>>
>> While we could modify the PM8916 charger driver and DT node to have some
>> special mode where charging and battery monitoring is completely
>> disabled and only the USBIN extcon is provided, I'm not sure if that
>> would provide a significant advantage compared to just keeping the
>> simple &pm8916_usbin node with the existing driver.
> Hmm okay I see..
> 
> Generally it's rather "no bueno" to have two DT nodes consuming the
> same register space.. What happens when you enable BMS on a device
> with a non-PM8916 charger? Does it correctly recognize "no battery"
> etc.?
> 

The _charger and _bms are separate and communicate in a generic
manner via power-supplies and supply core (see 3/3) so giving
a different charger to _bms can work.

If an external charger is present in the device, qcom mandates
"external charger" optional line of the pmic to be tied, and
_charger is then disabled. The driver bails out in this case,
but _usbin could still be used.

> Konrad
