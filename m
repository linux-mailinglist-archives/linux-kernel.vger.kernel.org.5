Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB27535A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbjGNIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbjGNIvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:51:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFF826BC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:51:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6fbf0c0e2so24884191fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689324671; x=1691916671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVJFUGPgUiZjejGogHmLzYwwKGbHbhdGEjYSUHSjBfo=;
        b=pYAcX4FPQitZnsDIm6cTcKdm1Ztraq4W2bv6eu94SIYUTBpXculUzJiLK05nDzIZQY
         X+ajUMzJ4+s3GZVMczZKydx+tBqLXWPIIcNeeaSKxDbOIpV+juiQrp9N9A7oMFbOy0ej
         Bev1FExTBu9b0hpfG/pxEJkztwcOKTfi7ojBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689324671; x=1691916671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVJFUGPgUiZjejGogHmLzYwwKGbHbhdGEjYSUHSjBfo=;
        b=ME2mZ3YWBkcZoJn145ag6TIorBmqvjYYzyr7g1POwRy1MOZ+K+4OaGCUJRiF3JVLrf
         Fk+p6TBatF7Uq9E9Gsnm+DgZOfnKSPEs3LgaHajEXFNvVysZr2q/XzBqYn/kTnRnHgDd
         JNt1LcZHMTume8Xao8XYORrohWQJGYef5WSBg29a6ZV7iBswndgOqzdkAKKPT1lKk4Ry
         x+kyI8YyZ+XhyfYJU5bj1ZzLEFrrvE8sFjupQ+tOGIKzE79h+8rCtEonb+BZa7MIK2XV
         RQu49HGOoFvqqOeQJEaYTZQAFQX/jobVN874QW/Mhgo10gfsXikK+Fq8ZhHNG9NQQ0di
         qJLQ==
X-Gm-Message-State: ABy/qLbRBoXyHIU3pZ0N2fc7wv86YoPIAL30NAEpYZrgUruY039Ohinh
        eqnhUOLEqmy53Q5ajhuEBkhBzvDJUYusCUnmdkTa
X-Google-Smtp-Source: APBJJlHjR6JsuaMQbXZar+lmwIZWlDiqDI6I9i3Y4OuSMcqQfvuZ6VyIJunOF1Ue2HAQ0kQfJSL6fyyKFEWspQicjTo=
X-Received: by 2002:a2e:8611:0:b0:2b6:ee1c:216a with SMTP id
 a17-20020a2e8611000000b002b6ee1c216amr3436379lji.34.1689324671023; Fri, 14
 Jul 2023 01:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com> <20230703124647.215952-9-alexghiti@rivosinc.com>
In-Reply-To: <20230703124647.215952-9-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 14 Jul 2023 01:50:59 -0700
Message-ID: <CAOnJCUJGHWicrhGOGPK_aduaD9jXz7THHcbU+i+7tK-ChtQxNg@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] Documentation: admin-guide: Add riscv sysctl_perf_user_access
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

On Mon, Jul 3, 2023 at 5:54=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> riscv now uses this sysctl so document its usage for this architecture.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 27 ++++++++++++++++++---
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
> index d85d90f5d000..19b627883313 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -941,16 +941,35 @@ enabled, otherwise writing to this file will return=
 ``-EBUSY``.
>  The default value is 8.
>
>
> -perf_user_access (arm64 only)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +perf_user_access (arm64 and riscv only)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controls user space access for reading perf event counters.
>
> -Controls user space access for reading perf event counters. When set to =
1,
> -user space can read performance monitor counter registers directly.
> +arm64
> +=3D=3D=3D=3D=3D
>
>  The default value is 0 (access disabled).
>
> +When set to 1, user space can read performance monitor counter registers
> +directly.
> +

For ARM64, 1 also enables reading performance counters via perf interface o=
nly.
I don't think there is any way to access the counters directly in ARM64.

>  See Documentation/arm64/perf.rst for more information.
>
> +riscv
> +=3D=3D=3D=3D=3D
> +
> +When set to 0, user space access is disabled.
> +
> +The default value is 1, user space can read performance monitor counter
> +registers through perf, any direct access without perf intervention will=
 trigger
> +an illegal instruction.
> +
> +When set to 2, which enables legacy mode (user space has direct access t=
o cycle
> +and insret CSRs only). Note that this legacy value is deprecated and wil=
l be
> +removed once all user space applications are fixed.
> +
> +Note that the time CSR is always directly accessible to all modes.
>
>  pid_max
>  =3D=3D=3D=3D=3D=3D=3D
> --
> 2.39.2
>


--=20
Regards,
Atish
