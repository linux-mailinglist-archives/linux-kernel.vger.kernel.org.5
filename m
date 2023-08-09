Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CC77764DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjHIQSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjHIQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:18:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F28F2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:17:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26854159c05so3927087a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691597879; x=1692202679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHLoN7tBYiBt4IC9BoSBMZPybpCDdS5lyEi5Q2VdGdE=;
        b=ZNVS/49rrsAyq36TYDMzxwqxd53cG5yh8OylLIDFnThnxrCUme34Nn+E3Y2gRhm8/2
         b/KI/HrW+tuUQ6d/+Ue7k1/YcH8E6Vf/D7O3DOsc2PHlpuGTKgAoxH7OOSd+E6XmG8i2
         2O2EYohAM9qNZJUaU2p8tRnu5eoQhRZet42j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691597879; x=1692202679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHLoN7tBYiBt4IC9BoSBMZPybpCDdS5lyEi5Q2VdGdE=;
        b=YaeIP77KbjjvtvgQvqJmMDbFENyWHmjGWRvr8Os4SFtTwYYHqFx2oax92Q1ZB2+eit
         ugOeZJEe3idWrSAb5veWhI0+3BDBD4CTlwzJh/nsnxiDBqr66rT2H5WaMqd8Ayvm2Gvz
         SpoVQdeS0Am+5bbZe83lJ392DyjjgKWkxdZObAfdgj3LoMCNwLltBejp/6cpPj3JA5Wa
         pSYm8y1srGD9kOpGkh/2Sy8VdcLhWjCbXOyh7tpgApZbtsAhIfGKgdua7ewXnIrKFMC4
         pTz+hh11ynHjTYtz4rAEg7kQZ6FFX9z6wI2qvrHoK+riow9zirNwFZugQWYPygE7nZqN
         uZQQ==
X-Gm-Message-State: AOJu0YycYOGy5ZinoUPFlGUKjOzdHVrYfad8iQ53ZpYxBG2rEZqkYp+A
        G/0cgSF3xHqTSO7kgqZsZZZfKe/58uICpeH3Cioq/Q==
X-Google-Smtp-Source: AGHT+IFILk9qe3x2c3g5OACJh3zb2BvFno+fEkvYJ4z02ZUwtZ5eqs4WQPQxCBVrDK7PeZD8uAl3/YBDVn/TXhqgUl8=
X-Received: by 2002:a17:90b:3ec1:b0:268:ee6:6bdf with SMTP id
 rm1-20020a17090b3ec100b002680ee66bdfmr2446960pjb.47.1691597878863; Wed, 09
 Aug 2023 09:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
 <169139091575.324433.13168120610633669432.stgit@devnote2> <CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
 <20230809231011.b125bd68887a5659db59905e@kernel.org> <CABRcYmKEd=zmriE8VUnSTvybwA962r60+QaRJZK=KNqYixd_eg@mail.gmail.com>
In-Reply-To: <CABRcYmKEd=zmriE8VUnSTvybwA962r60+QaRJZK=KNqYixd_eg@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 9 Aug 2023 18:17:47 +0200
Message-ID: <CABRcYmLHfQsjwf7dk+A0Q96iANhj60M0g_xRjVyMUY9LJPybNg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/6] fprobe: Use fprobe_regs in fprobe entry handler
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 6:09=E2=80=AFPM Florent Revest <revest@chromium.org>=
 wrote:
>
> On Wed, Aug 9, 2023 at 4:10=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
> >
> > Hi Florent,
> >
> > On Wed, 9 Aug 2023 12:28:38 +0200
> > Florent Revest <revest@chromium.org> wrote:
> >
> > > On Mon, Aug 7, 2023 at 8:48=E2=80=AFAM Masami Hiramatsu (Google)
> > > <mhiramat@kernel.org> wrote:
> > > >
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> > > > This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH=
_ARGS
> > > > instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fpro=
be
> > > > on arm64.
> > >
> > > This patch lets fprobe code build on configs WITH_ARGS and !WITH_REGS
> > > but fprobe wouldn't run on these builds because fprobe still register=
s
> > > to ftrace with FTRACE_OPS_FL_SAVE_REGS, which would fail on
> > > !WITH_REGS. Shouldn't we also let the fprobe_init callers decide
> > > whether they want REGS or not ?
> >
> > Ah, I think you meant FPROBE_EVENTS? Yes I forgot to add the dependency
> > on it. But fprobe itself can work because fprobe just pass the ftrace_r=
egs
> > to the handlers. (Note that exit callback may not work until next patch=
)
>
> No, I mean that fprobe still registers its ftrace ops with the
> FTRACE_OPS_FL_SAVE_REGS flag:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/k=
ernel/trace/fprobe.c?h=3Dtopic/fprobe-ftrace-regs&id=3D2ca022b2753ae0d2a251=
3c95f7ed5b5b727fb2c4#n185
>
> Which means that __register_ftrace_function will return -EINVAL on
> builds !WITH_REGS:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/k=
ernel/trace/ftrace.c?h=3Dtopic/fprobe-ftrace-regs&id=3D2ca022b2753ae0d2a251=
3c95f7ed5b5b727fb2c4#n338
>
> As documented here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/i=
nclude/linux/ftrace.h?h=3Dtopic/fprobe-ftrace-regs&id=3D2ca022b2753ae0d2a25=
13c95f7ed5b5b727fb2c4#n188
>
> There are two parts to using sparse pt_regs. One is "static": having
> WITH_ARGS in the config, the second one is "dynamic": a ftrace ops
> needs to specify that it doesn't want to go through the ftrace
> trampoline that saves a full pt_regs, by not giving
> FTRACE_OPS_FL_SAVE_REGS. If we want fprobe to work on builds
> !WITH_REGS then we should both remove Kconfig dependencies to
> WITH_REGS (like you've done) but also stop passing this ftrace ops
> flag.

Said in a different way: there are arches that support both WITH_ARGS
and WITH_REGS (like x86 actually). They have two ftrace trampolines
compiled in: ftrace_caller and ftrace_regs_caller, one for each
usecase. If you register to ftrace with the FTRACE_OPS_FL_SAVE_REGS
flag you are telling it that what you want is a pt_regs. If you are
trying to move away from pt_regs and support ftrace_regs in the more
general case (meaning, in the case where it can contain a sparse
pt_regs) then you should stop passing that flag so you go through the
lighter, faster trampoline and test your code in the circumstances
where ftrace_regs isn't just a regular pt_regs but an actually sparse
or light data structure.

I hope that makes my thoughts clearer? It's a hairy topic ahah
