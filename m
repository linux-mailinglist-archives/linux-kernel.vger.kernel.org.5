Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EED77BE57
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjHNQpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjHNQpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:45:11 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27C8E5F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:45:10 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3492e05be7cso2555ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692031510; x=1692636310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUOrFLsIZYMXOqsY5xgWwBV0ImqoZShpWf5IuSUgWgI=;
        b=jI6Gr0FRrjvGeJMEI2J8ZnZVkqk3LIcr8NpGV+Y+d48pChX47ng6l8lIZluFd5qijf
         Vy4Pc+avZR6i4rP9hCWvkX1U0Vn+evBgb/sam6zB/uLlpDMD8+c3BrrKzjB0JRBdI9H9
         7LUSfD27s0IiFR2tak8vcZ1D8yQu4Z7UzYsjGDv3sDMH/nB6iDvgaT81tC4SkjjjKM9q
         uuAHoeR4LGvJ3UXkY+9WMJuQbtdbtNM3VW93Wrwk+G/XZih4HW6Z3xtepuFT9Sxv9vYh
         8QiKW1e+b3Y7vhVL9vVWPkbMEKrzIbCWOjDTSlDW5MGe7DcgscNk/PPPu6yIi9obT4lZ
         SbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031510; x=1692636310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUOrFLsIZYMXOqsY5xgWwBV0ImqoZShpWf5IuSUgWgI=;
        b=gETVcT+LibZvrJqlA1pjVMJTdmAyc04aKbm4YmnLxoPWFpmF/fEGHvwudhDSoX/Sbi
         tO8H2OjVV2YKCMsHCEt4w4gGZ+NjH7DocrFkiKntSoid4K3gDd3frsYF+eaAj5pyauuS
         DAlmDDUJCBMQWs336WijzN7gi6vm6aBYQbp7iSNGuymYJp08LuQ8rMJ8xfX6qchRZ2jC
         fj2r4u2V3zvY4KpQzcW9b0q8e23zTcW4wPpBa99lj4FvAzEz/RAZOjuMI7AhGY0BDD/j
         VnE2sIx7ssauUlZ6ukT7RFm9zrfNQ6XQwoXGgOhMafqz/bdsNLj77RVBsdwKQbHHdYBr
         w1vQ==
X-Gm-Message-State: AOJu0YylUf2rk8EtH3Pt+U5gbGfClcKjvi5EAs+3Yg7gmHhzyLXsYUya
        XHXOQ7AV4tvn7esMcLbeDoc2QkY6jDJ/AVXb4YtEug==
X-Google-Smtp-Source: AGHT+IHaVdS2tL6lFC4JIfMaRKMI72Pka+6x9A1yAAwchBWIR4AFgLTDvCZa48IjUvUxK8db50EWHKlDZ5LeoG7M3q8=
X-Received: by 2002:a05:6e02:1d0d:b0:346:676f:3517 with SMTP id
 i13-20020a056e021d0d00b00346676f3517mr579011ila.11.1692031510069; Mon, 14 Aug
 2023 09:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230802080328.1213905-1-alexghiti@rivosinc.com> <20230802080328.1213905-11-alexghiti@rivosinc.com>
In-Reply-To: <20230802080328.1213905-11-alexghiti@rivosinc.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Aug 2023 09:44:58 -0700
Message-ID: <CAP-5=fVcMg7TL6W_jH61PW6dYMobuTs13d4JDuTAx=mxJ+PNtQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/10] perf: tests: Adapt mmap-basic.c for riscv
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 1:14=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> riscv now supports mmaping hardware counters to userspace so adapt the te=
st
> to run on this architecture.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/mmap-basic.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.=
c
> index e68ca6229756..886a13a77a16 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -284,7 +284,8 @@ static struct test_case tests__basic_mmap[] =3D {
>                          "permissions"),
>         TEST_CASE_REASON("User space counter reading of instructions",
>                          mmap_user_read_instr,
> -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || =
\
> +                        (defined(__riscv) && __riscv_xlen =3D=3D 64)
>                          "permissions"
>  #else
>                          "unsupported"
> @@ -292,7 +293,8 @@ static struct test_case tests__basic_mmap[] =3D {
>                 ),
>         TEST_CASE_REASON("User space counter reading of cycles",
>                          mmap_user_read_cycles,
> -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || =
\
> +                        (defined(__riscv) && __riscv_xlen =3D=3D 64)
>                          "permissions"
>  #else
>                          "unsupported"
> --
> 2.39.2
>
