Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474EF7FEE3E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345148AbjK3LsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3LsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:48:23 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8B784
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:48:28 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cb55001124so1567212b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701344908; x=1701949708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5xVQObOoSd+luGlbgeWIPH7/3pbckJn6omk5INMCc8=;
        b=Y6kYjcaUukUHP97WNFi9imlbuDvVIu7oYydnJQqLVV6NSS8fwGWTq19fSP9OyJNywF
         FUKYPOecMo2hLvRhxwT7wC29nBS/ORno1Fe0AuEAHA57xJa7739Tqu4DkuZmHTKWBx++
         ulDA8QMDSOnBhkHmazXmIPADM4CUJX6iHh+MEOt0QtPGaGvTCDEvId0qvUQk+YOZiEn3
         X+49tpIilBlYF7t0cbHzJLfruANbZFI5SLO9a4xjIrOMn/zbVKXUGVgaCFEwdx27a6l7
         G8KRaR9m2ptxxL1QVHWPIzVsJ+iPUNckPvh5JLR9LPqx15AO2vWTUDe+tMM0/UfM7ky4
         gVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701344908; x=1701949708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5xVQObOoSd+luGlbgeWIPH7/3pbckJn6omk5INMCc8=;
        b=ihuVI7UcFns/0aUIMNPIdJ+nZkZYU9UI3pYDxvPLk5U3CpQCPU1rA3Wqv2ScMGgKRf
         dBX1ftYP4zIeZZXxLIp2ALk/+wkT0WiIqBnmBE1ZAtzRZoLGTfhdz2XAI776kPHTII/I
         v9XKWYdlbcwi0cZ9+wBx3H6fkT7uLP/bq0m1YN62ddP1YjnhRt0lKa5K4xHQpMYVvPVH
         CxsaBxI5OfNoLMxzNQx4YNOJNfdP9a1MpAdn7v4V02Q29tEi5t/dsXMQPml35Z89cMRN
         daqfpoblnrAxhQPavpiZR2BcIIkXwVW3WnD6OrezhFr1562eIBOdP7tFgIVDgwreHdcA
         jZ1g==
X-Gm-Message-State: AOJu0YzDyjw/Y4aVQhPn8CswcmSDAlFgrpX9G3QnEWyWyx0L92nO7MhH
        eSrKzGjF8MgaoWwjPOE1e1gCiRrz2OJJYh+jjNfnDPCsiVnIEZdT
X-Google-Smtp-Source: AGHT+IFTmJeU2BC41RfxCo4Hb6eAP+kSriPWB9Hzj5XXCXlBKjrBq16vH0SwZWA6USdqgl/1JnjAj/QuHOy5XuumlTM=
X-Received: by 2002:a17:90a:bc84:b0:286:2013:cfe9 with SMTP id
 x4-20020a17090abc8400b002862013cfe9mr6667826pjr.2.1701344908209; Thu, 30 Nov
 2023 03:48:28 -0800 (PST)
MIME-Version: 1.0
References: <IA1PR20MB4953C82499C5D81D2C6A020BBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953F9D77FFC76A9D236922DBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAK9=C2WAv5jJBt56xBea268DeyUA+YvbU7i+ahVjueafCi-r6A@mail.gmail.com>
 <20231130-decibel-passenger-6e932b1ce554@spud> <CAK9=C2Vsx8ddpYiqUhvqnJpdb-FKeNhLz3PsVpSeEz4TeQHiEg@mail.gmail.com>
 <20231130-shower-award-3cd5f1bba5db@spud>
In-Reply-To: <20231130-shower-award-3cd5f1bba5db@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 30 Nov 2023 17:18:15 +0530
Message-ID: <CAK9=C2WgN=3BjxS+nF2ibFQoquNwXfxr_UQv8Kbf1+e4Teyfcw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 5:15=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Nov 30, 2023 at 04:51:32PM +0530, Anup Patel wrote:
> > On Thu, Nov 30, 2023 at 3:27=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Thu, Nov 30, 2023 at 03:01:24PM +0530, Anup Patel wrote:
> > > > On Sat, Nov 18, 2023 at 12:39=E2=80=AFPM Inochi Amaoto <inochiama@o=
utlook.com> wrote:
> > > > >
> > > > > The timer registers of aclint don't follow the clint layout and c=
an
> > > > > be mapped on any different offset. As sg2042 uses separated timer
> > > > > and mswi for its clint, it should follow the aclint spec and have
> > > > > separated registers.
> > > > >
> > > > > The previous patch introduced a new type of T-HEAD aclint timer w=
hich
> > > > > has clint timer layout. Although it has the clint timer layout, i=
t
> > > > > should follow the aclint spec and uses the separated mtime and mt=
imecmp
> > > > > regs. So a ABI change is needed to make the timer fit the aclint =
spec.
> > > > >
> > > > > To make T-HEAD aclint timer more closer to the aclint spec, use
> > > > > regs-names to represent the mtimecmp register, which can avoid ha=
ck
> > > > > for unsupport mtime register of T-HEAD aclint timer.
> > > > >
> > > > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > > > Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT=
 timer")
> > > > > Link: https://lists.infradead.org/pipermail/opensbi/2023-October/=
005693.html
> > > > > Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclin=
t.adoc
> > > >
> > > > The ratified Priv v1.12 specification defines platform specific M-m=
ode timer
> > > > registers without defining any layout of mtime and mtimecmp registe=
rs.
> > > > (Refer, "3.2.1 Machine Timer Registers (mtime and mtimecmp)")
> > > >
> > > > The "thead,c900-aclint-mtimer" can be thought of as is one possible
> > > > implementation of "riscv,mtimer" defined by the Priv v1.12 specific=
aiton.
> > > >
> > > > If it is not too late then I suggest making this binding into gener=
ic
> > > > "riscv,mtimer" binding.
> > >
> > > We could definitely reorganise things, it's not too late for that as
> > > implementation specific compatibles would be needed regardless, so
> > > software that would've matched on those will continue to do so.
> > >
> > > That said, does this platform actually implement the 1.12 priv spec i=
f
> > > there is no mtime register? The section you reference says:
> > > "Platforms provide a real-time counter, exposed as a memory-mapped
> > > machine-mode read-write register, mtime." It seems to me like this
> > > hardware is not suitable for a generic "riscv,mtimer" fallback.
> >
> > Yes, the T-Head mtimer does not implement both mtime and mtimecmp
> > so technically it only implements a portion of the ratified RISC-V mtim=
er
> > chapter.
> >
> > >
> > > Am I missing something there Anup?
> > >
> > > It doesn't even implement the draft aclint spec, given that that says=
:
> > > "The MTIMER device provides machine-level timer functionality for a s=
et
> > > of HARTs on a RISC-V platform. It has a single fixed-frequency monoto=
nic
> > > time counter (MTIME) register and a time compare register (MTIMECMP) =
for
> > > each HART connected to the MTIMER device."
> > >
> > > But I already said no to having a generic, "riscv" prefixed, compatib=
le
> > > for that, given it is in draft form.
> >
> > I am not suggesting T-Head timer implements aclint spec. Also,
> > since aclint spec is in draft state it is out of the question.
>
> I did not intend to imply that you were suggesting that there should be
> one. I was just trying to clarify that I was not trying to bring back
> the topic of a generic aclint binding applying here.
>
> > My suggestion is to treat "3.2.1 Machine Timer Registers (mtime
> > and mtimecmp)" as RISC-V mtimer defined by the RISC-V privileged
> > specification and define "riscv" prefixed DT binding for this.
>
> I'm not against a binding for that at all.

Thanks.

>
> > This binding defines two possible values for "reg" property:
> > 1) contains two items: a) mtime register address and,
> >      b) base address of mtimecmp registers
> > 2) contain one item: a) base address of mtimecmp registers
> >
> > The t-head mtimer seems to implement #2 whereas the RISC-V
> > mtimer (Priv spec) aligns with #1.
> >
> > If we want to keep this DT binding t-head specific then
> > we should remove option #1 (above) from this DT binding
>
> This part is already the conclusion of one of the other "branches" of
> this thread and is (AFAIU) Inochi's plan for the next version.

Sounds good.

>
> > and add separate "riscv" prefixed DT binding for RISC-V mtimer.
>
> Do you know of any users for a "riscv,mtimer" binding that are not
> covered by existing bindings for the clint?

Ventana Veyron-v1 implements a mtimer per-cluster (or chiplet)
which is compatible to "riscv,mtimer" (i.e. we have both mtime
and mtimecmp MMIO registers).

Regards,
Anup
