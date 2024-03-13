Return-Path: <linux-kernel+bounces-101199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CFF87A3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFCD2830D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626B18629;
	Wed, 13 Mar 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU/LLtHM"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B83117588;
	Wed, 13 Mar 2024 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317335; cv=none; b=YF+T90LzELRq4N7EVTNjDkY1F9RtGMusDKzLsbVICYLU6/c1OR5mZ8Mj4K4LCNEy4N+bcudKFJ103xj1oEUl0BzX096wC7BMipG3QTVAzg31fTWawuVmWpdSeVZGK/VAT06kEDYjMBGK0QjuYPGKV0qTRCuvwC2YYuMudoG4Fic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317335; c=relaxed/simple;
	bh=VozBGaVQ8lhx7qUzqQooYeLEXDRUM5AI2hJblFFxPJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1+NBdzquyP8HpdrIX855i9DNKZ7PGgdHqh/ISDQbu68sMoLRc1YixPOxG7bNeFlVtU/k3KdlC6TWRnHis4THeCx9sH2JmlxYEyLMGy6b/EhHnAw6P7Ih5HIKzvinZOKXXqLw2gkMZh79yau3Pp3WXmR9lH7AFXIWe1V1qTu/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU/LLtHM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513a08f2263so3829205e87.3;
        Wed, 13 Mar 2024 01:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710317332; x=1710922132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BfErrriYyw5YY9i8bqAQhGI/qhM6QBazCKyEK5zDkw=;
        b=RU/LLtHMMhaw96wSv0kSeb5gKwCzsU0KU8mPbFh2WZophdCoCvXUUdNoZVZ/aanfEw
         1lXiN/kFoEc0Ev8W8BdkaqulOedvf798NE6cDtPf1Z5FxoSzPyScvVvjlWrnKSa4d72u
         Pil9YTvxUJe7RyTT/TtV+IXyhUg3K8Bfp5iRBUyHLkfsRvnsKRrZ0ji5XehAQAhmoQaE
         aU7tSpmvvgH8gxBqRQnh0F0+v88eWwQSf1ojGvfUq50/SMeg2AvjpbDtmUOQSm8BwYjA
         KftLgkN8lWNINsNcPdpUE1gvDeHCOb48xOXx0bgaxpwBrJ+Wm/ve8JywZXM9EPjLnnlt
         6S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710317332; x=1710922132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BfErrriYyw5YY9i8bqAQhGI/qhM6QBazCKyEK5zDkw=;
        b=aVdFeb+I0Mpc71naAOzc7pQn7GK0UShhgsdPQYrIcvspOaBx63pRi02f3bcXaIezNX
         4G+3m3qrWKsqU1RTqmXT4A2XiYLQpql5hzFYQnQNXekARbYs3gr2WHFTBNW8V9SRcp2U
         bUsF2ufGJWwVxLgeptuqk9sZR0cCtBD9MdeNI+iBoUABiiCGHxsu76pP2Rez5fpslrCt
         tK81lz7P2pPHM519+0RRHNnJp+VJjJsOqCEVe87xbSO/YpljkLkkQq/sxE40BNFF8Cci
         E0nQHO1PlkUdRXaQi/hjP96Qt/5DInBWPOc4bEk2uno3EaJasNxUSMpbcS1oks36nWic
         Hdkg==
X-Forwarded-Encrypted: i=1; AJvYcCWbQfZJOsJQAxDVaZHboUUXWELqDXjlMAZVfG4jN5tDpJZqLTW+inRxyeZJ4PW/UVq4AVNAs+31Z2FDziWYktwalC4Dxo0gLRZ9wkeM46jYP8r2N/xUnE8aw5Pc6YD3TM4y3IoUp1xK
X-Gm-Message-State: AOJu0YzbzN4I0IneGtBgb/Ng83PMKZXQnV3QhC0Pp6JXGvXZvlz/IaWK
	9W+4CLs4JsFdpYlDh1FTz6c+bX72yQwXnW7vNBFpaxUoqfVvnZhrGwIBdWrq
X-Google-Smtp-Source: AGHT+IE9hc80mTvJhvVRlDS6WVFj3kYNjWetQdvvpeBdA7ce2l6jwoW9Qr1B0eAPwuuGpOh6arCJGw==
X-Received: by 2002:a05:6512:781:b0:513:28b9:76da with SMTP id x1-20020a056512078100b0051328b976damr7568828lfr.46.1710317331854;
        Wed, 13 Mar 2024 01:08:51 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o25-20020a056512051900b00513c4e41140sm423279lfb.204.2024.03.13.01.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 01:08:51 -0700 (PDT)
Message-ID: <9724f90c-111f-40e7-9787-c62787cef96e@gmail.com>
Date: Wed, 13 Mar 2024 10:08:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [drivers/iio] Question about `iio_gts_build_avail_time_table`
Content-Language: en-US, en-GB
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijie Zhao <zzjas98@gmail.com>
References: <CALGdzur-rsLbd4BcgtR9QV2=ZH8xHAVySjm2z2TT=Aog74mdPw@mail.gmail.com>
 <6dd0d822-046c-4dd2-9532-79d7ab96ec05@gmail.com>
 <CALGdzuoA4ANBurXyP+00hFPmPznixcMTgrYNp1P4VwvpFb_GtA@mail.gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CALGdzuoA4ANBurXyP+00hFPmPznixcMTgrYNp1P4VwvpFb_GtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chenyuan,

On 3/12/24 18:53, Chenyuan Yang wrote:
> Hi Matti,
> 
> I have a question about the "The idea of the check which has been
> removed was to assign the value in
> the array in first free spot if it is bigger than the last value".

Can you please avoid top-posting when discussing on the Linux lists. You 
can find more information from:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

part of which may be crucial in order to get your changes applied if you 
haven't already familiarized yourself with the kernel development processes.


> 
> -               if (times[idx] < new) {
> -                       times[idx++] = new;
> -                       continue;
> -               }
> +               times[idx] = new;
> 
> It appears that the comparison should perhaps be made with `idx-1`
> rather than `idx`, given that `idx` represents the current number of
> copied values in times, whereas `idx-1` points to the last value.
> Could I have your thoughts on this?

Yes. I implemented the old code wrong as you pointed out.

You may want to take the GTS Kunit test cases:
https://lore.kernel.org/all/6b839dd533fd93b75c2e6f6a8f2286233d4901fb.1704881096.git.mazziesaccount@gmail.com/
which, I think, are already merged in IIO testing branch.

You can test the sorting when you change the order of the times in the 
test case:

+static const struct iio_itime_sel_mul gts_test_itimes[] = {
+	GAIN_SCALE_ITIME_US(400 * 1000, TEST_TSEL_400, 8),
+	GAIN_SCALE_ITIME_US(200 * 1000, TEST_TSEL_200, 4),
+	GAIN_SCALE_ITIME_US(100 * 1000, TEST_TSEL_100, 2),
+	GAIN_SCALE_ITIME_US(50 * 1000, TEST_TSEL_50, 1),
+#define TIMEGAIN_MAX 8
+};

for example to

+static const struct iio_itime_sel_mul gts_test_itimes[] = {
+	GAIN_SCALE_ITIME_US(400 * 1000, TEST_TSEL_400, 8),
+	GAIN_SCALE_ITIME_US(50 * 1000, TEST_TSEL_50, 1),
+	GAIN_SCALE_ITIME_US(200 * 1000, TEST_TSEL_200, 4),
+	GAIN_SCALE_ITIME_US(100 * 1000, TEST_TSEL_100, 2),
+#define TIMEGAIN_MAX 8
+};

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


