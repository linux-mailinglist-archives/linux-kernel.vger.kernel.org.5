Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E9F7E16D6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjKEV3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 16:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEV3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:29:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8414CC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 13:28:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BD7C433C7;
        Sun,  5 Nov 2023 21:28:57 +0000 (UTC)
Date:   Sun, 5 Nov 2023 16:28:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-ID: <20231105162850.4fb804a4@rorschach.local.home>
In-Reply-To: <20231105141130.6ef7d8bd@rorschach.local.home>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
        <169920068069.482486.6540417903833579700.stgit@devnote2>
        <20231105172536.GA7124@noisy.programming.kicks-ass.net>
        <20231105141130.6ef7d8bd@rorschach.local.home>
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

On Sun, 5 Nov 2023 14:11:30 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> You even Acked the patch:

More specifically, you acked the series and stressed the ftrace_regs
wrapper part when doing so:

  https://lore.kernel.org/all/20201113080733.GZ2628@hirez.programming.kicks-ass.net/

> On Thu, Nov 12, 2020 at 09:01:42PM -0500, Steven Rostedt wrote:
> > Steven Rostedt (VMware) (3):
> >       ftrace: Have the callbacks receive a struct ftrace_regs instead of pt_regs
> >       ftrace/x86: Allow for arguments to be passed in to ftrace_regs by default
> >       livepatch: Use the default ftrace_ops instead of REGS when ARGS is available
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

-- Steve
