Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B02E7D8896
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjJZSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjJZSyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:54:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B4E1A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:54:04 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so1755866e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698346442; x=1698951242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YN4RVHkxUHXpdD2Tu1w8w0WncGzqflUXO4856b5/210=;
        b=FfBPuK+LEbFxll/KM9UaifqudMjDEYkvInRkTT0BW7Mf0s5xRQPqNkINswjREV9jdw
         C9Y+Ks88ZL1DEJFiHHEFMmqapItWOban9DMCTaBlzLA7s/kDlI4+UqeySlYtR/bvunvQ
         yPzsbtFRi2k15XtSNRoAL3NqD64Lhrk4dBFHWX6kwfUPi/DFn0FP+rYwNfKjEnqTwK9W
         ICczBIODum5fW4q264eMYDGJAKs5HtyhVRYetsf3MbB++Pg6s/lrnmGhrn8DH+mgf4Tx
         ygARfQEvO7Et4cNrYK+WOilo9lS99B1ndc1mGdrki2YD7FAcFEc1etSjTjgZhVO8eU4d
         6y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698346442; x=1698951242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YN4RVHkxUHXpdD2Tu1w8w0WncGzqflUXO4856b5/210=;
        b=BCFZ+ojNAjHwUk1SaJDnqFF5D3oGWWbGZ7NNzKCep8klnP0xmFFumAnfZPZrokwdqW
         ItwFVEAvBWYRepjzwIUXT5M4ZTSd/MiPXv2//gYwKlCEUxkge5tr+KzXuoaEdwLKGhQh
         c5pho4bc51xaY+8WZm7Ab7D3kOeuVv+A9XkPY2QzpCvVI0je6q/zmjRMjSrG0s7B14bS
         IeunW8x0gO5G39WN+3e7k1YoB/GFf0UdoliemGE7fCiFxnJDek4ecRrbMvSejCNYj4mP
         0neM2RWpEmGCDzRV/YoYqoVeDOu2XJ462M3hdfLUTwSygS8NhWeAJoi1StgMaM1ZF+AR
         Yx5A==
X-Gm-Message-State: AOJu0YzrXvuBd3OK0UYCPCjjJMNBtb3pjFQ89fAezlv5jlr7lcWlC/7r
        QH4srOcTY7pp1HncGnENAC1yvg==
X-Google-Smtp-Source: AGHT+IElLwSk+F6Ttzd0DDTOv89uu1+MwsSejU2BrdRUTggcph0gtzc9myGEzhEVaMOVzTGyNim/5A==
X-Received: by 2002:a19:434d:0:b0:503:655:12e7 with SMTP id m13-20020a19434d000000b00503065512e7mr170306lfj.62.1698346442358;
        Thu, 26 Oct 2023 11:54:02 -0700 (PDT)
Received: from [172.30.205.8] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h28-20020a0565123c9c00b00507a96d17b3sm3057580lfv.237.2023.10.26.11.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 11:54:01 -0700 (PDT)
Message-ID: <f3c215a3-579a-4b4f-92bf-092c91234180@linaro.org>
Date:   Thu, 26 Oct 2023 20:54:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: pm8916: Add BMS and charger
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Andy Gross <agross@kernel.org>,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <b9c7f8662e4c02a4f9f275d27469f3be@trvn.ru>
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



On 10/24/23 11:29, Nikita Travkin wrote:
> Konrad Dybcio писал(а) 24.10.2023 13:34:
>> On 10/23/23 08:20, Nikita Travkin wrote:
>>> pm8916 contains some hardware blocks for battery powered devices:
>>>
>>> - VM-BMS: Battery voltage monitoring block.
>>> - LBC: Linear battery charger.
>>>
>>> Add them to the pmic dtsi so the devices that make use of those blocks
>>> can enable them.
>>>
>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>> ---
>>>    arch/arm64/boot/dts/qcom/pm8916.dtsi | 48 ++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 48 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
>>> index f4de86787743..4b2e8fb47d2d 100644
>>> --- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
>>> @@ -41,6 +41,35 @@ watchdog {
>>>    			};
>>>    		};
>>>    +		pm8916_charger: charger@1000 {
>>> +			compatible = "qcom,pm8916-lbc";
>>> +			reg = <0x1000>, <0x1200>, <0x1300>, <0x1600>;
>>> +			reg-names = "chgr", "bat_if", "usb", "misc";
>>> +
>>> +			interrupts = <0x0 0x10 0 IRQ_TYPE_EDGE_BOTH>,
>>> +				     <0x0 0x10 5 IRQ_TYPE_EDGE_BOTH>,
>>> +				     <0x0 0x10 6 IRQ_TYPE_EDGE_BOTH>,
>>> +				     <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
>>> +				     <0x0 0x12 0 IRQ_TYPE_EDGE_BOTH>,
>>> +				     <0x0 0x12 1 IRQ_TYPE_EDGE_BOTH>,
>>> +				     <0x0 0x13 0 IRQ_TYPE_EDGE_BOTH>,
>>> +				     <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>,
>>> +				     <0x0 0x13 2 IRQ_TYPE_EDGE_BOTH>,
>>> +				     <0x0 0x13 4 IRQ_TYPE_EDGE_BOTH>;
>>> +			interrupt-names = "vbat_det",
>>> +					  "fast_chg",
>>> +					  "chg_fail",
>>> +					  "chg_done",
>>> +					  "bat_pres",
>>> +					  "temp_ok",
>>> +					  "coarse_det",
>>> +					  "usb_vbus",
>> So, both the charger and the USBIN driver use the same irq? :/
>>
> 
> AFAIU the usbin extcon driver pretty much just tracks the state
> of the IRQ to report extcon. It happens to assume the same part
> of the pmic though, yes, which also means there will be no user
> that would enable both charger and vbus extcon, since charger
> driver provides this functionality as well.
So, should USBIN be removed from PM8916 dt since it's essentially
a part of the charger block?

Konrad
