Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0A7DCE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344702AbjJaNyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbjJaNyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:54:35 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 585009F;
        Tue, 31 Oct 2023 06:54:32 -0700 (PDT)
Message-ID: <714040ef-a032-41b4-9612-c739ecc25d33@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1698760470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZUERBcJomGwI5V072etc02VGxK584H2du5hts/zKNc=;
        b=t9vBByn8fT/MAyShle8FMOMGPVDJgIICMdv+HbKIAILqNWsgHZrJQkHop3pB60d8TWiQ4t
        KT6sC/EBXR0filNeqNPCFz0rhYmDy7W9p6C4TxHVGy8oGmF6iCQrJ5bM3DBRIf6RYuBkrq
        Xc/kTh1y7XmTheMeQtK4xg15qYBfhhk=
Date:   Tue, 31 Oct 2023 14:52:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/4] ARM: dts: qcom: Add support for Samsung Galaxy Tab
 4 10.1 LTE (SM-T535)
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20231025083952.12367-1-newbyte@postmarketos.org>
 <20231025083952.12367-4-newbyte@postmarketos.org>
 <a3162513-c4d0-4db6-9ff9-447f4249fc67@linaro.org>
Content-Language: en-US
From:   Stefan Hansson <newbyte@postmarketos.org>
In-Reply-To: <a3162513-c4d0-4db6-9ff9-447f4249fc67@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-31 12:08, Konrad Dybcio wrote:
> On 25.10.2023 10:37, Stefan Hansson wrote:
>> Add a device tree for the Samsung Galaxy Tab 4 10.1 (SM-T535) LTE tablet
>> based on the MSM8926 platform.
>>
>> Signed-off-by: Stefan Hansson <newbyte@postmarketos.org>
>> ---
>>   arch/arm/boot/dts/qcom/Makefile               |  1 +
>>   .../qcom/qcom-msm8926-samsung-matisselte.dts  | 36 +++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8926-samsung-matisselte.dts
>>
>> diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
>> index a3d293e40820..cab35eeb30f6 100644
>> --- a/arch/arm/boot/dts/qcom/Makefile
>> +++ b/arch/arm/boot/dts/qcom/Makefile
>> @@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>>   	qcom-msm8916-samsung-serranove.dtb \
>>   	qcom-msm8926-microsoft-superman-lte.dtb \
>>   	qcom-msm8926-microsoft-tesla.dtb \
>> +	qcom-msm8926-samsung-matisselte.dtb \
>>   	qcom-msm8960-cdp.dtb \
>>   	qcom-msm8960-samsung-expressatt.dtb \
>>   	qcom-msm8974-lge-nexus5-hammerhead.dtb \
>> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8926-samsung-matisselte.dts b/arch/arm/boot/dts/qcom/qcom-msm8926-samsung-matisselte.dts
>> new file mode 100644
>> index 000000000000..6e25b1a74ce5
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom/qcom-msm8926-samsung-matisselte.dts
>> @@ -0,0 +1,36 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2022, Matti Lehtimäki <matti.lehtimaki@gmail.com>
>> + * Copyright (c) 2023, Stefan Hansson <newbyte@postmarketos.org>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "qcom-msm8226-samsung-matisse-common.dtsi"
>> +
>> +/ {
>> +	model = "Samsung Galaxy Tab 4 10.1 LTE";
>> +	compatible = "samsung,matisselte", "qcom,msm8926", "qcom,msm8226";
>> +	chassis-type = "tablet";
>> +};
>> +
>> +&pm8226_l3 {
>> +	regulator-max-microvolt = <1350000>;
>> +};
>> +
>> +&pm8226_s4 {
>> +	regulator-max-microvolt = <2200000>;
>> +};
>> +
>> +&reg_tsp_3p3v {
>> +	gpio = <&tlmm 32 GPIO_ACTIVE_HIGH>;
>> +};
>> +
>> +&sdhc_2 {
>> +	/* SD card fails to probe with error -110 */
>> +	status = "disabled";
> Can you give us some logs?

I tested it again just now, and it worked without issues. Maybe I used a 
defective SD card to test it or hadn't inserted it properly. I'll send 
another revision fixing this.

> Konrad

Stefan
