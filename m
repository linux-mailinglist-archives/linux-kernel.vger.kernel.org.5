Return-Path: <linux-kernel+bounces-108898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B0F881189
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F37CB2331F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8D53FB85;
	Wed, 20 Mar 2024 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7OJwtXv"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A73B2BB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936959; cv=none; b=JE8xgDA/fS3SJWrkDYC88+qVXQYO7Z60JO5ShKE8Ui2tyn2+eCRMeW1wWdv91yNdgdk/ZX2SA2K3GjL/OyKPhV8hwoerxH7d0eWYePPJ5Nm6aVfT65ABZ+vSw8GbBKDemFB4s3JMdUw21xMi6w3xp9K5ZcLHNZp8CmjCP7SIANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936959; c=relaxed/simple;
	bh=tQer80CvvEW7IY5WeGKCkkCNaaVFh6qNbbSxYTpjuZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxfJEbcw+SEvitB0s02tEIlUPPRNkisdV0PlGeK5nE0mQsNYMVHtnBBF9oL6spUOGifzo+rQ9SRsL52lhGASOaXU/7vRZOnDtiDP20G3OcZL0dmodz0n7AuaRJP2bnFx/6l+mXnC9SrJWD/Wo/mkx49ysNKaRez7eY9fLG45dJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7OJwtXv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso653972166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710936954; x=1711541754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bJ8NNpe+o3avzYA+jPeB7yp7D/TXMUTkuPdqKHK6cCo=;
        b=u7OJwtXv5WzFRyF/bmxca59atgXIUDZNaEsPCL4Dh+oCTkoJD1gG8I8meY07TC6mbK
         3jRiV1SfWNZwakolxZP2wm+78GxrsqyX0SebkCV6aOpFwYEKmuY///ArdR5OV3H2UDEf
         256x8IAjnwWn9CkdUn3265O/Qeqym1msPaUwNsHXC5eq5D3y6i9laqvyLOmNYxH73KB0
         DeqQbBs5XXLd2OwL/lliO5/Hgw6JCr5WK071pmmp0fkEyhKeTNSfKj5E3MqRNkbEdKnN
         gWiN5kLW5FfNjcUQZ1y6u4amkYRzURZMDFsN/kI5evrEoQI4cJR1nzrhkLQiLjPnHGxs
         UJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710936954; x=1711541754;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJ8NNpe+o3avzYA+jPeB7yp7D/TXMUTkuPdqKHK6cCo=;
        b=KcR9eoSS0u49paQbd3s7FMQkBjhQRuGRVGzoq6iNzkVyE3yw0RaID7C/TR/akgz/zw
         z61lTwExPEZkTxaKG8AJYDEdUwL9t0wXxlY20jqoJ1tO6gnYgNlxPpqLp1+zt1wGSMBo
         P3eS35Bh62+OAnYRtt6Ji6cLs2vMCuO1ogixxyUHO/u8K2OpEuZoXT4AE/QwxcwD069l
         GOAdwrQnlkq6osTdTs3GvDKdB/3k2liY8nLtc/nyXWDopdYTf7fbG7SbCjKXxpXtPC1K
         ZSrhCiN3/WpSTnRgy48ybpOEngu7niKx1kEFJ1Nw+VmY4oTD31jkDjyCqJcWgbPPxFJw
         8hiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuTw3abc7EpaU/5oRG/TWchvzG5cLbttCV8dvo3dkINBUrmuS2qGRec7zSKJMC/oAqrcvBmu/yp412oAivfQZ1+LRIoTJpkjBcmIGV
X-Gm-Message-State: AOJu0YwpHGpNFIUSO3NEHinL/uWb8At5jDJHqnlWYtWiHKKkBQ+QSrwc
	r2O4SNZTai7RDhbcedhcSSHf0EJNwHaYDPNgN95u9qjywc8PMEBJiSjJAlPmKLo=
X-Google-Smtp-Source: AGHT+IE8P3/N8/J6gRAFmhgU1tfJZghnrdxp7vomDNfX0tpvGceup2fO30D9pq8l5GfVUtFmJZuyXA==
X-Received: by 2002:a17:906:b7cb:b0:a46:f355:df68 with SMTP id fy11-20020a170906b7cb00b00a46f355df68mr1137519ejb.33.1710936954580;
        Wed, 20 Mar 2024 05:15:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id qk26-20020a170906d9da00b00a45bb14b1a5sm7171652ejb.89.2024.03.20.05.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 05:15:54 -0700 (PDT)
Message-ID: <7e58bf96-3c38-467f-86b6-06ff5feedb31@linaro.org>
Date: Wed, 20 Mar 2024 13:15:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: nxp,imx93-adc.yaml: Add
 calibration properties
To: Andrej Picej <andrej.picej@norik.com>, haibo.chen@nxp.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 upstream@lists.phytec.de
References: <20240320100407.1639082-1-andrej.picej@norik.com>
 <20240320100407.1639082-3-andrej.picej@norik.com>
 <38637621-1611-4268-ae79-7ac93a72c5ee@linaro.org>
 <e994b756-7f4e-4be3-b8f3-310988174b44@norik.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e994b756-7f4e-4be3-b8f3-310988174b44@norik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 13:05, Andrej Picej wrote:
> Hi Krzysztof,
> 
> On 20. 03. 24 11:26, Krzysztof Kozlowski wrote:
>> On 20/03/2024 11:04, Andrej Picej wrote:
>>> Document calibration properties and how to set them.
>>
>> Bindings are before users.
> 
> will change patch order when I send a v2.
> 
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching.
>> There is no file extension in prefixes.
> 
> So: dt-bindings: iio/adc: nxp,imx93-adc: Add calibration properties?

Did you run the command I proposed? I don't see much of "/", but except
that looks good.

> 
>>
>>>
>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>>> ---
>>>   .../bindings/iio/adc/nxp,imx93-adc.yaml           | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>> index dacc526dc695..64958be62a6a 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>> @@ -46,6 +46,21 @@ properties:
>>>     "#io-channel-cells":
>>>       const: 1
>>>   
>>> +  nxp,calib-avg-en:
>>> +    description:
>>> +      Enable or disable averaging of calibration time.
>>> +    enum: [ 0, 1 ]
>>> +
>>> +  nxp,calib-nr-samples:
>>> +    description:
>>> +      Selects the number of averaging samples to be used during calibration.
>>> +    enum: [ 16, 32, 128, 512 ]
>>> +
>>> +  nxp,calib-t-samples:
>>> +    description:
>>> +      Specifies the sample time of calibration conversions.
>>> +    enum: [ 8, 16, 22, 32 ]
>>
>> No, use existing, generic properties. Open other bindings for this.
> 
> You mean I should use generic properties for the ADC calibration 
> settings? Is there already something in place? Because as I understand 
> it, these calib-* values only effect the calibration process of the ADC.

Please take a look at other devices and dtschema. We already have some
properties for this... but maybe they cannot be used?


Best regards,
Krzysztof


