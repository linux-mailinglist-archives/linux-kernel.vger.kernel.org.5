Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8587E338F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjKGDHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjKGDHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:07:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF11D7A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 19:07:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CABC433CB;
        Tue,  7 Nov 2023 03:07:33 +0000 (UTC)
Date:   Mon, 6 Nov 2023 22:07:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 18/32] function_graph: Fix to initalize ftrace_ops
 for fgraph with ftrace_graph_func
Message-ID: <20231106220735.5e218484@gandalf.local.home>
In-Reply-To: <20231107104924.d992919b8277be36d6fa8455@kernel.org>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
        <169920060974.482486.15664806338999944098.stgit@devnote2>
        <20231106190416.cbd04fdd5bb9cdff72563e64@kernel.org>
        <20231107104924.d992919b8277be36d6fa8455@kernel.org>
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

On Tue, 7 Nov 2023 10:49:24 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > I've changed this, because fprobe entry handler is not called via
> > fgraph without this. But maybe I have to set correct gops->ops.func
> > after init?  
> 
> I confirmed that this is right because it is introduced by
> 0c0593b45c9b ("x86/ftrace: Make function graph use ftrace directly")
> which replaces ftrace_stub with ftrace_graph_func (which automatically
> switched by architecture)

Agreed.

-- Steve
