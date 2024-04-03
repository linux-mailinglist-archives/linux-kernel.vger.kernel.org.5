Return-Path: <linux-kernel+bounces-129503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23664896BAE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65571F23705
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C1413667E;
	Wed,  3 Apr 2024 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXA5RjU4"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99E13A279;
	Wed,  3 Apr 2024 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138893; cv=none; b=sVhmV6lpaeYhnKXQhOLEcpqMPRno9xW1yUy9LCQh12T5wT0uYafejp2Ixsf0hDV4YH2PFUf5IQ8NgpqcwlsKyk/c8Wafj0UkCx/Q4TjlOYKEsjt33h5eWKUF51mSypS8M9Rj/WQbB6JBJgA6XaPw2k5AnfdGMfM/ZifIEfnPdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138893; c=relaxed/simple;
	bh=8G7FykjVMtnmR1a/yPBi3lb2UksOoP9XloVGYnThLxM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ga/v3AHT82locGKxzUBejphpDXpfua8Tq9QEzTXkoJ+HkhhiwvxYSiqdh25NQiGjkq/mc+TxQo1u1pgAyzyYyTB48FLRcZnVPxnHw94Je8IbQmwTmAtdI0yk0OpmObV8AEqYkb01h1wkAr2zUxbNXOVYque4/Hrr71BkYNXTeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXA5RjU4; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d43c633fecso2428835e0c.3;
        Wed, 03 Apr 2024 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712138891; x=1712743691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bFS0RDDcgoBF1Pmbsu15na/pfHJDuhbIMoL/w120wPQ=;
        b=WXA5RjU4PTz8gctQYn5pDvVZJWwyx3VPCPmGUbBppohV/Lk3VUnRTXDDzZ+/Yy3f7L
         VNJr5opOZgzeiazQPP11DMjH0i/qQKYuWvMYlDIEr6mK5m1IxCuHaky6L/J55IftFPu+
         I7c8966xYXc8d3wnL013+/YvtY/soMtgX6hhzbiYMBVcHh7wddFyKNsYm60I3lNRTu7i
         O751O9MYfvHLFD4aOBY1kK5y0wk38bmBOGWYwCsnkHE4KLTDHKaDUdjfs0bm7UFz2TaG
         9KhrQDurQJNvQth7KY1zoVLiePlgqa/fYU6P1jqz1bCP6ajczvk4rO0l8xKYw6FflmIq
         5orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712138891; x=1712743691;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFS0RDDcgoBF1Pmbsu15na/pfHJDuhbIMoL/w120wPQ=;
        b=dVmKfY4iC5kYJCqYh0TP0y70pu++3LMIv2AP3nB62ud7G7Qp08+eTuuDyEadWCNQXa
         JEKukuQUVvlhgg6lQ5kXVNQWMyCTP4k9x61dSWq3vJsl4YyJqcn8Gy+oWjwm1NUgU6TK
         ub4qCwJFQxorMxErW/6ZBgdW9WGBaYOrI4G/PjNsTbhXGR+bOhiyia3czdll+omSnj3R
         J8YwVek67AbOCXksuRZ7ot3soc9NL3xYSSOlseMlpdH9SboQyrsfDNccCIbSc1e2LNu/
         YzKXPortFVVWqeKjXE544BwkpXZ9yl4twJCge4P2yVX0gkJJk7dw+JxjSGswTslrR74E
         SWzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB32FfEEmX3FBCE3F2Sr8b3eUn4oG4Ou5OwDp1gdNfNSTP6CzsX3Ben03wxgB/um7Ipamk7Sia05sjyED4Nk2SQfDBuqVRHfTzAM0jd3xoalfD/NlO3nABvOtwbYHFzO/N2oHJm7GUEM3neGet7hgadX0UwvBn7WptNVTWgaSkwcSotw==
X-Gm-Message-State: AOJu0YwGZ5YxUmhwGtL+WN15oTJF9Ox5hpKDgtARrVH9YXty0N4LPhO9
	nmCto5y48duISLHcYSwfLAIq2q/zKYeUHSv1QRUNSyiWsKRoQLC1
X-Google-Smtp-Source: AGHT+IHwkiwtnjuEL1WWFIdK2SfLIixpEkiIB+nIu4xS2AJpuuc81E5LAWU8nEthnF9OjQSU8rLNMg==
X-Received: by 2002:a05:6122:2026:b0:4d4:3ec6:421e with SMTP id l38-20020a056122202600b004d43ec6421emr13295422vkd.4.1712138891129;
        Wed, 03 Apr 2024 03:08:11 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ge6-20020a05621427c600b00696924bb1e7sm6330193qvb.117.2024.04.03.03.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 03:08:09 -0700 (PDT)
Message-ID: <dce3ae6c-6e65-4134-8927-549e9b4afd4c@gmail.com>
Date: Wed, 3 Apr 2024 13:08:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
 <CAMknhBGJt1TG0-UXMqqCT6nxJKAX7ZbsPF19eeWqwKsXbKOQoQ@mail.gmail.com>
 <0db40597-0d66-4d5b-8165-d9a4c068a42e@gmail.com>
Content-Language: en-US
In-Reply-To: <0db40597-0d66-4d5b-8165-d9a4c068a42e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/04/2024 10:45, Ceclan, Dumitru wrote:
> On 01/04/2024 23:22, David Lechner wrote:
>> On Mon, Apr 1, 2024 at 2:37 PM David Lechner <dlechner@baylibre.com> wrote:
>>>
>>> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
>>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> 
> ...
> 
>>
>> Also, I just noticed that AD411x have only one AVDD input instead of
>> AVDD1 and AVDD2. So we need an if statement that says if properties:
>> compatible: enum: - adi,ad411x, then properties: avdd2-supply: false.
> 
> Already addressed by this:
> "
>   # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
>   - if:
>       properties:
>         compatible:
>           not:
>             contains:
>               enum:
>                 - adi,ad7172-4
>                 - adi,ad7173-8
>                 - adi,ad7175-8
>     then:
>       properties:
>         vref2-supply: false
>       patternProperties:
>         "^channel@[0-9a-f]$":
>           properties:
>             adi,reference-select:
>               enum:
>                 - vref
>                 - refout-avss
>                 - avdd
> "

Mistaken vref2-supply to avdd2-supply.

But still, the presence of avdd2-supply does not influence anything at all.
Driver does not use it, you cannot select it for channel conversions.
Would a restriction like this really be required?

