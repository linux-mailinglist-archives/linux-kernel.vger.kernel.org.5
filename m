Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E2980BC7E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 19:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjLJR7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:59:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A41A7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 09:59:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A5CC433C7;
        Sun, 10 Dec 2023 17:59:10 +0000 (UTC)
Date:   Sun, 10 Dec 2023 12:59:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Allow for max buffer data size trace_marker
 writes
Message-ID: <20231210125908.5bf1cf7a@rorschach.local.home>
In-Reply-To: <c5c39d2a-a841-4a27-b072-7b190e6838cb@efficios.com>
References: <20231209175003.63db40ab@gandalf.local.home>
        <2683467e-cadb-4bb8-8c50-87ef052edacb@efficios.com>
        <20231210103009.29010d00@gandalf.local.home>
        <a684a5f8-9a60-4e16-93f5-747117d08371@efficios.com>
        <20231210113829.780c7097@gandalf.local.home>
        <c5c39d2a-a841-4a27-b072-7b190e6838cb@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023 12:28:32 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > Again, it's not a requirement, it's just an enhancement.  
> 
> How does this have anything to do with dispensing from testing the
> new behavior ? If the new behavior has a bug that causes it to
> silently truncate the trace marker payloads, how do you catch it
> with the current tests ?

I'm not disagreeing with you, but honestly, writing tests that can be
submitted, take up time I simply do not have. So it's either I get this
working and manually test it, or not apply it at all. This was a simple
change which is why I added it. The tests will take much longer to
write than the enhancement itself.

If someone wants to submit patches that test this further, I'd be more
than happy to apply them!

It may be several more months before I get the time to work on this any
further, and there's still several other features that are in my queue
to apply, where some of them will be affected by these changes.

Right now I'm just focused on that any of these changes do not cause
regressions in the workflow that others have. The trace_marker usage
that I've ever seen has been simple writes that are never more than a
couple of hundred bytes. The main reason I added this change was to
be able to test the subbuffer change. Otherwise I would never had made
this change.

Adding more tests is on my todo list, and not just for this, but for
other features. I do have a bunch of tests I run locally that are not
upsteam, but they are mostly hacks that require a lot of clean up
before being added to selftests.

-- Steve
