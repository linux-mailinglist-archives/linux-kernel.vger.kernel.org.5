Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78427543B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjGNUVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbjGNUVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:21:11 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5D630F4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:21:10 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-345d2b936c2so2408215ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689366070; x=1689970870;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fwc1SiQJw7BgJqNETMm+QaaCOFItfxb5hm7Db+eQ9o=;
        b=PbqWXbNrqEaZkGjp/fjOAEwfFtW3ZupLitJndjdoS3uVXY5UFNH5rXxm9cOdCTyEOg
         gNNbsYcf/66y+1kGTq+CuXDEfLWZY2iQ00ZtSJwDwJ0b4cwo8tTq0ydb8zIyQ199ra9x
         y2Vmekze2xsBo3EBKDNi1uCJ6AZ54eENOowJ18VhD4t26KXDoHn/UzUUtxdWeSkQkjjs
         YeXlGVIftc/mBnKII+3LjgSU22e7nl9mKvoe5Dg4u1uozdDvQ3SNEYWz4gcPpMSm8vs2
         jGIw5gHTaybTj+pg1OLiTUHc61bMm6TYWKUBN7Ys0GkanMPCUWQ/khzeCAZQoX4R+reT
         qkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689366070; x=1689970870;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fwc1SiQJw7BgJqNETMm+QaaCOFItfxb5hm7Db+eQ9o=;
        b=EMIgRGEQNY+LNhA62qjtdfuNrID7ORqHXlwFDMUeBobQRhEqFBqE092v2vHJN6WnvV
         XmctOqKQNaYPgVXZqfkPvaDJxByPhG/tcZXqFBXP3NiBxUft09cHTgxqkDOZG5l/DOwS
         HPO44W0Q3ahmWsS75owr32vKbJOf92+DbDGIUaKdg/ciVVK9u7GM0Dlf3JEoPG/B5Mnv
         mPTSnVCvwv1riBx2X59m+sqQOcF+oT8ZN5D9mTcO/jVoJ4g67RrdI8rFlbcVrAjvqA3q
         kfipbH2XN3s4aRr9snoVYf4zYtmqSAZZV0ne8VzRzHKknYct56HG2BfWcqLzfS2M0Uyi
         8IDA==
X-Gm-Message-State: ABy/qLYW1bK/5OcMQPz/81q9bqLnzX1YSWNqa5bnktNwLKLi2Z1g+q7f
        ZvvG3kJSa3rsY71QtOs6XGcibEKczOx+Ar2ORvM=
X-Google-Smtp-Source: APBJJlGYup/De1+VZakKwjxBPLdvLClr2Xxr50fobudoMtCxeBySJV6DmizD/4CWG/lrgXEV+Jhj+A==
X-Received: by 2002:a05:6602:4887:b0:780:c6bb:ad8d with SMTP id ee7-20020a056602488700b00780c6bbad8dmr232314iob.0.1689366070056;
        Fri, 14 Jul 2023 13:21:10 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a5-20020a029985000000b0042b2a16f6b1sm2762741jal.176.2023.07.14.13.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 13:21:09 -0700 (PDT)
Message-ID: <c36db018-79a5-e071-ef80-00c5fd05d4fb@kernel.dk>
Date:   Fri, 14 Jul 2023 14:21:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] exit: add internal include file with helpers
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
References: <20230711204352.214086-1-axboe@kernel.dk>
 <20230711204352.214086-5-axboe@kernel.dk>
 <20230714-lachen-gelassen-716cd90a9a0c@brauner>
 <fbdea234-b8cf-7ac7-7c26-b593cb7f5427@kernel.dk>
In-Reply-To: <fbdea234-b8cf-7ac7-7c26-b593cb7f5427@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 2:16?PM, Jens Axboe wrote:
> On 7/14/23 9:38?AM, Christian Brauner wrote:
>>> diff --git a/kernel/exit.h b/kernel/exit.h
>>> new file mode 100644
>>> index 000000000000..f10207ba1341
>>> --- /dev/null
>>> +++ b/kernel/exit.h
>>> @@ -0,0 +1,30 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +#ifndef LINUX_WAITID_H
>>> +#define LINUX_WAITID_H
>>> +
>>> +struct waitid_info {
>>> +	pid_t pid;
>>> +	uid_t uid;
>>> +	int status;
>>> +	int cause;
>>> +};
>>> +
>>> +struct wait_opts {
>>> +	enum pid_type		wo_type;
>>> +	int			wo_flags;
>>> +	struct pid		*wo_pid;
>>> +
>>> +	struct waitid_info	*wo_info;
>>> +	int			wo_stat;
>>> +	struct rusage		*wo_rusage;
>>> +
>>> +	wait_queue_entry_t		child_wait;
>>> +	int			notask_error;
>>> +};
>>> +
>>> +bool pid_child_should_wake(struct wait_opts *wo, struct task_struct *p);
>>> +long __do_wait(struct wait_opts *wo);
>>> +int kernel_waitid_prepare(struct wait_opts *wo, int which, pid_t upid,
>>> +			  struct waitid_info *infop, int options,
>>> +			  struct rusage *ru, unsigned int *f_flags);
>>
>> I know this isn't your mess obviously but could you try and see whether
>> you can expose a nicer, dedicated struct and helper suited to io_uring's
>> needs instead of exposing the messy kernel/exit.c format?
> 
> From a quick look, I think the wait_opts is pretty much what we need,
> not much to cut from that. For waitid_info, we can make do with just a
> forward declaration, we don't need the whole thing.

I'm wrong obviously, we do need waitid_info as well as that is the
output side... Seems to me that none of them have anything redundant wrt
io_uring. They could be combined into one thing, but is it worth it?

-- 
Jens Axboe

