Return-Path: <linux-kernel+bounces-119527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A43388CA53
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B76B2462F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEE713CAB7;
	Tue, 26 Mar 2024 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zeu3s1+S"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1527713CA91
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472209; cv=none; b=uNgOEql76BoNF7UEaE4Hzjs26DghQW+cENVD6/d9TuT+wOkJ9NEVljK6pnpH61jUdAXK6I0GZkato5CzIqMzRkw492ZsXRCZH0Z+CMavyjdcPeySsUPJWCQN6rbJ0N8Lqo2yIWPhSwVFJ5azYt4okRITZwSIkDmAzvwt76k24Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472209; c=relaxed/simple;
	bh=MpjDTokvtX1EE6EGgkGbT2jYFu3j8gUVKMk4u80tuOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYpUplKVPbeFTe5T5PujVlGDmMWnhVO6GTVdSYw57uWtHIjLw5/88Tkl4shcVNPjJbEWTvrzrW2izTFJYKIXL5xnH3q2Xj9vcWSgf6zPLqE6PLCq9BFgQBRjlQwpWGhnL8+YyUa5L0PRP1DeAil0Sk7r5OZLlNpe7RCYPVmw+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zeu3s1+S; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d46dd8b0b8so74355071fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711472206; x=1712077006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5/8WXXOlm8B5IwH6u3vDD002jtgNLvKBWnXoZGy2nH8=;
        b=zeu3s1+SaL8CoZvZCnR+WstNnCRuy9n4lvXGvRyfbApSmS3J16VXe1jzF85/fPhHKf
         1/T64WAhdh8s1Tit7S+Kdz6KQnH4VCZZmmfIr1imIfr29AM6ckMcFLPPwd33qA8zYiyh
         toFAPIV4R1v63RwK/FGwWnM5T4yx9INkURbMBfurEE9a0SbOIY3aDsvnSERHOB7vlp6c
         ONVuRMHkMCxH0FWx5yLh/hGUHqNs7yxV5JqxsQP0X38c0yZ3X/JRIftTNW8cYwtV8yfy
         yTRQR6Lrt3XJX/HGZmmiYm604eDEeclG2BAvNzIoVx2Uh+8SO7vK/z/OpVYqnvtVcyKA
         gDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472206; x=1712077006;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/8WXXOlm8B5IwH6u3vDD002jtgNLvKBWnXoZGy2nH8=;
        b=V7H7bfUYvhnkAgpwd/1KzpIGW9jWt2RGAmRwchs2ztV6REIwJ4lhldWPdMgNQNlS5a
         R58IHr2CvXo7/LdcbPxiQGJlgC6DPhDytV9ykuyGhDBL9vQpl4mUH2eeQeYNdI+g36DQ
         uyN620D1F+q9RqQ8uYcjeMvH//nQ3WMxG1H1febiEG0wqHtLsBs9V13B80rgp6JPiJWM
         pQs6bq5AM7InvGq0UNgo0hd6NjpQYGKj+BFyym0ixs353sprIrKdWFukHBjzusdw6bbH
         MptqvthOycIrYYVTMQTbqmGbEVNBeDCn+paCQa5hVNOy7rgRQmsxsh7+iNUhD1XYpg1X
         TYUw==
X-Forwarded-Encrypted: i=1; AJvYcCX8/hgiZsmacRH0TrIZ3/dNEsPMzO1kge7jN3j2No9djtF9gyxW1d70z2v7BARQBNY0VHzkB2w2Ne3J8eo919bTBtFuVdqZnHb9s/wo
X-Gm-Message-State: AOJu0Ywg3h2I/rZ+lk7pNhopFgS06YDNYRB9P4xrz/2WuQYbg2YPeYEL
	6ic0dkwLTl+g0cq3jY/lNTQfHeWkbXrncx0M7KYDg24er4aW9ECtjNhpp5AvdAk=
X-Google-Smtp-Source: AGHT+IFdFXrpqJBi9ggghgTV04ekiGzgZw4KLrXf8OHueaj+CMenDPKyihhyFJd3ChJvN4toXpaY8Q==
X-Received: by 2002:a2e:a9a4:0:b0:2d4:9333:8e38 with SMTP id x36-20020a2ea9a4000000b002d493338e38mr2943756ljq.38.1711472206124;
        Tue, 26 Mar 2024 09:56:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id c6-20020a2e6806000000b002d4972b1658sm1871167lja.52.2024.03.26.09.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:56:45 -0700 (PDT)
Message-ID: <5c5f1fe3-b517-471c-aa5e-0bbc1645c8fc@linaro.org>
Date: Tue, 26 Mar 2024 17:56:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] virt: vmgenid: add support for devicetree bindings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com,
 dan.j.williams@intel.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, graf@amazon.de, dwmw@amazon.co.uk,
 bchalios@amazon.es, xmarcalx@amazon.co.uk
References: <20240325195306.13133-1-sudanl@amazon.com>
 <20240325195306.13133-5-sudanl@amazon.com>
 <5ca78fc8-4a53-4f09-878f-4a47875f9de5@linaro.org>
 <ZgLXQ0P8aDl4Xh21@zx2c4.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZgLXQ0P8aDl4Xh21@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 15:10, Jason A. Donenfeld wrote:
> On Mon, Mar 25, 2024 at 10:51:25PM +0100, Krzysztof Kozlowski wrote:
>>>  		.owner = THIS_MODULE,
>>
>> This is clearly some abandoned driver... sigh... I thought we get rid of
>> all this owner crap. Many years ago. How could it appear back if
>> automated tools report it?
>>
>> Considering how many failures LKP reported for your patchsets, I have
>> real doubts that anyone actually tests this code.
> 
> Now you're commenting on the context rather than the patch.
> 
> No, this isn't an abandoned driver, no it's not untested. Rather, it's
> code I maintain, care deeply about, and have a tree that receives quite
> a bit of testing (random.git) where I'll be taking these OF patches in
> the case that this patchset improves (and thanks very much for your

I apologize. I jumped too fast to conclusions and missed important point
- acpi drivers do need to set the owner. I am sorry.

(platform driver do not need, but that's a different thing)

Best regards,
Krzysztof


