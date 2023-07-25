Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9E762318
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGYUNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjGYUNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D4B19AD;
        Tue, 25 Jul 2023 13:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD3B7616A3;
        Tue, 25 Jul 2023 20:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9279C433C7;
        Tue, 25 Jul 2023 20:13:33 +0000 (UTC)
Date:   Tue, 25 Jul 2023 16:13:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ze Gao <zegao2021@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH 1/3] sched, tracing: report task state in symbolic
 chars instead
Message-ID: <20230725161332.34ba912a@rorschach.local.home>
In-Reply-To: <20230725133100.GL3765278@hirez.programming.kicks-ass.net>
References: <20230725072254.32045-1-zegao@tencent.com>
        <20230725072254.32045-2-zegao@tencent.com>
        <20230725083357.GA3765278@hirez.programming.kicks-ass.net>
        <CAD8CoPAdRUxk3FWdNX6g0V6Kdr3+sXv8fdQ9NhgKUR29-ZLaug@mail.gmail.com>
        <20230725133100.GL3765278@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 15:31:00 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > > This is a format change and will likely break a ton of programs :/  
> >   
> 
> > BTW, could you help to point to any possible tools/programs that would
> > break other than perf/libtraceevent, because these two are the only
> > users I run into so far.  
> 
> Latencytop was the one breaking a few years ago, but there's a metric
> ton of sched_switch users out there, this is bound to generate pain.
> 
> Steve, you remember what the status of all this was? at the time
> breaking this was considered on par with ABI breakage and we reverted or
> something. Is this still so?

I did reply to the patch (before I switched to thread mode, and notice
that there were already replies ;-)

Pretty much all the tools have been switched over to libtraceevent, but
some just copied the code internally. Although, newer code (like
rasdaemon) are moving over to the newer shared library. Anyway, I did
post a possibly solution in my other email.

-- Steve
