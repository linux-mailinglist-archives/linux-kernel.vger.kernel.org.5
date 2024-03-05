Return-Path: <linux-kernel+bounces-91469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F878711FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E49B283631
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7588BEA;
	Tue,  5 Mar 2024 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5ADGQSp"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A376110;
	Tue,  5 Mar 2024 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599772; cv=none; b=W6HRTmVEXj+mz/u98JfSs1IIuo+N2IkdZtIBSOp9wdVOxw5Bj7di2aeGRMFtAJ/w/H51JBLtYsOOdySZTi5U4MBfwVwJfRPocmM026yBOVneiCCHGXaoc9eD0X3SeBB/t0Gvvab8u46WVkPKh8gpuCQKQ5ZBZzrLCRJgysvsMd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599772; c=relaxed/simple;
	bh=J4n4n3ug8xj7D+g9LkKXtQRpuTp0CSeXy7Prgd+wrxk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=av3yceLOl34zka36LCLX12/3NvyabtcY05tnGQXIjJbfnxUO0acctrIkFV8LLXRDCrJk/+y1VPIvK4MjLxg2Ztib53tHXwDZO3wE9M5qt0BslDylddSP5why7I3BmjElfuDQ/nk8a//hARaFMAVHEekGm8+kKX4ZXsZ3xcp2JLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5ADGQSp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso4648930a12.2;
        Mon, 04 Mar 2024 16:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709599770; x=1710204570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=++8tOr68/fSpJcWWzBhYIXaEDMYMfDDTltrPw8fd4cE=;
        b=O5ADGQSpOFgNRpo5mQ2Jgkjx2CrMegMvlUo3sF7nH+ULr2TzVVOnM4UOqZfqys1UNk
         NKF1x2d4gV0uRGyD1bTikp4rYHt4kWZvffvU08jIyu8nrTQtdbBo3wRkSH4alvd4iXsk
         bHr4abPPpYbnKGIsRxQJMrLKpBGnDBwk0qOTm6l/zlO7xJDQMFYXtgrdgL616+G64NCT
         ghyW2omlRkHmNqQjvZ9bRI7xDIkVvGG4ZRU9nM7dGwypZMxXJym0dH8s7ylrK22iSFYr
         M9o/VdKvLmi4f0vO3Te/ST0o+68XD5Zfw4M7cVB6LXm81F8oSiO1AOS9jJCwQ1PPosM2
         Tjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599770; x=1710204570;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++8tOr68/fSpJcWWzBhYIXaEDMYMfDDTltrPw8fd4cE=;
        b=FwdmNKOLv/cVl3B9bU5jMf/0wEh1rOrPQuLv/eV5TF5t/HqAdE4UHq1cFjUAErpK8P
         ARnwmaKczmZdlzvZnDPx/VXCYpn/Wcp3R+3WC+Bq8GzCme3Zj5w1CicEJxoNi17EOqO7
         nuEBQ/NN4wcgsex1rNWrqRbZQkBlaAwktIWkYrGF++l+AcswvEXHCX+0EvR4l6qGUD0I
         1zzg1IYUonO22wuepTnHJHy2wBIs/t8ZntmzRGXiLdI3eZQxKBS6qoU9cLtnnzhR+gtg
         sEOckr2HVm2Pr43nK+9d8CaIlQ8t1EJJrX8Xs6gpd9M2zn6/27CIIxqQ8bKlG6i1EujZ
         9qnA==
X-Forwarded-Encrypted: i=1; AJvYcCVtubMx5Zj4xjtdBRsFT7SogQR3D410fuly6YPzWw3JVLc0fWGhUp6HU+oo+js1gbjTTSiEpvIHkFr7HzLm+9aYTzuMyR++y0DtBACMi5dZLO10ZkVsYE/YdXR4uQXlzoJ+EACbEoRR5SscXK87NVcFzU8J/duY1OW4OuSRW3C68+3+GWtzHaRcRRc2m6f+htJAy9d53rGYYX0Xte+jN+3X
X-Gm-Message-State: AOJu0Yz1FF1a+kkIvyioWjD1apCM7GsexcWv+UwtA+GcAeIBmUSGOC5m
	Gv3xMoFJeGqiM/ZNYGsPyiBKfFAi4XTBcJ0etbwoxNZ2PoWf6zLf
X-Google-Smtp-Source: AGHT+IH5f7z8Q19BNOLE8e016EtE1ruOEMmi8zcLQWUpBERw4Pj2U1o93Uic/p8AsbOd/1jk2BeayQ==
X-Received: by 2002:a05:6a21:3988:b0:1a1:31a0:f07a with SMTP id ad8-20020a056a21398800b001a131a0f07amr373567pzc.60.1709599769932;
        Mon, 04 Mar 2024 16:49:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090aae0900b0029b12d6b4a3sm7947605pjq.39.2024.03.04.16.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 16:49:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <03b6a094-b76d-4b4f-90d8-8b00219ec236@roeck-us.net>
Date: Mon, 4 Mar 2024 16:49:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
To: Zev Weiss <zev@bewilderbeest.net>, baneric926@gmail.com
Cc: jdelvare@suse.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, corbet@lwn.net, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, kcfeng0@nuvoton.com, kwliu@nuvoton.com,
 openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com,
 naresh.solanki@9elements.com, billy_tsai@aspeedtech.com,
 Rob Herring <robh@kernel.org>
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-2-kcfeng0@nuvoton.com>
 <1cf69d3e-a8b4-49f6-ac4d-550b525e45e2@hatter.bewilderbeest.net>
 <e590e3ba-f446-4f20-9618-d4ff388586ad@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <e590e3ba-f446-4f20-9618-d4ff388586ad@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/24 16:41, Guenter Roeck wrote:

>>> +
>>> +  min-rpm:
>>> +    description:
>>> +      Min RPM supported by fan.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    maximum: 1000
>>
>> I can't say with certainty that it's not, but are we sure 1000 is low enough?  Looking at just what I've got on hand, an 80mm fan I have will run steadily at about 1500RPM, and I'd assume larger ones (e.g. 120mm) could potentially go significantly lower...
>>
> 
> I have seen fans which run stable at < 400rpm.
> One of my systems right now has:
> 
> fan1:              732 RPM  (min =    0 RPM)
> fan2:                0 RPM  (min =    0 RPM)
> fan3:              586 RPM  (min =    0 RPM)
> fan4:              472 RPM  (min =    0 RPM)
> fan5:              480 RPM  (min =    0 RPM)
> 
> Those are 80mm fans. A quick check shows that various Noctua fans have a
> minimum speed of 300 rpm. So 1000 is indeed a bit high for the minimum speed.
> 

No, wait, that is the _maximum_ minimum speed. Got me there.

So, there is Noctua's NF-A4x20 PWM with a minimum rotational speed of 1,200 RPM.

If I interpret
https://www.mouser.com/datasheet/2/471/SanyoDenki_San_Ace_40LG28_E-3198440.pdf
correctly, it lists some fans with a minimum speed of 7,500 RPM.

Guenter


