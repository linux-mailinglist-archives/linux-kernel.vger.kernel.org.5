Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0B77692DD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjGaKPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjGaKPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:15:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072C3E5F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:15:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so39878015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690798523; x=1691403323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG3iuoYl2Yyk7UzsEc9LvQqrnR5PB3HBwoWOS4ckXVc=;
        b=JwLZ45qZwpOVPkXVdWIjIpyNCmwYH3dD8Ou7rl1pivlSHmOAShFMtPSrushNT6kmaq
         0dvPQPJk9qUs4AvASoH4gYvejhe/vSpJ4yXyYZyySjdQGekmCa/rEJCpbcQYWU/E8P3S
         AlJhoAOq/XPyByQrKiIkNk/OrNEA5ye2AzKSbO1oFASt+UzRwFIPWKYe3WuZmxeQvDGd
         /Fldg0QEg6p7DZ7btLj4ScOMseJMGHIDA9pso+oYxo3L4B91PFlYyvSd5DbmYHBcFOoi
         vHMqeQ0nYL/ARSHDJmf9aL3oEsBkBmeXhnms5OSIg/VaUgDVI2kRDsctBYp8rqkmYenw
         IuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690798523; x=1691403323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EG3iuoYl2Yyk7UzsEc9LvQqrnR5PB3HBwoWOS4ckXVc=;
        b=HzI8AlsM3qdedSoNIxYJiIKzsyYrr8zt8gaWQQeOt+LL82EchOrzJRy6q3ct288Hq0
         ybnhMKLPPNPVnArXTq+vKwhoyKba/pm2q9gG222TT97zOqza2e6kxB6vtBJDZSNyi3wQ
         Cy38nQ3U6Iy0AWuS3NaqIJ9G+yPpjtsOzMVqD+JpGJorS3+Dr9zCtE0iZAv7Stngq5Vx
         esSAGMGBFNE5p3UubDKiM9rmJ9CVjzjzq5BBT77QiBBAyogKnQzWoVjpysfyHazmOHTv
         BbacR5MvOYJGPIuAdiITSqbBcZIsQMZI9Cc0HmeADV+d8HF8CAr6nCkf5s7f4/ACztDn
         1sUA==
X-Gm-Message-State: ABy/qLaEWK+6f7wcfZ0LCLRdJsjmEcdokz/JVMYHNbHks5SJAnQEXG8p
        nnprfMO9/BLRnIxK76sGwHwSbkxvwGdoe/iavhwxGg==
X-Google-Smtp-Source: APBJJlFxSlRHvyoI0m2LL342krCpCaswj8cTM0vLfwdYwEDfTBUig6/z+ede7/AhGalI5Gom70ZQdsAskFXQlQqiPT4=
X-Received: by 2002:a5d:43c3:0:b0:30f:af19:81f3 with SMTP id
 v3-20020a5d43c3000000b0030faf1981f3mr5506063wrr.41.1690798523303; Mon, 31 Jul
 2023 03:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
 <20230727141428.962286-10-alexghiti@rivosinc.com> <CAP-5=fU5XYXrVnRUidpwjV2LiTsdebfidL43_Qo4Z7TBxMsVGA@mail.gmail.com>
In-Reply-To: <CAP-5=fU5XYXrVnRUidpwjV2LiTsdebfidL43_Qo4Z7TBxMsVGA@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 31 Jul 2023 12:15:12 +0200
Message-ID: <CAHVXubgVAe1WsiZx5Ay+3KPK4u24k_vsnTwFFmBeVsHrGXwhfw@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] tools: lib: perf: Implement riscv mmap support
To:     Ian Rogers <irogers@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Fri, Jul 28, 2023 at 7:53=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jul 27, 2023 at 7:28=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > riscv now supports mmaping hardware counters so add what's needed to
> > take advantage of that in libperf.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  tools/lib/perf/mmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > index 0d1634cedf44..378a163f0554 100644
> > --- a/tools/lib/perf/mmap.c
> > +++ b/tools/lib/perf/mmap.c
> > @@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int counter)
> >
> >  static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
> >
> > +#elif __riscv_xlen =3D=3D 64
>
> This is something of an odd guard, perhaps:
> #elif defined(__riscv) && __riscv_xlen =3D=3D 64
>
> That way it is more intention revealing that this is riscv code. Could
> you add a comment relating to the __riscv_xlen ?

I guess Andrew answered that already.

>
> > +
> > +/* TODO: implement rv32 support */
> > +
> > +#define CSR_CYCLE      0xc00
> > +#define CSR_TIME       0xc01
> > +
> > +#define csr_read(csr)                                          \
> > +({                                                             \
> > +       register unsigned long __v;                             \
> > +               __asm__ __volatile__ ("csrr %0, " #csr          \
> > +                : "=3Dr" (__v) :                                 \
> > +                : "memory");                                   \
>
> To avoid the macro pasting that could potentially go weird, could this be=
:
>
> __asm__ __volatile__ ("csrr %0, %1",
>   : "=3Dr"(__v) /* outputs */
>   : "i"(csr) /* inputs */
>   : "memory" /* clobbers */)
>
> Also, why is this clobbering memory? Worth adding a comment.

No idea, I see that it is also done this way in
arch/riscv/include/asm/csr.h. @Atish Kumar Patra , @Palmer Dabbelt ?

Thanks for your comments!

Alex

>
> Thanks,
> Ian
>
> > +                __v;                                           \
> > +})
> > +
> > +static unsigned long csr_read_num(int csr_num)
> > +{
> > +#define switchcase_csr_read(__csr_num, __val)           {\
> > +       case __csr_num:                                 \
> > +               __val =3D csr_read(__csr_num);            \
> > +               break; }
> > +#define switchcase_csr_read_2(__csr_num, __val)         {\
> > +       switchcase_csr_read(__csr_num + 0, __val)        \
> > +       switchcase_csr_read(__csr_num + 1, __val)}
> > +#define switchcase_csr_read_4(__csr_num, __val)         {\
> > +       switchcase_csr_read_2(__csr_num + 0, __val)      \
> > +       switchcase_csr_read_2(__csr_num + 2, __val)}
> > +#define switchcase_csr_read_8(__csr_num, __val)         {\
> > +       switchcase_csr_read_4(__csr_num + 0, __val)      \
> > +       switchcase_csr_read_4(__csr_num + 4, __val)}
> > +#define switchcase_csr_read_16(__csr_num, __val)        {\
> > +       switchcase_csr_read_8(__csr_num + 0, __val)      \
> > +       switchcase_csr_read_8(__csr_num + 8, __val)}
> > +#define switchcase_csr_read_32(__csr_num, __val)        {\
> > +       switchcase_csr_read_16(__csr_num + 0, __val)     \
> > +       switchcase_csr_read_16(__csr_num + 16, __val)}
> > +
> > +       unsigned long ret =3D 0;
> > +
> > +       switch (csr_num) {
> > +       switchcase_csr_read_32(CSR_CYCLE, ret)
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +#undef switchcase_csr_read_32
> > +#undef switchcase_csr_read_16
> > +#undef switchcase_csr_read_8
> > +#undef switchcase_csr_read_4
> > +#undef switchcase_csr_read_2
> > +#undef switchcase_csr_read
> > +}
> > +
> > +static u64 read_perf_counter(unsigned int counter)
> > +{
> > +       return csr_read_num(CSR_CYCLE + counter);
> > +}
> > +
> > +static u64 read_timestamp(void)
> > +{
> > +       return csr_read_num(CSR_TIME);
> > +}
> > +
> >  #else
> >  static u64 read_perf_counter(unsigned int counter __maybe_unused) { re=
turn 0; }
> >  static u64 read_timestamp(void) { return 0; }
> > --
> > 2.39.2
> >
