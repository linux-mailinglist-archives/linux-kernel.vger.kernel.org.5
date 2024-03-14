Return-Path: <linux-kernel+bounces-102902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0C687B830
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9080F1C22D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298D9DDDA;
	Thu, 14 Mar 2024 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YI3qPqvr"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8255664
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399692; cv=none; b=KcOkvm/ciwMRWcN4XaBmDe/roRR4GKcZPf4g8qxn1CPPtWvj0zJX57pix2AQuzpTZWLqF2buniUpVuVHu5Uma/Dn+aEugvaq3x9v3Gyql2IfuG+Wa/p0K/8EqOFoZK2PnBV0QoiQWz5lT6EA0olRuElMsChtiSSvshYf+YnM3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399692; c=relaxed/simple;
	bh=7NkQyoOA1mHyQIXA52IUTmI0Wd4PYuuEIHltkCMQUOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJOzqCFhQxxFdZaEGhVtDuZun1HmaBBbjTQ4mfuB0LuB/wCMNsD+Z0K1alooE9HhWWcXCdh9Kmx/Bjd2uZfaqN35q7QGwLrLJiJ6Ip1VNhFmLhEYJpyHH3dzNfbZBAdrqTDYEO0lzoijEoJ6XsGu4v0qK2a02Pl0hhEPQ4b3Yyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YI3qPqvr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ec7e1d542so130204f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710399688; x=1711004488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lbY8CxO60JeZjTgbdzeSJeBKzxbN0g8ObCIYlzq2v4=;
        b=YI3qPqvryHjB9ZAa6n3qiAwlKAYAbaPoOAa7W9eNkKLM6iclN+7mZwUnuggy4RxTKC
         jAewnAtcs/M0QAxwUXCFQt4KoGO6k4R9xB4qbvDzwRV1x7ICH+KVaeJ5Ig0LTnI9Z5qC
         F+M803AlZ4XRPXHZwaRsJS9ok3XA0sNHdvHKNXaUzueRcL5iWdG4C5tqPVd56sRDaCWf
         bzeif7NbZFEGfZaA2d1NZL5pE7/bJO32WW0oR/vQLg08ga03HgE/tTPyAqslHfUQR6ef
         pmYhWZXx+acnc3yHtWMRKkQ4t+LMNNdGYFpxiMmA0YKfXAhM3i7INLz86E23s+t0JkDZ
         Y0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710399688; x=1711004488;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lbY8CxO60JeZjTgbdzeSJeBKzxbN0g8ObCIYlzq2v4=;
        b=VbWnAsURU3DUFBUxuopFdhi8LBnatHQrxq/3Zfn7s2IixC+JxHNWbZRXIyIl4/P25l
         kmcPzOvnFeJC+/4UNtwJ0RkR75giVOS0zo8iCzxBDNQW81PRwlv9yrbvY2fgQXqS6ltG
         JAAwGhK1Jp/PbQmlgZODalY74Emr6IS3Web7Ji/DO+4Z0Ad+3PBDjD9furQSVCyi437s
         ZRI0ql2T5ipHozVDZVrwrC0CbV0lDmegJL/u7HU6KJEBM2amGpmHNzJitidhHQXajhqw
         KqsT4VRfoao6dOI4DHZe4xHiuTTLIPMz8/mi+KtYM1J9VpYMsAZ4z9csTU8HjObJ+Iiq
         1pow==
X-Forwarded-Encrypted: i=1; AJvYcCXaMAojhEQHYXYuvLUkT7l36UnMW2uc9MZHTebr8F51MSSVoACzHbUStSdOZAj6ZtRjkR3OVKU2RFOxyeC1ygr1JrNdBU9eOOVO8wzo
X-Gm-Message-State: AOJu0YzmrQfC9cbdF6HQmslnMU1GzqnkjG+W74iYk95mM520D+v52gfJ
	RUKpFgPTFlSnbVlvYVNrPoNHkFWnvmyzdx7fQQgI3Mqz08gbk0d+24s787xqvcc=
X-Google-Smtp-Source: AGHT+IERaoaq1F3MVIhdgIzUtYz0Iuz2Pu/YzlkKgvcGZZUiGSmADiZ0Y/YE0roJ6qi4Vox3KEy3tw==
X-Received: by 2002:adf:fc8e:0:b0:33e:c974:1296 with SMTP id g14-20020adffc8e000000b0033ec9741296mr161792wrr.25.1710399688114;
        Thu, 14 Mar 2024 00:01:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id v29-20020adfa1dd000000b0033ec3c2e410sm15902wrv.23.2024.03.14.00.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 00:01:27 -0700 (PDT)
Message-ID: <3163c850-a0e0-4170-a5ee-cfc412b875b4@linaro.org>
Date: Thu, 14 Mar 2024 08:01:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: qcom: Document rb5gen2 board
Content-Language: en-US
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Wasim Nazir <quic_wasimn@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240313071238.3290-1-quic_wasimn@quicinc.com>
 <20240313071238.3290-2-quic_wasimn@quicinc.com>
 <fc00af46-1521-4bb8-9b7c-237cbd26a17c@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <fc00af46-1521-4bb8-9b7c-237cbd26a17c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 05:15, Caleb Connolly wrote:
> 
> 
> On 13/03/2024 07:12, Wasim Nazir wrote:
>> Document board bindings for Rb5gen2.
>> Rb5gen2 is using Rb5 gen2 SOM which is based on QCS8550 SoC.
>> RB5gen2 is development kit used for IOT solutions.
>>
>> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 8115088a6076..de6139db8ef6 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -1013,6 +1013,13 @@ properties:
>>            - const: qcom,qcs8550
>>            - const: qcom,sm8550
>>
>> +      - items:
>> +          - enum:
>> +              - qcom,qcs8550-rb5gen2
>> +          - const: qcom,qcs8550-rb5gen2-som
> Is this a Thundercomm SoM like the other RBx boards? If so, shouldn't it
> be "thundercomm,c8550-som" (Or "qcom,c8550-som")?

If this is the same product, then yes. It's clearly not Qualcomm:
https://www.thundercomm.com/product/c8550-som/

If not, can you point us to any resources on this?

Eh, let me un-review it.

Best regards,
Krzysztof


