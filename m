Return-Path: <linux-kernel+bounces-23276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA61982AA16
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C347B1C2564B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDE9154B2;
	Thu, 11 Jan 2024 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jt2phPfC"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464471772E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2bdc3a3c84so156712966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704963516; x=1705568316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEyCOzWKzhN6fJuNZ8x6DfrD1KxuLW5yl178ZcMbpVM=;
        b=Jt2phPfCjPKwX0A6qbLtRcbt0BvnJSbqP9E+w4/rJru/CDr1RP9u610lMf0UPIGvzt
         8LIaUQqVzZT+2Gge9nJxnekH+Q6MxN0oPX9eJLU7EktHz4uqa5dpyIvt3YqQfOy62deU
         vQFuqRl/vhaAksInZ8qqrgOdERaIXw5sTzc7DmlIZgn5mJXxboEG7S/6AMLf/vrxbzdp
         Sxs+FVhg83sIJ5lUbduG4LKs+Y8PFOM217/tRv5922rQcLKxBbbo2NubJfAlZaZNi0Re
         4DsB/Z8gLVHbJJUEbeibf/02h/ABeqXnx39/9+J4rRkk4FG2mZC9UYdrmchI2RleDkoZ
         3d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963516; x=1705568316;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEyCOzWKzhN6fJuNZ8x6DfrD1KxuLW5yl178ZcMbpVM=;
        b=doUgJz0qWGxGaRl0+3R3sX2BGN9JsBHZ73t+2gGcZ8mt/uXoCElVpfu/HIU9eBTRA5
         oGjb2uVFQlN2BHZx/cE+bqTqKYcVR7XeBYXOROCqO387m6bWKhVgeyWSdF4sI+Dgp7NT
         yx8JfW36Ssjsx38kB8FtlklnlYWf+3BtJ+/Vkm92p6AbSsg6GPnIH8A7g0WVMKjUxqq3
         AuTBKr12+1o06UriaJj5v6ifA74NnqIjVzbc/8hy/zNNfQzv5zkUZwXJb+iU9XE1yUYu
         b0vhqnR4gA2ggiKe3Ma0713v5VFHwXby4CIxsYH4uJFWLvRpzvDyv8m+xCgo37YNmYXf
         FOOA==
X-Gm-Message-State: AOJu0Yx7Bvn6yS9eH++3rW+1Lh8OeS0TWhURtdiJXYUltXZQJy89q+qD
	wMqBGlS9Zg3ErTfSJLm9qHEu+MGRZpIXmA==
X-Google-Smtp-Source: AGHT+IGGJC7YroF42FIiBLUaEY8Uwq+Z4UdPUsTbm5xkNKjL/CJMPFhImK0PVAA1pnXowysgl9C1OQ==
X-Received: by 2002:a17:906:e12:b0:a28:e5eb:3f31 with SMTP id l18-20020a1709060e1200b00a28e5eb3f31mr398132eji.80.1704963516564;
        Thu, 11 Jan 2024 00:58:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id rv25-20020a17090710d900b00a26c8c70069sm319909ejb.48.2024.01.11.00.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 00:58:35 -0800 (PST)
Message-ID: <3476ab0f-1589-4023-9951-3c03ab2467c3@linaro.org>
Date: Thu, 11 Jan 2024 09:58:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3] arm64: dts: qcom: qcs6490-idp: Add definition
 for three LEDs.
Content-Language: en-US
To: Luca Weiss <luca.weiss@fairphone.com>, quic_huliu@quicinc.com,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111-lpg-v3-1-811c9e82dae4@quicinc.com>
 <CYBQW9KRHVJS.3UOHTOMRWDWVK@fairphone.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CYBQW9KRHVJS.3UOHTOMRWDWVK@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/01/2024 09:47, Luca Weiss wrote:
> On Thu Jan 11, 2024 at 3:52 AM CET, Hui Liu via B4 Relay wrote:
>> From: Hui Liu <quic_huliu@quicinc.com>
>>
>> Add definition for three LEDs to make sure they can
>> be enabled base on QCOM LPG LED driver.
>>
>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>> ---
>> Changes in v3:
>> - Rephrased commit text and updated the nodes to qcm6490-idp board file.
>> - Link to v2: https://lore.kernel.org/all/20231110-qcom_leds-v2-1-3cad1fbbc65a@quicinc.com/
>>
>> Changes in v2:
>> - Rephrased commit text and updated the nodes to board file.
>> - Link to v1: https://lore.kernel.org/r/20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com
>> ---
>>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> index 37c91fdf3ab9..f801144a1556 100644
>> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> @@ -5,6 +5,7 @@
>>  
>>  /dts-v1/;
>>  
>> +#include <dt-bindings/leds/common.h>
>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>  #include "sc7280.dtsi"
>>  #include "pm7325.dtsi"
>> @@ -414,6 +415,30 @@ vreg_bob_3p296: bob {
>>  	};
>>  };
>>  
>> +&pm8350c_pwm {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	status = "okay";
>> +
>> +	led@1 {
>> +		reg = <1>;
> 
> Hi Hui Liu,
> 
>> +		color = <LED_COLOR_ID_RED>;
>> +		label = "red";
> 
> Please remove the deprecated "label" property. Since you already have
> "color" set you only need to add "function". On phones for the
> notification LED we usually use "function = LED_FUNCTION_STATUS;"
> 
> Also depends on what your hardware looks like, if it's 3 separate LEDs
> then with label replaced it would be okay.
> If the 3 LEDs are in one spot (so you can mix the colors with it), then
> please make it a RGB multi-led like e.g. in sm8550-qrd.dts.
> 

I already asked for this and it was ignored:

https://lore.kernel.org/all/6aa67adb-a4d5-40da-a261-c90050ac04b2@linaro.org/

Let's engage three different community reviewers to repeat the same, one
feedback. This is just disrespectful to our time.

Best regards,
Krzysztof


