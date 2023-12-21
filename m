Return-Path: <linux-kernel+bounces-8848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2579A81BD38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E012B21D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FFC62808;
	Thu, 21 Dec 2023 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VssPLwX0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099759910
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso1247789a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703179766; x=1703784566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1xsSRw5an+DdkMAjpyEAY4wOM2WTUgfCJWFOCdWDXuk=;
        b=VssPLwX0IH/vmih/ua1LxK7xZFHLPtG6+iixEW3ScdPlnHYhfvhe6PHAGMibUkbIkf
         8hXtaWu/1El+zkTEeNA9fOqEXvA4jGED+Y4tP5uWttVdmxBT5NHNUtvkivyFVYRum08v
         4aqSBdg6MgVqOQN7oZTBM4nZ6ZNI1LxXp+Co+Mgj7/h6YOBeqX5R0NsLY7K668jyf41P
         N/2UrjCWWMTj+e4oRz0e2xVQ6bEPCwXXEogNNWimeL7HTfikqKzKu6k/FwdWz2JrZb/e
         pug5nbViD7wi1yLMPU6BY4AKI5NaVZllJPvvZdF2dgtsLkY2psi/ty8fNVX4zp9c3UNa
         KjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703179766; x=1703784566;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xsSRw5an+DdkMAjpyEAY4wOM2WTUgfCJWFOCdWDXuk=;
        b=OL2e3lnLVROBqIwNQMzwL9DSIIbpXa87HFvegNA1BGZieGFa9Fy9Ye+/SPfzdvXIax
         jwvX1GEGq5RRjr+29Sb2eg1plUA+9+v1S5q98VWq1trqauczd6tBijMP47TMWMsbxtI2
         YjYNnuVig8UDCIBxk1K4PxbH7UBLVjc2hy/4RbiYbtuLFnr0TbKMm+zrJp5qqufVmxvB
         1AJ3RhG9vHJrRxF9rZDqzqpxb4/1gCjc6ZVBBjEWDY/hmUyY2/znn30/zX/Lsqq307Jg
         mTV4l5xdx5SL8tyzFUfyfrl+Ohy0dWjbiAyojo5ZS9mvR/gvcKOQ+QbgUMpkLgIMSwgK
         P7rA==
X-Gm-Message-State: AOJu0YwgE0mHxPOlmwfjB0K+MlW0aO7j9yLX19Sm6XoyXL9A0XxYxTwA
	orkTPPHognSPLlzjN4QrF8lz/A==
X-Google-Smtp-Source: AGHT+IFy/pmFzHH9RNeBpLNUfZlghhNI7MnK89Wi0df0D+t+5qS1hRh1Dv354svHVBJl9esnRSs15w==
X-Received: by 2002:a50:b404:0:b0:554:1193:35ad with SMTP id b4-20020a50b404000000b00554119335admr827552edh.49.1703179766358;
        Thu, 21 Dec 2023 09:29:26 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402434400b005528265bc41sm1436066edc.0.2023.12.21.09.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 09:29:25 -0800 (PST)
Message-ID: <40d09489-8242-4be7-bbe1-4e80a729c218@linaro.org>
Date: Thu, 21 Dec 2023 18:29:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] ASoC: dt-bindings: Add tas2563 into ti,ta2781.yaml
 to support dsp mode better
Content-Language: en-US
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org,
 conor+dt@kernel.org
Cc: robh+dt@kernel.org, andriy.shevchenko@linux.intel.com, kevin-lu@ti.com,
 baojun.xu@ti.com, devicetree@vger.kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 liam.r.girdwood@intel.com, soyer@irl.hu, tiwai@suse.de, peeyush@ti.com,
 navada@ti.com
References: <20231221101346.429-1-shenghao-ding@ti.com>
 <20231221101346.429-5-shenghao-ding@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231221101346.429-5-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/12/2023 11:13, Shenghao Ding wrote:
> Add tas2563 to better support dsp mode.
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> ---
> Change in v2:
>  - Add devicetree list and other list of necessary people and lists to CC
>  - Express Compatibility in the bindings

Nothing changed in that matter - no compatibility was expressed.

...

>  
> -allOf:
> -  - $ref: dai-common.yaml#
> -
>  properties:
>    compatible:
> +    description: |
> +      ti,tas2781: 24-V Class-D Amplifier with Real Time Integrated Speaker
> +      Protection and Audio Processing, 16/20/24/32bit stereo I2S or
> +      multichannel TDM.
> +
> +      ti,tas2563: 6.1-W Boosted Class-D Audio Amplifier With Integrated
> +      DSP and IV Sense, 16/20/24/32bit stereo I2S or multichannel TDM.
>      enum:
>        - ti,tas2781
> +      - ti,tas2563          # fallback compatible

I don't see any use of fallback. The comment is meaningless. Open
example-schema and see how it is done there.

>  
> -  reg:
> -    description:
> -      I2C address, in multiple tas2781s case, all the i2c address
> -      aggregate as one Audio Device to support multiple audio slots.
> -    maxItems: 8
> -    minItems: 1
> -    items:
> -      minimum: 0x38
> -      maximum: 0x3f
> +  reg: true

No, why? Keep min/maxItems.

>  
>    reset-gpios:
>      maxItems: 1
> @@ -49,6 +46,34 @@ required:
>    - compatible
>    - reg
>  
> +allOf:
> +  - $ref: dai-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tas2781
> +    then:
> +      properties:
> +        reg:
> +          description:
> +            I2C address, in multiple AMP case, all the i2c address
> +            aggregate as one Audio Device to support multiple audio slots.

Description applies to second case as well, so keep it in top-level.



Best regards,
Krzysztof


