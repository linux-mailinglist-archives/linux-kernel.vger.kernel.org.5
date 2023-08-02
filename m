Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3715776D2BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjHBPrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjHBPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:47:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48475EE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:47:15 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686e0213c0bso4939988b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690991235; x=1691596035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkMUNgKxht7YwbZMZK7OHgHWSnVKkc1p6TLM+Nlb7N0=;
        b=cAn9a1GhV/IswzlC1cdUKtgmW1/O55mQp+VbeqG4VPljJ4MYvh+B/ToAasgWBzkZmK
         IKxbdQoO1ClubGMGFeWCU4j/JV/kMfN+B36SFTQ7vuE4DLp9B72fKHAjvF7kvT9flLjz
         le/rW/mYwJTtJtbSAOc4jEnihcWIZRjG/Ocik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690991235; x=1691596035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkMUNgKxht7YwbZMZK7OHgHWSnVKkc1p6TLM+Nlb7N0=;
        b=Le9wxAmBuMxkmDbyK6o9a2Ku/ofF0BxV9FaDr5R+hEn59GYiKJgBYPrSPLOTsdcxRJ
         EauJvLljeKQOd3tT0+8702R8usRdlBODZnYLjVRUH+XxaMd91gRiIvkWl/4eBaOsBE3c
         JT8JoJ/1OCBHdl7WqCViH9xYcpLndiM0Tdx50o80XuPbDiMnvwRWUU6HNq2DwG2kwjTE
         oh05HbtiZIdVznatSPl3z2ixRbasYM0sNeSYEA/drjba8PqLzLRsXmvSYRMCUj4wnkET
         eebjgDcZ7hkOREDKjBJiMORr+uWeqzJhMaoFHGkUE9lcp/0jx2BxRfKji1IddHVezHMl
         CQXA==
X-Gm-Message-State: ABy/qLa0LIEytEKQCPZikFIhl1oOKEfQTz7N7af/NizpuMBTnOs+DCWg
        IA248lek+pqRmVK6MYQloECKAcIrhFhuJH+ONRoRxQ==
X-Google-Smtp-Source: APBJJlGj44q8t2bFk7J5q48WOvpItv1C9uoMhJGOUbUjIXjAL/NxnApNadXWFtx6xiiK17jLwIhzgu+p3f/wWA0Qkzg=
X-Received: by 2002:a17:90b:1954:b0:256:8dbd:74fa with SMTP id
 nk20-20020a17090b195400b002568dbd74famr12467229pjb.22.1690991234786; Wed, 02
 Aug 2023 08:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
 <169078863449.173706.2322042687021909241.stgit@devnote2> <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
 <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org> <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
 <20230802000228.158f1bd605e497351611739e@kernel.org> <20230801112036.0d4ee60d@gandalf.local.home>
 <20230801113240.4e625020@gandalf.local.home> <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
 <20230801190920.7a1abfd5@gandalf.local.home> <20230802092146.9bda5e49528e6988ab97899c@kernel.org>
 <20230801204054.3884688e@rorschach.local.home> <20230802225634.f520080cd9de759d687a2b0a@kernel.org>
In-Reply-To: <20230802225634.f520080cd9de759d687a2b0a@kernel.org>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 2 Aug 2023 17:47:03 +0200
Message-ID: <CABRcYm+-tBmM1sUMozPaa8fBfRFhTNpTNtwT5z6xz0nsZA=P0g@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 3:56=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 1 Aug 2023 20:40:54 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Wed, 2 Aug 2023 09:21:46 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >
> > > > Then use kprobes. When I asked Masami what the difference between f=
probes
> > > > and kprobes was, he told me that it would be that it would no longe=
r rely
> > > > on the slower FTRACE_WITH_REGS. But currently, it still does.
> > >
> > > kprobes needs to keep using pt_regs because software-breakpoint excep=
tion
> > > handler gets that. And fprobe is used for bpf multi-kprobe interface,
> > > but I think it can be optional.
> > >
> > > So until user-land tool supports the ftrace_regs, you can just disabl=
e
> > > using fprobes if CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dn
> >
> > I'm confused. I asked about the difference between kprobes on ftrace
> > and fprobes, and you said it was to get rid of the requirement of
> > FTRACE_WITH_REGS.
> >
> >  https://lore.kernel.org/all/20230120205535.98998636329ca4d5f8325bc3@ke=
rnel.org/
>
> Yes, it is for enabling fprobe (and fprobe-event) on more architectures.
> I don't think it's possible to change everything at once. So, it will be
> changed step by step. At the first step, I will replace pt_regs with
> ftrace_regs, and make bpf_trace.c and fprobe_event depends on
> FTRACE_WITH_REGS.
>
> At this point, we can split the problem into two, how to move bpf on
> ftrace_regs and how to move fprobe-event on ftrace_regs. fprobe-event
> change is not hard because it is closing in the kernel and I can do it.
> But for BPF, I need to ask BPF user-land tools to support ftrace_regs.

Ah! I finally found the branch where I had pushed my proof of concept
of fprobe with ftrace_regs... it's a few months old and I didn't get
it in a state such that it could be sent to the list but maybe this
can save you a little bit of lead time Masami :) (especially the bpf
and arm64 specific bits)

https://github.com/FlorentRevest/linux/commits/bpf-arm-complete

08afb628c6e1 ("ftrace: Add a macro to forge an incomplete pt_regs from
a ftrace_regs")
203e96fe1790 ("fprobe, rethook: Use struct ftrace_regs instead of
struct pt_regs")
1a9e280b9b16 ("arm64,rethook,kprobes: Replace kretprobe with rethook on arm=
64")
7751c6db9f9d ("bpf: Fix bpf get_func_ip() on arm64 multi-kprobe programs")
a10c49c0d717 ("selftests/bpf: Update the tests deny list on aarch64")
