Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7CB7E27C9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjKFOza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjKFOzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:55:25 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09997B6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:55:23 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7748ca56133so41197439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 06:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1699282522; x=1699887322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iairs2nHbf4BFvIm6R4/DL1Lv/6t5zKTAWcYMmkRBmo=;
        b=2k2tFvPu8qRmpOnG+RiggRUTFNK/9Zy6UWXbrZjYt2n7CyZiFT2s1T4v+W7mdL1yM3
         VY7X7dmA7OMhpkacCdHBiHaHI07Cj411B+YdTMEajUBSk0YoNQc476nm8e3WVfAZDLcP
         ++Lv3l5+Bhv5FplzALUKJAE4SjpezHeyKOAUeJS8IHu/OFwwpTOJV8932MXyj1gdQW0e
         8fqGI0TQUtNosHvEpnoSK5YHN0vIqoCgtWSeroUZ4/lR9u96bvLa9sIntZgSoB65GaQ7
         kEd/pAfwhydldOle+MCFKIX78Nuy6zzbP+Y/tQp8mHhrYDxL1FpQXvXQQyUEdi8qGXZK
         zSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699282522; x=1699887322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iairs2nHbf4BFvIm6R4/DL1Lv/6t5zKTAWcYMmkRBmo=;
        b=KzObPJS+kO1kdmE1aDtnnX0jhr5KKPyXtAf7QRFXU/VOVx9eRGeV2b3jTdBlYUrrbg
         gvUpLepjQQPI41CGCXtBrAfaXfygr1n13yB9Whh7Gnf+I+ZNk6gteg/lY27xRSyiG3cW
         gTNK1N4UFxNSoZh7VQ+rRYXf7dN1q5+cEt/fEvL4SRLraNs8rW8qivzEr/26OD4ZIQWD
         NZrkjA4DqLmgZThA9rCXwMzzQ/R47pbGLUEqSvGRpHpHfMT5Zt7UttPH0UDkTgTWnyMF
         Jpgur/w+xFZoYW7eWRCFqc2wp80utfAxO91EomN4lRiyJ04uk9ODKHJjBKzrScOnqa5h
         Ynvw==
X-Gm-Message-State: AOJu0YwQttazRzLvnOPP5nZcXfkosXhTzKsxFYnFtucKoaHi1f/okkuD
        /KwQ61itPMCUSJ9KxLUHksTbKA==
X-Google-Smtp-Source: AGHT+IEG4LkvzOFaOp62JcFT1CxHf8o8fb6KRC4bWob/4jtCewcHGdjRc90M/C/q507HMKpXurQncA==
X-Received: by 2002:a92:d08b:0:b0:359:39ac:a161 with SMTP id h11-20020a92d08b000000b0035939aca161mr15435444ilh.1.1699282522379;
        Mon, 06 Nov 2023 06:55:22 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gs25-20020a0566382d9900b0042b2f0b77aasm2118414jab.95.2023.11.06.06.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 06:55:21 -0800 (PST)
Message-ID: <2a1bdb5a-1216-45b0-a78d-5542b36ccd17@kernel.dk>
Date:   Mon, 6 Nov 2023 07:55:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IO_URING: Statistics of the true utilization of sq
 threads.
Content-Language: en-US
To:     Xiaobing Li <xiaobing.li@samsung.com>, asml.silence@gmail.com
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        kun.dou@samsung.com, peiwei.li@samsung.com, joshi.k@samsung.com,
        kundan.kumar@samsung.com, wenwen.chen@samsung.com,
        ruyi.zhang@samsung.com
References: <CGME20231106074844epcas5p252beb2aa7925de34aea33d5c64d1d72e@epcas5p2.samsung.com>
 <20231106074055.1248629-1-xiaobing.li@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231106074055.1248629-1-xiaobing.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 12:40 AM, Xiaobing Li wrote:
> Since the sq thread has a while(1) structure, during this process, there
> may be a lot of time that is not processing IO but does not exceed the
> timeout period, therefore, the sqpoll thread will keep running and will
> keep occupying the CPU. Obviously, the CPU is wasted at this time;Our
> goal is to count the part of the time that the sqpoll thread actually
> processes IO, so as to reflect the part of the CPU it uses to process
> IO, which can be used to help improve the actual utilization of the CPU
> in the future.
> 
> Signed-off-by: Xiaobing Li <xiaobing.li@samsung.com>
> ---
>  io_uring/sqpoll.c | 8 ++++++++
>  io_uring/sqpoll.h | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
> index bd6c2c7959a5..27b01ad42678 100644
> --- a/io_uring/sqpoll.c
> +++ b/io_uring/sqpoll.c
> @@ -224,6 +224,7 @@ static int io_sq_thread(void *data)
>  	struct io_ring_ctx *ctx;
>  	unsigned long timeout = 0;
>  	char buf[TASK_COMM_LEN];
> +	unsigned long long start, begin, end;
>  	DEFINE_WAIT(wait);

These can just be unsigned long, that's the size of jiffies on any
platform. Ditto for struct io_sq_data.

And while this looks fine, nothing is using this accounting. For this to
be an acceptable patch, surely the value needs to be used somehow or at
least you should be able to query it?

-- 
Jens Axboe

