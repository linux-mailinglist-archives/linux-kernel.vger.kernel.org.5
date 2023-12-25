Return-Path: <linux-kernel+bounces-11091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A2C81E132
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F4228254F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BD6524DA;
	Mon, 25 Dec 2023 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3BhTD+n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1241851C27;
	Mon, 25 Dec 2023 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-35fe9a6609eso22309285ab.2;
        Mon, 25 Dec 2023 06:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703516246; x=1704121046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4aiW5+AczULkdWKgKzZEQT6Vz/ZvVOIizOQvICxQE/g=;
        b=O3BhTD+nXxfRLRp0SNhC9BUvQJ11hl+zkNaetrg074S0GHlFqaZIiGJENFknpePeoj
         6JMAWXi8wbz+GBdH5x8DGfFbjMUF1ymgKQrhJZbqn3LZ3KlT136nx2mMYRugzy3D1QX2
         xoW/rZg0f5otEWmwo0yJe43TeUmNkphPel9FQZQRwh8fVxYtkFKxrolHUr+wRyPzNoUU
         jbamt537tsE6kvxEdm15woAGxlxZ0LrOFtjA8XgHnlWdC428YVtxy/dWJFeJpZKWuV1Q
         tbRhh2y+wEwUUxEEYCd0FWNLots3bUdHo6SRlV9M9dimPPFUnIRavQGg4bv/A8rvtPIo
         h77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703516246; x=1704121046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aiW5+AczULkdWKgKzZEQT6Vz/ZvVOIizOQvICxQE/g=;
        b=quRXolhjnKGCZWjLJpMPIn2UZMj2TmsUdeZUczt65ONMfCjcUF7TNV0Aa3mKeGWyWi
         EbUW82fbDg4G4zWni/ejSno7vMTronTTGqgJGOndVIXgGLLS8xMOXdxpKRGXlBuqHxDG
         n+Dc9AMQZSyFRN+q078AXni6KvlkIlZgwJIaFptBJdjaW+XlHz8JB/qsBRC8VV8s79go
         h9QbDU9cC2HVgHf31UPKg9A5mnrj4ePZz2ZTLlznCP2fE9/F5mOjSkhmJ3BId2V9fsgv
         sgtgDVmF87e9CkLuugoPTNqJXb2zqXje7nJX+EG1x8geBKRBljvdNmodz9lUlBdGTv0U
         loGQ==
X-Gm-Message-State: AOJu0YxAWBzNXPBBb0xH98o6i0xXwesf4EwbH9f+oMTdBajEvBZhaUpt
	ObRGaJXInIjb01RiptqlwJ4=
X-Google-Smtp-Source: AGHT+IHR5x6OhDDciEaHttITlEjCwg329MZhAHnNtogZRzuZTaztVIu7Xqz7JbIhp2UUwpc3NRKeaA==
X-Received: by 2002:a05:6e02:b22:b0:35f:ef56:35a with SMTP id e2-20020a056e020b2200b0035fef56035amr7367417ilu.48.1703516246083;
        Mon, 25 Dec 2023 06:57:26 -0800 (PST)
Received: from [183.173.16.211] ([183.173.16.211])
        by smtp.gmail.com with ESMTPSA id st14-20020a17090b1fce00b0028a4c85a55csm15962pjb.27.2023.12.25.06.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 06:57:25 -0800 (PST)
Message-ID: <0edbd57a-cf94-4710-a20c-04d0cc43cfad@gmail.com>
Date: Mon, 25 Dec 2023 22:57:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media:fimc-capture: Fix a possible data inconsistency due
 to a data race in fimc_subdev_set_fmt()
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 s.nawrocki@samsung.com, mchehab@kernel.org, alim.akhtar@samsung.com
Cc: linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org, BassCheck <bass@buaa.edu.cn>
References: <20231223164351.3521588-1-islituo@gmail.com>
 <93da765f-44c8-4023-b416-eae617d5ed74@linaro.org>
From: Li Tuo <islituo@gmail.com>
In-Reply-To: <93da765f-44c8-4023-b416-eae617d5ed74@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

Thanks for your reply very much. It is very helpful.
I am really sorry to confuse you.

On 2023/12/24 18:11, Krzysztof Kozlowski wrote:

> On 23/12/2023 17:43, Tuo Li wrote:
>> Accesses to ctx->s_frame.width and ctx->s_frame.height should be protected
>> by the lock fimc->lock to guarantee that width and height are consistent.
>> Here is an example in fimc_subdev_get_fmt():
>>
>>    struct fimc_frame *ff = &ctx->s_frame; // Alias
>>    mutex_lock(&fimc->lock);
>>    mf->width = ff->width;
>>    mf->height = ff->height;
>>
>> However, ctx->s_frame.width and ctx->s_frame.height are accessed without
>> holding the lock fimc->lock in fimc_subdev_set_fmt():
>>
>>    mf->width = ctx->s_frame.width;
>>    mf->height = ctx->s_frame.height;
> Other places setting parts of s_frame, like fimc_capture_try_format() or
> fimc_capture_try_selection(), do not have mutex.
>
>> And thus a harmful data race can occur, which can make ctx->s_frame.width
> Harmful how?

The function set_frame_crop() which updates s_frame.width and
s_frame.height is called by fimc_cap_s_selection(). fimc_cap_s_selection()
is an ioctl function and it is likely to be able to execute concurrently
with other functions such as fimc_subdev_set_fmt(). However, in
fimc_subdev_set_fmt(), the accesses to s_frame.width and s_frame.height are
not protected by the mutex lock fimc->lock.

If fimc_cap_s_selection() and fimc_subdev_set_fmt() can execute
concurrently and the execution orders is like this:

1. ctx->s_frame.width is accessed and assigned to mf->width in
    fimc_subdev_set_fmt()      Line 1552 in fimc-capture.c
2. ctx->s_frame.width and ctx->s_frame.height is updated by
    fimc_cap_s_selection()     Line 1329 in fimc-capture.c
3. ctx->s_frame.height is accessed and assigned to mf->height in
    fimc_subdev_set_fmt()      Line 1553 in fimc-capture.c

The width and height assigned to mf are not coming from the same
ctx->s_frame configuration and can cause data inconsistency.

Besides, the functions fimc_subdev_set_selection() and
fimc_subdev_set_fmt() exist in the same driver interface named
fimc_subdev_pad_ops. Therefore, it seems that fimc_subdev_set_fmt() and
fimc_subdev_set_selection() can also execute concurrently. However, if the
execution order of fimc_subdev_set_selection() and fimc_subdev_set_fmt() is
like mentioned above, a data inconsistency can also occur.

I analyze this possible data race manually according to the code logic, and
I am not sure whether all accesses to configurations such as width, height,
f_width, and f_height should be protected by a mutex lock to make them
consistent. I am really sorry to trouble you, and any feedback will be
appreciated!

>> inconsistent with ctx->s_frame.height, if ctx->s_frame.height is updated
>> right after ctx->s_frame.width is accessed by another thread.
>>
>> This possible bug is found by an experimental static analysis tool
>> developed by our team, BassCheck[1]. This tool analyzes the locking APIs
>> to extract function pairs that can be concurrently executed, and then
>> analyzes the instructions in the paired functions to identify possible
>> concurrency bugs including data races and atomicity violations. The above
>> possible bug is reported when our tool analyzes the source code of
>> Linux 6.2.
>>
>> To fix this possible data race, the lock operation mutex_lock(&fimc->lock)
>> is moved to the front of the accesses to these two variables. With this
>> patch applied, our tool no longer reports the bug, with the kernel
>> configuration allyesconfig for x86_64. Due to the lack of associated
>> hardware, we cannot test the patch in runtime testing, and just verify it
>> according to the code logic.
> You wrote long four paragraphs which have basically almost zero relevant
> information, whether this locking is needed or not. Your bass
> description is not relevant... or actually making things worse because I
> am certain you are fixing it just to fix your report, not to fix real issue.
>
>> [1] https://sites.google.com/view/basscheck/
> Instead provide the report.

I am sorry to confuse you, and I wrote these descriptions according to
researcher guidelines in the kernel documentation
Documentation/process/researcher-guidelines.rst
I will provide a more concise patch in the future.

>> Fixes: 88fa8311ee36 ("[media] s5p-fimc: Add support for ISP Writeback ...")
>> Signed-off-by: Tuo Li <islituo@gmail.com>
>> Cc: stable@vger.kernel.org
>> Reported-by: BassCheck <bass@buaa.edu.cn>
> Run checkpatch, you will see the warning.

Thanks for your advice. I am sorry to bother you, and I will be careful in
the subsequent patches.

> Best regards,
> Krzysztof
>
Sincerely,
Tuo Li


