Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9E6776416
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjHIPjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjHIPjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:39:02 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6832D6D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:38:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a7a180c3faso2217360b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691595491; x=1692200291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or+4Q7ioH1LO85WlhMl+Hf8sfqeAwfesSr6HY/tLZlg=;
        b=dZcu+9OCCvDLKeSC8+efZ2t+vflJAufUebNBSxKiPMXcivRTCQnANXkWc+eUMIOfP5
         niV3udOO9xEsykqD1etTNR21tWhoh0SdlANcSTLtFgIor0e+TCSi4toemI4fNBG24Tcs
         mm9be/Lb7kIaAwrSUVBkeEXK+XV7nwreJY1i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595491; x=1692200291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Or+4Q7ioH1LO85WlhMl+Hf8sfqeAwfesSr6HY/tLZlg=;
        b=R/n36r5zyx+m75iD0tbACGg5a9oWnpLPWEw8z/CEmb+ylu+JXeLFiR8dnIMtjzhacz
         GqlsL/f9KrNEHmJw07C6Tm5TA8xmnKpdHbGn5iamWdFzN8F0H5F7cqoC74CX5Zm7pNHl
         fDTjVnzjl197RcfgbgeiL/EWZZl73b3hjs8CR0X8qsAMOt3RFBdM9flqB4vHqvq+8Mrj
         KvAVH7OKO+PdUI+d64Gp78vzAL/jQdNbZpg3fbk3cZzQldinRVS4sTGSW8xvlUkBAtQb
         /T9K7DO684ShnXxsTYCW2vqzjlz2nf8PBkC1s0uQjX7ztpHEoe5mxFW1q2S2ROnpahNp
         Xl9g==
X-Gm-Message-State: AOJu0YyzOvCcrtV+qnD6kKB9Ywi0tQ16StiPgXZO8GvOI+l2cd0MjzL5
        QYv5doL1Xdt2Iw5xF9wu+mEBgltzQYgaTgh0gIFI/A==
X-Google-Smtp-Source: AGHT+IH+aYrEIoM4XMzeEh0db0LKZFpFauBuv8UFazpm8vaS77/zQP9gsRXuMtjL++12niCEpG3Eo4HXLokCZLkpirY=
X-Received: by 2002:a05:6808:23c7:b0:3a7:8e1b:9d65 with SMTP id
 bq7-20020a05680823c700b003a78e1b9d65mr3596640oib.47.1691595491693; Wed, 09
 Aug 2023 08:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
 <169139095066.324433.15514499924371317690.stgit@devnote2> <CABRcYm+8-zYRGjKSPtWQ8_Vq2649=vi71fGvFx2aWM1tnOMYQQ@mail.gmail.com>
 <20230809234512.e3c39b8fffcc6297262f8fc8@kernel.org>
In-Reply-To: <20230809234512.e3c39b8fffcc6297262f8fc8@kernel.org>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 9 Aug 2023 17:38:00 +0200
Message-ID: <CABRcYm+24OLedwiLGj1RyvVg22R5NduORVsYZfXSA_OX5F+riA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 4:45=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
> > > --- a/kernel/trace/trace_fprobe.c
> > > +++ b/kernel/trace/trace_fprobe.c
> > > @@ -132,25 +132,30 @@ static int
> > >  process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
> > >                    void *base)
> > >  {
> > > -       struct pt_regs *regs =3D rec;
> > > -       unsigned long val;
> > > +       struct ftrace_regs *fregs =3D rec;
> > > +       unsigned long val, *stackp;
> > >         int ret;
> > >
> > >  retry:
> > >         /* 1st stage: get value from context */
> > >         switch (code->op) {
> > >         case FETCH_OP_STACK:
> > > -               val =3D regs_get_kernel_stack_nth(regs, code->param);
> > > +               stackp =3D (unsigned long *)ftrace_regs_get_stack_poi=
nter(fregs);
> > > +               if (((unsigned long)(stackp + code->param) & ~(THREAD=
_SIZE - 1)) =3D=3D
> > > +                   ((unsigned long)stackp & ~(THREAD_SIZE - 1)))
> >
> > Maybe it'd be worth extracting a local
> > "ftrace_regs_get_kernel_stack_nth_addr" helper function and/or
> > "ftrace_regs_within_kernel_stack" ?
>
> Yeah, maybe we can make it a generic inline function in linux/ftrace.h.

Or even just above this function if there are low chances it would get
used elsewhere :)
