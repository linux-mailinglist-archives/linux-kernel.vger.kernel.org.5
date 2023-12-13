Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD6810670
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378141AbjLMA0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjLMAZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:25:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FED92
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:25:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C59C433C7;
        Wed, 13 Dec 2023 00:25:54 +0000 (UTC)
Date:   Tue, 12 Dec 2023 19:26:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Have trace_marker break up by lines by size of
 trace_seq
Message-ID: <20231212192637.27e884d7@gandalf.local.home>
In-Reply-To: <20231213091933.e3c78e210683b75b9dcbf59f@kernel.org>
References: <20231212190422.1eaf224f@gandalf.local.home>
        <20231213091933.e3c78e210683b75b9dcbf59f@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Wed, 13 Dec 2023 09:19:33 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 12 Dec 2023 19:04:22 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > If a trace_marker write is bigger than what trace_seq can hold, then it
> > will print "LINE TOO BIG" message and not what was written.
> > 
> > Instead, if check if the write is bigger than the trace_seq and break it  
> 
> Instead, check if ... ?

Ah yes, thank you.

> 
> > up by that size.
> > 
> > Ideally, we could make the trace_seq dynamic that could hold this. But
> > that's for another time.  
> 
> I think this is OK, but if possible it is better to be merged with the
> "LINE TOO BIG" patch (by updating the version).

What do you mean by "updating the version"?

Note, the LINE TOO BIG doesn't happen today. It only happens when applying
the sub buffer resize change, and then when I run the tests, it breaks when
the subbuffer is bigger than the trace_seq.

> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

-- Steve
