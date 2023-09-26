Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC27AF58E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjIZUwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjIZUwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:52:35 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755EC120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:52:28 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-322d2acf4abso6364618f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695761547; x=1696366347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xrypDOHQ7EnWLT1fAC4mj+J/Ny7QwGyNqoMoBzWEChA=;
        b=qz/8NKvGkybGhqCFZBHy2QOWUDiatqVuQzbEOQGhwf/uf6vRjGCT069ftKn55Ne3do
         HmcPIihWscn9WK89fuGIrLkDxGaDDUPq/woote2ARyyV/dXu3wzQTu9GB4pwGTX7+oGF
         AYcckj9arQQLrNM+hABMwvK9cBfduO3t2oYuyB1vBQ5K4YrjHnPDfHsUAecuQsehB1ph
         w8xkZMwcSWf08cIcmD1ZpwqfYu04lG3F4AHRFYONPdAKI5hpeCT000B2YaDBpZpFDK2M
         9ucxzfQKpAfQgK1XO4DtN+Jc646MTLczngtbpg7BpxRQRcwIXxD5j4dmgErgd8Sd/KH1
         PHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695761547; x=1696366347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrypDOHQ7EnWLT1fAC4mj+J/Ny7QwGyNqoMoBzWEChA=;
        b=o/A94zaTlQ4U445NaPSeAENon80M1hC0u+M5GCP7EUwXnk25WhsKcju3wRi/hKV3uJ
         mh0Afj53wVuoFjoNlzYamh75K2fTbULWygS+Oc/GPfQV+fOzYLeW4Z2oZYvyN0ctCh2u
         9a+42X/Jc3wTp0bY+NDLT8qYWXjvfDewNXtg7jfWbRKCuL5Z+a2Ly1xhxP7pCMkaK2HQ
         UTsMkr4NmYqdZfVhTH7vVLg7O8aaF37gfUbFnOVjlJwwljO0OaDwvUJpLy0HMqWW++0c
         GWe48g6a4GBgvRuXeU4trFalb+jnpC/yUQhVLmTNsA4/I7D8/UCtp6Ss8KQ3NF3F0GIP
         xNcA==
X-Gm-Message-State: AOJu0YyQMfgRWDTUNDqDLwSYR3kZ8OZ5nwES4bUUroYHoX44nFxjd96c
        miC5dbmyBlmylRcQE/7iCs5L5Ry+VIlX
X-Google-Smtp-Source: AGHT+IFbugUBPJsObmukOcm7PN9PUqCtpIpnfXBZrDwvp1SMbjd8ej9aDBvvhWOhXNltTOfXtK7SKfPc3zlc
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:2a5f:6690:fe14:d69a])
 (user=dvyukov job=sendgmr) by 2002:a5d:4b90:0:b0:321:a6b5:b50e with SMTP id
 b16-20020a5d4b90000000b00321a6b5b50emr57461wrt.11.1695761546817; Tue, 26 Sep
 2023 13:52:26 -0700 (PDT)
Date:   Tue, 26 Sep 2023 22:52:15 +0200
In-Reply-To: <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com>
Mime-Version: 1.0
References: <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230926205215.472650-1-dvyukov@google.com>
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
From:   Dmitry Vyukov <dvyukov@google.com>
To:     mathieu.desnoyers@efficios.com
Cc:     David.Laight@ACULAB.COM, alexander@mihalicyn.com,
        andrealmeid@igalia.com, boqun.feng@gmail.com, brauner@kernel.org,
        carlos@redhat.com, ckennelly@google.com, corbet@lwn.net,
        dancol@google.com, dave@stgolabs.net, dvhart@infradead.org,
        fweimer@redhat.com, goldstein.w.n@gmail.com, hpa@zytor.com,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com,
        paulmck@kernel.org, peterz@infradead.org, pjt@google.com,
        posk@posk.io, rostedt@goodmis.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't see why we can't stick this directly into struct rseq because
>> it's all public anyway.
>
> The motivation for moving this to a different cache line is to handle 
> the prior comment from Boqun, who is concerned that busy-waiting 
> repeatedly loading a field from struct rseq will cause false-sharing and 
> make other stores to that cache line slower, especially stores to 
> rseq_cs to begin rseq critical sections, thus slightly increasing the 
> overhead of rseq critical sections taken while mutexes are held.
>
> If we want to embed this field into struct rseq with its own cache line, 
> then we need to add a lot of padding, which is inconvenient.
>
> That being said, perhaps this is premature optimization, what do you think ?

Hi Mathieu, Florian,

This is exciting!

I thought the motivation for moving rseq_sched_state out of struct rseq
is lifetime management problem. I assume when a thread locks a mutex,
it stores pointer to rseq_sched_state in the mutex state for other
threads to poll. So the waiting thread would do something along the following
lines:

rseq_sched_state* state = __atomic_load_n(mutex->sched_state, __ATOMIC_RELAXED);
if (state && !(state->state & RSEQ_SCHED_STATE_FLAG_ON_CPU))
	futex_wait();

Now if the state is struct rseq, which is stored in TLS,
then the owning thread can unlock the mutex, exit and unmap TLS in between.
Consequently, load of state->state will cause a paging fault.

And we do want rseq in TLS to save 1 indirection.

If rseq_sched_state is separated from struct rseq, then it can be allocated
in type stable memory that is never unmapped.

What am I missing here?

However, if we can store this state in struct rseq, then an alternative
interface would for the kernel to do:

rseq->cpu_id = -1;

to denote that the thread is not running on any CPU.
I think it kinda makes sense, rseq->cpu_id is the thread's current CPU,
and -1 naturally means "not running at all". And we already store -1
right after init, so it shouldn't be a surprising value.

