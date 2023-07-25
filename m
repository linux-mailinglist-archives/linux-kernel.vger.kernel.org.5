Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA0B7623C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGYUmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjGYUmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:42:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5291D1733
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:42:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b89b0c73d7so9551855ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690317737; x=1690922537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRYSozX4kcw/DQspU4WPwUVPiXgju75i+9aE2fyZQJY=;
        b=YknB+8xVMg4Lgo0CREiqHZnVJ7fTkIV5ZG9PbxrxDwursgw7bV9LfbgLVPx6oGecDA
         Kj/P9QJPNyVwqvlStFmLODz2Rp94daCH2+307wkK/EpI+rdwEh6n6njsuHxOFw394ACH
         tLjKQWN4/Uw4qxb22/RLVeswUj9AlCTk6YHJ8W7X0LLrArQBINC1ilrDUG7oeClNCOR/
         kD/h6a2yAQYES64L5rs1ZCfUw3tcPvnhrT/TukuPe4b/1WoyNtT4qJzEXYcm2DwBF05v
         DWXRWoT/1AtG1I5OIu4jEU5nWS/kSAh/k5Vv6dv0ZoC9vD18l9SXzNQ+uNcNUtSSsSJZ
         YjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317737; x=1690922537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRYSozX4kcw/DQspU4WPwUVPiXgju75i+9aE2fyZQJY=;
        b=C2NH4KzYpXRoxEzg6uoGL+4da4TFk4aNw8fO+813EgYWJ+GkM/jrtY/qCMkspBTcp4
         syyZ2zrP4YTb3ZA9R5iG7yC/URIfBXpoEyXB0FokjcP5opXza5MLvKeP70m0MLly17KI
         qiK7n6hJb4PiH1FhQjA1fBdDIOH5VdbPD8HRW2bNYHSJt10bBwodaxLprhg+TE33T541
         xiGMQdtZQMq/nSmKZCPJwCjP5JQr0N9hegxZKcQYySiP2c5dw4kRRdZcSjrjuE0VzNjL
         SLdY9w7okvJ9lo8r6yIvfpPtMIsjjSommCGyN3ZZ8HOaUOOZm+Qzid77TQoqPF6MI8f7
         FZnQ==
X-Gm-Message-State: ABy/qLaRamvqId4XeHeXuqZHXS6mgdSElX5QlYPBHpFIhlkZzfRHe8kk
        tgC0er08HA4PEwbLcHLeukk18g==
X-Google-Smtp-Source: APBJJlHif98db+dzl0ZgxaBVur6tH1hj4nvA4bQIX+gut/k3paT0qMDcTWV9LDiE9NzQmAL3d/x9/A==
X-Received: by 2002:a17:902:e5c2:b0:1b8:85c4:48f5 with SMTP id u2-20020a170902e5c200b001b885c448f5mr321797plf.2.1690317736786;
        Tue, 25 Jul 2023 13:42:16 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090aec0f00b0025bdc3454c6sm18273pjy.8.2023.07.25.13.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:42:16 -0700 (PDT)
Message-ID: <24a8a74a-e218-6105-ee97-02f60b1523bb@kernel.dk>
Date:   Tue, 25 Jul 2023 14:42:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/10] io_uring: add support for futex wake and wait
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        andres@anarazel.de
References: <20230720221858.135240-1-axboe@kernel.dk>
 <20230720221858.135240-7-axboe@kernel.dk>
 <20230721113031.GG3630545@hirez.programming.kicks-ass.net>
 <20230721113718.GA3638458@hirez.programming.kicks-ass.net>
 <d95bfb98-8d76-f0fd-6283-efc01d0cc015@kernel.dk>
 <94b8fcc4-12b5-8d8c-3eb3-fe1e73a25456@kernel.dk>
 <20230725130015.GI3765278@hirez.programming.kicks-ass.net>
 <28a42d23-6d70-bc4c-5abc-0b3cc5d7338d@kernel.dk>
 <9a197037-4732-c524-2eb9-250ef7175a82@kernel.dk>
 <20230725151909.GT4253@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230725151909.GT4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 9:19?AM, Peter Zijlstra wrote:
> On Tue, Jul 25, 2023 at 07:57:28AM -0600, Jens Axboe wrote:
> 
>> Something like the below - totally untested, but just to show what I
>> mean. Will need to get split and folded into the two separate patches.
>> Will test and fold them later today.
>>
>>
>> diff --git a/io_uring/futex.c b/io_uring/futex.c
>> index 4c9f2c841b98..b0f90154d974 100644
>> --- a/io_uring/futex.c
>> +++ b/io_uring/futex.c
>> @@ -168,7 +168,7 @@ bool io_futex_remove_all(struct io_ring_ctx *ctx, struct task_struct *task,
>>  	return found;
>>  }
>>  
>> -int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>> +static int __io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>  {
>>  	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
>>  	u32 flags;
>> @@ -179,9 +179,6 @@ int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>  	iof->uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
>>  	iof->futex_val = READ_ONCE(sqe->addr2);
>>  	iof->futex_mask = READ_ONCE(sqe->addr3);
>> -	iof->futex_nr = READ_ONCE(sqe->len);
>> -	if (iof->futex_nr && req->opcode != IORING_OP_FUTEX_WAITV)
>> -		return -EINVAL;
>>  
>>  	flags = READ_ONCE(sqe->futex_flags);
>>  	if (flags & ~FUTEX2_MASK)
>> @@ -191,14 +188,36 @@ int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>  	if (!futex_flags_valid(iof->futex_flags))
>>  		return -EINVAL;
>>  
>> -	if (!futex_validate_input(iof->futex_flags, iof->futex_val) ||
>> -	    !futex_validate_input(iof->futex_flags, iof->futex_mask))
>> +	if (!futex_validate_input(iof->futex_flags, iof->futex_mask))
>>  		return -EINVAL;
>>  
>> -	iof->futexv_owned = 0;
>>  	return 0;
>>  }
> 
> I think you can/should split more into io_futex_prep(), specifically
> waitv should also have zero @val and @mask.

Yep, I'll include that. Updating them now...

-- 
Jens Axboe

