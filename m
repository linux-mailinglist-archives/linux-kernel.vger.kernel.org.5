Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A701276D97F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjHBV3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjHBV3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:29:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF781734;
        Wed,  2 Aug 2023 14:29:04 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso4070511fa.0;
        Wed, 02 Aug 2023 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691011742; x=1691616542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0utdvIhX3amp8utvvS+BAk3g+AmsUNViXEgeD6WJsZ4=;
        b=EuhMrUrxRGKAFB4uDxWeh2sbofFgEXon1HQFmho2U6hPIm9c7pGsR0PFFr1ShuhOGM
         XxjCspEy/2Dr1X99sL97YkjEFgfNeTM9rNAMfIv4JhwKXKCkoj2acZXhC2aOQv5a1HHc
         Sp+KGaSYtC5xgo9+9S7xBiwA1uzFw6Oc6D1zSl6tc+C/+iLgt0JzaKNn6Jt5V4/QAUFW
         FBNqDFrqY5FlQeRInStqV2gLHL31JWId5EBr79DB6E7yMBtdmDqrJEir3PNoJOcdVg0z
         buRHv2SgyvnBfAyf4vGmxqa9lkEo07D+K4+YIQNoVOxWpIKXlbFGLreBFtRAcnzDvOzS
         R9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691011742; x=1691616542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0utdvIhX3amp8utvvS+BAk3g+AmsUNViXEgeD6WJsZ4=;
        b=lcGAvyb7veiTSlYZsqwVtS+55MMUxE15U8aha8mnXk7OhfKvgeBNvqjpxyJ6RCSdwf
         IPnsgPREpGuPIY80gFyVZu7sZ/q2C69ogKL3L+ba6HvNPV5pFcimbCqQh1Yzp3lF0QnY
         3O4wgAQFPV55GRWHNl9dWcD4Gb2zuFP6XYstVnpVUX6J0zwg1MBtKUkm0EJeb1jvFLT1
         GnKss3LBisrtZ2ag+//AkcoYWNegfgsOL6SlqBziuWBsgi70zD7rOJ70MSR1gqqrScG6
         eM+DDbsjgSi269UBXJp1ZmdE62SkN5gBmhsbcCjKMYKbG9yWli+NMH69sEQeLw1SqAuy
         dCIw==
X-Gm-Message-State: ABy/qLbQuiuLB1Sko4Cm3Je6ydWWRcRwsxe+51jFC7Ud681UDHPsOiJb
        KUpucu2m5yB28CBWppDsY/u88iYAO78aaWZgO98=
X-Google-Smtp-Source: APBJJlG0emxHL6mSNkEUCVWAQARSUCcQMmVUOsR3dTZxgltNZ+78Zs2AP7iA5PYgSC0XH6HGm/MHGU6k1Qoa3sMeMVA=
X-Received: by 2002:a2e:959a:0:b0:2b6:e283:32cb with SMTP id
 w26-20020a2e959a000000b002b6e28332cbmr5472066ljh.23.1691011742309; Wed, 02
 Aug 2023 14:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
 <169078863449.173706.2322042687021909241.stgit@devnote2> <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
 <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org> <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
 <20230802000228.158f1bd605e497351611739e@kernel.org> <20230801112036.0d4ee60d@gandalf.local.home>
 <20230801113240.4e625020@gandalf.local.home> <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
 <20230801190920.7a1abfd5@gandalf.local.home> <20230802092146.9bda5e49528e6988ab97899c@kernel.org>
 <20230801204054.3884688e@rorschach.local.home> <20230802225634.f520080cd9de759d687a2b0a@kernel.org>
 <CAADnVQLqXjJvCcuQLVz8HxF050jDHaSa2D7cehoYtjXdp3wGLQ@mail.gmail.com>
 <20230802143845.3ce6ed61@gandalf.local.home> <CAADnVQKrL3LZaRcgoTdGN-csPt=eyujPbw9qoxgv9tPYPmZiZA@mail.gmail.com>
 <20230802161220.579b2220@gandalf.local.home>
In-Reply-To: <20230802161220.579b2220@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Aug 2023 14:28:50 -0700
Message-ID: <CAADnVQ+hrW3TuR1HLa2ZJ+7xxTP2YA_Rjsc0pz8wnR0skNP_-w@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 1:12=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 2 Aug 2023 12:48:14 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Wed, Aug 2, 2023 at 11:38=E2=80=AFAM Steven Rostedt <rostedt@goodmis=
.org> wrote:
> > >
> > > On Wed, 2 Aug 2023 11:24:12 -0700
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > > > This is a non starter.
> > > > bpf progs expect arch dependent 'struct pt_regs *' and we cannot ch=
ange that.
> > >
> > > If the progs are compiled into native code, isn't there optimizations=
 that
> > > could be done? That is, if ftrace_regs is available, and the bpf prog=
ram is
> > > just using the subset of pt_regs, is it possible that it could be com=
piled
> > > to use ftrace_regs?
> > >
> > > Forgive my ignorance on how BPF programs turn into executables when r=
unning
> > > in the kernel.
> >
> > Right. It's possible for the verifier to do an offset rewrite,
> > forbid certain access, always return 0 on load from certain offset,
> > and so on.
> > It's all non trivial amount of work.
> > ftrace_partial_regs() from ftrace_regs into pt_regs is so much simpler.
>
> Sure, and the copy could be the solution we have in the near future, but =
if
> we could optimize it in the future, then perhaps it would be worth doing =
it.
>
> Also, how are the bpf programs referencing the pt_regs?

Typically through macros that abstract arch differences away in
tools/lib/bpf/bpf_tracing.h
PT_REGS_PARM1
PT_REGS_PARM1_CORE
PT_REGS_PARM1_SYSCALL

pt_regs at syscall entry is special, since syscall calling convention
is different from the rest of the kernel.
ftrace_regs cannot help with that either.

> Could a ftrace_regs
> API be added too?

Potentially yes, but I don't see the value.
bpf users are slowly migrating to fentry/fexit that has accurate
args and return value and much faster.
kprobes are still heavily used, of course.
multi-kprobe (with fprobe_ips underneath) is a new addition that is
also very important to some users.

> If the verifier sees that the program is using
> ftrace_regs, it could then use the lighter weight fprobes for access,
> otherwise it falls back to the kprobe version.
>
> -- Steve
