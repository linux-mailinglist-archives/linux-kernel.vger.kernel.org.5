Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C167D8965
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbjJZUDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjJZUDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:03:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E4A1B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:03:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507cd62472dso2825279e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698350625; x=1698955425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyw5MHyHHlTKy6ei3+OUwIzekh8WpQwnC4wd1zyLdCI=;
        b=Kwq27T8W1W+OaGoa62mYUgXjXnqd7/+7axB0JlvlYqRvWfk6wLVzW/x8ZWEXJK4Ssw
         B65FNDJ++zlzxUbz3+LhsWTTv70/+EuDZD7WWpnKwCNGri6QofI2NUVQsAHIfxEq2AhV
         vJPcZ0EXCeDL4NMEIGz6IAxc2k0/LkqN0sCQ+AAoaEvCRc1+peYhCbI/tDhiUyEhLGWs
         0DzqD41GM18Tt7vlYa+aZjElzGWJKAARFHvN84kG4g/Amp4EMzAOM7HA4jXb1hp8Ova7
         KABNwyFTmrtaqRyVEf8AY5eHHxtrL+1JcpUD2Keo/wtUOsZtjb1qbSnCty8axApcU7vC
         7aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698350625; x=1698955425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyw5MHyHHlTKy6ei3+OUwIzekh8WpQwnC4wd1zyLdCI=;
        b=O3lttN2DgezgSZRl0kJ9CvqFrDgCSCzf/WWd7R71kGhVmvSaXBUpjOTzo+WZ7DJzDB
         uOEcVLA0odm5PITOEIUWRAFyr7upAie6oZMLed76A7bvbrow+lwOk/Og7STWrpDPO/od
         fJCm4tvV4oI0nMDDyoq2iGwOY7/qVq2U44QnZtx1MtjsUmxS4XVgY2vyLSBmQfvbIWWc
         UOMhDPbdOrugG42PN24XelE1iEgXEngZEPSuHvbRqvUSWyngN+96HqY+3yY4Uf1tQ5e3
         BMi4wV9whegbV4ZsPREUBz0Fx037cDIkwXUh+DiQQRuu1GByC3FR85aVxa5mmNdK0psi
         giLw==
X-Gm-Message-State: AOJu0Yw7qdl376mVsipcpE6++4SpqlFjqURrnWLa6T/XvjXuk99hy+EC
        gNvwO27WjeAEJ+x+jdpl/kuBSQ==
X-Google-Smtp-Source: AGHT+IEINiksgAi2Adn8Zrtz8fdqWkxv9fCJgRe4jVpy8BNaOk/A1lCTRkLNN8ZnFvaebHR55fEHGw==
X-Received: by 2002:a05:6512:ad5:b0:4ff:839b:5355 with SMTP id n21-20020a0565120ad500b004ff839b5355mr1236216lfu.18.1698350625274;
        Thu, 26 Oct 2023 13:03:45 -0700 (PDT)
Received: from [172.30.205.86] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512203000b00500d1a72734sm3118696lfs.130.2023.10.26.13.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 13:03:44 -0700 (PDT)
Message-ID: <e56bec85-46be-4c88-ae88-199e7272ccdd@linaro.org>
Date:   Thu, 26 Oct 2023 22:03:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: pm8916: Add BMS and charger
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
 <20231023-pm8916-dtsi-bms-lbc-v2-2-343e3dbf423e@trvn.ru>
 <3dff444b-c439-4c40-9d21-1e390f449840@linaro.org>
 <b9c7f8662e4c02a4f9f275d27469f3be@trvn.ru>
 <f3c215a3-579a-4b4f-92bf-092c91234180@linaro.org>
 <ZTq7XGz4Ux8lYQho@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZTq7XGz4Ux8lYQho@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/23 21:17, Stephan Gerhold wrote:
> On Thu, Oct 26, 2023 at 08:54:00PM +0200, Konrad Dybcio wrote:
>> On 10/24/23 11:29, Nikita Travkin wrote:
>>> Konrad Dybcio писал(а) 24.10.2023 13:34:
>>>> On 10/23/23 08:20, Nikita Travkin wrote:
>>>>> pm8916 contains some hardware blocks for battery powered devices:
>>>>>
>>>>> - VM-BMS: Battery voltage monitoring block.
>>>>> - LBC: Linear battery charger.
>>>>>
>>>>> Add them to the pmic dtsi so the devices that make use of those blocks
>>>>> can enable them.
>>>>>
>>>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>>>> ---
>>>>>     arch/arm64/boot/dts/qcom/pm8916.dtsi | 48 ++++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 48 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
>>>>> index f4de86787743..4b2e8fb47d2d 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
>>>>> @@ -41,6 +41,35 @@ watchdog {
>>>>>     			};
>>>>>     		};
>>>>>     +		pm8916_charger: charger@1000 {
>>>>> +			compatible = "qcom,pm8916-lbc";
>>>>> +			reg = <0x1000>, <0x1200>, <0x1300>, <0x1600>;
>>>>> +			reg-names = "chgr", "bat_if", "usb", "misc";
>>>>> +
>>>>> +			interrupts = <0x0 0x10 0 IRQ_TYPE_EDGE_BOTH>,
>>>>> +				     <0x0 0x10 5 IRQ_TYPE_EDGE_BOTH>,
>>>>> +				     <0x0 0x10 6 IRQ_TYPE_EDGE_BOTH>,
>>>>> +				     <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
>>>>> +				     <0x0 0x12 0 IRQ_TYPE_EDGE_BOTH>,
>>>>> +				     <0x0 0x12 1 IRQ_TYPE_EDGE_BOTH>,
>>>>> +				     <0x0 0x13 0 IRQ_TYPE_EDGE_BOTH>,
>>>>> +				     <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>,
>>>>> +				     <0x0 0x13 2 IRQ_TYPE_EDGE_BOTH>,
>>>>> +				     <0x0 0x13 4 IRQ_TYPE_EDGE_BOTH>;
>>>>> +			interrupt-names = "vbat_det",
>>>>> +					  "fast_chg",
>>>>> +					  "chg_fail",
>>>>> +					  "chg_done",
>>>>> +					  "bat_pres",
>>>>> +					  "temp_ok",
>>>>> +					  "coarse_det",
>>>>> +					  "usb_vbus",
>>>> So, both the charger and the USBIN driver use the same irq? :/
>>>>
>>>
>>> AFAIU the usbin extcon driver pretty much just tracks the state
>>> of the IRQ to report extcon. It happens to assume the same part
>>> of the pmic though, yes, which also means there will be no user
>>> that would enable both charger and vbus extcon, since charger
>>> driver provides this functionality as well.
>> So, should USBIN be removed from PM8916 dt since it's essentially
>> a part of the charger block?
>>
> 
> The "USB_IN" pad of the PM8916 seems to be connected on pretty much all
> devices, even if they are using external chargers and the charging
> functionality of PM8916 is completely disabled. For those devices, the
> &pm8916_usbin device provides a convenient way to detect the USB state,
> even without a working charger driver.
> 
> While we could modify the PM8916 charger driver and DT node to have some
> special mode where charging and battery monitoring is completely
> disabled and only the USBIN extcon is provided, I'm not sure if that
> would provide a significant advantage compared to just keeping the
> simple &pm8916_usbin node with the existing driver.
Hmm okay I see..

Generally it's rather "no bueno" to have two DT nodes consuming the
same register space.. What happens when you enable BMS on a device
with a non-PM8916 charger? Does it correctly recognize "no battery"
etc.?

Konrad
