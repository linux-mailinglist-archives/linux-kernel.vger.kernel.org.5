Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E835E77938D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbjHKP5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjHKP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:57:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32952712;
        Fri, 11 Aug 2023 08:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63F5B65C00;
        Fri, 11 Aug 2023 15:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C67C433C8;
        Fri, 11 Aug 2023 15:57:15 +0000 (UTC)
Date:   Fri, 11 Aug 2023 11:57:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Florent Revest <revest@chromium.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 4/6] tracing/fprobe: Enable fprobe events with
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-ID: <20230811115714.171163fc@gandalf.local.home>
In-Reply-To: <20230810093845.7ebbe1ada897a4afe861e331@kernel.org>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
        <169139095066.324433.15514499924371317690.stgit@devnote2>
        <CABRcYm+8-zYRGjKSPtWQ8_Vq2649=vi71fGvFx2aWM1tnOMYQQ@mail.gmail.com>
        <20230809234512.e3c39b8fffcc6297262f8fc8@kernel.org>
        <CABRcYm+24OLedwiLGj1RyvVg22R5NduORVsYZfXSA_OX5F+riA@mail.gmail.com>
        <20230810093845.7ebbe1ada897a4afe861e331@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 09:38:45 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Or even just above this function if there are low chances it would get
> > used elsewhere :)  
> 
> Thanks, but since regs_get_kernel_stack_nth() is defined in asm/ptrace.h,
> I think ftrace_regs_get_kernel_stack_nth() is better defined in
> linux/ftrace.h. :)

I agree with Masami.

Thanks,

-- Steve
