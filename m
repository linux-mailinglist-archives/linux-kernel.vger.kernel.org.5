Return-Path: <linux-kernel+bounces-143992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC58A407F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97663B21509
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11CF1C68C;
	Sun, 14 Apr 2024 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVd/1JLG"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BAD1BF35
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713074836; cv=none; b=m8whcgA7oYPak/zF/NPVMNDiqtFf/4iV6If57uoKz1yDMS+L2ZP/aasQi/3mSoPq7N/7Qe6q27+eGkpIU/zY0d0q4fcr9lAfMZPky7c9+0Va+ZYKOotuuuJk97TJS3OBhybeCgOUJU+AaYE9lCY36vEVIKZIyuaFgT7ldAPbjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713074836; c=relaxed/simple;
	bh=rgUmJRNE583FfwwKk7ImcN7Q38hAoqx0XrUkO1ukD60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFs2F07z0BwNekIn4iZ0l8VjCz3k7I4nNZ1/bSVmBLpV55ytjlj1NWdahpsIGOwuIJqJtOKwBvV4rJ4D++ZE55KDZ05jY/r/NE1Wl2kfBFWl0xW4G+Ok0xLh88g8SPmaocFKVgxYG87e36Yac6MEUM+sAIt/stM6x9p66+o2DYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dVd/1JLG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so350796566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713074831; x=1713679631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=birczs2n38bj+qt5ct4BeQZrHZlbkYfeLVY4PLvG/PE=;
        b=dVd/1JLGtdaSD8GeGmiy1E/j175K0CLtYCiV7+QT2d/WzCQx395lMo0Yj0avJEq/rB
         bjUjTJKlZLSLXjWIj/YEOnSi9vK9aKUZQYwbrbqbGXJwEnXrJlQYS4KynCNfLRJf2dKu
         DNtTSpLvPJby2YDkzNPR81cVYvojOwiNd7jtG3nqOISI57DUCazlhX/LHxWj22BZXZZl
         N7Ka8CJz2PFmy1i/MduMezlIgW3B8gWw4+VmEKhxwn8I0vldGN78GymplTrw0cOvnnZm
         D5f4186i6CcG/OjvK2nn4lRY6bRVYcoYXDQensvbUVJFRmadjbk+FseG+2L0cQ/ON+cU
         9Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713074831; x=1713679631;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=birczs2n38bj+qt5ct4BeQZrHZlbkYfeLVY4PLvG/PE=;
        b=LivrL+/YtWlFbYawhx5Y8Vg+usRpAPO+TUJHSEg+jEoCxwWDF+BDxMI4xzUB3ytu7L
         Rn6GJPBoA7PDHnk2iKAVVNW/zOVQzxHSUf6srC4pb7bFBOIgIHZrEIW1fhPFbDohvFug
         kFrEcdv2s1AyvebLCwlrVol8+yxZLpWDTIhK4MoS9RBr36RdGqpc3kqvLOBcLxKneYFy
         WwZzKNLAGrClD8Fe0FxpKJNTKMLhcRKQBPdb2w6o1G3TX57215z38coSMJpeuHhOuIXT
         B6L2NFifhU0wWrY3DD2yh1DbtHehny2jdZPaJxJKqua1R2AE//xk4G+b1z15KkyI7W1/
         eYzw==
X-Forwarded-Encrypted: i=1; AJvYcCVAaMqHDulIHV2p4/44eS0SXwUmSbhdWl2vtnYBvRY6eR4VQO+Z5wALl+yN8XEXSoOovbiBJbv8IWESq83HeZBmoR9pomGFz1KJmew/
X-Gm-Message-State: AOJu0Yy01ggIpx5Vxuwmdcbh9n32J3URQWyl7R0fjRPnHiB9kWd7ZHeO
	TysmMz5uQoj7j9+7/6DGdjXXxrZ6R6NC+nwvY3fZBTU/81KDvTaoi1r2ehowPhs=
X-Google-Smtp-Source: AGHT+IFRHLi+mC72P5wOlGYDKkwCG3kYJ/bZgR0nHp32C5KCLzYuDmgD3GZXevlyaJteLdQJXgpgpA==
X-Received: by 2002:a17:907:72c8:b0:a52:51ce:3703 with SMTP id du8-20020a17090772c800b00a5251ce3703mr2468366ejc.2.1713074831322;
        Sat, 13 Apr 2024 23:07:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id rs6-20020a170907036600b00a4e6626ae21sm3811546ejb.0.2024.04.13.23.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 23:07:10 -0700 (PDT)
Message-ID: <13b195e6-cbbd-4f74-a6fa-d874cb4aaa45@linaro.org>
Date: Sun, 14 Apr 2024 08:07:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: max31790: Add
 maxim,pwmout-pin-as-tach-input property
To: Chanh Nguyen <chanh@os.amperecomputing.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240414042246.8681-1-chanh@os.amperecomputing.com>
 <20240414042246.8681-4-chanh@os.amperecomputing.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240414042246.8681-4-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/2024 06:22, Chanh Nguyen wrote:
> The max31790 supports six pins, which are dedicated PWM outputs. Any of the
> six PWM outputs can also be configured to serve as tachometer inputs,
> allowing for up to 12 tachometer fans to be monitored.
> 
> Add a new vendor-specific property, 'maxim,pwmout-pin-as-tach-input',
> to allow PWMOUT to become a TACH input.
> 
> An array of six integers responds to six PWM channels for configuring
> the PWM to TACH mode. When set to 0, the associated PWMOUT produces
> a PWM waveform for control of fan speed. When set to 1, PWMOUT becomes
> a TACH input.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
> Changes in v2:
>  - Update the vendor property name to "maxim,pwmout-pin-as-tach-input"   [Rob]
>  - Update commit message                                                 [Krzysztof]

Please put binding before its user.

> ---
>  .../devicetree/bindings/hwmon/maxim,max31790.yaml     | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> index a561e5a3e9e4..2d4f50bc7c41 100644
> --- a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> @@ -30,6 +30,16 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  maxim,pwmout-pin-as-tach-input:
> +    description: |
> +      An array of six integers responds to six PWM channels for
> +      configuring the pwm to tach mode.
> +      When set to 0, the associated PWMOUT produces a PWM waveform for
> +      control of fan speed. When set to 1, PWMOUT becomes a TACH input
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    maxItems: 6
> +    minItems: 6

tach-ch solves your case. You define which inputs should be used for tach.

Best regards,
Krzysztof


