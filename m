Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF0076D6CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjHBSY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjHBSY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:24:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8611717;
        Wed,  2 Aug 2023 11:24:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9c66e2e36so1834231fa.1;
        Wed, 02 Aug 2023 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691000664; x=1691605464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts9PjQF+d06CnZ4NHHtCvTIMUe8RTgL9534A2fuPK1U=;
        b=l1Sq1p2CrCPnOa7VKOCx+PpzLFNmbxuPIdrniaIMzhAo+hX2a7fAWRdhP1rwiGGNl9
         ZzJgNaoctxHOGc0EoE2aGQmJZ4v1xYQx9R35X7nwrZAjxtCEBJcnXiazHrjLIxkffhem
         gFz+sFdMXDhvybJi8su0Kt4vJd4LXC2TP02FbggLHPGmnhUeVuhWle/Fd17cMFZkmhnf
         J/g1SsMbHFJ0Qgwh6QCIah8pOp/XqWdEf4DV9UZXBuZhuPDmVX1duuKqbpwurxuyaXlj
         /+B9RM3Jm+kLdaDsKlv5R2RmzScx5PNYyPIiemZj4rmUcW9Pifntv5bEqtFm5+t5rsyT
         v+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691000664; x=1691605464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts9PjQF+d06CnZ4NHHtCvTIMUe8RTgL9534A2fuPK1U=;
        b=WXQrXUmRgwn3EpDFjq31vT4JCNBAvY82OHVNJV5ofbommxlypKoRmEc8Z3CVYBBGQE
         Thdv6yuq9JCGLm6nWgF9zkbjRkX5ikouceqpi5Zkjg1v535MMC7NnuI70eEE/IujdQjx
         D4nm/irwzufGRkd6xHTgsECKc/BpaVj/aw624GFRHc/mIszwwcOTjds7euTLvHBuBdmU
         go6iIwUi+Ao+WB7anCrLXfbVe+w1SI4fAkLKQiCwHIo+Ect8mnw/BliCfDGfKc0jq5Sc
         +WBtHEIMbFGN0ziU6punra22RQF68ci8XD9xfhg/PH0H2Fyx/GV6y1V91zGoXF/IXRvY
         eKsA==
X-Gm-Message-State: ABy/qLYAmerzgrGQQ+mGLJ5mCEqEcTDBjQodFaYehxE52bZT+MhcVKIs
        VCwtC68skr9/i6oNlMDhlOfox3BxnT9UhVzBIdc=
X-Google-Smtp-Source: APBJJlH70XQzAjJ43HuabtPY+JfTpxCEUJEQ9MndguEVsTBqK4KmWMDKIjQJe1gZv7tYXXNHGY7pP7G+aIqNEze18DU=
X-Received: by 2002:a2e:b98b:0:b0:2b9:90fb:3502 with SMTP id
 p11-20020a2eb98b000000b002b990fb3502mr2441722ljp.9.1691000663641; Wed, 02 Aug
 2023 11:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
 <169078863449.173706.2322042687021909241.stgit@devnote2> <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
 <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org> <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
 <20230802000228.158f1bd605e497351611739e@kernel.org> <20230801112036.0d4ee60d@gandalf.local.home>
 <20230801113240.4e625020@gandalf.local.home> <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
 <20230801190920.7a1abfd5@gandalf.local.home> <20230802092146.9bda5e49528e6988ab97899c@kernel.org>
 <20230801204054.3884688e@rorschach.local.home> <20230802225634.f520080cd9de759d687a2b0a@kernel.org>
In-Reply-To: <20230802225634.f520080cd9de759d687a2b0a@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Aug 2023 11:24:12 -0700
Message-ID: <CAADnVQLqXjJvCcuQLVz8HxF050jDHaSa2D7cehoYtjXdp3wGLQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
        Florent Revest <revest@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 6:56=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
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
>
> >
> > >
> > > Then you can safely use
> > >
> > > struct pt_regs *regs =3D ftrace_get_regs(fregs);
> > >
> > > I think we can just replace the CONFIG_FPROBE ifdefs with
> > > CONFIG_DYNAMIC_FTRACE_WITH_REGS in kernel/trace/bpf_trace.c
> > > And that will be the first version of using ftrace_regs in fprobe.
> >
> > But it is still slow. The FTRACE_WITH_REGS gives us the full pt_regs
> > and saves all registers including flags, which is a very slow operation
> > (and noticeable in profilers).
>
> Yes, to solve this part, we need to work with BPF user-land people.
> I guess the BPF is accessing registers from pt_regs with fixed offset
> which is calculated from pt_regs layout in the user-space.

This is a non starter.
bpf progs expect arch dependent 'struct pt_regs *' and we cannot change tha=
t.
