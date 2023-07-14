Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17B2753490
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjGNIEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbjGNIEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:04:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18BB4C27
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:01:41 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so24628591fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689321700; x=1691913700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShjQafFlxwj0ZbXGvO6wNGgWYgf4xaRFZkYq02YP6kc=;
        b=NxLgPV4I19f8IiP60ZnGFSeHPxtkexY32ZSMloC+h1rGlZvabpR6A/95fQRFz3JYYl
         mA3aygOemm5vn9YIIfhjVvgiQfzkmba/RYXwnACWZ9QvSY934p3EaqHuKQndThA/Ncol
         PPB/1ojsJfRmvkFBS7VpyIdsWANx5SGYvfneQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321700; x=1691913700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShjQafFlxwj0ZbXGvO6wNGgWYgf4xaRFZkYq02YP6kc=;
        b=aeXwJ9Wg/hkaCnbUa8jN30b61yblsbz90yS1yAHTAsbvKkKJG59HGQN8f23MBQ75Tj
         yZbtTz/AsiMtX0p5yZTjueX7gvYNduLDLUciRdzTK9o5YcgxH48fP5yWi/DO7ebHFTNc
         JXNDkWchPAxVdUJJT6M32fnY+EPgxNTuxzUV44XmrrNdUTvgCK7rn7FWaFdBQ1z7TGeF
         0/z+4YRvt5MVPFTcBv+Ndwk3CCLGAm95kFRU0F0mZO1Eo663FVQ8U48o8XO2CubhYmBP
         l2mc8ntH7OTvjgvlvq0wi6gss8fM+zSJRQclxs+hERDRueOp3jYOY3cX9LEUSifXv9R2
         4Cjw==
X-Gm-Message-State: ABy/qLbIRdvQFdL9lxUhqlsrAxlaaZ/ympvQwrVOcqYr5zZP+KgEa1Lo
        VYcUQu0MyYizEfJ+s7XK+052tQlpEPUNs6davhoW
X-Google-Smtp-Source: APBJJlG8yJgz5jfm4hlpuw8sREsVvtiALqK/rKnopveB5SJ1Aggbn1Z9er70e9nUIoAw3y4SZLdpoCvsmxLPKA6jdac=
X-Received: by 2002:a2e:8082:0:b0:2b6:d8d5:15b1 with SMTP id
 i2-20020a2e8082000000b002b6d8d515b1mr2761616ljg.50.1689321700031; Fri, 14 Jul
 2023 01:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com> <20230703124647.215952-5-alexghiti@rivosinc.com>
In-Reply-To: <20230703124647.215952-5-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 14 Jul 2023 01:01:28 -0700
Message-ID: <CAOnJCULCcPaHL5WeF=1L=Ge22M6CgGHLPVh7z1dOyhT7S0V5+Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] drivers: perf: Rename riscv pmu sbi driver
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 5:50=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> That's just cosmetic, no functional changes.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c   | 4 ++--
>  include/linux/perf/riscv_pmu.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 4f3ac296b3e2..83c3f1c4d2f1 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -914,7 +914,7 @@ static int pmu_sbi_device_probe(struct platform_devic=
e *pdev)
>  static struct platform_driver pmu_sbi_driver =3D {
>         .probe          =3D pmu_sbi_device_probe,
>         .driver         =3D {
> -               .name   =3D RISCV_PMU_PDEV_NAME,
> +               .name   =3D RISCV_PMU_SBI_PDEV_NAME,
>         },
>  };
>
> @@ -941,7 +941,7 @@ static int __init pmu_sbi_devinit(void)
>         if (ret)
>                 return ret;
>
> -       pdev =3D platform_device_register_simple(RISCV_PMU_PDEV_NAME, -1,=
 NULL, 0);
> +       pdev =3D platform_device_register_simple(RISCV_PMU_SBI_PDEV_NAME,=
 -1, NULL, 0);
>         if (IS_ERR(pdev)) {
>                 platform_driver_unregister(&pmu_sbi_driver);
>                 return PTR_ERR(pdev);
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pm=
u.h
> index 9f70d94942e0..5deeea0be7cb 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -21,7 +21,7 @@
>
>  #define RISCV_MAX_COUNTERS     64
>  #define RISCV_OP_UNSUPP                (-EOPNOTSUPP)
> -#define RISCV_PMU_PDEV_NAME    "riscv-pmu"
> +#define RISCV_PMU_SBI_PDEV_NAME        "riscv-pmu-sbi"
>  #define RISCV_PMU_LEGACY_PDEV_NAME     "riscv-pmu-legacy"
>
>  #define RISCV_PMU_STOP_FLAG_RESET 1
> --
> 2.39.2
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
