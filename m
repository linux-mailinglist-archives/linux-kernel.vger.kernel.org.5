Return-Path: <linux-kernel+bounces-7974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97DD81AFF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A36B2136F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB415E9B;
	Thu, 21 Dec 2023 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y21Q/4nu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8BF171BC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a235500d0e1so48315266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703145846; x=1703750646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZ3EgJBFwrcoVo0x7FF2XBy23R5zWqDNweyq7hF92Xc=;
        b=y21Q/4nubZxNvE4iaPceQn3FC9djLrq15pxNabyxtRNraZt1znDbReXOG6ctGLaCW6
         DF+rcmspE0mgMkdYUfYTodGFvmQzxCUvHSQ9yqLIpo5+MtqbhY/Xs2z4N128f4b9L9PF
         frosukRXqPe8gqoftOh5U7N/e4xE9Jpemdy23KhzkOO542yT8BxTClxFoN1MnL6xXvZn
         GZv8NOS53fD5IkJTsDKYuOXGwGl3CGVxCZ/4jAqOCGBrRC2K1u3VGdeJsMOeRXZ1xYDS
         YpMWpISkrvIlD4OUwLQ0bLhZw6p1fDETCdQ6dqO6ir66W5MjX2LhS31k5ax21vFZ7tWI
         4dEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703145846; x=1703750646;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZ3EgJBFwrcoVo0x7FF2XBy23R5zWqDNweyq7hF92Xc=;
        b=Q3xAjx+7qOUD1eoTXS3X++b/Xi1N6um0S4ks8VRKIhN2T41Dylp0q99IbqTkTGSVjo
         bi3+BZiYFiyL3110fMfkkzTBUmYNZ69TiKsx1gQ1mMydgfANNo5crxRfQ0hq6KKSXQj9
         zOsSqQa0z8EUoAH4A7foT4HmUG9gGpNE+l4mET4zd4Hx3iCHvYc77Wi/7dIzqIpR5WqW
         Es5gpwmzmJIFfYtzDHs3fyqpUPq7OPWHW3S5WSUTUoMRWbr/cCcNB/lVKYyxScKGLElh
         MBFKXyxBbeOjLoxafzAIdNhUUZ2xmfJCv9eL3PDrWIGQsU/5emC4AVOPl4VISrKefG8F
         Czyg==
X-Gm-Message-State: AOJu0YyyaWtI80vkA4wxLS4ocbB2Ys8qyXpyJipDwjeh6Rss6g9ccwU7
	7PO1vnNX/k0eXryhhhH7nOZ4Cg==
X-Google-Smtp-Source: AGHT+IFlLf/Y8txPOazZFFIbWprrfrvwwiSUa02b2iZjD/FdJ5o9tWd17tCYfFEumi8+76SEor2ClQ==
X-Received: by 2002:a17:906:b4b:b0:a23:633a:79c2 with SMTP id v11-20020a1709060b4b00b00a23633a79c2mr3410151ejg.94.1703145846007;
        Thu, 21 Dec 2023 00:04:06 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id zx13-20020a170907348d00b00a26881eeda6sm662421ejb.99.2023.12.21.00.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 00:04:05 -0800 (PST)
Message-ID: <bea6c2ed-c47b-4bbe-8cda-6e28fd2fcea8@linaro.org>
Date: Thu, 21 Dec 2023 09:04:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: iio: adc: Add QCOM PMIC5 Gen3 ADC
 bindings
Content-Language: en-US
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 daniel.lezcano@linaro.org, dmitry.baryshkov@linaro.org,
 linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
 andriy.shevchenko@linux.intel.com, quic_subbaram@quicinc.com,
 quic_collinsd@quicinc.com, quic_amelende@quicinc.com,
 quic_kamalw@quicinc.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, marijn.suijten@somainline.org
Cc: lars@metafoo.de, luca@z3ntu.xyz, linux-iio@vger.kernel.org,
 lee@kernel.org, rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 cros-qcom-dts-watchers@chromium.org, sboyd@kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
 kernel@quicinc.com
References: <20231116032530.753192-1-quic_jprakash@quicinc.com>
 <20231116032530.753192-2-quic_jprakash@quicinc.com>
 <832053f4-bd5d-4e58-81bb-1a8188e7f364@linaro.org>
 <716cf526-59e3-e755-0a47-ff9ae496e87c@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <716cf526-59e3-e755-0a47-ff9ae496e87c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/12/2023 09:00, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 11/16/2023 5:13 PM, Krzysztof Kozlowski wrote:
>> On 16/11/2023 04:25, Jishnu Prakash wrote:
>>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>>
>> A nit, subject: drop second/last, redundant "bindings". The
>> "dt-bindings" prefix is already stating that these are bindings.
>>
>>>   
>>>     reg:
>>> -    description: VADC base address in the SPMI PMIC register map
>>> -    maxItems: 1
>> NAK.
>>
>> I wrote it multiple times. You canno remove the widest constraints from
>> top-level property.
>>
> 
>>>     '#io-channel-cells':
>>>       const: 1
>>>   
>>>     interrupts:
>>> -    maxItems: 1
>> No, srsly. We went through it.
> 
> 
> Is it fine if I add the bindings for ADC5 Gen3 in a new file? It's not 
> just for the reg and interrupts properties, I think it would make sense 
> to have a new file as ADC5 Gen3 is a new device combining the functions 
> of the existing QCOM VADC and ADC_TM devices.
> 

The patch is no longer in my mailbox, that was more than a month ago.

Best regards,
Krzysztof


