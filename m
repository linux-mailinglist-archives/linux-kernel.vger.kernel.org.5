Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8F575348B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjGNIEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjGNIDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:03:36 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2A34C00
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:01:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6fbf0c0e2so24237691fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689321673; x=1691913673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EP8QirGSf2eyBcIi4yRsMFtzBd2RQ70krFjONUiThU=;
        b=qrgkw6OLa/u09k4e8aJM4RCLYCSGJL2Ws3SFmAj0tiB0tCpyZoQo61oYAsI8sU9BB8
         H+gQWv8vCeKgKgyoeSKS4C4Sc0C4IPiwmVfTHUNpOFsAZRTsMpO+0/j6Wnd+QMliJQf8
         i4x/3jU9uKTH2hS4SI8A4xrNpqD/H+x2vIEBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321673; x=1691913673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EP8QirGSf2eyBcIi4yRsMFtzBd2RQ70krFjONUiThU=;
        b=kL8nmjK5pP8ZGThzftx9546dN8zMyVNAuKWZ7BZQfA6Y5FbxlyYl+HK+VEmX1+TeKU
         08yYjd4LwXMfukFR5xX9aMoKvQPKEt/I9oKmhs7cVnGpSiKSYybYRcW9Qz1NAZuz4DBR
         76kHhA3IeVi3jy15wX2wz8X0tedJoeUJrrZWNNabCP65OEdOAtVyrpw3PepDwvKdgcKS
         kxxPbRvvxhKpdmFNBxvT6CXM6SHu+IkjMgT25LvKhV67Aqat83mO5FCd2FQ4feEsQ/cB
         eoy0NzFLgs+C3eVWurQFA0agKTYwY69CgmcZwCc5kXEFKlusQMDrLMr96wxUXAkB3Wuq
         Y/9Q==
X-Gm-Message-State: ABy/qLbEcoWneig3m0zBVW5vwaie3BJl0VW7Lg7hBr50w1G1ARduFPU9
        vRmZiSbPIeZ5OgMBXfJlh3mLKPVycFm2ipLIvqQ8
X-Google-Smtp-Source: APBJJlH9NXJwG/irkEBqLyvhCaQIJQoJOMcC3K+qxYOhEFI0i6ghNvHJrlfaGxOM3WfsQn8boxIxuA7ht9mmOsLse2o=
X-Received: by 2002:a2e:8611:0:b0:2b6:ee1c:216a with SMTP id
 a17-20020a2e8611000000b002b6ee1c216amr3346497lji.34.1689321672902; Fri, 14
 Jul 2023 01:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com> <20230703124647.215952-4-alexghiti@rivosinc.com>
In-Reply-To: <20230703124647.215952-4-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 14 Jul 2023 01:01:01 -0700
Message-ID: <CAOnJCULeM0TXR8mp-FihtMZ2KfOTkPzmzjX74Mj6_c62UrhAEA@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] riscv: Make legacy counter enum match the HW numbering
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 5:49=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> RISCV_PMU_LEGACY_INSTRET used to be set to 1 whereas the offset of this
> hardware counter from CSR_CYCLE is actually 2: make this offset match the
> real hw offset so that we can directly expose those values to userspace.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/perf/riscv_pmu_legacy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_leg=
acy.c
> index ca9e20bfc7ac..6a000abc28bb 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -13,7 +13,7 @@
>  #include <linux/platform_device.h>
>
>  #define RISCV_PMU_LEGACY_CYCLE         0
> -#define RISCV_PMU_LEGACY_INSTRET       1
> +#define RISCV_PMU_LEGACY_INSTRET       2
>
>  static bool pmu_init_done;
>
> --
> 2.39.2
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
