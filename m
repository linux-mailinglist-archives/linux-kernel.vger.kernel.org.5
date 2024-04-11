Return-Path: <linux-kernel+bounces-140520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E138A15B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3F42821C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9392714D439;
	Thu, 11 Apr 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJjhrMbk"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F41EB26
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842602; cv=none; b=nzYlLEeu0VanbixN4aXAEpV9SicgZLJuk8RVvdeyOy/e1SQGrop8Mf+h5j4QNsM4veuLIfKq9YuaC43nOHWn8YrNYEJygFQu9w4pQKOEBq8cxFlHiVKADl2YsY5NuBXK1sUteB/WB60WAb5kSfbCS5z5pj1+t9/iLXA9myjUXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842602; c=relaxed/simple;
	bh=PsY+0cp0r2CZ1Vl1ULBirCpa74L7iR5OUvVPi2TsLtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGmas6KSQtEuOLcnp3jo0WiwxGQWtgstV/GFMhwioXoeTlJduDJUeelcjCciSmCz1l1vw/TtrNPHzrJ4JOCOXj8yVEsPxgEGxLU7TL5FKpj8u9QGYcdIacZfMOBeOt0Llqi7Bh83uDgVOfisCaYtM13pOUWXNuZ4tw/tUeMyIP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FJjhrMbk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-417d14b39feso5750685e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712842599; x=1713447399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CYaEFXhyb6LZQLHIIVizc6COCxtPhfacc7ilKAheMt0=;
        b=FJjhrMbksWRyHtkTTcvUcVL5cNP/1kCzAFyjtybKugX3hkKu4vnJPOFj27VK3jusu9
         FwRS1HXLWyiZd4mn31AWQb6WFUj3cAET+5CzOmzxbFJt+7aBNqE+bpJvRtY87xL+aj55
         wmCuw4a/K7m3q8nplIlD2/uDbxh01iSwHGQG/ar0RoueuiUjaDPwuCpV7JPE2Tib62R7
         EbF25lKIGy5Vm4gbxuHOGo+0jfH9vazIYQdmAx5nyRPTIXkMs61F1zQ/7MqDSFCrqkC2
         RtvN58NYTUdTDchqAOM8lA1yKhm4mz4owm8Sf6hgTlIdhqtjXWw3dDuww3A+21guyMzi
         afAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842599; x=1713447399;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYaEFXhyb6LZQLHIIVizc6COCxtPhfacc7ilKAheMt0=;
        b=Kiv1KDVm/up//QkWKtjMnm0OAKzVPxMdT8MusABhZeSeZRQysOtwsRh0GI1udkQvWd
         SKbVV1e+EsbpKIMLl2/WsncQdJzCJLXTlge+eo6N78K/9J8XvKNiC8Kch18U5mbod1iL
         ZeP2RbmMym1ETtJbFTpC0tou8v6XiWAO18Yxsp7VUCpKCJLfc197QQTMFsB1BdYF/Lxk
         ht/ipRAC/QtfB2ZJwyUXUQ5AuPca/pazMzG1vGZ4P3U5t0Z2F1CFch35FCHVKWmrVI9o
         oB6TseKDyJIro0KFEhgvxWhhx6d9z/5o0Vn35/6WksIhvmDms2VrwL6wYtagI84MeePh
         N86A==
X-Forwarded-Encrypted: i=1; AJvYcCWWfEWOldgssYK7/AXVWzvuXdqpjl/W2Gx3AJx8wPZGnmiqX1hZeCyjHXIJHMIPpEEA6NwZc/fu7AU914xI+x0NtCvIq1OqLse311ZL
X-Gm-Message-State: AOJu0YzktPQPDA9o21EKyfPLQV7j9fmpD59Kw0LlzKJR6NtfBsM2bKEk
	D3NCoknCJ7PTIfeK7uIdRjsF8NsA/6d77k6UyvMxpUARO5RFDvMktmFGCbnGMLU=
X-Google-Smtp-Source: AGHT+IEX1udSEiYP7O2GbGoEX1Leu8G80HqYkS34ca2YUfC/I/Vafx1RaNkExfYNKcEtODspKTAWHQ==
X-Received: by 2002:a05:600c:19d2:b0:416:bbf8:27e0 with SMTP id u18-20020a05600c19d200b00416bbf827e0mr4254479wmq.40.1712842599353;
        Thu, 11 Apr 2024 06:36:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b00417caec4135sm2363003wmq.4.2024.04.11.06.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 06:36:38 -0700 (PDT)
Message-ID: <e6465ed5-c52c-44c2-8032-2ce0bbcf07a2@linaro.org>
Date: Thu, 11 Apr 2024 15:36:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: dt-bindings: media: add access-controllers to
 STM32MP25 video codecs
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
 Rob Herring <robh@kernel.org>, Hugues Fruchet <hugues.fruchet@foss.st.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20240410144222.714172-1-hugues.fruchet@foss.st.com>
 <171276671618.403884.13818480350194550959.robh@kernel.org>
 <278bccaa-edc0-4f3d-8e9e-6159d2b47394@foss.st.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <278bccaa-edc0-4f3d-8e9e-6159d2b47394@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 14:57, Alexandre TORGUE wrote:
> Hi Rob
> 
> On 4/10/24 18:31, Rob Herring wrote:
>>
>> On Wed, 10 Apr 2024 16:42:22 +0200, Hugues Fruchet wrote:
>>> access-controllers is an optional property that allows a peripheral to
>>> refer to one or more domain access controller(s).
>>>
>>> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
>>> ---
>>>   .../devicetree/bindings/media/st,stm32mp25-video-codec.yaml   | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml: access-controllers: missing type definition
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240410144222.714172-1-hugues.fruchet@foss.st.com
>>
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your schema.
>>
> 
> This patch depends on STM32 firewall bus YAML which has been recently 
> added in stm32-next branch. I tested it on top of stm32-next and there 

Where is it expressed in the patch? How maintainers are supposed to know
if this patch should be applied or not?

> is no YAML issues (neiter dt-bindings checks nor dtbs_check). If you 
> agree to ack it, I could merge it on stm32-next.

Drop redundant second "media" from the subject. One media is enough.

With the subject fixed:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


