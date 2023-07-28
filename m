Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFCA7673F4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjG1RxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjG1RxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:53:13 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C41435BF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:53:12 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3460770afe2so7175ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690566791; x=1691171591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsIHLPb5okBWXJf2DtS76Y92BZwwFSzgLVO6RcujWsQ=;
        b=dtdPiasbgn7CaqvxkgS3cosIxhKaD7PdNI4nHup/Mt+FArUPs4kuQQNpIZHJItnBiy
         yOqBDtVdIN0uZpwAh+C6NKhqrAH7nxnm+Bl22M2vUM/p1ubXV4AiSDC9dnIr5AxdTou0
         kzxM5iVxPfYWqxeR1ivufNCcn/nkNGQ0s11RRlmZiqVs53VN9Xrqn1iqGw1eWvrnWycS
         sJgAwtpJ/yhA+254E2CbjGcn4IXCSCg/D72dF4TwHsgnMJxz7kpPK1zeOsFr/vkqkXJo
         ga4i1v6ZpMGL4ECLEcii9uTg2DGiR7/QEA5eLmKR10HGjXkndlW04IAEC8cZyEB0oTbc
         0THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566791; x=1691171591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsIHLPb5okBWXJf2DtS76Y92BZwwFSzgLVO6RcujWsQ=;
        b=lXCbaK6kj1pq5HT67qdo5DTXm/pIjAWvqDZEkatLA/Uxq9zjc0eO0gDWkqwWszKh8W
         75e9m7wnLoGnDvR+fqtZVvgziNG7YvCIjdQZbVetZFYZuo+LXzCywiemFp6IRI4IK7cp
         X9mDscjoFwpr51Uqj9B8aOtHZLXn3jtxZivEolvRtZmFW8JhtzEiVOqizRkBqvOUYlzY
         e5k2lzFuNAKDKxWPnh81fcITESVWjd+eu3+FuiPYqC0qpicUxKXHoNSvjgNtWYfXAzUY
         +3fkEugPzKuAJkzjVqZGWXTgv7AGlsXhy8hXC7B4WvldALhaiMCFHiFGoPIOKyR2YNjc
         S+Tw==
X-Gm-Message-State: ABy/qLZAEPcaQY8uub/rxbinzz4sC+ewBKM9R7YTx+qjMgdaKkD/mv9+
        pKwY+zubE0UV5V8hNZk1w0iTQq56Mr2ucLVmx+ghng==
X-Google-Smtp-Source: APBJJlEDh03sKgpDB0dKs6Z85qIKrMbTr+Ye9aruBFA5yuWJzcNZnvHEOZQeaHI6jnTYkiNFcm6HvFJcJmmT2PwfIAQ=
X-Received: by 2002:a05:6e02:b48:b0:33d:8e80:4c2f with SMTP id
 f8-20020a056e020b4800b0033d8e804c2fmr16633ilu.20.1690566791205; Fri, 28 Jul
 2023 10:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230727141428.962286-1-alexghiti@rivosinc.com> <20230727141428.962286-10-alexghiti@rivosinc.com>
In-Reply-To: <20230727141428.962286-10-alexghiti@rivosinc.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 Jul 2023 10:52:59 -0700
Message-ID: <CAP-5=fU5XYXrVnRUidpwjV2LiTsdebfidL43_Qo4Z7TBxMsVGA@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] tools: lib: perf: Implement riscv mmap support
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 7:28=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> riscv now supports mmaping hardware counters so add what's needed to
> take advantage of that in libperf.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/lib/perf/mmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index 0d1634cedf44..378a163f0554 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int counter)
>
>  static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
>
> +#elif __riscv_xlen =3D=3D 64

This is something of an odd guard, perhaps:
#elif defined(__riscv) && __riscv_xlen =3D=3D 64

That way it is more intention revealing that this is riscv code. Could
you add a comment relating to the __riscv_xlen ?

> +
> +/* TODO: implement rv32 support */
> +
> +#define CSR_CYCLE      0xc00
> +#define CSR_TIME       0xc01
> +
> +#define csr_read(csr)                                          \
> +({                                                             \
> +       register unsigned long __v;                             \
> +               __asm__ __volatile__ ("csrr %0, " #csr          \
> +                : "=3Dr" (__v) :                                 \
> +                : "memory");                                   \

To avoid the macro pasting that could potentially go weird, could this be:

__asm__ __volatile__ ("csrr %0, %1",
  : "=3Dr"(__v) /* outputs */
  : "i"(csr) /* inputs */
  : "memory" /* clobbers */)

Also, why is this clobbering memory? Worth adding a comment.

Thanks,
Ian

> +                __v;                                           \
> +})
> +
> +static unsigned long csr_read_num(int csr_num)
> +{
> +#define switchcase_csr_read(__csr_num, __val)           {\
> +       case __csr_num:                                 \
> +               __val =3D csr_read(__csr_num);            \
> +               break; }
> +#define switchcase_csr_read_2(__csr_num, __val)         {\
> +       switchcase_csr_read(__csr_num + 0, __val)        \
> +       switchcase_csr_read(__csr_num + 1, __val)}
> +#define switchcase_csr_read_4(__csr_num, __val)         {\
> +       switchcase_csr_read_2(__csr_num + 0, __val)      \
> +       switchcase_csr_read_2(__csr_num + 2, __val)}
> +#define switchcase_csr_read_8(__csr_num, __val)         {\
> +       switchcase_csr_read_4(__csr_num + 0, __val)      \
> +       switchcase_csr_read_4(__csr_num + 4, __val)}
> +#define switchcase_csr_read_16(__csr_num, __val)        {\
> +       switchcase_csr_read_8(__csr_num + 0, __val)      \
> +       switchcase_csr_read_8(__csr_num + 8, __val)}
> +#define switchcase_csr_read_32(__csr_num, __val)        {\
> +       switchcase_csr_read_16(__csr_num + 0, __val)     \
> +       switchcase_csr_read_16(__csr_num + 16, __val)}
> +
> +       unsigned long ret =3D 0;
> +
> +       switch (csr_num) {
> +       switchcase_csr_read_32(CSR_CYCLE, ret)
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +#undef switchcase_csr_read_32
> +#undef switchcase_csr_read_16
> +#undef switchcase_csr_read_8
> +#undef switchcase_csr_read_4
> +#undef switchcase_csr_read_2
> +#undef switchcase_csr_read
> +}
> +
> +static u64 read_perf_counter(unsigned int counter)
> +{
> +       return csr_read_num(CSR_CYCLE + counter);
> +}
> +
> +static u64 read_timestamp(void)
> +{
> +       return csr_read_num(CSR_TIME);
> +}
> +
>  #else
>  static u64 read_perf_counter(unsigned int counter __maybe_unused) { retu=
rn 0; }
>  static u64 read_timestamp(void) { return 0; }
> --
> 2.39.2
>
