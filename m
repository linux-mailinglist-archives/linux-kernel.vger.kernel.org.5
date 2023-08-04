Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2944176FDA3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjHDJnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjHDJn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:43:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AF130EB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:43:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so1776411a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691142205; x=1691747005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1eXbT/KalONwMKPKZfZFiDNuA7l+qr3D7lfU+28kCBQ=;
        b=tMxDCZWY4gGhkYmTyR60h5DpxZNyiNEUht4LfLAAdA11c0Kqdw3ikJKKMIyM896WAt
         gDMhvRVATOEUC5X/iVQRbktG4S9VmMu3Bi9mN08wC9qnclDiiwdJWl+Wi+qPPlCH8xgl
         HEm4PDd9L4OfgCxWsotTw2FhEcWsz/i4dO4C3Rh/z6mZuNW0G4pCALsb19iNHwvuZCnk
         KfDIUzh5b7jXddXqr7bTXpzCg3MMTe27rZvrEBqZrIEyK5c9VHWxa8yguOIbQg4bFtIG
         lFY2dZXiwIoP45xY5V2dnJb7/0MofSxb838NMEldTDg9Aa0fNmak4J/mbo+VRtocfJoW
         PBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691142205; x=1691747005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eXbT/KalONwMKPKZfZFiDNuA7l+qr3D7lfU+28kCBQ=;
        b=KukxRf6XIViJ/tMclV66prBkhN/7Of3U6iqBX72yQaHk2xF8urKA75+8cIjX0rTu6k
         BRUoIvw9JLFbMCzQAASU7AjbrP4vKFBLLhQ7+G4h/ykeo0jgaHaV+PCseKxvacsVDd+K
         Bs82yUF8Q+JOoX0tnvfSc8MORlOV5QbBaPSZ9HTdRJ1SOAOwie3784SFzUHFuwbaVI6N
         IWtN3nM4vZ9n1sipUdwaBjEKPIMte7k4lWxm5t2X37s/vvDM8Yly0IEaec5L59+CF0jc
         q2QXM6syfp+lreziGGGzfkhmNcQQAdeWWPnQjNhkLnPrQqEnrgY0++pQ1lOluHASpL5m
         KF3w==
X-Gm-Message-State: AOJu0Yz4O1Kr2G6OgGh5OCLptR8rQj2KLiosSRRxrXVWoWVnQYcj2ZwP
        E9J2WFhoowxQaKFJ62SDBvAF8Q==
X-Google-Smtp-Source: AGHT+IGC9mA7LPO2N64IIl+Xk6+A/e9ohIrzJGE8pgrJFcZhD7dVNL2lN7+hweJBbOWw01HxcF6Slg==
X-Received: by 2002:a17:906:28a:b0:99b:d178:f051 with SMTP id 10-20020a170906028a00b0099bd178f051mr893587ejf.64.1691142205545;
        Fri, 04 Aug 2023 02:43:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id gs10-20020a170906f18a00b0097404f4a124sm1059389ejb.2.2023.08.04.02.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 02:43:25 -0700 (PDT)
Message-ID: <b16b0fa5-d2ce-dca0-9074-f2e04fe533dc@linaro.org>
Date:   Fri, 4 Aug 2023 11:43:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V1] arm64: dts: qcom: sa8775p-ride: Remove min and max
 voltages for L8A
Content-Language: en-US
To:     "Naveen Kumar Goud Arepalli (QUIC)" <quic_narepall@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230725100007.14775-1-quic_narepall@quicinc.com>
 <a3l7356miuuapf5dakgfchdjmxjp62ynvle4ta3hejd3tjvzd4@e2t2zm6jh7hb>
 <516a54da44724001895f7e50634ad884@quicinc.com>
 <33232e22-1014-2670-47f6-712b0acc929d@linaro.org>
 <78e6233799f54428b6601896b8bd7b5c@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <78e6233799f54428b6601896b8bd7b5c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 10:04, Naveen Kumar Goud Arepalli (QUIC) wrote:
>>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>> b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>> index ed76680410b4..6f3891a09e59 100644
>>> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>> @@ -98,8 +98,6 @@
>>>  
>>>  		vreg_l8a: ldo8 {
>>>  			regulator-name = "vreg_l8a";
>>> -			regulator-min-microvolt = <2504000>;
>>> -			regulator-max-microvolt = <3300000>;
>>>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>  			regulator-allow-set-load;
>>>  			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>>> --
>>> 2.17.1
>>>
>>
>> Reviewing with very little expertise in the area....
>> A few questions below that would help me understand this a bit better.
>>
>> Does it make sense to *not* set the range of the regulator at all?:
>>>>> Yes, we are removing the range of the regulator.
>>
>>     1. A board dts knows its UFS device
>>     2. Is UFS backwards compatible with respect to UFS2/UFS3?
>>        I don't know how the version is determined, but if it's a
>>        "start at UFS2, go to UFS3" should it be scaled as that goes?
>>        >>>> For a UFS device 3.x, we cannot start as UFS 2.0. vcc has to be as per UFS 3.x recommendations.
>>
>> Relying on the bootloader to set up the device before the kernel 
>> starts seems like a direction that should be actively avoided instead 
>> of depended on in my opinion.
> 
> I have trouble finding which part is your reply and which is quote of Andrew. Please reconfigure your mail client.

Who said this? Me or you? I am pretty sure I *said this*.

Not only you pasted it as your reply, but you also re-wrapped lines.

That's not how email communication works outside of corporate structure.
Please, don't bring Outlook style to our lives...

> 
>>>>>> As per upstream UFS driver,  voltage voting is not there and we vote only for enable/disable . 
>> Since UFS is the only client in Linux for this rail (L8A ), we don't 
>> need min and max range to support UFS 2.x and 3.x cards.
> 
> I would assume some reasonable range is always desired. Why it cannot be the wider range from both? 2.4 - 3.6?

Again - who said that? I am 100% sure that me, not you.

> 
> Wider range cannot be mentioned in DT, For UFS 2.x range is 2.7 V to 3.6 V and for UFS 3.x range is 2.4V to 2.7V.
> Giving the wider range will not set the correct voltage.

So is this your reply?

I don't see a problem in wider range...

> 
> For example: 
> If the range is mentioned as 2.4V to 3.6V in DT and we have connected UFS 2.x device,  Since UFS driver is voting only for
> regulator_enable(voltage is not being set) the voltage will be 2.4V(min voltage) from pmic driver which is wrong voltage for
> UFS 2.x devices, which is violation of spec.

So what is your solution? Remove constraints? Then who configures them?
You rely on bootloader which is not what we want.

Best regards,
Krzysztof

