Return-Path: <linux-kernel+bounces-23509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6175382ADC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2E5284529
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF1154AE;
	Thu, 11 Jan 2024 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCV6MjnT"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361C15492
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33748c4f33dso5046664f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704973643; x=1705578443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsiMBO40kJH/thHe9GYKBdch/ltIhJJopmiy+KYSE0U=;
        b=SCV6MjnTBEwnAx90IWXp+L6rn3rtHzJbjH1050VIUmAgdLRnFjWUw0qn/jf7ZrBv4i
         gxQ4iLW775Q2J0qDMTN0M7lig473alfCz1JvP2WetJvGS4OzDHiLcy0VnRtOl800J0mg
         xzlurMKEckHLiQSNtC/WiwU0FHIqgD/j7jDfBn+fskDRJmXa6B7kLCsmaxXgdmXBxypy
         Sb6bpD2KPQZRxhE/voZRtwhH/+xyAkoLiAcOASdAVlH4Dad4wXMxRyie25VgTvVW7O2A
         iY70cCHvH3q6NyRPyP+Y7a+l0AoHGoLU3KRqSpXKaYFJqAK7CLOsksa6awzCyezk/3Cd
         xUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704973643; x=1705578443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsiMBO40kJH/thHe9GYKBdch/ltIhJJopmiy+KYSE0U=;
        b=mnMIezePcjLi4R5cP84J88bFd2HYO1bQpQW35lCABIftztp4T2WZGN2QpDDpp1ITuP
         hKoxN0lJiDvqnpACqJLzH5kM03G0YyWvd1V5QrBQhZZWwbikAOEZvRNSNiBScDq5dNYO
         l06W165mgNJIGQy0riFFt3WPV6jxncv/NLQQyoXnEjUcEPPok03kHS7m51BbcA1y6rZc
         tMzol6Zq0myMqIY5c0wdhJDlEAYTq3sqEwjtnuvXOsJusUwzsG1/+94IRhmUOjSRC41H
         9iVen016E1jCyp/6fRYO7jgM5sAmKVOrzIt94tGtufmyWP/UoXdmkQRRYmKc5hdsNeH0
         WnrA==
X-Gm-Message-State: AOJu0YzP6ImeTlGwLfF5wfVDRNiBV3z0cqhMDY2nFYKCWf4VwBhTu8Mz
	b3DVwZhEC4gFZDTrr2NiiRddBt58O+eLQQ==
X-Google-Smtp-Source: AGHT+IE+uP9ZMTE1oSuFFPj96rhKKdrXLb2ZF+0WzdY/iPUZIT3Q98p9oBGkuqLOP2WDpR2+j7QUug==
X-Received: by 2002:a5d:4449:0:b0:337:4921:6e74 with SMTP id x9-20020a5d4449000000b0033749216e74mr617802wrr.84.1704973643391;
        Thu, 11 Jan 2024 03:47:23 -0800 (PST)
Received: from [192.168.100.48] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id h18-20020adf9cd2000000b00336a1f6ce7csm1019372wre.19.2024.01.11.03.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 03:47:23 -0800 (PST)
Message-ID: <d9d260e4-c395-4ec3-bb41-10d2af6a1d96@linaro.org>
Date: Thu, 11 Jan 2024 11:47:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: sc8280xp: camss: Add CAMSS block
 definition
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-0-b8e3a74a6e6a@linaro.org>
 <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-4-b8e3a74a6e6a@linaro.org>
 <927d1ca0-3915-4039-b855-b31ff5280cf7@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <927d1ca0-3915-4039-b855-b31ff5280cf7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/01/2024 11:03, Konrad Dybcio wrote:
> 
> 
> On 1/9/24 17:06, Bryan O'Donoghue wrote:
>> Add CAMSS block definition for sc8280xp.
>>
>> This drop contains definitions for the following components on sc8280xp:
>>
>> VFE * 4
>> VFE Lite * 4
>> CSID * 4
>> CSIPHY * 4
>>
>> This dtsi definition has been developed and validated on a Lenovo X13s
>> laptop.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 239 
>> +++++++++++++++++++++++++++++++++
>>   1 file changed, 239 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index f48dfa5e5f36..35bc31117b41 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -3614,6 +3614,245 @@ cci3_i2c1: i2c-bus@1 {
>>               };
>>           };
>> +        camss: camss@ac5a000 {
>> +            compatible = "qcom,sc8280xp-camss";
>> +
>> +            reg = <0 0x0ac5a000 0 0x2000>,
>> +                  <0 0x0ac5c000 0 0x2000>,
>> +                  <0 0x0ac65000 0 0x2000>,
>> +                  <0 0x0ac67000 0 0x2000>,
>> +                  <0 0x0acaf000 0 0x4000>,
>> +                  <0 0x0acb3000 0 0x1000>,
>> +                  <0 0x0acb6000 0 0x4000>,
>> +                  <0 0x0acba000 0 0x1000>,
>> +                  <0 0x0acbd000 0 0x4000>,
>> +                  <0 0x0acc1000 0 0x1000>,
>> +                  <0 0x0acc4000 0 0x4000>,
>> +                  <0 0x0acc8000 0 0x1000>,
>> +                  <0 0x0accb000 0 0x4000>,
>> +                  <0 0x0accf000 0 0x1000>,
>> +                  <0 0x0acd2000 0 0x4000>,
>> +                  <0 0x0acd6000 0 0x1000>,
>> +                  <0 0x0acd9000 0 0x4000>,
>> +                  <0 0x0acdd000 0 0x1000>,
>> +                  <0 0x0ace0000 0 0x4000>,
>> +                  <0 0x0ace4000 0 0x1000>;
>> +
>> +            reg-names = "csiphy2",
> The random newlines kill consistency with everything else
> 
> Konrad

Not random.

What exactly are you asking for ?

---
bod

