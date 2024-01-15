Return-Path: <linux-kernel+bounces-25988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 060EC82D95E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB57B21247
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EED168B7;
	Mon, 15 Jan 2024 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPh2GCt2"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD3D15AF9;
	Mon, 15 Jan 2024 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so10580675e87.3;
        Mon, 15 Jan 2024 05:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705323693; x=1705928493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+5+Wznx7Rlg/3OxfhTEbZdgMDExRp4/plSS+QMv9OQ=;
        b=TPh2GCt28yKYDHlphc2jUFn90IuGcsLjgv865gxkNqr6bK0QscuSP0k8exEfggYvpk
         h5wtsdHeGT4eC/VFO7XHSpxmnm0qx/l23lntAhFsnkD+qJR8Lj7ciw3IcgaGqBw2TKwK
         ud1h5oREkQoxQYvv+4bszRXCDqGAJgmKCUHRvVZuXgi72ETMS50vkbOtp4f6sFdBCtIe
         YkLMcHX8zbK6eK6mIYoBS8x3BSOxUwVrV0EWKZf7hRkiXWOyblu7n7wkJ1pZzQNxgzHn
         AuItm9Ojc2tdA65RyqpfdrEl9p5cJULy7wJ+lxP1YvdMTygyAv87DSuga0htoZCk3AMr
         JXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705323693; x=1705928493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+5+Wznx7Rlg/3OxfhTEbZdgMDExRp4/plSS+QMv9OQ=;
        b=eZHrNa7rLGa7mXUjce8WZY5mfdHvhfC2I+Yi8LB5RCbsrTTYnEQG0oC5jJ8oV37QWz
         Y+9zIwuWzwiQm9IcN5LygGtQq9J0pUYRL+UmKs4NCalf61uWAzI98yfENGvIw1kmPABv
         3CCaXYAaBJJr5Db26dWdRj8ZKBLNMUVGRQQkLEtSG6uGilv+t4YwVY3Ba/hBsTAn1e0n
         dC02wr8kaLakBVpvQk1V+zatvaVKI6ARSIdCmk2nCDtuasYwErlMsr9ZcVkgKlBisW3c
         xzX0VjRGdF4kxuW8NeudIZB1eVUqTGhO1qScRBoQBjHvUP8eu93S/ZgXW5rfO3dHHvpP
         EBVg==
X-Gm-Message-State: AOJu0Yw5EPETCvQEhflCmDKLmnNKqZqT/SO40Iti6tf0IPfo+Eqwj+UZ
	qpyUjT1W5pBb5KH/bs5beYYms+CLciM=
X-Google-Smtp-Source: AGHT+IFEs/BZBKo6tHlk+fqfeBt9LJdKrbOX987CA39O7ePmrigBLwcqHzHR9oQ1sMTjXlPWT5eVhg==
X-Received: by 2002:a05:6512:3fb:b0:50e:7b2c:9013 with SMTP id n27-20020a05651203fb00b0050e7b2c9013mr2299243lfq.132.1705323692864;
        Mon, 15 Jan 2024 05:01:32 -0800 (PST)
Received: from ?IPV6:2001:14ba:7426:df00::3? (drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:7426:df00::3])
        by smtp.gmail.com with ESMTPSA id 28-20020ac2483c000000b0050e7740b871sm1447973lft.159.2024.01.15.05.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 05:01:32 -0800 (PST)
Message-ID: <ff962e6a-5e2b-4a72-9043-80b8fc218642@gmail.com>
Date: Mon, 15 Jan 2024 15:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: test: test gain-time-scale helpers
Content-Language: en-US, en-GB
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <cover.1704881096.git.mazziesaccount@gmail.com>
 <6b839dd533fd93b75c2e6f6a8f2286233d4901fb.1704881096.git.mazziesaccount@gmail.com>
 <20240113161229.48d63b54@jic23-huawei>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240113161229.48d63b54@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/13/24 18:12, Jonathan Cameron wrote:
> On Wed, 10 Jan 2024 12:12:55 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Some light sensors can adjust both the HW-gain and integration time.
>> There are cases where adjusting the integration time has similar impact
>> to the scale of the reported values as gain setting has.
>>
>> IIO users do typically expect to handle scale by a single writable 'scale'
>> entry. Driver should then adjust the gain/time accordingly.
>>
>> It however is difficult for a driver to know whether it should change
>> gain or integration time to meet the requested scale. Usually it is
>> preferred to have longer integration time which usually improves
>> accuracy, but there may be use-cases where long measurement times can be
>> an issue. Thus it can be preferable to allow also changing the
>> integration time - but mitigate the scale impact by also changing the gain
>> underneath. Eg, if integration time change doubles the measured values,
>> the driver can reduce the HW-gain to half.
>>
>> The theory of the computations of gain-time-scale is simple. However,
>> some people (undersigned) got that implemented wrong for more than once.
>> Hence some gain-time-scale helpers were introduced.
>>
>> Add some simple tests to verify the most hairy functions.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>

..

>> +static void test_iio_gts_chk_scales_all(struct kunit *test, struct iio_gts *gts,
>> +					const int *vals, int len)
>> +{
>> +	static const int gains[] = {1, 2, 4, 8, 16, 32, 64, 128, 256, 512,
>> +				    1024, 2048, 4096, 4096 * 2, 4096 * 4,
>> +				    4096 * 8};
>> +
>> +	int expected[ARRAY_SIZE(gains) * 2];
>> +	int i, ret;
>> +	int exp_len = ARRAY_SIZE(gains) * 2;
> 
> Use this for expected[*] just above?

Doing:
const int exp_len = ARRAY_SIZE(gains) * 2;
int expected[exp_len];

gives me:
warning: ISO C90 forbids variable length array ‘expected’ [-Wvla]

I could drop the whole exp_len variable, but I prefer test code which is 
as obvious as it gets if any of the checks fails. For me the check:

>> +	KUNIT_EXPECT_EQ(test, exp_len, len);
>> +	if (len != exp_len)
>> +		return;

is (very slightly) more obvious than:
	KUNIT_EXPECT_EQ(test, ARRAY_SIZE(gains) * 2, len);
	if (len != ARRAY_SIZE(gains) * 2)
		return;

I guess I'll leave this one as it is. Just kick me in v2 if I 
misunderstood you :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


