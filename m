Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472347BD886
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345615AbjJIK3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345724AbjJIK3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:29:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC319D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:29:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-692ada71d79so3258572b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696847359; x=1697452159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSeREleE3b5gI82rL9oCjjJblLQ+MfHKv1aiTlpTAVI=;
        b=J2pETjUCqu5X6BzmTQX6sw+U+NPDAlYoF/KQSFGVgwxKvkideeXc6is9kjQBtU6Cea
         OrpXW1DzPkyOZCCbE6ARO7K4yxqclsWl/JPxs895gyD6sWD1r62I3KQMH4+sFs3KFWM0
         BLgkPhS7Jhs8gmKmGZZYkxGXEKhIVsgUdqlcKaYhvv4E4As3ZclhoQltFNsXBo760cQH
         F5Z3WtKACNANM8DmmArnoo+7kSVqRdY8L9QhJb2oPnDWpcX+PVllj7J29+aFStrNYlNS
         UPnMSYdD9iX2gWsMIUuqOetkTC1fqqMtBjX1TpuoCW1vtvpOHcjUjllx4hJXP31PHQ0T
         8N2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696847359; x=1697452159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mSeREleE3b5gI82rL9oCjjJblLQ+MfHKv1aiTlpTAVI=;
        b=mIym87tRWgqHIpORiq9pQoxVeQAkTNMXK4KPKL+d7m6FVjnzZZuDHWzGwahXFq0TTW
         JjpoNqOjB4POc70CFYUAiREHX0UByARHcyLXB/uivbWF49iImpFFXE50wNFi+khTAO9J
         bbtwq/7AWnbmaFCRUrEwnZgL3sDfsiPQMROdvhi9BCeGMXoPo9WRdQqkxxcNPvUTZKoH
         p1LRZ81nqjO736jJL1AoMiCoGpsrobLLQtjpt4eCaMHA3xsTTVleUOvO5BZbr2rBrN8a
         gO7pUb+BEm+FRmHCGJzWATmhbL5fDVJeMTy1JlPcDUkGOMCLlGj7fEVYFpfpCz1C+9Br
         ygFA==
X-Gm-Message-State: AOJu0Yw8WMbjQTwcDPeGt5axmLEn0wNJMxn+3TUf62mcfq+bsKRzN4nA
        7FkFilsc8ckMfsxsJsbmu9E=
X-Google-Smtp-Source: AGHT+IFg7hx0GhODYb3WVEzJMmzHkMmw+hlj0uuyuJQuosz5tU3NFe432Ah2B45eFF194EyTWHSR2g==
X-Received: by 2002:a05:6a00:1392:b0:692:6d3f:483f with SMTP id t18-20020a056a00139200b006926d3f483fmr15305316pfg.27.1696847359467;
        Mon, 09 Oct 2023 03:29:19 -0700 (PDT)
Received: from [10.53.28.113] ([143.92.127.238])
        by smtp.gmail.com with ESMTPSA id y3-20020a62b503000000b00692b7011349sm6068475pfe.188.2023.10.09.03.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 03:29:19 -0700 (PDT)
Message-ID: <a93f13de-a018-2ee4-c7a0-855c3bd04444@gmail.com>
Date:   Mon, 9 Oct 2023 18:29:15 +0800
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Thanks, agree with you, I try do it in other ways :)
