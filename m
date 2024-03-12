Return-Path: <linux-kernel+bounces-100162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4918792CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5671F2326C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61D779B75;
	Tue, 12 Mar 2024 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXWA79EV"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4C69D0A;
	Tue, 12 Mar 2024 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242197; cv=none; b=YLCk1dg/aF04ySFGy6ylxdNRGXhYZoHnREWsR35VspanaYA27tiHOR1iH8jDZ/6Vj5+YKX//OoVzUbPht+ml+Fa19yvyEsA3zD7Q7wCGVYjSipxUoh1VQyE4yv+nlvUAxFeuWGFyh283BYJniTTcRjxo5HKuMMfiR3Fgv8DhrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242197; c=relaxed/simple;
	bh=rXCQMoPnbQrK2DoGOWi/2IAc66hjG44/JK5fA2xDgi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toqymQ1l57ozO55EWWv356P1dMJjHLPGuqB/cXgi8kE7MUhu4V1T1R4tE3ktwRxPoBudiwuMOKVYVh9sZd9PAuRNX0pP5IROh7YsN4Hi2RMP/YwNI2D4F1OCMqZ0Djp4feBT993vFvgnxlzwFaqoJgjgYdmrCFU0Ev3p5AmrG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXWA79EV; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513c53ed3d8so38088e87.3;
        Tue, 12 Mar 2024 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710242193; x=1710846993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLdQNFOVM/pPG6LlBIiHy/tpPuE7zfP+IIyyMxjL5xE=;
        b=cXWA79EVHu1BP96mVtSRtOB6O2oJf72D79ZnRo2tIGvnwROeo+j9U/spqbKAdgiAAo
         xeMW+dhP6WSBZPPGIo+CccD6BVYBpxj0DJXivFdzQKgo7ZZkN6SrcFaFjrpqLupV/pZW
         o1iTVZHAsQQZFQ550ECTWnxGXo/fJB3tYjehw02y6OMOIjmXIRCsRvukVjFLu4cB7fYp
         6P546kU3nuRbf+4VDUvr6dj+8Qu+LvFhl8GOqZrQlupzg9uc2zzCniabxDrbPibeK65Z
         92n1LnC7qeCeUnL8S+rDs2VVHfGlbQ3aDrVX3R/bXqwqA925rlit2Uz/nJSgChlJN32j
         2cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710242193; x=1710846993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLdQNFOVM/pPG6LlBIiHy/tpPuE7zfP+IIyyMxjL5xE=;
        b=j9hPAhFdgClCo7sbYcUqYaIckQY5319VahKSCi9qdndjseLDKuV9JRWLXodsPzNMGd
         g8D1t4kq7NPGeDxnqlh2y+0UhRu88quvcFU9ZOdRQD4fGnUT0NkAZVKY8h/LtTWiWSqE
         VS6+YXHMAYJzhIr69pktRN7CsqQ/ff2j6HQFXLMDA8oseWQxI0B+HcksavyLeAhbdyik
         My3sAc7FCigFavwdbz5wb3qfLr//YxpWzYA/JKrK5fz4tfP96ukTH/4SN1+2R56YjHJy
         YHgH5N+1UqM7eFFP38P1SIkzYCAB0mJ6bFoZo1Wcby6L0yM0amdJx8NUMLS8hA9VbKtf
         ko4g==
X-Forwarded-Encrypted: i=1; AJvYcCWUdRigjk+5ruTBmoj+02giAq4AXcpAPNhEquYz4Vt7/9uLJ4dbQfp4wxiSJ/qyn317nzmcidN7E/5p0v+D8AvY4m4THE0V7RWS
X-Gm-Message-State: AOJu0YyUzePPVdIledr2rYqv/hgkp25KOJioz1MjY/R4aD8GVCYSszg0
	dUOiPskykA80HM8YTU7j3G6anZryFJMLkvBCbHKgimwWNETlKZSBlBgrOhg1
X-Google-Smtp-Source: AGHT+IFyVcVoLljfPDittekwPfe4Jrbzt/eefSFN+OHvxQ9dAdAe195eMEtO7thTNgrVEMF3jjcjaA==
X-Received: by 2002:a05:6512:34c5:b0:513:2858:6a67 with SMTP id w5-20020a05651234c500b0051328586a67mr4515249lfr.63.1710242193072;
        Tue, 12 Mar 2024 04:16:33 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f12-20020a0565123b0c00b005131d145ae6sm234027lfv.57.2024.03.12.04.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 04:16:32 -0700 (PDT)
Message-ID: <6dd0d822-046c-4dd2-9532-79d7ab96ec05@gmail.com>
Date: Tue, 12 Mar 2024 13:16:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [drivers/iio] Question about `iio_gts_build_avail_time_table`
Content-Language: en-US, en-GB
To: Chenyuan Yang <chenyuan0y@gmail.com>, jic23@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zijie Zhao <zzjas98@gmail.com>
References: <CALGdzur-rsLbd4BcgtR9QV2=ZH8xHAVySjm2z2TT=Aog74mdPw@mail.gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CALGdzur-rsLbd4BcgtR9QV2=ZH8xHAVySjm2z2TT=Aog74mdPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chenyuan!

Thank you for pointing out the problems :)

On 3/11/24 21:48, Chenyuan Yang wrote:
> Dear Linux Developers for IIO Driver,
> 
> We are curious about the functionality of
> `iio_gts_build_avail_time_table`
> (https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-gts-helper.c#L363)
> 
> ```
> static int iio_gts_build_avail_time_table(struct iio_gts *gts)
> {
>    int *times, i, j, idx = 0, *int_micro_times;
> 
>    if (!gts->num_itime)
>      return 0;
> 
>    times = kcalloc(gts->num_itime, sizeof(int), GFP_KERNEL);
>    if (!times)
>      return -ENOMEM;
> 
>    /* Sort times from all tables to one and remove duplicates */
>    for (i = gts->num_itime - 1; i >= 0; i--) {
>      int new = gts->itime_table[i].time_us;
> 
>      if (times[idx] < new) {
>        times[idx++] = new;
>        continue;
>      }
> 
>      for (j = 0; j <= idx; j++) {
>        if (times[j] > new) {
>          memmove(&times[j + 1], &times[j],
>                                  (idx - j) * sizeof(int));
>          times[j] = new;
>          idx++;
>        }
>      }
>    ...
> }
> ```
> 
> For this function, we are trying to understand how it works but not
> sure how this sorting is done.
> 
> 1. When the gts->itime_table[i].time_us is zero, e.g., the time
> sequence is `3, 0, 1`, the inner for-loop will not terminate and do
> out-of-bound writes. This is because once `times[j] > new`, the value
> `new` will be added in the current position and the `times[j]` will be
> moved to `j+1` position, which makes the if-condition always hold.
> Meanwhile, idx will be added one, making the loop keep running without
> termination and out-of-bound write.
> 2. If none of the gts->itime_table[i].time_us is zero, the elements
> will just be copied without being sorted as described in the comment
> "Sort times from all tables to one and remove duplicates".
> 
> Please correct us if we miss some key prerequisites for this function
> or the data structure.
> Thanks in advance!

You are correct. The sorting is not working as intended! It has only 
worked and passed the tests because the arrays in the test and driver 
code have been ordered in "descending time" - order. The code above has 
done a copying of items in reverse order, resulting a working set of 
available times.

> A possible patch based on our understanding is attached.

I copied your suggested fix here for my initial thoughts:

diff --git a/drivers/iio/industrialio-gts-helper.c 
b/drivers/iio/industrialio-gts-helper.c
index 7653261d2dc2..0667da988295 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -375,19 +375,17 @@ static int iio_gts_build_avail_time_table(struct 
iio_gts *gts)
  	for (i = gts->num_itime - 1; i >= 0; i--) {
  		int new = gts->itime_table[i].time_us;

-		if (times[idx] < new) {
-			times[idx++] = new;
-			continue;
-		}
+		times[idx] = new;

The idea of the check which has been removed was to assign the value in 
the array in first free spot if it is bigger than the last value. As you 
pointed out, the implementation is wrong, but I think the idea is Ok. 
Here you do unconditional assignment which is slightly sub-optimal.

  		for (j = 0; j <= idx; j++) {
  			if (times[j] > new) {
  				memmove(&times[j + 1], &times[j],
  					(idx - j) * sizeof(int));
  				times[j] = new;
-				idx++;
+				break;
  			}
  		}
+		idx++;
  	}
  	/* create a list of times formatted as list of IIO_VAL_INT_PLUS_MICRO */


I will fire-up a setup with the IIO-GTS Kunit tests, and alter the order 
of times in array for the available times test.

I would appreciate if you could post formal fixup-patch in inline 
message as per usual Linux review and merge process. That would simplify 
the process for Jonathan and other reviewers. Please, let me know if you 
don't want to send a formal fix. In that case I will write a fix by myself.

Finally, your finding and report is _very much_ appreciated! Thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


