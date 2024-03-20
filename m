Return-Path: <linux-kernel+bounces-108756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746D8880F98
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E043A1F224DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261363D993;
	Wed, 20 Mar 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+rQpkij"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74F3BB48
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930253; cv=none; b=S8/eB5pDASsgrUsL3AZvpeMwXuN5jdLFQSlwkN0vQ90xfUC0e4o/nZUv33Py7hsQP7i9xMyYmpQgzTkq/2SzRk4iroW6h92J40Fz7G5hFvef06JinZw96Bwd1c9m8G0pMPw1CxHui1jhGPVUuAmqQOq1gW9DdwBvAg9YEu484qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930253; c=relaxed/simple;
	bh=FntOVS9RTj65ER/1UeXzQzNeQZXqJvEG86AIMo02Vio=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fApDAcrWZAjKET+5DzTNBOcfHaVbaCh+1JL/0zC2nSdAi51yJqYi/dekzzUZsqaZ/HB0B5DzvxBjx+rtwPjbfiBtlbmnBISsCBAu0WPgKy/3ClQWHIGHq01y6kN/XdaYObNt8I7+Q/n7T5svuw/wQDyBk4/pydSazgC9WC+ojOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d+rQpkij; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46dd7b4bcbso221343766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710930249; x=1711535049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zUxLDUcelK/0PKWxOgb0tRnuM6xgbFRxgTPdQohocPE=;
        b=d+rQpkijrNtSc0iaUqsGc9O1T17EaOGs2Dmpdnk6r2E5/bWi1jLM3Qc2z21NesZkuT
         rJgtg9eYlBGirSXOy+M8qCj1cEVphMkSsUsj6utS25BZ5ZWDD0x2R74D/GP11YOUvnPi
         nV76hFVGBKQKWpJRXJDfnM926LSBU6bWJnK+/GCt/w+mQ32dbB1404vuMmtLxkwOIi0B
         WKETI/5Z/QPQNTdnF4y7VEamcOl0DH5KpL4xtS8+Kwcx7pWM5V9SXo7tXcg+YPYuyQRx
         RILlfWkONlptRmSs1Pw6N6SEySpXrTRRxc83g9VH67N1RpirTmaKOVPu8rx/vjLSC2Z3
         u3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710930249; x=1711535049;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUxLDUcelK/0PKWxOgb0tRnuM6xgbFRxgTPdQohocPE=;
        b=FpTNGbwzSlIzq2Vtz+lXHvuLxYjIt48aQ3OEXAtQggUxchLF85fCwHhBEEsNXZQT1H
         QtXiJ0KZJh5NB1fEhjorXDvyWzM2o3pZICxMupZmmn3P+gXGwiCNgdBIY9lPMhqA0pq9
         SUXeBDdC11wTonnNBuvV9mMJV4JBqeMv+A+F8gg8CpsNnk3HZeddbYVmhvXLT25gXQhB
         51fVJafKG4UgljpU0hIP5D6W4i5F1vDuQ0ngpBsl3r5Xr+/7uLsliZ0Bco8mlb/ATZOa
         DKkNbYe9y/QeNw9Ry4eukdjg8kCTkCbohx1kOx49m8whvIIndOBdRe8u0/sA79mTgYUS
         /ACA==
X-Forwarded-Encrypted: i=1; AJvYcCWwXfknDN3KUMOPE5cSq0q+KJBLkYi6uvln6dRLgE1ZfgJN7HGWXzu1yD2qGScMA4mqqs6ufXzl+pkeltuJ69gHA+/GxFk/XwSIqrUm
X-Gm-Message-State: AOJu0YzBwYn8kxJcR5pUgoaoYSaHvAqv0z/fmIGXkZB3+M3pmnhjtB2s
	56RIrFtVETD0KD1gB5vTmV0YHfUy4kcrMD/WzSimzoBARl+TpogPZVugJRgA/9ZeNLcNMBUZuM+
	V
X-Google-Smtp-Source: AGHT+IH0TVU2B967dqvpA5N4Ww+O+n5Nwuq97zEjfZLHCTBGVX94nWUvcyKLsqFepv/YVmvVT41LSQ==
X-Received: by 2002:a17:906:1547:b0:a45:b1d8:200c with SMTP id c7-20020a170906154700b00a45b1d8200cmr12083115ejd.14.1710930249600;
        Wed, 20 Mar 2024 03:24:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906190b00b00a44e2f3024bsm7074104eje.68.2024.03.20.03.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 03:24:09 -0700 (PDT)
Message-ID: <cfdb77c8-e893-41bf-965f-1013f3fc910e@linaro.org>
Date: Wed, 20 Mar 2024 11:24:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] dt-bindings: Add bindings for vmgenid
To: "Landge, Sudan" <sudanl@amazon.co.uk>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240319143253.22317-1-sudanl@amazon.com>
 <20240319143253.22317-4-sudanl@amazon.com>
 <ba8418ab-2829-416c-8e20-414f7818cab9@linaro.org>
 <f221da06-2a7c-4db3-a0de-870156865631@amazon.co.uk>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f221da06-2a7c-4db3-a0de-870156865631@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 11:17, Landge, Sudan wrote:
> 
> On 19/03/2024 15:28, Krzysztof Kozlowski wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>

Why did you remove all the people from CC list?

>>
>> On 19/03/2024 15:32, Sudan Landge wrote:
>>> Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
>>> ("virt: vmgenid: notify RNG of VM fork and supply generation ID"), as an
>>> ACPI only device.
>> That's not a valid rationale. Second today... we do not add things to
>> bindings just because someone added some crazy or not crazy idea to Linux.
>>
>> Bindings represent the hardware.
>>
>> Please come with real rationale. Even if this is accepted, above reason
>> is just wrong and will be used as an excuse to promote more crap into
>> bindings.
> 
> Thank you for the quick review.
> 
> I will add more details to the problem we are trying to fix with an 
> updated cover letter
> 
> but to summarize the problem briefly:
> 
> Firecracker is a minimalist feature hypervisor and we do not have ACPI 
> support
> 
> for ARM yet. The vmgenid devicetree support looked a better option because
> 
> supporting ACPI on ARM means supporting UEFI which adds a lot of complexity.

That does not convince me. Amount of work for you is not making virtual
stuff real hardware. Come with some other discoverable protocol - you
have full control of both sides of this thing.

> 
>> A nit, subject: drop second/last, redundant "bindings". The
>> "dt-bindings" prefix is already stating that these are bindings.
>> See also:
>> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching.
> Got it, thanks.
>>> Add a devicetree binding support for vmgenid so that hypervisors
>>> can support vmgenid without the need to support ACPI.
>> Devicetree is not for virtual platforms. Virtual platform can define
>> whatever interface they want (virtio, ACPI, "VTree" (just invented now)).
> Sorry for my lack of experience in this area. I took reference of virtio 
> devices when I
> 
> uploaded the patch. We would still like to support vmgenid via a 
> devicetree so I'll
> 
> revert with a new approach.

There are other solutions, I think. This was discussed already multiple
times.

> 
>>> Signed-off-by: Sudan Landge<sudanl@amazon.com>
>>> ---
>>>   .../devicetree/bindings/vmgenid/vmgenid.yaml  | 57 +++++++++++++++++++
>> No, you do not get your own hardware subsystem. Use existing ones.
> 
> Got it. The changes are related to the "rng" subsystem so I'll rethink 
> if that is the
> 
> right place for this and revert.

Your wrapping is odd. Please use some decent email client.

Anyway, I am not discussing topics semi-private. Keep all maintainers in
loop.

Best regards,
Krzysztof


