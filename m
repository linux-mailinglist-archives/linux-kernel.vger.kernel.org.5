Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D1D7EC419
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343998AbjKONvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbjKONvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:51:22 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FA19B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:51:19 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-779f81223ebso11291785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700056279; x=1700661079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WYEMkbRs5f6FQHbQGdDrqvN21x+DPqoXcf4uI4/Hi3A=;
        b=d44Y42Ns+Ep6JW+TMjbKPDHJzX64ECRGhZT/t7+ac39ONy8ewOlVQzwnPS8d0E/FY3
         as1YrZULZnR8c+11UAz6010jByqAPEPnFBNUh1VXxDXesJ64HhD/DbAviF4j4DB8UDJI
         pFRsO9I7hwJzsnArHK6/J8WnkjIYx5GjmxAANz7q0jyozQLIU33AZVZxdjwlp+xK6Paw
         OYeWJcLOjiBoCHirnF7EG5ATlLT/w627a7v51CQiLX4NgvEl4J05OaBet8Wk5C/GoABH
         WvCuPXdz2P358JR10TVhTEu4ZvqK+KCaNy0TJgvcOhZLSrrZB85Zxoccc0sbAlIJquKK
         C/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700056279; x=1700661079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYEMkbRs5f6FQHbQGdDrqvN21x+DPqoXcf4uI4/Hi3A=;
        b=n9uoozwDG/icu3rn4sMCJ+TDC856eacDiPRB/mLTcj0ubKUXRWEvMOjCe+CjfXgjsL
         OY5/SJpc/GKBI/9AFdrNrcg27VdT89GFeCdImU+mVBBqhc188fsFgHObSvzHDZ3hA2Sc
         h4EHRovjuqT6HXSZyBFbHjqNMGWr1yJ7w4ZKZTapRM8/KUO7Kh3zY1XG+aFlNYUrvdu2
         /HiFzP2MdPacHefhWEe/5MSEZxVyZqCw8+r2jn1UtGavaiwF8yVLKmEAjQn3JAvyqQxP
         Zyva4TBlT7FWmk1QqPTXkjQ516DXJb3YMW9r1SURFSKWC6qldfjrmRI4vDcDuV92i2D2
         keJA==
X-Gm-Message-State: AOJu0YwZmunBfytL/37AfNZupo33iWTdn/3gTA30753FqzEMmKnkYP0/
        SjpA6uoCCXWRV/6bILD0oLGbpg==
X-Google-Smtp-Source: AGHT+IGaj1Qpq+RNmSVt5V0/DdAN36kVvgi9dfEsGco2RNPoc4Fw6kPcMdc1FeDZbo3ALaKmjZSsgQ==
X-Received: by 2002:a05:620a:1a0f:b0:767:e04f:48c8 with SMTP id bk15-20020a05620a1a0f00b00767e04f48c8mr5993087qkb.7.1700056279043;
        Wed, 15 Nov 2023 05:51:19 -0800 (PST)
Received: from ?IPV6:2600:380:9175:75f:e6af:c913:71c3:9f81? ([2600:380:9175:75f:e6af:c913:71c3:9f81])
        by smtp.gmail.com with ESMTPSA id b22-20020a05620a127600b0076c8fd39407sm3470731qkl.113.2023.11.15.05.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 05:51:18 -0800 (PST)
Message-ID: <b4a58cf5-3bc6-4279-8a33-d7209a60164f@kernel.dk>
Date:   Wed, 15 Nov 2023 06:51:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] io_uring: Statistics of the true utilization of sq
 threads.
Content-Language: en-US
To:     Xiaobing Li <xiaobing.li@samsung.com>, asml.silence@gmail.com
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        kun.dou@samsung.com, peiwei.li@samsung.com, joshi.k@samsung.com,
        kundan.kumar@samsung.com, wenwen.chen@samsung.com,
        ruyi.zhang@samsung.com, cliang01.li@samsung.com,
        xue01.he@samsung.com
References: <CGME20231115122627epcas5p37263cadafd5af20043fbb74e57fe5a4c@epcas5p3.samsung.com>
 <20231115121839.12556-1-xiaobing.li@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231115121839.12556-1-xiaobing.li@samsung.com>
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

On 11/15/23 5:18 AM, Xiaobing Li wrote:
> v3:
> 1.Since the sq thread has a while(1) structure, during this process,
>   there may be a lot of time that is not processing IO but does not
> exceed the timeout period, therefore, the sqpoll thread will keep
> running and will keep occupying the CPU. Obviously, the CPU is wasted at
> this time;Our goal is to count the part of the time that the sqpoll
> thread actually processes IO, so as to reflect the part of the CPU it
> uses to process IO, which can be used to help improve the actual
> utilization of the CPU in the future.
> 
> 2."work_time" in the code represents the sum of the jiffies count of the
>   sq thread actually processing IO, that is, how many milliseconds it
> actually takes to process IO. "total_time" represents the total time
> that the sq thread has elapsed from the beginning of the loop to the
> current time point, that is, how many milliseconds it has spent in
> total.
> The output "SqBusy" represents the percentage of time utilization that
> the sq thread actually uses to process IO.
> 
> 3.The task_pid value in the io_sq_data structure should be assigned
>   after the sq thread is created, otherwise the pid of its parent
> process will be recorded.
> 
> 4.After many tests, we do not need to obtain ctx->uring_lock in advance
>   when obtaining ctx->sq_data. We can avoid null pointer references by
> judging that ctx is not null.

This is mixed in with my patch, please just base it on top of the v4
I'll send out now rather than integrate it. And then you'd need that rcu
free patch as well on top of that, then your changes as a separate
patch.

-- 
Jens Axboe

