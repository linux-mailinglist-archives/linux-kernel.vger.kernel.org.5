Return-Path: <linux-kernel+bounces-129327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5F89689C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DB828200C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E157412BE9F;
	Wed,  3 Apr 2024 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaD3L1HW"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160E6FE04;
	Wed,  3 Apr 2024 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132640; cv=none; b=E022XuXj4cIBa8HQsuil2I/JOPfpLDBbtebiTzFEgDe+SPbqRSaE4zqvsLuAHsOxD/VhHKFzpvcSsSXfpVi7/8vG2ocIy9bFQGX38uwrnj1HA9rKjhLDAvsKWmWDuM9Nz257bZ9ujN652r2nEJi19fdnQLMvnmrpqaA6BHisxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132640; c=relaxed/simple;
	bh=+M42Bao+ClNNeoWyVzyTejnWVkvKqhDo99qvjTGhSSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rRa3DKiHUx+5oZZUCTDhUfULiMHvG0q4MmScGuKR28oHa8maaA0puJOU1LMQ9XdLayq0EFFHV83T+WGxBKWHsdlVrNvmFRj/wUv47IKJMD6vidxcNtLhwwW55xkA1yp3TyqmjUrkvvxcV7ztPJC5I8yYoOrM/YnBbZ+LPfjgdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaD3L1HW; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51588f70d2dso7997938e87.3;
        Wed, 03 Apr 2024 01:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712132637; x=1712737437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJ4Sw0ukh/12TacOdDd7Bi3/+M5GpiW9CnKijj1wT7c=;
        b=RaD3L1HWDc+0w6d7yfbmhDSZI/XBRRBxaUuyCn1lEqUTRXz2wEAf76MIZQlEg+Gkhz
         p+VJBnZPZAkEeZlvaFP0JyEpfavaHlGtI4ZenGOIeZGJfeEWYzCiZFiD8Mag+5jRoyh2
         iw/1UBtRWe5LQUpRO2YJU646WB4h6hz600aReMnOcGy84t12NbqX+VW5jTUr45KQ9d6q
         bsq0br7/lqhd8mDSdbXNuHZXvWTyZxwHMDFr5BfBx2aJ5BIWLPUBKZh0pniZY/6uV/5R
         owpyCW+engZLdOqwH2xek35LKSeeYnHDg41WChg+4m4ms2rJNz2GohA5vlO0T9XndguQ
         r8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712132637; x=1712737437;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ4Sw0ukh/12TacOdDd7Bi3/+M5GpiW9CnKijj1wT7c=;
        b=dLOrCAe91Y/jMU/DfLGa31xZ2DNlYqo4SjT8+1FXN+iI9NyY7ePM3YUtCs3sGW+VaA
         bxQQcbSSgdEr8h1L51DB/jsdqo/XKEFDcP9/vRm9Awm3dQknCF91+VHUIUtBjsErMtKl
         WlE8beiao9fBjWIx+B4E06p+WzeLDZzZYYcxtu7vKR9f90z774fEqayZcX3JNKku8Cll
         EIIRmfzbaiO31q5FRWdb+IwULQjpR++d+G3Angb8V5LFKrkOH8S0gAEthIAsm8VL6DML
         pJPzy6eziMcAcr+H/eq+Rw1H+lNCGHlIsRYumgLHc7FCefG2dxkuj+xE5arh1pX6rli+
         Ib9g==
X-Forwarded-Encrypted: i=1; AJvYcCVdK+2dGidrpzy2bjGDcgD6YL4srcefA0620Pc9Hbu9PWrQ6xv1jJwTyaAnEEk6VToqH0hTfJ+9Tf1I0ehC7TtYKs/R48Tih2Zt9Efg3QJBxPWtLX9E+HdFwanZTluCZ8YaeTTH/d4QLw==
X-Gm-Message-State: AOJu0Yyf9GmnM5lRyzezIGpbVAzXYn/WzwnTmFh22L30gSDQ8bVLoxP1
	Q836ZT8CiiXqFMega0fdpDlMF9MA3Z2SblY2FOTVSj9/g0PyiV7q9KTQ7ACX
X-Google-Smtp-Source: AGHT+IELzTtNIEw+C4X9+qkLnlcWx3mAWu3YHSZjHWNQnqwNrTFWo5wmP+OjKO1XHFk6cHVHQXuoSg==
X-Received: by 2002:a19:5519:0:b0:513:2c86:3498 with SMTP id n25-20020a195519000000b005132c863498mr1309585lfe.48.1712132636692;
        Wed, 03 Apr 2024 01:23:56 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g19-20020a056512119300b00513ddd1760fsm1964610lfr.122.2024.04.03.01.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 01:23:56 -0700 (PDT)
Message-ID: <f875655f-3e80-41e4-8994-e5d30aea7003@gmail.com>
Date: Wed, 3 Apr 2024 11:23:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ROHM BD71879
Content-Language: en-US, en-GB
To: Andreas Kemnade <andreas@kemnade.info>, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402193515.513713-1-andreas@kemnade.info>
 <20240402193515.513713-2-andreas@kemnade.info>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240402193515.513713-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/24 22:35, Andreas Kemnade wrote:
> As this chip was seen in several devices in the wild, add it.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>


Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> index 0b62f854bf6b..e4df09e8961c 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> @@ -17,7 +17,9 @@ description: |
>   
>   properties:
>     compatible:
> -    const: rohm,bd71828
> +    enum:
> +      - rohm,bd71828
> +      - rohm,bd71879
>   
>     reg:
>       description:

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


