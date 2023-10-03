Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EF17B6D46
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjJCPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjJCPiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:38:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3D195
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:38:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50573e85ee0so1271152e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696347483; x=1696952283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArI9kt0KOowwB7EYnbkzew0Sjhg00yX3Kal9qOzNpu8=;
        b=CMeMQIQtI6yxhJwEaUhxsDIOiGfSVgMsIIh8zAoKwAj6v9Vxv3G1P0qH+wlFyowK7u
         XJ4Gt+xH9LzJwDHfzfvGQ3M9f+DqyHhIzD08yIc77qSJS3fIho33POOc1xGdRi6gez/r
         JAptcqc5DQM8zgLIOP6b7dpF/D6b/2CmeSUmT5DrtlFIMWpzawAXTu52UrXLbWg/E87D
         PxIHcLCjrGaZE4J/9eZlS6KD4t/srAsGRfb+1Nnvh+5I1lAiG/Q4itSrY4qipWMuuVk2
         SM2UmfQzHX5rtjVpacDgYhngLHCjgbsjQPKPOnJbRAhh++ml7SkSRD3q9igVYxe52i1c
         WEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696347483; x=1696952283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArI9kt0KOowwB7EYnbkzew0Sjhg00yX3Kal9qOzNpu8=;
        b=iM1t3Awk5ICw4HFeWAxKNGHgerd1alQjpaANcgtX/2qYvgXJcd8hC2XZYZyUXWVTgl
         Ke3HiCy3ilpbILI3nFEKbIiB1d2FJInft8RezdNIHs8/YcdDDwH3+Ke1hS1ea4mmD9KT
         JQsWrBZN1o1itnlVhuDQrnVGKCdZ8ChYHz8wVdUdZfYeFjLHDqckLvVECYMQnJCn0YQp
         vbnrDlaay1nGBbiwFdmzUyix/LIflsld358rcQGXkRmJNCVMOdNsCMaaHN3JY+v+NpbF
         cJpFmHCxMmYvYjpde+5B7GuL9fwK61Im4NHnUC3zlsGTtYeeV+A8JvmZb4R3zYDj+vd4
         +nTA==
X-Gm-Message-State: AOJu0YxPyzbb5nufu8CnItYtgXuwgOZGgguOzs8EZs4pjb3y/vnHhTlm
        DK9i2TDimalWphrigIs4Wv/jGBHq1SFsrlbsDM0=
X-Google-Smtp-Source: AGHT+IEIitcdr/L1oHpzp/5ApN/DzTbfClnPQPNJMtYUonc+Yj14sO/Gz2ruo3LD59mstDjFLxqJIZB7Vyi4trjzno8=
X-Received: by 2002:a05:6512:2342:b0:503:317b:8b76 with SMTP id
 p2-20020a056512234200b00503317b8b76mr15141498lfu.21.1696347483334; Tue, 03
 Oct 2023 08:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230926150316.1129648-1-cleger@rivosinc.com> <20230930-patchy-curdle-ef5ee6e1a17c@spud>
 <8ce6cd97-6d63-4174-a290-40690c81e205@rivosinc.com> <20231002-spearman-doze-70cc026ac13e@spud>
 <693e6584-1e66-48c0-aa7c-61d9f88abd4c@rivosinc.com> <CAP6exYLtQuyqMgG6jRAhizp-52ebu3OLNSXe8a8xvLALYFD3kA@mail.gmail.com>
 <FF617BC9-0FE4-4468-8FF9-06BD8A8115E2@jrtc27.com>
In-Reply-To: <FF617BC9-0FE4-4468-8FF9-06BD8A8115E2@jrtc27.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Tue, 3 Oct 2023 09:37:51 -0600
Message-ID: <CAP6exYJ2ksVvVbrs3aJjfpEiXuFs82vsMn4d6Wi=LH0PjpeTfA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFRvcGVs?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Maslowski <cyrevolt@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it is true that it violates the spec today, given the fluidity
of the spec of the last 10 years, I'm not sure that matters :-)

Anyway, that's out of scope for this discussion, though I appreciate
your clarification. I'll bring it up elsewhere.

Clement points out that this series would work fine if that bit were
hardwired to 1, which is all I care about.

thanks

On Mon, Oct 2, 2023 at 4:23=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.com> w=
rote:
>
> On 2 Oct 2023, at 16:32, ron minnich <rminnich@gmail.com> wrote:
> >
> > This was a very interesting read. One other thought crossed my mind,
> > which is that a RISC-V implementation might make the alignment
> > delegation hard-wired to always delegate to S mode. I.e, the bit might
> > be WARL and always 1. For what I'm doing, this would actually be
> > pretty convenient. Just want to make sure this code can accommodate
> > that -- wdyt?
>
> Such an implementation would violate the spec:
>
>   An implementation shall not have any bits of medeleg be read-only
>   one, i.e., any synchronous trap that can be delegated must support not
>   being delegated.
>
> Supporting that is thus out of scope.
>
> Jess
>
> > We have found lots of value in our experiments with delegating
> > alignment traps to Linux -- not least because they tend to locate
> > problems in the kernel :-) -- we've found issues in module loading,
> > early startup (there's a needed .align2 directive for sbi secondary
> > startup, AFAICT) and the timing code for misaligned load/store
> > handling.
> >
> > I don't know how you test this unaligned trap handling, but it might
> > be worthwhile to work that out. You can test via oreboot and the
> > visionfive2, save we have not figured out why SMP startup is going
> > wrong, yet :-), so we're not as feature-complete as needed. But soon.
> >
> > Thanks!
> >
> > On Mon, Oct 2, 2023 at 5:19=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@=
rivosinc.com> wrote:
> >>
> >>
> >>
> >> On 02/10/2023 12:49, Conor Dooley wrote:
> >>> On Mon, Oct 02, 2023 at 09:40:04AM +0200, Cl=C3=A9ment L=C3=A9ger wro=
te:
> >>>>
> >>>>
> >>>> On 30/09/2023 11:23, Conor Dooley wrote:
> >>>>> On Tue, Sep 26, 2023 at 05:03:09PM +0200, Cl=C3=A9ment L=C3=A9ger w=
rote:
> >>>>>> Since commit 61cadb9 ("Provide new description of misaligned load/=
store
> >>>>>> behavior compatible with privileged architecture.") in the RISC-V =
ISA
> >>>>>> manual, it is stated that misaligned load/store might not be suppo=
rted.
> >>>>>> However, the RISC-V kernel uABI describes that misaligned accesses=
 are
> >>>>>> supported. In order to support that, this series adds support for =
S-mode
> >>>>>> handling of misaligned accesses as well support for prctl(PR_UNALI=
GN).
> >>>>>>
> >>>>>> Handling misaligned access in kernel allows for a finer grain cont=
rol
> >>>>>> of the misaligned accesses behavior, and thanks to the prctl call,=
 can
> >>>>>> allow disabling misaligned access emulation to generate SIGBUS. Us=
er
> >>>>>> space can then optimize its software by removing such access based=
 on
> >>>>>> SIGBUS generation.
> >>>>>>
> >>>>>> Currently, this series is useful for people that uses a SBI that d=
oes
> >>>>>> not handled misaligned traps. In a near future, this series will m=
ake
> >>>>>> use a SBI extension [1] allowing to request delegation of the
> >>>>>> misaligned load/store traps to the S-mode software. This extension=
 has
> >>>>>> been submitted for review to the riscv tech-prs group. An OpenSBI
> >>>>>> implementation for this spec is available at [2].
> >>>>>>
> >>>>>> This series can be tested using the spike simulator [3] and an ope=
nSBI
> >>>>>> version [4] which allows to always delegate misaligned load/store =
to
> >>>>>> S-mode.
> >>>>>
> >>>>> Some patches in this series do not build for any configs, some are
> >>>>> broken for clang builds and others are broken for nommu. Please try=
 to> build test this more thoroughly before you submit the next version.
> >>>>
> >>>> Hi Conor,
> >>>>
> >>>> Thanks for the feedback, I'll check that.
> >>>>
> >>>>>
> >>>>> Also, AIUI, this series should be marked RFC since the SBI extensio=
n
> >>>>> this relies on has not been frozen.
> >>>>
> >>>> This series does not actually uses the SBI extension but provides a =
way
> >>>> to detect if misaligned accesses are not handled by hardware nor by =
the
> >>>> SBI. It has been reported by Ron & Daniel they they have a minimal S=
BI
> >>>> implementation that does not handle misaligned accesses and that the=
y
> >>>> would like to make use of the PR_SET_UNALIGN feature. This is what t=
his
> >>>> series addresses (and thus does not depend on the mentioned SBI exte=
nsion).
> >>>
> >>> Ah, I must have misread then. Apologies.
> >>
> >> No worries, maybe I should actually remove this from the cover letter =
to
> >> avoid any confusion !
> >>
> >> Cl=C3=A9ment
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
