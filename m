Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC376D11E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjHBPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjHBPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:09:45 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9181126BD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:09:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-56481f2a148so341799a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690988950; x=1691593750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGrnYzd5HDo329ej7S9UGy2s8CEMFYkTaY0FnMVZHLY=;
        b=S7Zlx66nt0XIGNLBNb0wRwefz585SdXOx7OtJCRv9BjsgPttexJzuDmcaaKyiIij4y
         bggyt9MI9nkv2Rc1mhFyyFzUNuDuXjjvu2zqf0i1lS/WQlbzjctF/rbLs5GhVdsNWP80
         uf4Q3xP36leowau/xopRA+1zZ6s8m5VnVTCNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690988950; x=1691593750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGrnYzd5HDo329ej7S9UGy2s8CEMFYkTaY0FnMVZHLY=;
        b=X/+J2/PxMr6c7u3gvm3gdMQUY/Idqy5dwEpp6tMk9jk80If/cgQJcf1zWUIYwQPjiN
         JHMkr76C/3W2BwYT1lFgv/iNL5ADCK9zLceX0I0BFmXtoIfc+04c5joWoaTLE1CwrK2Z
         8/wXHbM0Stq/sJNC7qTO6jwE2RkpfOcOvKrN9bXFCsySU4T5lMCuIaRnCFT/sA4H79Xb
         0DeMc3vjw3iVS+/og+4J6QSX3fLUQwba+Hsjek6IxM/357SMibrwK5vmC3Q4RfOvGFX2
         KcG1L3jkl0nL8x7n70Ap4ooTZptFKMAgUaKj0pRJuBN7v0fJefN8xixnysbtVGN1Lv0H
         3OyQ==
X-Gm-Message-State: ABy/qLb1aYcWZYqxqPvdY0kMyQTlxqimeRUfFhGqs9MY7cCsbMi/Ydp9
        2E6193nNG638ESZietgNQdl91egtvV+nm0nLKPhMfw==
X-Google-Smtp-Source: APBJJlHVMvJm2a/C1eS98klvhVEoC0tcCIwJ4eZaCh1MBiRn6EVdUAj0yHKvO1ZjJIUATpc7+XvmWgTPce5oDuY/Dcc=
X-Received: by 2002:a17:90b:1e0b:b0:268:5919:a276 with SMTP id
 pg11-20020a17090b1e0b00b002685919a276mr13671658pjb.20.1690988950550; Wed, 02
 Aug 2023 08:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
 <169078863449.173706.2322042687021909241.stgit@devnote2> <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
 <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org> <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
 <20230802000228.158f1bd605e497351611739e@kernel.org> <20230801112036.0d4ee60d@gandalf.local.home>
 <20230801113240.4e625020@gandalf.local.home> <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
 <20230801190920.7a1abfd5@gandalf.local.home> <20230802092146.9bda5e49528e6988ab97899c@kernel.org>
 <20230801204054.3884688e@rorschach.local.home> <20230801204407.7b284b00@rorschach.local.home>
 <CAADnVQLkVatr5BTScpuKaKAO+Cp=0KVxhqXwsjZoGhJPu3G4jA@mail.gmail.com> <20230802230738.2b22cef561feb5d498f22f49@kernel.org>
In-Reply-To: <20230802230738.2b22cef561feb5d498f22f49@kernel.org>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 2 Aug 2023 17:08:58 +0200
Message-ID: <CABRcYm+ik1G1x4OpL+W39=c_NUSit1=6sYHNPA9SSLxbgU403w@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 4:07=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 1 Aug 2023 19:22:01 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Tue, Aug 1, 2023 at 5:44=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > On Tue, 1 Aug 2023 20:40:54 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > > Maybe we can add a ftrace_partial_regs(fregs) that returns a
> > > > partially filled pt_regs, and the caller that uses this obviously k=
nows
> > > > its partial (as it's in the name). But this doesn't quite help out =
arm64
> > > > because unlike x86, struct ftrace_regs does not contain an address
> > > > compatibility with pt_regs fields. It would need to do a copy.
> > > >
> > > >  ftrace_partial_regs(fregs, &regs) ?
> > >
> > > Well, both would be pointers so you wouldn't need the "&", but it was
> > > to stress that it would be copying one to the other.
> > >
> > >   void ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt=
_regs regs);
> >
> > Copy works, but why did you pick a different layout?
>
> I think it is for minimize the stack consumption. pt_regs on arm64 will
> consume 42*u64 =3D 336 bytes, on the other hand ftrace_regs will use
> 14*unsigned long =3D 112 bytes. And most of the registers in pt_regs are =
not
> accessed usually. (as you may know RISC processors usually have many
> registers - and x86 will be if we use APX in kernel. So pt_regs is big.)
>
> > Why not to use pt_regs ? if save of flags is slow, just skip that part
> > and whatever else that is slow. You don't even need to zero out
> > unsaved fields. Just ask the caller to zero out pt_regs before hand.
> > Most users have per-cpu pt_regs that is being reused.
> > So there will be one zero-out in the beginning and every partial
> > save of regs will be fast.
> > Then there won't be any need for copy-converter from ftrace_regs to pt_=
regs.
> > Maybe too much churn at this point. copy is fine.
>
> If there is no nested call, yeah, per-cpu pt_regs will work.

BPF "multi_kprobe" programs (ugh, it's pretty awkward we called them
that way given that kprobe is out of the picture and fprobe is subject
to completely different constraints than kprobe) can't be nested, as
checked here: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/t=
ree/kernel/trace/bpf_trace.c?id=3D4c9fbff54297471d4e2bbfe9c27e80067c722eae#=
n2642
(this is probably the place where we'd be calling a
"ftrace_partical_regs" anyway so that's cool)
