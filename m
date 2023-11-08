Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0505C7E59F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjKHP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKHP0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:26:08 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3901BF7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:26:06 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3593d2018bfso5447265ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 07:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1699457166; x=1700061966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vEsnau1atbcuYTR+ZyZFHwkMorYown74B1nldk+VG0=;
        b=N+oQfRKi40b+2jTB5XXVI9331gXMLWuBQdAPA3AndpLNVT1qNCbGtZbMEtPUkXT4xL
         qy7D47dAUzmsmFG5ynsjVUg3LDmh9aMtSkEtrUYjlC63OvOseKPLkVLBLmbe+tieAYic
         XO/h574J82V4ql9Bvy7Mn1I1IOlunB4dr1Tt4/M2uNlfU/JPErCJE9tMZWg9K9YVkHPi
         YLNr7cE18gE0/rs4dVxzsNs8aZof+73IfGP2XPFNNK5sRiVeimPQHVf2XG6zklBp25ju
         aKXDgZOP5l7BtCehkv3+traC8uLO8skVK8sHQo0DSNp4oQrcBSP3I4rEHiUSETvarRmF
         SKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699457166; x=1700061966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vEsnau1atbcuYTR+ZyZFHwkMorYown74B1nldk+VG0=;
        b=tURX2QYfTMwMATZDzHnxgIUez4sI/py/2KZQrlbX8O3XhxZOEP9MowtvLsxv502x3g
         3y7TjGiRuMiJIYTsoAf8kVXFN1ZOFZubKWGkI7TFmXhm2lehyOOo8iFPZJYI4rREHWTf
         3YTKKhVvqTeKVL2FcWJMOyxce2q2rUhSlXGtQCBPstBSt3f6n/6biuBX+oAOTin2pXkI
         z5T5gL9G7OSTxYz7WdBJdUaWYyFCTzuAkKOvMqw8tEZ+YDdDhREt0dpu21/jZZULvKfr
         w691muRF3alYz/Qj8kj+NRBYjnHE/CVLBdxqVOiuX0wZHPChIoDX7lWYog7BA2gwBRTb
         sNig==
X-Gm-Message-State: AOJu0YxfaNLp+szNlBtMxTuTCH6n+ip2wseZfGy7UWnAzgtfM7Da9Hsi
        osgIwwUjS2uvGN5pM9lu8/uZsA==
X-Google-Smtp-Source: AGHT+IGUb/rKQUf4kclHmjx/WEMJwIf+c33LzZDIXunhASIhp7wLEYXiRc8lc6x/f0lyOOdyctM/Hg==
X-Received: by 2002:a05:6602:c87:b0:790:958e:a667 with SMTP id fp7-20020a0566020c8700b00790958ea667mr2514722iob.2.1699457165784;
        Wed, 08 Nov 2023 07:26:05 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dk10-20020a0566384bca00b0043978165d54sm3385277jab.104.2023.11.08.07.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 07:26:05 -0800 (PST)
Message-ID: <60464608-a9b7-4cf8-bd6d-c982210c6f83@kernel.dk>
Date:   Wed, 8 Nov 2023 08:26:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] io_uring: Statistics of the true utilization of sq
 threads.
Content-Language: en-US
To:     Xiaobing Li <xiaobing.li@samsung.com>, asml.silence@gmail.com
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        kun.dou@samsung.com, peiwei.li@samsung.com, joshi.k@samsung.com,
        kundan.kumar@samsung.com, wenwen.chen@samsung.com,
        ruyi.zhang@samsung.com
References: <CGME20231108081516epcas5p442a11004e3b4e6339972fd6da4c6692b@epcas5p4.samsung.com>
 <20231108080732.15587-1-xiaobing.li@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231108080732.15587-1-xiaobing.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 1:07 AM, Xiaobing Li wrote:
> Since the sq thread has a while(1) structure, during this process, there
> may be a lot of time that is not processing IO but does not exceed the
> timeout period, therefore, the sqpoll thread will keep running and will
> keep occupying the CPU. Obviously, the CPU is wasted at this time;Our
> goal is to count the part of the time that the sqpoll thread actually
> processes IO, so as to reflect the part of the CPU it uses to process
> IO, which can be used to help improve the actual utilization of the CPU
> in the future.

There should be an explanation in here on what 'work' and 'total' mean.

> The test results are as follows:
> cat /proc/11440/fdinfo/6
> pos:    0
> flags:  02000002
> mnt_id: 16
> ino:    94449
> SqMask: 0xf
> SqHead: 1845170
> SqTail: 1845170
> CachedSqHead:   1845170
> CqMask: 0xf
> CqHead: 1845154
> CqTail: 1845154
> CachedCqTail:   1845154
> SQEs:   0
> CQEs:   0
> SqThread:       -1
> SqThreadCpu:    -1
> UserFiles:      1
> UserBufs:       0
> PollList:
> CqOverflowList:
> PID:    11440
> work:   18794
> total:  19123

These should go with the other Sq thread related ones, eg be SqWork and
SqTotal. It's counted in jiffies right now which is a bit odd in terms
of being exposed, as you'd need to know what the base of that unit is.
But probably not much of a concern, as work/total is really the metric
you care about. Maybe it'd be better to expose it as a percentage, and
get rid of total? Eg just have SqBusy: xx% be the output.

> diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
> index f04a43044d91..f0b79c533062 100644
> --- a/io_uring/fdinfo.c
> +++ b/io_uring/fdinfo.c
> @@ -213,6 +213,12 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *f)
>  
>  	}
>  
> +	if (ctx->sq_data) {
> +		seq_printf(m, "PID:\t%d\n", task_pid_nr(ctx->sq_data->thread));
> +		seq_printf(m, "work:\t%lu\n", ctx->sq_data->work);
> +		seq_printf(m, "total:\t%lu\n", ctx->sq_data->total);
> +	}
> +

This doesn't work, it needs proper locking. See how we get the other sq
values.

-- 
Jens Axboe

