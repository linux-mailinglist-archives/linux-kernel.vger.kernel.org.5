Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DAD7BDA17
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346255AbjJILjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjJILjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:39:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF5699
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:39:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c877f27e8fso35096085ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696851542; x=1697456342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6zHBem5TwD6LgAbP9oujFTmsoUdAprERpP64C38kf8=;
        b=EdX8s4dJT7Ph4Q22BfVfZ+vtgt9oJPAk6cQVC1Y7vA673Sv/JISQl2TYwfjhAeaQvo
         irbsZmB/vKVBzwYG2vojoBxUnz3DfMyNTsVsEgLDk2VJlj5zHlw2zgyIWNscPlUOs8VV
         2AqUBS8eayvoVWrrD+1Vivmnm2QaTT9C1aFM6xs8JIZCLMXnTedbDBvxFQTjvHF7iPHn
         OvC/lMd3CQ2iEGpZ9VD5VxLmIBnX5DKOE4itKWJracd62XMQkaDFT/anig+7eokk8PRP
         ZxCND7BiZpodVt1opH/c6NnxMVnga4bnUwJpEaKnvxOcWTFLHj/lZdSgKBVw6WDFwYMK
         yO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696851542; x=1697456342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+6zHBem5TwD6LgAbP9oujFTmsoUdAprERpP64C38kf8=;
        b=M9yroEUi+D1QvxNLIvDsBzJwKjvTh/mQ4VhVgNw54SQAb3RK88xVg3JwO5t+t2z3vf
         1CPFfGhdLqEzcOtClgeGM0Ya9gapNog8sjxxh7d/cMu7WLpekQQY2rnfhQEH1960HR+g
         eFF7Yu/hU1j6Gykr0uxbgizftV3WlAquKHwwU8rpRiqcJKNYPJ0vCfQL0pHL+kETVOSz
         meyb9cTICjKxCsVI2uHJ2Dr5npkG5yHRVVVBQACGqmlnpnKEKb49Z30KyOo0BKnAO0f2
         Zxziyuh24o2tQDKJ0UouYbgZYsK2/o4IIniCtrhb241qUshHJlxbYOB+3eWicDFJD1Am
         53JQ==
X-Gm-Message-State: AOJu0Yw2yN8HF0d/vGysMt5GqgJh2u6+wx9oTpa0ZLXmQgtVqD/B4XmU
        TEhyf9rVRPGzmaud1F4Pv7o=
X-Google-Smtp-Source: AGHT+IEtHqvD0mFKDoeru0KQ8cs73v8SPrrsAVmPv4z2Ppn9QBHzOpJTrXWjaAtVOooF/0Q41ya86w==
X-Received: by 2002:a17:902:bc4b:b0:1c5:df3f:89e5 with SMTP id t11-20020a170902bc4b00b001c5df3f89e5mr16454602plz.62.1696851542470;
        Mon, 09 Oct 2023 04:39:02 -0700 (PDT)
Received: from [10.53.28.113] ([143.92.118.30])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001c726147a46sm9327196plg.234.2023.10.09.04.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 04:39:01 -0700 (PDT)
Message-ID: <b1258877-4d02-67d9-a2db-d510eadf8441@gmail.com>
Date:   Mon, 9 Oct 2023 19:38:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] delayacct: convert task->delays to a object
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bsingharora@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
References: <cover.1696761522.git.chunguang.xu@shopee.com>
 <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
 <20231008105801.GC6320@noisy.programming.kicks-ass.net>
 <5dba07eb-88f0-bf84-494e-b979f32ad44d@gmail.com>
 <20231009084341.GA14330@noisy.programming.kicks-ass.net>
From:   brookxu <brookxu.cn@gmail.com>
In-Reply-To: <20231009084341.GA14330@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/10/9 16:43, Peter Zijlstra 写道:
> On Sun, Oct 08, 2023 at 07:10:01PM +0800, brookxu wrote:
>
>>>> @@ -1331,7 +1332,7 @@ struct task_struct {
>>>>    	struct page_frag		task_frag;
>>>>    #ifdef CONFIG_TASK_DELAY_ACCT
>>>> -	struct task_delay_info		*delays;
>>>> +	struct task_delay_info		delays;
>>>>    #endif
>>> Yeah, no.
>> Yes, this way will increase about 80 bytes for task_struct, about 0.85% of
>> size of task_struct, I think this just like sched_statistics, so that can
>> better support dynamically enable through sysctl.
> But it's 80 bytes 'nobody' will use. And arguably we should do the same
> with schedstats, that's default disabled and again, that's per-task
> storage nobody ever uses.
>
> Per this argument we can grow task_struct indefinitely until it
> collapses in on itself by the sheer weight of it's information density.
> Every additional field will be a smaller fraction of the total.
>
> Yes, it makes it all a little more cumbersome, but we should really not
> burden everybody with the load of some.
>
> Surely there is another solution... ?

Hi, peter:

I found another question when I tried to allocate task_delay_info on 
demand, it is hard for us to

determine whether tsk->delays is NULL due to memory failure or delayacct 
disabled, if due to

memory failure I think we should not try to allocate it again, otherwise 
we may have performance

issues, such as following code. If we limit only try once, the code is 
very trick..


bool delayacct_enter(struct task_struct *tsk)

{
         if (!static_branch_unlikely(&delayacct_key))
                 return false;

         if (tsk->delays && !IS_ERR(tsk->delays))
                 return true;

         if (!cmpxchg(&tsk->delays, NULL, -1))
                 __delayacct_tsk_init(tsk);

         return !IS_ERR_OR_NULL(tsk->delays);

}

static inline void delayacct_blkio_start(void)
{
         if (delayacct_enable(current))
                 __delayacct_blkio_start();
}

static inline void delayacct_blkio_end(struct task_struct *p)
{
         if (delayacct_enable(p))
                 __delayacct_blkio_end(p);
}


do you have any suggestion?

