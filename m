Return-Path: <linux-kernel+bounces-24252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA71B82B9C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF211C230EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A9139F;
	Fri, 12 Jan 2024 02:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zkP4l4X/"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C894A16
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6daf21d1d5dso808316b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705028295; x=1705633095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7FK1ugbK12N35S5tXeTe+pTDZkhu3R71IZEsD0n/is=;
        b=zkP4l4X/DPSbWtpj/sOYmHaw+P3ZhBw7vdS2VbkNR5QoXz8A7mq4S9zgHLk7f69wAs
         lQyAS5/QYgwhRPHONgSTylg4Pzv3CguI/JU5IztjqON9W1i6mpiFEFU6sp907cy4rdkX
         K2FPK+sDm+loDPzMZazuJVAVwe1gOdzxqARuFccRPKiiQ2yj9+sl+46osjsPmzioz+lz
         SLoRiuAbN5qZjlooZz+pPGF91RltR1smRf8k+TJSwMRYAIz2E1T9xoRgkGcBRBaEoRsC
         9fcRyYQtL/LyXKl+vAM1IJnygotQDO4C7z9/n+DMzk5cE2pKGe8/gQjlK9GVzuqh5Vnh
         dzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705028295; x=1705633095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7FK1ugbK12N35S5tXeTe+pTDZkhu3R71IZEsD0n/is=;
        b=dhQ6gex5HzsByXUY9M8Mo56HXKZMwk6FspExIjCPVyxQ9BXRp+Y10/ihgEER/MfJcX
         J1u8uNoUot8t9rrnKKcrF+TtXe09OA4sCzBb2c9yxPX4VK68p05eoDYn6EigFfemNocn
         qBIi5cESTH/VlS+tjq/gzarKQwJ5d4Wt3tMCzYixsfWd6AaYbpJE6sjVEFce+gWeVffp
         LhyYyp8Oj1rd5gV7Uhh0gWOIVM3uh/pnfCFDkYWBaDrvlQG656dXjov1wyGElUtGLORg
         BbPF+TYhnanYMq//QDaevNv/6l+KKJpdh9zopAELardscuYjdFryy8M3VDDMKyqAUZ2Y
         cORw==
X-Gm-Message-State: AOJu0Yy2rixhzrSqwB2wYOMIMarMpBjOHKuxV5689nhYCgdJSLGvDscF
	LGEN1v9jF/MQ85kwqvzBXD6QSRP34rRr6w==
X-Google-Smtp-Source: AGHT+IESNhy5EiEhmoQxUnK707pRf9v1drw4N4jgI2UCZCjSFrmrFWUOB/cf/zlKljwHwXz9u2XPMg==
X-Received: by 2002:a05:6a00:2d94:b0:6da:83a2:1d5e with SMTP id fb20-20020a056a002d9400b006da83a21d5emr610297pfb.2.1705028294705;
        Thu, 11 Jan 2024 18:58:14 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id l22-20020a62be16000000b006d9b38f2e75sm2003074pff.32.2024.01.11.18.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 18:58:14 -0800 (PST)
Message-ID: <e117f6e0-a8bc-4068-8bce-65a7c4e129cf@kernel.dk>
Date: Thu, 11 Jan 2024 19:58:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] io_uring: Statistics of the true utilization of sq
 threads.
Content-Language: en-US
To: Xiaobing Li <xiaobing.li@samsung.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, kun.dou@samsung.com, peiwei.li@samsung.com,
 joshi.k@samsung.com, kundan.kumar@samsung.com, wenwen.chen@samsung.com,
 ruyi.zhang@samsung.com
References: <b0c67327-5131-4cde-a8bd-df69b1f300e5@kernel.dk>
 <CGME20240112012013epcas5p38c70493069fb14da02befcf25e604bc1@epcas5p3.samsung.com>
 <20240112011202.1705067-1-xiaobing.li@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240112011202.1705067-1-xiaobing.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 6:12 PM, Xiaobing Li wrote:
> On 1/10/24 16:15 AM, Jens Axboe wrote:
>> On 1/10/24 2:05 AM, Xiaobing Li wrote:
>>> On 1/5/24 04:02 AM, Pavel Begunkov wrote:
>>>> On 1/3/24 05:49, Xiaobing Li wrote:
>>>>> On 12/30/23 9:27 AM, Pavel Begunkov wrote:
>>>>>> Why it uses jiffies instead of some task run time?
>>>>>> Consequently, why it's fine to account irq time and other
>>>>>> preemption? (hint, it's not)
>>>>>>
>>>>>> Why it can't be done with userspace and/or bpf? Why
>>>>>> can't it be estimated by checking and tracking
>>>>>> IORING_SQ_NEED_WAKEUP in userspace?
>>>>>>
>>>>>> What's the use case in particular? Considering that
>>>>>> one of the previous revisions was uapi-less, something
>>>>>> is really fishy here. Again, it's a procfs file nobody
>>>>>> but a few would want to parse to use the feature.
>>>>>>
>>>>>> Why it just keeps aggregating stats for the whole
>>>>>> life time of the ring? If the workload changes,
>>>>>> that would either totally screw the stats or would make
>>>>>> it too inert to be useful. That's especially relevant
>>>>>> for long running (days) processes. There should be a
>>>>>> way to reset it so it starts counting anew.
>>>>>
>>>>> Hi, Jens and Pavel,
>>>>> I carefully read the questions you raised.
>>>>> First of all, as to why I use jiffies to statistics time, it
>>>>> is because I have done some performance tests and found that
>>>>> using jiffies has a relatively smaller loss of performance
>>>>> than using task run time. Of course, using task run time is
>>>>
>>>> How does taking a measure for task runtime looks like? I expect it to
>>>> be a simple read of a variable inside task_struct, maybe with READ_ONCE,
>>>> in which case the overhead shouldn't be realistically measurable. Does
>>>> it need locking?
>>>
>>> The task runtime I am talking about is similar to this:
>>> start = get_system_time(current);
>>> do_io_part();
>>> sq->total_time += get_system_time(current) - start;
>>
>> Not sure what get_system_time() is, don't see that anywhere.
>>
>>> Currently, it is not possible to obtain the execution time of a piece of 
>>> code by a simple read of a variable inside task_struct. 
>>> Or do you have any good ideas?
>>
>> I must be missing something, because it seems like all you need is to
>> read task->stime? You could possible even make do with just logging busy
>> loop time, as getrusage(RUSAGE_THREAD, &stat) from userspace would then
>> give you the total time.
>>
>> stat.ru_stime would then be the total time, the thread ran, and
>> 1 - (above_busy_stime / stat.ru_stime) would give you the time the
>> percentage of time the thread ran and did useful work (eg not busy
>> looping.
> 
> getrusage can indeed get the total time of the thread, but this
> introduces an extra function call, which is relatively more
> complicated than defining a variable. In fact, recording the total
> time of the loop and the time of processing the IO part can achieve
> our observation purpose. Recording only two variables will have less
> impact on the existing performance, so why not  choose a simpler and
> effective method.

I'm not opposed to exposing both of them, it does make the API simpler.
If we can call it an API... I think the main point was using task->stime
for it rather than jiffies etc.

-- 
Jens Axboe


