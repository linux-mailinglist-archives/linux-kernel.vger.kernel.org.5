Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAFE7E5805
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbjKHNjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjKHNjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:39:17 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1949719A3;
        Wed,  8 Nov 2023 05:39:14 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8CPMZw030934;
        Wed, 8 Nov 2023 14:38:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=DFtbioxDNAXutgfgT//Bjlhv4YfwX1TOTV2WWZ22Sg8=; b=3b
        bwDlG5yB3UQTGKy8BeullFID2SRBZpoCYcfJU+dmAYT0Z8gapcJR5nbYeZl/OuqY
        b1T5LsHx+SPyhGc5FAT0q/RlR/PmvxBMLnGJsXwT4o2qbmCV6rzjX6K2Plm/T50Y
        HthxmrPRDceYOrB9IC5Hh1NNAk6Onsw/JzrBFskN3nu1EuEiznEj2tuBVMKTBge0
        fIzLPCYvzOnJzaLO6I/HrB2zPbx4enLPi9TLoOrWlHgTtpnpUmTXdmqEPNwh/6iV
        9A6F9+DSSmWRTMj/90jOVKZgzlq2jGrnjuPY1MJJqrZOs5CoVwk5pxP2/hvp6zAw
        eAQySHz0eyE7HsUjLMDQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w26bkp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 14:38:52 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C96C5100056;
        Wed,  8 Nov 2023 14:38:50 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9BB3F2207B0;
        Wed,  8 Nov 2023 14:38:50 +0100 (CET)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 8 Nov
 2023 14:38:49 +0100
Message-ID: <35fb85cd-4c4c-48f5-802b-82f2df360437@foss.st.com>
Date:   Wed, 8 Nov 2023 14:38:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ARM: dts: stm32f469-disco: use the same 3v3 for SD
 and DSI nodes
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-amarula@amarulasolutions.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230904180635.923506-1-dario.binacchi@amarulasolutions.com>
 <5e75b5fd-c351-1f42-94ed-b6dc1d3f030e@foss.st.com>
 <CABGWkvquib1WEKGR-DFiNN62gLcYF3Y==K29_w-=9pV0gnjEqg@mail.gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <CABGWkvquib1WEKGR-DFiNN62gLcYF3Y==K29_w-=9pV0gnjEqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-08_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario



On 10/23/23 13:00, Dario Binacchi wrote:
> Hello Alexandre,
> 
> On Thu, Sep 14, 2023 at 10:57 AM Alexandre TORGUE
> <alexandre.torgue@foss.st.com> wrote:
>>
>> On 9/4/23 20:06, Dario Binacchi wrote:
>>> In the board schematic, the power supply for the SD card is the same 3.3
>>> volts used to power the LCD panel and other peripherals. By generalizing
>>> the name of the voltage regulator, it simplifies the device tree and makes
>>> it more readable.
>>>
>>
>> It makes sens as it is the same discret regulator (no pmic involved).
>>
> 
> I don't see it applied to linux-stm32/next. Is something missing?

ok, It is because the [RFC..] has been kept. Please resend by dropping it.

Cheers
Alex

> 
> Thanks and regards,
> Dario
> 
>> regards
>> Alex
>>
>>> Link: https://www.st.com/en/evaluation-tools/32f469idiscovery.html#cad-resources
>>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>>
>>> ---
>>>
>>>    arch/arm/boot/dts/st/stm32f469-disco.dts | 15 ++++-----------
>>>    1 file changed, 4 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/st/stm32f469-disco.dts b/arch/arm/boot/dts/st/stm32f469-disco.dts
>>> index cbbd521bf010..8a4f8ddd083d 100644
>>> --- a/arch/arm/boot/dts/st/stm32f469-disco.dts
>>> +++ b/arch/arm/boot/dts/st/stm32f469-disco.dts
>>> @@ -69,16 +69,9 @@ aliases {
>>>                serial0 = &usart3;
>>>        };
>>>
>>> -     mmc_vcard: mmc_vcard {
>>> +     vcc_3v3: vcc-3v3 {
>>>                compatible = "regulator-fixed";
>>> -             regulator-name = "mmc_vcard";
>>> -             regulator-min-microvolt = <3300000>;
>>> -             regulator-max-microvolt = <3300000>;
>>> -     };
>>> -
>>> -     vdd_dsi: vdd-dsi {
>>> -             compatible = "regulator-fixed";
>>> -             regulator-name = "vdd_dsi";
>>> +             regulator-name = "vcc_3v3";
>>>                regulator-min-microvolt = <3300000>;
>>>                regulator-max-microvolt = <3300000>;
>>>        };
>>> @@ -164,7 +157,7 @@ panel@0 {
>>>                compatible = "orisetech,otm8009a";
>>>                reg = <0>; /* dsi virtual channel (0..3) */
>>>                reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
>>> -             power-supply = <&vdd_dsi>;
>>> +             power-supply = <&vcc_3v3>;
>>>                status = "okay";
>>>
>>>                port {
>>> @@ -219,7 +212,7 @@ timer@2 {
>>>
>>>    &sdio {
>>>        status = "okay";
>>> -     vmmc-supply = <&mmc_vcard>;
>>> +     vmmc-supply = <&vcc_3v3>;
>>>        cd-gpios = <&gpiog 2 GPIO_ACTIVE_LOW>;
>>>        broken-cd;
>>>        pinctrl-names = "default", "opendrain";
>>
> 
> 
