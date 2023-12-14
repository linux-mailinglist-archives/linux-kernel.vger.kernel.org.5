Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE828135D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjLNQK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443906AbjLNQKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:10:16 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CF2127;
        Thu, 14 Dec 2023 08:10:21 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c3f68b79aso64598125e9.0;
        Thu, 14 Dec 2023 08:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702570220; x=1703175020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F040nn5DGpwH0v1Omp9qK9nDHPF0hXACKBYMGUkMwi8=;
        b=VPGpW1p7Su9qr8cPoy0OzysZPbdyOopHuFW98w1lbVMLewUyzw+pAOybHL5VeR+4US
         /Mxp3MGauDVOjfh5/RVp1E74vWv0+UYKAiwHkW5R845o0Creu2NEfweoABXy2+9ZWzgh
         p4+JY7+mXkr2oXUTBprZTHdgQSg5wTsTtt3ALaC4I/R2PUKwuviPSbPetYE9JBg2OplH
         cqZ11ZSTQhdRqZCpMW+wZrTtne76ohit+qIZgFGPe03mhnHpMLRnPtcUrFYscMhBS5rl
         pieJiLjdLQd9sfSiHsMKs+RI8rrsiT8rIRzaaZsLD+R7+E/UkDmKQiu6F0ug7F92KxRI
         od0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570220; x=1703175020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F040nn5DGpwH0v1Omp9qK9nDHPF0hXACKBYMGUkMwi8=;
        b=esN8+wg/GGsOzFmQ76ngxmqQlp4/IR53JOE2ojfEnui2RLIwVPGNqjk0IUyVr1m8WZ
         LsG3wNeizYO+1ri2URb7TXzMzhIvy2lEnbhwkqk4iJi+jj7MGC3Mh8Zp+oJD4S2q39yI
         6OMa8Syko7t44lN55dTlZSzmYteXQU3D8wOhCMS5x4IIEEzKgrr/KwJ7291G5yeYHfQa
         z7ZlKzM8NExJ+kJ6llhunWnT5/ngegAfFMOcLKSoWwlWZcI8BdwOrEgqj6LQ0EcVniiy
         fflOX0w7VoOnuf8w13a6+1vLxdph/pfdXqj7+hk5VaRECuBISkO9/WNRhD6s5q6XNIPV
         xQTw==
X-Gm-Message-State: AOJu0YwTqAEMcfzAaYVZK4iKb0JhxT8utluATE5g4jfY2DGBgc+0TVGr
        yFwIUT1wogbpr7tou/YG7A4FQnsz3LZMhqb6jmg=
X-Google-Smtp-Source: AGHT+IGvm6IDpcLwZzfxmzI1DnffJLMGuiMJ+YeJRZJYi42i4gF22gQ3QJ/0Tit/I0YEfCFUkIKn3FApGXkRUYokg78=
X-Received: by 2002:a05:600c:250:b0:40c:66b4:ce3e with SMTP id
 16-20020a05600c025000b0040c66b4ce3emr504399wmj.104.1702570219713; Thu, 14 Dec
 2023 08:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20231214062434.3565630-1-menglong8.dong@gmail.com>
 <20231214062434.3565630-2-menglong8.dong@gmail.com> <CAADnVQ+kKxj2hg33CzH_iXdH5fs8wjwpkPP-Jjh41weqf9BEwA@mail.gmail.com>
 <CADxym3Z1=6R8x7==wMfMA6N+Ha9VtOdpiw5LP7z4frW3=sYjCA@mail.gmail.com>
In-Reply-To: <CADxym3Z1=6R8x7==wMfMA6N+Ha9VtOdpiw5LP7z4frW3=sYjCA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 Dec 2023 08:10:08 -0800
Message-ID: <CAADnVQJddDYv7K6UxqYA3PJk4OsdAphWoRzd5_gkxhU6rUBdKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: make the verifier tracks the "not
 equal" for regs
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
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

On Thu, Dec 14, 2023 at 6:07=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Hello,
>
> On Thu, Dec 14, 2023 at 9:49=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 10:28=E2=80=AFPM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > >
> > > We can derive some new information for BPF_JNE in regs_refine_cond_op=
().
> > > Take following code for example:
> > >
> > >   /* The type of "a" is u16 */
> > >   if (a > 0 && a < 100) {
> > >     /* the range of the register for a is [0, 99], not [1, 99],
> > >      * and will cause the following error:
> > >      *
> > >      *   invalid zero-sized read
> > >      *
> > >      * as a can be 0.
> > >      */
> > >     bpf_skb_store_bytes(skb, xx, xx, a, 0);
> > >   }
> >
> > Please craft a selftest from above with inline asm
> > (C might not work as compiler might optimize it)
>
> Okay! Should I add this selftests to reg_bounds as a subtest,
> or add a "verifier_reg_edge.c" for verifier testing?

reg_bounds is for automated.
I think it will fit fine in the existing progs/verifier_bounds.c

>
> > Also we call:
> >         /* fallthrough (FALSE) branch */
> >         regs_refine_cond_op(false_reg1, false_reg2,
> > rev_opcode(opcode), is_jmp32);
> >         /* jump (TRUE) branch */
> >         regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
> >
> > so despite BPF_JNE is not handled explicitly it still should have
> > caught above due to rev_opcode() ?
>
> Ennn.....I'm a little confused. In this case, the TRUE path is
> handled properly, as the opcode is BPF_JEQ; and the FALSE
> is not handled properly, as the opcode is rev_opcode(BPF_JEQ),
> which is BPF_JNE. And the bpf_skb_store_bytes() will be called
> in the FALSE path. The origin state of false_reg* should be the same
> as true_reg*.

Ahh. I see.
It wasn't clear how 'a > 0 && a < 100' got to be JNE after optimizations.
