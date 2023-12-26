Return-Path: <linux-kernel+bounces-11498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C98DA81E747
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D3AFB21D77
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132FC4E618;
	Tue, 26 Dec 2023 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ra0guoUs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CF4E607
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so3477604a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 04:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703592773; x=1704197573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jtaM2b6oovv3VEFVs42AfAV1uVRd9vO3ycvBmWCiu84=;
        b=ra0guoUs9ksspI4cmT0Xdw39lEr2kYSWFp5wYIv1OpZGZECW9KKNNJzA8g68SgcvYW
         QBNHpJdt91v2V7y4GziWi13hbfNyqDDQzUgCfV82YiOeF6SJAAVnIXsz9C4suC0nyvGz
         pRmF0PGINCynxXbyDlq0hdGyNeb0JxAMA5rzTnTm+dRWBkV19eaYyjW5S7Kr1sgblUod
         7kY4Kb6JFuIYYW+y/eLP3XFKjcmiB3C6ATjrbIfl5Hk939WAJzSErwAx9z+PW3winQNQ
         ucdozg+Tdf38PfbrCrEsYIkOyPLV1GLXKc6y2JoYVHyJhyRX8fSExo4fJADD66K3K6sA
         1saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703592773; x=1704197573;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtaM2b6oovv3VEFVs42AfAV1uVRd9vO3ycvBmWCiu84=;
        b=XlRqP4svdG+mNDpPYIz23TWDqV8G9iI1CL9HATZss4Jv1yMZVp51xq0ItPxfTOd4RH
         iTb+i2v42vQZiR2uqjeiQ5cjmbjLCdOFl8I73uwmjDoAHyDhikrSjWl30kUYZMLAId+q
         U24uklnVK8xrCnj+WaPOMigwDi11ZtJ18MKgvtxzUg6lvT8B9VrXQpPtSJWSyoYmkgqL
         snHCmTDzGjrrUR8ndev8yiuR71VVr4Y6VFEc48L08NOYvceMk7rGC9D/g0u13d66EuCY
         L42NLlv6jtSKHvCFANbRJnkNteIweLbMM2cdP/b/FGZcGWF6ZJdlB7Tz/HOlBj/0X7Ls
         F6gg==
X-Gm-Message-State: AOJu0YwfHAZ9hq0Y2oTmrexvpwO6xMNW0oViOZAcyDuY/OF/BX51e+mx
	h0wJtUmHF4xK6SRiDmDRHEjNPG/dBEBWzw==
X-Google-Smtp-Source: AGHT+IGcuTRkPdUjqK/2XW9d9E54O3M/PJdMINhKx2QyTqfPzAgtuPfFO0iDS9hxY+DwoZcd3aMXKw==
X-Received: by 2002:a05:6402:888:b0:554:ca00:287c with SMTP id e8-20020a056402088800b00554ca00287cmr2664280edy.61.1703592772905;
        Tue, 26 Dec 2023 04:12:52 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id p2-20020a056402044200b005553a8bb61dsm193434edw.87.2023.12.26.04.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 04:12:52 -0800 (PST)
Message-ID: <0f1f0991-9ad9-4216-afc8-8340eddb1ad9@linaro.org>
Date: Tue, 26 Dec 2023 13:12:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: rtq6056: add support for the
 whole RTQ6056 family
To: ChiYuan Huang <cy_huang@richtek.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1703562468-29052-1-git-send-email-cy_huang@richtek.com>
 <1703562468-29052-2-git-send-email-cy_huang@richtek.com>
 <9715ed9d-7edf-430c-808c-00e7748bc59a@linaro.org>
 <20231226111921.GA22684@linuxcarl2.richtek.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231226111921.GA22684@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/12/2023 12:19, ChiYuan Huang wrote:
> On Tue, Dec 26, 2023 at 10:18:47AM +0100, Krzysztof Kozlowski wrote:
>> On 26/12/2023 04:47, cy_huang@richtek.com wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> Add compatible support for RTQ6053 and RTQ6059.
>>>
>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>> ---
>>>  .../devicetree/bindings/iio/adc/richtek,rtq6056.yaml         | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
>>> index 88e008629ea8..d1e1f36d1972 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
>>> @@ -25,7 +25,10 @@ description: |
>>>  
>>>  properties:
>>>    compatible:
>>> -    const: richtek,rtq6056
>>> +    enum:
>>> +      - richtek,rtq6053
>>> +      - richtek,rtq6056
>>
>> Aren't these devices compatible? Your driver change says they are, so
>> express compatibility with list here (and oneOf).
>>
> Thanks, I try to take other binding as the reference. One more question.
> If rtq6053 is compatible with rtq6056, there's only chip package type difference.
> Do I need to seperate it into a dedicated enum element?
> Or just put it into one item and said this part number is compatible with rtq6056? 

See example-schema. You need enum and items, both in oneOf:.

Best regards,
Krzysztof


