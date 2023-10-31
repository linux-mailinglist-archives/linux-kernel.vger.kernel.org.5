Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433E07DC3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 02:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjJaBHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 21:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjJaBHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 21:07:06 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F2EC1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 18:07:04 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1e99a55a9c0so712673fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 18:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1698714423; x=1699319223; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJLxAfPvPgIhPej6aCP9kF5nh3kvypGF/m0OnJyvvS8=;
        b=GMS49lrMmRwDA49jYGr0dTavFAMJY3Ee1iD7uypth/+7U70cPJPi6XFhey07lfouam
         PXD4dgPhlTay00dJZoKTsXzAKycgGabZiyr76EanIGppcOh89eNwh7j9GLRf0Rit6zoD
         v1vkvXbv2640b6P3xbxbtScXgNf0GSF2DMlRNVCpWv3TJmyT+HgTJce/a1wfaHc0D+SZ
         7VTP85BFPbRyB1ZpC1hBLkErhv65i1heJBLxoXfNjDaVa8OWkAj9B9XeJQXmAcTfl4o9
         JPX9mP0kZS67q8jdT84IQ5nLFDC4ghrHrX1+3mVzg5be5yWzqNekjQIXqtkRfyVSmnhQ
         eXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698714423; x=1699319223;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oJLxAfPvPgIhPej6aCP9kF5nh3kvypGF/m0OnJyvvS8=;
        b=FAMzcvAQlj5AZQtYOGHhgMrVLvmysfzvJT45H++QE+WEyj+m25l8pzOPSZhRPkkbgH
         5MsJH5Fxu8lctop0+8fKwDdGY420XCiliWtMY90SI8W2YexqqSpr6AVJKTHcmY6hYMfX
         ErXtK0B1E08FiJCWkdnfd/+VP1Zs5S4CZk9OeRrNMB0FrtckUlliYFRGlwm8+x7TJOR/
         JbXzD0qVlvaUcaYXjlcFcSGKkKiSBZukHcc1ElkCO429IFS9h12Dg+ZAh3Cmf7/OjNZh
         DqUjIt+8t/NNLzjmccuq/Y7yO7F+7HsX/yLEVM3460zpSf28XxeZzvVLuGQ6YqLYpS3t
         It0Q==
X-Gm-Message-State: AOJu0YzjXaJ7oRvv2vrU8wk1wgifR80VflgGvJe/F/UlAB/QNq1lgNL7
        ckPhZEsCXO4GIgV/YIaOAZwq8g==
X-Google-Smtp-Source: AGHT+IHh3rQ705d8scc8zzA0Y/tXnY/BatdVmlrXGZTNuZUker0efJiuw2wm+m1d4n3kWWi4Y5ZEng==
X-Received: by 2002:a05:6871:2b13:b0:1bf:9fa2:bfa3 with SMTP id dr19-20020a0568712b1300b001bf9fa2bfa3mr12657357oac.1.1698714423433;
        Mon, 30 Oct 2023 18:07:03 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id g7-20020a63b147000000b0058563287aedsm117965pgp.72.2023.10.30.18.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 18:07:02 -0700 (PDT)
Message-ID: <49ec1791-f353-48f2-a39a-378b5463db42@kernel.dk>
Date:   Mon, 30 Oct 2023 19:07:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring futex support
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Was holding off on sending this one until the tip locking/core branch
had been merged with the futex2 changes, as this uses the same API. This
sits on top of both that, and the main for-6.7/io_uring branch.

This pull request adds support for using futexes through io_uring -
first futex wake and wait, and then the vectored variant of waiting,
futex waitv.

For both wait/wake/waitv, we support the bitset variant, as the
"normal" variants can be easily implemented on top of that.

PI and requeue are not supported through io_uring, just the above
mentioned parts. This may change in the future, but in the spirit
of keeping this small (and based on what people have been asking for),
this is what we currently have.

Wake support is pretty straight forward, most of the thought has gone
into the wait side to avoid needing to offload wait operations to a
blocking context. Instead, we rely on the usual callbacks to retry and
post a completion event, when appropriate.

As far as I can recall, the first request for futex support with
io_uring came from Andres Freund, working on postgres. His aio rework
of postgres was one of the early adopters of io_uring, and futex
support was a natural extension for that. This is relevant from both
a usability point of view, as well as for effiency and performance.
In Andres's words, for the former:

"Futex wait support in io_uring makes it a lot easier to avoid deadlocks
in concurrent programs that have their own buffer pool: Obviously pages in
the application buffer pool have to be locked during IO. If the initiator
of IO A needs to wait for a held lock B, the holder of lock B might wait
for the IO A to complete.  The ability to wait for a lock and IO
completions at the same time provides an efficient way to avoid such
deadlocks."

and in terms of effiency, even without unlocking the full potential yet,
Andres says:

"Futex wake support in io_uring is useful because it allows for more
efficient directed wakeups.  For some "locks" postgres has queues
implemented in userspace, with wakeup logic that cannot easily be
implemented with FUTEX_WAKE_BITSET on a single "futex word" (imagine
waiting for journal flushes to have completed up to a certain point). Thus
a "lock release" sometimes need to wake up many processes in a row.  A
quick-and-dirty conversion to doing these wakeups via io_uring lead to a
3% throughput increase, with 12% fewer context switches, albeit in a
fairly extreme workload."

Please pull!


The following changes since commit 93b8cc60c37b9d17732b7a297e5dca29b50a990d:

  io_uring: cancelable uring_cmd (2023-09-28 07:36:00 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/io_uring-futex-2023-10-30

for you to fetch changes up to 8f350194d5cfd7016d4cd44e433df0faa4d4a703:

  io_uring: add support for vectored futex waits (2023-09-29 02:37:08 -0600)

----------------------------------------------------------------
io_uring-futex-2023-10-30

----------------------------------------------------------------
Jens Axboe (10):
      Merge branch 'for-6.7/io_uring' into io_uring-futex
      Merge branch 'locking/core' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into io_uring-futex
      futex: move FUTEX2_VALID_MASK to futex.h
      futex: factor out the futex wake handling
      futex: abstract out a __futex_wake_mark() helper
      io_uring: add support for futex wake and wait
      futex: add wake_data to struct futex_q
      futex: make futex_parse_waitv() available as a helper
      futex: make the vectored futex operations available
      io_uring: add support for vectored futex waits

 include/linux/io_uring_types.h |   5 +
 include/uapi/linux/io_uring.h  |   4 +
 io_uring/Makefile              |   1 +
 io_uring/cancel.c              |   5 +
 io_uring/cancel.h              |   4 +
 io_uring/futex.c               | 386 +++++++++++++++++++++++++++++++++
 io_uring/futex.h               |  36 +++
 io_uring/io_uring.c            |   7 +
 io_uring/opdef.c               |  34 +++
 kernel/futex/futex.h           |  20 ++
 kernel/futex/requeue.c         |   3 +-
 kernel/futex/syscalls.c        |  18 +-
 kernel/futex/waitwake.c        |  49 +++--
 13 files changed, 545 insertions(+), 27 deletions(-)

-- 
Jens Axboe

