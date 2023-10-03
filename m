Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB91B7B6486
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbjJCIk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbjJCIkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:40:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4DCAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:40:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50306b2920dso752718e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696322441; x=1696927241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISaU8pCB0Dja2oDURRBMOlVydgdpzjme5xVS75ei+yQ=;
        b=Qu6hcKZxnUcanBEP5S8/LclQRj2GSR6iKX7MRSrrcTdAYuwdm9ENJLbspa7TVQGD01
         DGlsw3jl+Y8Et78mnFBYygsw6JpLX9cGspJOyZhd+uh0jVQeSMNpWBwimCDbWqg2plZ5
         BARp40ejuLLRpfMr/EeWZXiZS6Sr6UW1qXFfIu4An5lv9UZCcQPiGOaCpNH2fPeRvSjd
         W7YRcaN9xaFzOyia9foVyzx5YxZZ70FYNRXZ+j8NN3PuCAj5RI9UR0nar2EwnwVtrzJg
         Ormmr3n1IkRVF9+K/W1RBu5oZaqqznX/CMgQ45gKgYJayeeOFB9AsabI4HQwIcfDxJ2q
         wuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696322441; x=1696927241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISaU8pCB0Dja2oDURRBMOlVydgdpzjme5xVS75ei+yQ=;
        b=NMbqVaSNnWbDlFRaxAF91/qXAk3ts84ObIVslQb6fZ0DC6MKDz/HPm0+4QU1j0oR2j
         pqBL0jTqk2onx+t2M5njDFPeOburKWvTRuit4InXfAGG91GvQTZIypiHgCHAOg4cXbBh
         zXQPzoO8+6/uMPaXbf6bvcqh7zb76k16laC6ClzfCSDnrapkDpc3+MzKxN4FIrlf2KBF
         mWUJVncTzyqT5wYtMVGOX6vers8cGpgTqfgYs9UVnB5A/rrg5FFP7GyeylU0nfxTz8Hi
         CHfV5gPmsK/R/Mtd8AGi30b00sXAwi/xSBqBamIMf0rXak+U2I/3DwbPnssgINhLXIEy
         lELA==
X-Gm-Message-State: AOJu0YyrxaTC1s50JawBbqY69O4F0SeDGlgujqzvNmTAwdJxwMLKbb4e
        kFJg9SVXWSO5XzXXv0im/eFj4ZF+DiWDB00hN+HtrA==
X-Google-Smtp-Source: AGHT+IH8cKSCbVYvZlyiiuLFaoDBBxouUlEc58jqzFoCeuoq/H0aloztuf7u+xurYLsURNyerb+UY4so6TVEXP/waZg=
X-Received: by 2002:a05:6512:aca:b0:500:943f:11c9 with SMTP id
 n10-20020a0565120aca00b00500943f11c9mr1512437lfu.3.1696322441013; Tue, 03 Oct
 2023 01:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230926150316.1129648-1-cleger@rivosinc.com> <CALs-Hss+OK-vJy_ZKjVbGh7rTBZA+GditWcdM1XjDDskGF76Dw@mail.gmail.com>
 <10997d30-e6b7-4a24-a43e-e22679e8d450@rivosinc.com> <CALs-HssAAgbdUuoCyPEdjs+8yH+a8Gzz7jCpMre-6k21aE_sdQ@mail.gmail.com>
In-Reply-To: <CALs-HssAAgbdUuoCyPEdjs+8yH+a8Gzz7jCpMre-6k21aE_sdQ@mail.gmail.com>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Tue, 3 Oct 2023 01:40:30 -0700
Message-ID: <CAHBxVyEOvJy8gBfqW9v96XwW6_XFoWb3RdrL=AqMHJLHS7n2ww@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
To:     Evan Green <evan@rivosinc.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?B?QmrDtnJuIFRvcGVs?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 9:48=E2=80=AFAM Evan Green <evan@rivosinc.com> wrot=
e:
>
> On Thu, Sep 28, 2023 at 12:49=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@=
rivosinc.com> wrote:
> >
> >
> >
> > On 26/09/2023 23:43, Evan Green wrote:
> > > On Tue, Sep 26, 2023 at 8:03=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleg=
er@rivosinc.com> wrote:
> > >>
> > >> Since commit 61cadb9 ("Provide new description of misaligned load/st=
ore
> > >> behavior compatible with privileged architecture.") in the RISC-V IS=
A
> > >> manual, it is stated that misaligned load/store might not be support=
ed.
> > >> However, the RISC-V kernel uABI describes that misaligned accesses a=
re
> > >> supported. In order to support that, this series adds support for S-=
mode
> > >> handling of misaligned accesses as well support for prctl(PR_UNALIGN=
).
> > >>
> > >> Handling misaligned access in kernel allows for a finer grain contro=
l
> > >> of the misaligned accesses behavior, and thanks to the prctl call, c=
an
> > >> allow disabling misaligned access emulation to generate SIGBUS. User
> > >> space can then optimize its software by removing such access based o=
n
> > >> SIGBUS generation.
> > >>
> > >> Currently, this series is useful for people that uses a SBI that doe=
s
> > >> not handled misaligned traps. In a near future, this series will mak=
e
> > >> use a SBI extension [1] allowing to request delegation of the
> > >> misaligned load/store traps to the S-mode software. This extension h=
as
> > >> been submitted for review to the riscv tech-prs group. An OpenSBI
> > >> implementation for this spec is available at [2].
> > >
> > > For my own education, how does the new SBI call behave with respect t=
o
> > > multiple harts? Does a call to change a feature perform that change
> > > across all harts, or just the hart the SBI call was made on? If the
> > > answer is "all harts", what if not all harts are exactly the same, an=
d
> > > some can enable the feature switch while others cannot? Also if the
> > > answer is "all harts", does it also apply to hotplugged cpus, which
> > > may not have even existed at boot time?
> >
> > Depending on the feature, they can be either global (all harts) or
> > local (calling hart). The medeleg register is per hart and thus
> > misaligned load/store delegation for S-mode is also per hart.
>
> We should probably state this in the spec update then, both generally
> and for each specific feature added. Otherwise firmware writers are
> left not knowing if they're supposed to spread a feature across to all
> cores or not.
>

If a feature is required to update any CSR, it must be per hart only.
The supervisor software
is aware of the state of each hart and it should invoke it from all
the present harts.

Doing it in M-mode will result in M-mode IPIs and seems racy with what
kernel might be doing at that time.

> >
> >
> > >
> > > What happens if a hart goes through a context loss event, like
> > > suspend/resume? Is the setting expected to be sticky, or is the kerne=
l
> > > expected to replay these calls?
> >
> > That is a good question that we did not actually clarified yet. Thanks
> > for raising it !
>

IMO, it should be sticky until a reset. I would be interested to hear
other thoughts though if there is a non-sticky
use-case.


> No problem! This may also need to be specified per-feature in the
> spec. I have a vague hunch that it's better to ask the kernel to do it
> on resume, though ideally we'd have the terminology (and I don't think
> we do?) to specify exactly which points constitute a context loss.
> Mostly I'm remembering the x86 and ARM transition from S3, where lots
> of firmware code ran at resume, to S0ix-like power states, where
> things resumed directly into the OS and they had to figure out how to
> do it without firmware. The vague hunch is that keeping the laundry
> list of things firmware must do on resume low might keep us from
> getting in S0ix's way, but it's all so speculative it's hard to know
> if it's really a useful hunch or not.
>
> -Evan
