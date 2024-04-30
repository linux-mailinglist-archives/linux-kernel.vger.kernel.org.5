Return-Path: <linux-kernel+bounces-164395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BC98B7D27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43401F230AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6111836CD;
	Tue, 30 Apr 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/5iAQ1a"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A1537E4;
	Tue, 30 Apr 2024 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494846; cv=none; b=ocNkQadNMnvOkfLxWeEfyjVBJxG6O4WnyfuyWqrbnugqXjhAJoLk9D+n1kweI3QxgkHm9mU997lkafLewDSK+eXOQRg5Kxczzx2WlsllfoCSD1dSO3qP3cA4XS6JlgHjW4SLsazM/2HYZbdJS+DnnrX4+90ISMLs4abfmRQOs2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494846; c=relaxed/simple;
	bh=Nmts7SGpTnSBJShEKqMgy0d0lvZ16gTsppVGUwwJsn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/Mdu6VPXMACVpBbcAieYkp7jjrei3N7u+ZYW/e5DrKcJV5Rw6OoXlimYzvH0sZrayiyEAkdD5hjrgHbmHUPKEz1bq97pa5W7WOYbAvytpS8VlftIYDor+Qg6aT/sVLeAMbkfwLUk4OphDv+xMcaKPF5brWOal8sy99SZCWk/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/5iAQ1a; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso4844393b3a.0;
        Tue, 30 Apr 2024 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494844; x=1715099644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8yVh0LSF6AnP8AlfPOMnHNGqdMushJrhziYcF69ydXM=;
        b=d/5iAQ1a3BaZ6klWiCUQAdCT9TZDQ2utu3265qtDm3iotKc6Scbey8EXj5RtA4R4//
         bp9p/eRP5KYBKXf9M91aTjcVX/I7ctW3nVWB5CzWJvMUxTU4bpVjiZ4ezGr9mPP8sSWp
         bGJPogJLBhr656fcB9koZV7dumpdsm2R4zYpxU9THtTTMtSHm45bG6pvhfC61BouOgt5
         AG4yyd2t2aUQCVtH1ja4U8rpsncYg3Fw7+dhVGJECvu7bWLgEgT683kIQBVYIY359cvl
         KXTJb2e3vNEYy0Nx8+M3x3lkeMWhqUfr0Hxy/Hisv1Jnp73rYRMRn3LKSoZfnAgP8OLQ
         QgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494844; x=1715099644;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yVh0LSF6AnP8AlfPOMnHNGqdMushJrhziYcF69ydXM=;
        b=bjTLlhLgkJrw6EvK3YNv5RLsnd0o5SMtMALRBHsmWe22jMzLv5iw9kS6MmUDmSqlx+
         ZqzvmqlABAwwx+7KsXwfbbWRuEClMTfC/ZBaFnNRWrMTjwbF2FRNLDKze7k/DN3msJmr
         bT1cCvPoZcqNuLo77MuShgcy+RpfQen2xy2h0PzjG5RWvMve7uqYo7r9wOY81pNclOkv
         2Q7W2ZH5YxUZflwpx8PSdgRy/YUMPh6JvE9m79DQSLG0U1b9RtdM6zUl82v9n0ILM9Z6
         jFJU/dd5rracCd/pWVxMGaXkvpBoq+FYm3ipOMHQHroRKWw7sp90jN2AMAmmPqHr9uz/
         BMSw==
X-Forwarded-Encrypted: i=1; AJvYcCWKrrDFzVZDiLZX94YJG5uLzMt0cDCv3TyyuAP87K8gmDaa7Qob02mlCaIyih6KatSLez/4X12dFkhrSfFGsfs9omdOi3Jgz+G7RdOAaBuA2zcph586Qwr9kC9kxH6kv2ILVanPn4TZjtJuz9IReu351LYfT+XjbXpiKnKWEdWLUZbwAA84BeCfkUQstSNDq1o4rLiXxiaw/MLrRXWvJp4iUuDm6C+afk+kt0VmcGUi4qTEIkmraWHhA8DJPQ==
X-Gm-Message-State: AOJu0YxcZN9oweX88HvDKw3Nuhb+rkBDRooLhfL0PFOaZLOWpZ22Rt2E
	fs87G7WfdZz267WS9ElLcBRhB8YOCfmcftN7NQGVsam9L1p9pQLS
X-Google-Smtp-Source: AGHT+IHMlRdPUV+Vp+iaQO91MrJbNZoGRQBwlMcCasW3TWZCQdK7tEfZ21nXdx7uZqOu4pSGHzepsg==
X-Received: by 2002:a05:6a21:33a8:b0:1ac:663f:9efd with SMTP id yy40-20020a056a2133a800b001ac663f9efdmr447542pzb.19.1714494844277;
        Tue, 30 Apr 2024 09:34:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id st5-20020a17090b1fc500b002b29ce888fcsm1447456pjb.53.2024.04.30.09.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 09:34:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <453bb1ed-1fe5-4b2c-90a1-eb15a0086489@roeck-us.net>
Date: Tue, 30 Apr 2024 09:34:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] hwmon: (da9052) Use
 devm_regulator_get_enable_read_voltage()
To: David Lechner <dlechner@baylibre.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Jonathan Cameron <jic23@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Support Opensource <support.opensource@diasemi.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-input@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
 <20240429-regulator-get-enable-get-votlage-v2-3-b1f11ab766c1@baylibre.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240429-regulator-get-enable-get-votlage-v2-3-b1f11ab766c1@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 16:40, David Lechner wrote:
> We can reduce boilerplate code by using
> devm_regulator_get_enable_read_voltage().
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>


