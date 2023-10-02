Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281AF7B5695
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbjJBPdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbjJBPdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:33:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462DB3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:33:10 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c1886777d9so80958411fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696260789; x=1696865589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AurjURdP5ZlZL/smukAb81hKmuzUvXiFYPJa040s804=;
        b=YLQadow6VWpadkZcnF9aP4Ys+xkAty3Ouvkq+fTtvPIrHOIAkrde+V9LFX81Ipvwye
         a7VBijkKiTofRhtyBaIC19OeJ5sg/0aIqq4+wO3OJ37ooSO5pVeUZGd02MUgnIAPR7ol
         2pollSyzXWpJccRtzgPE6s9VtxP9P2GrKzZ3ozHQ/tPcNfJODG6+pKZUOb0E4dHKwbFN
         joGjKftLsdjKQc1/VQm01pL2gAgC+NGYGdWS6qqie2xsIdD9eoOAaKrok1f1tOdUYfKv
         kS3SGTgyNluKONZ1vrRgK0I3n0UuugBBKPnqk+SzGHM2n+JsqFrzN+D5X72qvGWbW5ZG
         1XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260789; x=1696865589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AurjURdP5ZlZL/smukAb81hKmuzUvXiFYPJa040s804=;
        b=QUuvKOBSlVQnQm9YE+bsPflvOIk/1O0MYjkqB+IQNc1Z86Qa4oNuMqiQUC4kdjE1Je
         oOBh4HyUQzhipFfJ0I6MK38C5+cTK0I30QTKwWECSZjqgFoSqBSyaxJt1RGwDbviqY/4
         /6I4h952kNvppfIBIg5oV28/INYiuxY39hIhn4DQwIYuYotJTNCHubCLRFGVSCmquzrx
         EynYJfJ1pVyQySpsHTQgNHPTihNsTfolVjQ7xs/znp1JuNdJBi7SXD3fmN7M7T40M5Ig
         3eo/G0dz2ajckTAp0q8TE7CF20wrPiiHRF2ejld1x0JnfMqVeyWLRfc7I07XjTS39Wri
         VKEA==
X-Gm-Message-State: AOJu0Yw08aCuXoX4pDS0/LMSaRduFu1RFsiaQVKFlPHYCqo+ITXZ8FPk
        GE4iMlNvkW7Q5UMui9y3gx2NCQOGIcFbfAh/lmY=
X-Google-Smtp-Source: AGHT+IHKX5/Cmt0I3N4/+jkaTuwYAcYj6gJd3d7Qv8r9/mddP7OXp8vB7NnHRV+OkFIzu4dN86GLaB4Qkm2lucLPAm8=
X-Received: by 2002:a2e:8448:0:b0:2bc:f39b:d1a8 with SMTP id
 u8-20020a2e8448000000b002bcf39bd1a8mr9237063ljh.46.1696260788411; Mon, 02 Oct
 2023 08:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230926150316.1129648-1-cleger@rivosinc.com> <20230930-patchy-curdle-ef5ee6e1a17c@spud>
 <8ce6cd97-6d63-4174-a290-40690c81e205@rivosinc.com> <20231002-spearman-doze-70cc026ac13e@spud>
 <693e6584-1e66-48c0-aa7c-61d9f88abd4c@rivosinc.com>
In-Reply-To: <693e6584-1e66-48c0-aa7c-61d9f88abd4c@rivosinc.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Mon, 2 Oct 2023 09:32:56 -0600
Message-ID: <CAP6exYLtQuyqMgG6jRAhizp-52ebu3OLNSXe8a8xvLALYFD3kA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Conor Dooley <conor@kernel.org>,
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

This was a very interesting read. One other thought crossed my mind,
which is that a RISC-V implementation might make the alignment
delegation hard-wired to always delegate to S mode. I.e, the bit might
be WARL and always 1. For what I'm doing, this would actually be
pretty convenient. Just want to make sure this code can accommodate
that -- wdyt?

We have found lots of value in our experiments with delegating
alignment traps to Linux -- not least because they tend to locate
problems in the kernel :-) -- we've found issues in module loading,
early startup (there's a needed .align2 directive for sbi secondary
startup, AFAICT) and the timing code for misaligned load/store
handling.

I don't know how you test this unaligned trap handling, but it might
be worthwhile to work that out. You can test via oreboot and the
visionfive2, save we have not figured out why SMP startup is going
wrong, yet :-), so we're not as feature-complete as needed. But soon.

Thanks!

On Mon, Oct 2, 2023 at 5:19=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@rivo=
sinc.com> wrote:
>
>
>
> On 02/10/2023 12:49, Conor Dooley wrote:
> > On Mon, Oct 02, 2023 at 09:40:04AM +0200, Cl=C3=A9ment L=C3=A9ger wrote=
:
> >>
> >>
> >> On 30/09/2023 11:23, Conor Dooley wrote:
> >>> On Tue, Sep 26, 2023 at 05:03:09PM +0200, Cl=C3=A9ment L=C3=A9ger wro=
te:
> >>>> Since commit 61cadb9 ("Provide new description of misaligned load/st=
ore
> >>>> behavior compatible with privileged architecture.") in the RISC-V IS=
A
> >>>> manual, it is stated that misaligned load/store might not be support=
ed.
> >>>> However, the RISC-V kernel uABI describes that misaligned accesses a=
re
> >>>> supported. In order to support that, this series adds support for S-=
mode
> >>>> handling of misaligned accesses as well support for prctl(PR_UNALIGN=
).
> >>>>
> >>>> Handling misaligned access in kernel allows for a finer grain contro=
l
> >>>> of the misaligned accesses behavior, and thanks to the prctl call, c=
an
> >>>> allow disabling misaligned access emulation to generate SIGBUS. User
> >>>> space can then optimize its software by removing such access based o=
n
> >>>> SIGBUS generation.
> >>>>
> >>>> Currently, this series is useful for people that uses a SBI that doe=
s
> >>>> not handled misaligned traps. In a near future, this series will mak=
e
> >>>> use a SBI extension [1] allowing to request delegation of the
> >>>> misaligned load/store traps to the S-mode software. This extension h=
as
> >>>> been submitted for review to the riscv tech-prs group. An OpenSBI
> >>>> implementation for this spec is available at [2].
> >>>>
> >>>> This series can be tested using the spike simulator [3] and an openS=
BI
> >>>> version [4] which allows to always delegate misaligned load/store to
> >>>> S-mode.
> >>>
> >>> Some patches in this series do not build for any configs, some are
> >>> broken for clang builds and others are broken for nommu. Please try t=
o> build test this more thoroughly before you submit the next version.
> >>
> >> Hi Conor,
> >>
> >> Thanks for the feedback, I'll check that.
> >>
> >>>
> >>> Also, AIUI, this series should be marked RFC since the SBI extension
> >>> this relies on has not been frozen.
> >>
> >> This series does not actually uses the SBI extension but provides a wa=
y
> >> to detect if misaligned accesses are not handled by hardware nor by th=
e
> >> SBI. It has been reported by Ron & Daniel they they have a minimal SBI
> >> implementation that does not handle misaligned accesses and that they
> >> would like to make use of the PR_SET_UNALIGN feature. This is what thi=
s
> >> series addresses (and thus does not depend on the mentioned SBI extens=
ion).
> >
> > Ah, I must have misread then. Apologies.
>
> No worries, maybe I should actually remove this from the cover letter to
> avoid any confusion !
>
> Cl=C3=A9ment
