Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8AA7BB60C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjJFLMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjJFLMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:12:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BDEF0;
        Fri,  6 Oct 2023 04:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2id1/+9flOvIccMuyVXeYT1CBOnL0U83OznUMHRoXl0=; b=aknUV9/slsQKLvyMXTeYIafutn
        d6ts337l+E35PCRYrfxMyaPlytpaEPSfH0BmQkP1wZlNOo5t5sYO8CoXdyHATlbNvmGfM+9GjnjP+
        bm2ibTmEaLSUSwVmndCxEyV0qUb5maBUkbulCo9gFYOwD2hOS+0E858Jc6IiCsjk4sF+Nq51Ct7ib
        SQDgcsFzCtKzJdqmgOnTcgov2/b3I3J6U/UXdHcjKqVbJWQkwdpZr4POZmQLAWNbNCAK7UUAf2Xnx
        BMFwlKcp9T3Bqp7GbxxPH/ojJFZ4NTqRpXHlB7XFYzaBUAT5VtC+G8qU1t0ZGk4Z1wnxKhA8wejo7
        brKVy4kQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qoiku-00EzA1-NW; Fri, 06 Oct 2023 11:12:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6301D300392; Fri,  6 Oct 2023 13:12:28 +0200 (CEST)
Date:   Fri, 6 Oct 2023 13:12:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: locking/core] locking/futex/selftests: Remove duplicate
 ABI defines
Message-ID: <20231006111228.GD36277@noisy.programming.kicks-ass.net>
References: <20231006095539.1601385-1-usama.anjum@collabora.com>
 <169658834039.3135.4395839213523782496.tip-bot2@tip-bot2>
 <20231006104325.GC36277@noisy.programming.kicks-ass.net>
 <ZR/oKYY7R52wKYC5@gmail.com>
 <ZR/ptQMWKxHCeXyp@gmail.com>
 <1b9a4e52-cfa3-4f56-b259-41c94abed362@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b9a4e52-cfa3-4f56-b259-41c94abed362@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:05:31PM +0500, Muhammad Usama Anjum wrote:

>     cd /linux_mainline/tools/testing/selftests/../../..

That's very odd way of writing:

 cd /linux_mainline/

>     make headers

This does a build without O=, I can't do that. 

As in, one must not mix O= and non O= builds, and since I have a ton of
O= output dirs on, I simply can't do this.

> make: *** [../../lib.mk:81: kernel_header_files] Error 1
> ➜  functional (06bc8fe4bfc4b) ✗ (cd $mainline && make headers) > /dev/null
> ➜  functional (06bc8fe4bfc4b) ✗ make
> gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../
> futex_wait_timeout.c -lpthread -lrt -o
> /linux_mainline/tools/testing/selftests/futex/functional/futex_wait_timeout

root@noisy:/usr/src/linux-2.6# cd tools/testing/selftests/futex/functional/
root@noisy:/usr/src/linux-2.6/tools/testing/selftests/futex/functional# make
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../       futex_wait_timeout.c -lpthread -lrt -o /mnt/hirez/usr/src/linux-2.6/tools/testing/selftests/futex/functional/futex_wait_timeout
In file included from futex_wait_timeout.c:20:
../include/futex2test.h:18:47: warning: ‘struct futex_waitv’ declared inside parameter list will not be visible outside of this definition or declaration
18 | static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,


Because noisy runs a really old userspace (buster)..



