Return-Path: <linux-kernel+bounces-95490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B290874E43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801941C210C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC005129A84;
	Thu,  7 Mar 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJ/lk8uH"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA80129A8C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812212; cv=none; b=ihPteDChv1YhoohlrZ2fuFr9om7hx6eKOoSJYgvhS1/tvw/qs6wz0CkYk2qndeKdNj71IlL7S5Qhc2prfU5iMEW+urhOzyB+qRvHGWCQp4kWgA4PIf13mHV3WctPx9cJCHAs/FSDiyhze+iUbagN8XANS9gze2JiGXeXEtJsKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812212; c=relaxed/simple;
	bh=c62K5oPh61vCveDvQf0OpOvXF4WeEmn4VK50d27H8EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvNxF+ABw+2FPtO/Nog3REK/OaYzvyE8OP+Q5oyRpFymAE0vFAI1Y7DM7lKYiyaDHI0VRaWui7HfMgZa337+E55N/f/owp9nrUA9Mfywg5qGUwbW+dRUw5N9THlyPBUxfwOsbk/hAP2OsqL4/12ckHzvdAtDHXfmoIuvX007I2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fJ/lk8uH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5131316693cso965203e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709812209; x=1710417009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6uts5XAuJGMgcS3q5Z9N3SGrS49osI0Xq6KbzVVrfg=;
        b=fJ/lk8uHB8PjTgDVNicH9xnL5Fy6XT4hrGjlqd3YIZKTy0U5zF1Js0cA7gSs7Ag6+O
         3OmlXTi2/2XQJJhk87DpzVXOj2hmnAfc0lzsDF7a2gW8Yj35wEMz71GtaXbi0ah+8Yjz
         UwMv+dVHN/FfpgJVnXkdXUzql1+VJU/Ldz6z9Ktj9hQpSzFZCC6Z/Qqbbq6bZL8yxtNl
         7Lo+/hjklFOUEa5JIkCvt41H2hrN9PyYbyHSoWqgp59lhzQbkn2TOGwQ367OSgPS/gRj
         e4OwBd3Fv4dA5JY4ToJm9CNYbgLeV/FKqwxHf82ExaYngUKMcH0narl5rAfGXKqWWxBA
         a6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709812209; x=1710417009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6uts5XAuJGMgcS3q5Z9N3SGrS49osI0Xq6KbzVVrfg=;
        b=atLKclU89Cej+oAlZyc62PNFDXDTKkCUg+adcNikpdn0TFSY0NeNbCDaxZL2L9aL70
         2uYcYSgYgoPoOtK7HEFPKiUYQKueKAyeE3K1JPzldYH8dWidKv4ZwjCtHrosUY32HN22
         Vjn/VNx9bZ2zWfx3VKDlNu6uaErL9pOCKP8OqMOyG3DXuEFcyhx1P2Fs3oXp2xdzHZxS
         gERSZGSFTAkM0kHoCV/OyORlhI2UZFmzp78LHIVHyjf3AmIFaTUjx7Nf6ghyT6IKWEMH
         Adz3hbynznFRkUajQq5fffryrSugpeKb2hMQbV8MoboKpeBrgCZUpNMnVhjBYUDa2S5R
         UCHA==
X-Forwarded-Encrypted: i=1; AJvYcCU+4FAlFqcR9Hf5eKbZfW54ZM1ckihinR+kZTnFi1aknX98CV23/17IAcmiHbeZvrZOfcqV6/U2CUaPRDQCNBak9ieoCQbvA5d0cruW
X-Gm-Message-State: AOJu0Yzk10jDI/UQcuLEMMQT8T/qZ2jG7UZ0ml4I8EZvdDXUqbgzb4qM
	8CtoIOe8Kntyx83ayk4QVYNG/5EdL8xz1E3Nzdie/oRTMS0ageK+AClJpd/UFOo=
X-Google-Smtp-Source: AGHT+IG4bzS87kZ3geSfi5mpqxwhIKXkroOdY/OO1oaxjjX8DMoKWY9bpC3ELNXCuGKGxX1lM0ohTA==
X-Received: by 2002:ac2:5b44:0:b0:513:5217:6201 with SMTP id i4-20020ac25b44000000b0051352176201mr1333056lfp.59.1709812208871;
        Thu, 07 Mar 2024 03:50:08 -0800 (PST)
Received: from [172.30.204.36] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q12-20020ac25a0c000000b00513360b4f1esm2435370lfn.305.2024.03.07.03.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:50:08 -0800 (PST)
Message-ID: <48fd9457-d092-4226-9a6c-13dea81694f5@linaro.org>
Date: Thu, 7 Mar 2024 12:50:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] arm64: dts: qcom: ipq6018: add sdhci node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Robert Marko <robimarko@gmail.com>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240306123006.724934-1-amadeus@jmu.edu.cn>
 <20240306123006.724934-2-amadeus@jmu.edu.cn>
 <CAA8EJpqYjutM1Kh6QxysB6XNAmXywtOtRJ7KP0LbY5E36kCPvA@mail.gmail.com>
 <78b1a1a2-a9fa-4b28-9d96-d65bb5517199@gmail.com>
 <CAA8EJppJBOQh19r4A-igsh5znDE_R6mDNy+ao5ximx7vtsZZvA@mail.gmail.com>
 <CAOX2RU4W-zV3A8eW0A+1V838Fm=tUkXY=Bs3j4VJ8Jo9mxrOAw@mail.gmail.com>
 <CAA8EJpq=-r4XhnFJset0=X=YO5QNUpuw+e1r6DTsPvzNAZCyNw@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpq=-r4XhnFJset0=X=YO5QNUpuw+e1r6DTsPvzNAZCyNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/7/24 08:50, Dmitry Baryshkov wrote:
> On Thu, 7 Mar 2024 at 09:38, Robert Marko <robimarko@gmail.com> wrote:
>>
>> On Thu, 7 Mar 2024 at 08:28, Dmitry Baryshkov
>> <dmitry.baryshkov@linaro.org> wrote:
>>>
>>> On Wed, 6 Mar 2024 at 22:35, Robert Marko <robimarko@gmail.com> wrote:
>>>>
>>>>
>>>> On 06. 03. 2024. 20:43, Dmitry Baryshkov wrote:
>>>>> On Wed, 6 Mar 2024 at 14:31, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>>>>>> Add node to support mmc controller inside of IPQ6018.
>>>>>> This controller supports both eMMC and SD cards.
>>>>>>
>>>>>> Tested with:
>>>>>>     eMMC (HS200)
>>>>>>     SD Card (SDR50/SDR104)
>>>>>>
>>>>>> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
>>>>>> ---
>>>>>>    arch/arm64/boot/dts/qcom/ipq6018.dtsi | 19 +++++++++++++++++++
>>>>>>    1 file changed, 19 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>>>>>> index 322eced0b876..420c192bccd9 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>>>>>> @@ -441,6 +441,25 @@ dwc_1: usb@7000000 {
>>>>>>                           };
>>>>>>                   };
>>>>>>
>>>>>> +               sdhc: mmc@7804000 {
>>>>>> +                       compatible = "qcom,ipq6018-sdhci", "qcom,sdhci-msm-v5";
>>>>>> +                       reg = <0x0 0x07804000 0x0 0x1000>,
>>>>>> +                             <0x0 0x07805000 0x0 0x1000>;
>>>>>> +                       reg-names = "hc", "cqhci";
>>>>>> +
>>>>>> +                       interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                                    <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +                       interrupt-names = "hc_irq", "pwr_irq";
>>>>>> +
>>>>>> +                       clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>>>> +                                <&gcc GCC_SDCC1_APPS_CLK>,
>>>>>> +                                <&xo>;
>>>>>> +                       clock-names = "iface", "core", "xo";
>>>>>> +                       resets = <&gcc GCC_SDCC1_BCR>;
>>>>>> +                       max-frequency = <192000000>;
>>>>> If I understand correctly, GCC_SDCC1_APPS_CLK support frequencies up
>>>>> to 384 MHz, but here you are limiting it to 192 MHz. Why is it so?
>>>>>
>>>>> I am not sure that 384MHz is actually supported as IPQ6018 datasheet
>>>>> clearly indicates that HS400 mode is not supported.
>>>
>>> I didn't check the datasheet, I opened the gcc-ipq6018.c
>>
>> I understand that, I just pointed it out, it wouldn't surprise me if
>> the frequency table
>> was just copy/pasted from IPQ8074.
> 
> Then it might be fixed instead, making the max-frequency property unnecessary.

The clock driver contains clock settings that were either autogenerated
or manually included, or copypasted. These settings, and particularly
downstream, only describe the known-working clock rates and the minimum
required voltage setting just to keep them ticking nicely (think running
a car with the clutch pressed, no real load), a subset (which may be an
improper subset) of which gets translated into the device OPPs (or frequency
levels downstream). We should have an OPP table here.

Konrad

