Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D9C769D19
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjGaQq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjGaQqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:46:23 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC0F199F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:46:20 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40a47e8e38dso1091cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690821979; x=1691426779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkpC0Z6fXatXUM3fvGCV0DX0YQXZ+FgSizXvrR3qNcg=;
        b=I12WSGpJOpsDMDhj94QiNWmOcnD++i//xN3g8WNRRYIaq7wNEVgQ/39SRQHRvovnit
         h2vvgUh4MuDCVr3+4Zl0pzxrJ9smosJUCufdI46/Fir0puaQGACh/fJSXwlO2eadbcmm
         xAiTRYYy+xuMxRo2lHQsJY6+yZi80MWQDw2R70j5VHEICqELGG60E3KLv1QWTstv/z6F
         QUO8dcSMqKjOduCsiGGI1KBAvIw2GjltRXwRMMOhTOzf48yUldVbrU9fUS0df3cMBnKB
         9v7RovMbt5hyoQydYi5F0Go4Nbw+ufBnfHLD13bENVdrE9TtArU8y1XIbqxgvdUUPatd
         FkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690821979; x=1691426779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkpC0Z6fXatXUM3fvGCV0DX0YQXZ+FgSizXvrR3qNcg=;
        b=CdpgD8yrGdyxu7HMzwQWvgTmmNEhYwGgMrSkBX2sR8W4DA8gIjbtziczNbJ9pZrU2r
         KJFx82d5VrenGJELf7WsIr+xENTQyUAmTOsVtakJGdr9MZI5b6HIl+71J+hA4iJwi0hQ
         B8Uc/OivQFUHRCRkHKuE6xeUeykSZPGnfk1jBbc3JVkwLbt8XpYaPSbtUkADbQrYr1JU
         RsOsUUsn4UDMKxcsc5a+fn+7qACUBxA7bohulPrI7rgZc/28WBNbDWEI+f9Ij/H0nElg
         3IR6g8DqBpnLsPaFOIxOacXrETlqFgGGxQMxY5UeIN6Xi+57vOvtpb1/x0fB81lh42fh
         r2vw==
X-Gm-Message-State: ABy/qLYa6wJkYMYSMWbLB7m5FjIVipFqVlAE10xsGuqB6P0cBmK4nKF9
        EXwXdyiYK0dlmL8foGdQzVXzalc9wwiFjZq6Fv7Hzg==
X-Google-Smtp-Source: APBJJlFFKZot7tLmdlKAC+vAUwI73rHoer0fQPHGa9/7EiPcRQmCTdlv/b+YtQMfESODC5FmbFtM9/UiMsXuONiKC2g=
X-Received: by 2002:ac8:7f84:0:b0:40f:c60d:1c79 with SMTP id
 z4-20020ac87f84000000b0040fc60d1c79mr134422qtj.28.1690821979504; Mon, 31 Jul
 2023 09:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
 <20230727141428.962286-10-alexghiti@rivosinc.com> <CAP-5=fU5XYXrVnRUidpwjV2LiTsdebfidL43_Qo4Z7TBxMsVGA@mail.gmail.com>
 <CAHVXubgVAe1WsiZx5Ay+3KPK4u24k_vsnTwFFmBeVsHrGXwhfw@mail.gmail.com>
 <CAHVXubj80rQRShuDS09BeTrfR6nux0A68EMWLbeat8fd_Y3YdA@mail.gmail.com>
 <CAP-5=fWwzuGZ6a6Z38ndsb7gw7_uwS0a2VGXx08hMeiK8eZ91w@mail.gmail.com> <CAHVXubjhM9C1fw_Us=8+RuSJbW0pacFAk9gp7j2=BtMUPy_Byw@mail.gmail.com>
In-Reply-To: <CAHVXubjhM9C1fw_Us=8+RuSJbW0pacFAk9gp7j2=BtMUPy_Byw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 31 Jul 2023 09:46:07 -0700
Message-ID: <CAP-5=fUbiaVwSAhTbymyhdUPcVAXHiQZZexAOnrqid0LsPmfpw@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] tools: lib: perf: Implement riscv mmap support
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Brendan Sweeney <brs@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 9:06=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> On Mon, Jul 31, 2023 at 5:10=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Mon, Jul 31, 2023 at 3:27=E2=80=AFAM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > On Mon, Jul 31, 2023 at 12:15=E2=80=AFPM Alexandre Ghiti <alexghiti@r=
ivosinc.com> wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Fri, Jul 28, 2023 at 7:53=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > On Thu, Jul 27, 2023 at 7:28=E2=80=AFAM Alexandre Ghiti <alexghit=
i@rivosinc.com> wrote:
> > > > > >
> > > > > > riscv now supports mmaping hardware counters so add what's need=
ed to
> > > > > > take advantage of that in libperf.
> > > > > >
> > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > > > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> > > > > > ---
> > > > > >  tools/lib/perf/mmap.c | 65 +++++++++++++++++++++++++++++++++++=
++++++++
> > > > > >  1 file changed, 65 insertions(+)
> > > > > >
> > > > > > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > > > > > index 0d1634cedf44..378a163f0554 100644
> > > > > > --- a/tools/lib/perf/mmap.c
> > > > > > +++ b/tools/lib/perf/mmap.c
> > > > > > @@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int =
counter)
> > > > > >
> > > > > >  static u64 read_timestamp(void) { return read_sysreg(cntvct_el=
0); }
> > > > > >
> > > > > > +#elif __riscv_xlen =3D=3D 64
> > > > >
> > > > > This is something of an odd guard, perhaps:
> > > > > #elif defined(__riscv) && __riscv_xlen =3D=3D 64
> > > > >
> > > > > That way it is more intention revealing that this is riscv code. =
Could
> > > > > you add a comment relating to the __riscv_xlen ?
> > > >
> > > > I guess Andrew answered that already.
> > > >
> >
> > Not sure. I still think it looks weird:
> > ...
> > #if defined(__i386__) || defined(__x86_64__)
> > ...
> > #elif defined(__aarch64__)
> > ...
> > #elif __riscv_xlen =3D=3D 64
> > ...
> > #else
> > static u64 read_perf_counter(unsigned int counter __maybe_unused) { ret=
urn 0; }
> > static u64 read_timestamp(void) { return 0; }
> > #endif
> >
> > The first two are clearly #ifdef-ing architecture specific assembly
> > code, under what conditions I get RISC-V code  =C2=AF\(=E3=83=84)/=C2=
=AF At least worth
> > a comment like "csrr is only available when you have xlens of 64
> > because ..."
>
> __riscv_xlen indicates riscv64, which is the only target of this
> patchset. But if you prefer, I don't mind adding back the
> defined(__riscv) if I re-spin a new version.

This kind of begs the question as to why there is no __riscv64 ifdef.
The issue with xlen is it isn't intention revealing so for regular
people trying to understand the code it would be nice to document it.

> >
> > > > >
> > > > > > +
> > > > > > +/* TODO: implement rv32 support */
> > > > > > +
> > > > > > +#define CSR_CYCLE      0xc00
> > > > > > +#define CSR_TIME       0xc01
> > > > > > +
> > > > > > +#define csr_read(csr)                                         =
 \
> > > > > > +({                                                            =
 \
> > > > > > +       register unsigned long __v;                            =
 \
> > > > > > +               __asm__ __volatile__ ("csrr %0, " #csr         =
 \
> > > > > > +                : "=3Dr" (__v) :                              =
   \
> > > > > > +                : "memory");                                  =
 \
> > > > >
> > > > > To avoid the macro pasting that could potentially go weird, could=
 this be:
> > > > >
> > > > > __asm__ __volatile__ ("csrr %0, %1",
> > > > >   : "=3Dr"(__v) /* outputs */
> > > > >   : "i"(csr) /* inputs */
> > > > >   : "memory" /* clobbers */)
> > >
> > > Forgot to answer this one: it compiles, but I have to admit that I
> > > don't understand the difference and if that's correct (all macros in
> > > arch/riscv/include/asm/csr.h use # to do this) and what benefits it
> > > brings. Can you elaborate more on things that could "go weird"?
> >
> > So rather than use an input constraint for the asm block you are using
> > the C preprocessor to paste in the csr argument. If csr is something
> > like "1" then it looks good and you'll get "csrr %0,1". If you pass
> > something like "1 << 31" then that will be pasted as "csrr %0, 1 <<
> > 31" and that starts to get weird in the context of being in the
> > assembler where it is unlikely the C operators work. Using the input
> > constraint avoids this, causes the C compiler to check the type of the
> > argument and you'll probably get more intelligible error messages as a
> > consequence.
> >
>
> Thanks. So if I'm not mistaken, in this exact context, given we only
> use csr_read() through the csr_read_num() function, it seems ok right?

So you've formed a cargo cult and the justification is not wanting to
stop a copy-paste chain from somewhere else. This code itself will be
copy-pasted and we go to some ends to encourage that by placing parts
of it in include/uapi/linux/perf_event.h. It seems better to catch
this issue early rather than propagate it.

> > >
> > > Thanks again,
> > >
> > > Alex
> > >
> > > > >
> > > > > Also, why is this clobbering memory? Worth adding a comment.
> > > >
> > > > No idea, I see that it is also done this way in
> > > > arch/riscv/include/asm/csr.h. @Atish Kumar Patra , @Palmer Dabbelt =
?
> >
> > It would seem to make sense then not to have a memory constraint until
> > we know why we're doing it?
> >
>
> I have just had the answer internally (thanks to @Brendan Sweeney):
> csr modifications can alter how the memory is accessed (satp which
> changes the address space, sum which allows/disallows userspace
> access...), so we need the memory barrier to make sure the compiler
> does not reorder the memory accesses.

The conditions you mention shouldn't apply here though? Even if you
add a memory barrier for the compiler what is stopping the hardware
reordering loads and stores? If it absolutely has to be there then a
comment something like "There is a bug is riscv where the csrr
instruction can clobber memory breaking future reads and some how this
constraint fixes it by ... ".

Thanks,
Ian

> Thanks,
>
> Alex
>
> > Thanks,
> > Ian
> >
> > > >
> > > > Thanks for your comments!
> > > >
> > > > Alex
> > > >
> > > > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > > > +                __v;                                          =
 \
> > > > > > +})
> > > > > > +
> > > > > > +static unsigned long csr_read_num(int csr_num)
> > > > > > +{
> > > > > > +#define switchcase_csr_read(__csr_num, __val)           {\
> > > > > > +       case __csr_num:                                 \
> > > > > > +               __val =3D csr_read(__csr_num);            \
> > > > > > +               break; }
> > > > > > +#define switchcase_csr_read_2(__csr_num, __val)         {\
> > > > > > +       switchcase_csr_read(__csr_num + 0, __val)        \
> > > > > > +       switchcase_csr_read(__csr_num + 1, __val)}
> > > > > > +#define switchcase_csr_read_4(__csr_num, __val)         {\
> > > > > > +       switchcase_csr_read_2(__csr_num + 0, __val)      \
> > > > > > +       switchcase_csr_read_2(__csr_num + 2, __val)}
> > > > > > +#define switchcase_csr_read_8(__csr_num, __val)         {\
> > > > > > +       switchcase_csr_read_4(__csr_num + 0, __val)      \
> > > > > > +       switchcase_csr_read_4(__csr_num + 4, __val)}
> > > > > > +#define switchcase_csr_read_16(__csr_num, __val)        {\
> > > > > > +       switchcase_csr_read_8(__csr_num + 0, __val)      \
> > > > > > +       switchcase_csr_read_8(__csr_num + 8, __val)}
> > > > > > +#define switchcase_csr_read_32(__csr_num, __val)        {\
> > > > > > +       switchcase_csr_read_16(__csr_num + 0, __val)     \
> > > > > > +       switchcase_csr_read_16(__csr_num + 16, __val)}
> > > > > > +
> > > > > > +       unsigned long ret =3D 0;
> > > > > > +
> > > > > > +       switch (csr_num) {
> > > > > > +       switchcase_csr_read_32(CSR_CYCLE, ret)
> > > > > > +       default:
> > > > > > +               break;
> > > > > > +       }
> > > > > > +
> > > > > > +       return ret;
> > > > > > +#undef switchcase_csr_read_32
> > > > > > +#undef switchcase_csr_read_16
> > > > > > +#undef switchcase_csr_read_8
> > > > > > +#undef switchcase_csr_read_4
> > > > > > +#undef switchcase_csr_read_2
> > > > > > +#undef switchcase_csr_read
> > > > > > +}
> > > > > > +
> > > > > > +static u64 read_perf_counter(unsigned int counter)
> > > > > > +{
> > > > > > +       return csr_read_num(CSR_CYCLE + counter);
> > > > > > +}
> > > > > > +
> > > > > > +static u64 read_timestamp(void)
> > > > > > +{
> > > > > > +       return csr_read_num(CSR_TIME);
> > > > > > +}
> > > > > > +
> > > > > >  #else
> > > > > >  static u64 read_perf_counter(unsigned int counter __maybe_unus=
ed) { return 0; }
> > > > > >  static u64 read_timestamp(void) { return 0; }
> > > > > > --
> > > > > > 2.39.2
> > > > > >
