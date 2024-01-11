Return-Path: <linux-kernel+bounces-23196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1379B82A8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217731C2265B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8EBDF5E;
	Thu, 11 Jan 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO9X2qPz"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6750DDA7;
	Thu, 11 Jan 2024 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e60c01112so2055065e9.3;
        Thu, 11 Jan 2024 00:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704961081; x=1705565881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rwQfo+ZJaEC5dJSMpIgccTGi76fIiQqAqibwMmXhHI=;
        b=jO9X2qPzzKT26eWkbHdg8X71zHSDYg4ZbGqsJA5IUEhn7VVAmhUAHlLKQ5CFWVZUF7
         mgDQVX4M23+eflaKNnuj0vFoxmkZQjbhkR2JFvzEwGPk6AVDxEwUu+dCJTKX92xzEn0/
         IRuR8Lhyn+OjyGAyAFbi0Xoqy0eMvUSmD9ZPZp9nGQAFyo67tqQYfZi5XO4czyYSgQ90
         M1iqIRAwqKgPJJ8HQfUKBctJXiPJCoFGeYNAK4LY8aK4Mnj+MqAHcgu/uxio0M4Z48xz
         /CXVNizcuU1/KcupenIzLP27x5N6t9418+kTpoGjdOUqSwDdprtig/WJXEB5662N9uv0
         ng7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704961081; x=1705565881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rwQfo+ZJaEC5dJSMpIgccTGi76fIiQqAqibwMmXhHI=;
        b=GRcQ5OHlKjKZj0T8RoJoKiQcgfggI2gyCfgX3e7y+a/S/kAzuoeRRisYbuYY2WL+t9
         qQB0ai+iuGPtyIYVeUi/5BDGWPqcyHc+BgMBZwWgMKvyYt/lNfwLCDtjIzgoWpvd3efJ
         Xa6y4ADsgqsJ8c+fl2gcOLxV4Dgq741kBp5lEKP4sOWj/3BwjeJjxTGXbuS+nywEs4Ho
         3qj1bXXTvPaNqfpSk3WrYv9m4qaEyKxbnDTjlyRQhjmWTu0trvuOEU7TPHGJE91kVaKR
         l+mTuQm97HiccluvAZB49YbnS3TQJn5FzUJ5F/zbmJ/vaKlIQydkibT0Sa963iq4haro
         sv1A==
X-Gm-Message-State: AOJu0Yw6Hm8dSUzBe12C/Ucr9w2DxHGdKI8kryg94TOTbf74zN3QrOI8
	WJia3dMdXgq+0P3EXAI3myg=
X-Google-Smtp-Source: AGHT+IHt/J3AVkSY28dINSArDDnQZqWP8Fj1RL8pSvDrJVbP0V7ClIf6ITN06YHaylgCtNAb15yqgA==
X-Received: by 2002:a05:600c:34c5:b0:40e:4e14:45bc with SMTP id d5-20020a05600c34c500b0040e4e1445bcmr184476wmq.13.1704961080551;
        Thu, 11 Jan 2024 00:18:00 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600c4e0800b0040e60dd364dsm768626wmq.14.2024.01.11.00.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 00:18:00 -0800 (PST)
Message-ID: <478d9445-96aa-44b3-b598-8f7d7716dbba@gmail.com>
Date: Thu, 11 Jan 2024 10:17:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: hmc425a: add conditional GPIO
 array size constraints
To: Conor Dooley <conor@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ceclan Dumitru <dumitru.ceclan@analog.com>
References: <20240110153757.5754-1-mitrutzceclan@gmail.com>
 <20240110153757.5754-2-mitrutzceclan@gmail.com>
 <20240110-unfitting-squander-b1d71c185bb7@spud>
Content-Language: en-US
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <20240110-unfitting-squander-b1d71c185bb7@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/24 18:17, Conor Dooley wrote:
> On Wed, Jan 10, 2024 at 05:37:09PM +0200, Dumitru Ceclan wrote:...
>>    ctrl-gpios:
>>      description:
>> -      Must contain an array of 6 GPIO specifiers, referring to the GPIO pins
>> -      connected to the control pins V1-V6.
>> -    minItems: 6
>> +      Must contain an array of GPIO specifiers, referring to the GPIO pins
>> +      connected to the control pins.
>> +        ADRF5740  - 4 GPIO connected to D2-D5
>> +        HMC540S   - 4 GPIO connected to V1-V4
>> +        HMC425A   - 6 GPIO connected to V1-V6
>> +    minItems: 1
>>      maxItems: 6
>>  
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: adi,hmc425a
>> +    then:
>> +      properties:
>> +        ctrl-gpios:
>> +          minItems: 6
> 
>> +          maxItems: 6
> 
> This one should not be needed, it's already set by constraints on the
> property above.
> 

No, not needed, just inspired from:
 /bindings/clock/samsung,exynos7-clock.yaml

Specifically, the top constraints:
  clocks:

    minItems: 1

    maxItems: 13

One of the conditional constraints:
  clocks:

    minItems: 13

    maxItems: 13


I would only have two arguments for this staying here:
 - It stays consistent with other cases
 - In the case a new device with more than 6 GPIOs is added, this would
need to be put back in

