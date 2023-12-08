Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F2880AE9B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574757AbjLHVJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHVJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:09:07 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4170137
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:09:13 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2cb21afa6c1so15836181fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1702069752; x=1702674552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRoW6U9K3GCzkZrINWjqMXbujMWIBb9ikA18zBPjrTw=;
        b=YF5G+KT+vsbQZddlSprn28ElJavAEapYRlyehgQT+b2Acb+xdqFdUAT/lXhOztU3le
         GL8XKWjNRDxO3hRqLVKg1/CF2gkX6xUVgG+K6sMZf8ZSfkkxdYRRupGDksabKxAPxqV6
         3upnhlI4KY2v8Zsb/I1yeEqSsiqXPbg3kAL4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069752; x=1702674552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRoW6U9K3GCzkZrINWjqMXbujMWIBb9ikA18zBPjrTw=;
        b=OejRDvh1WqZ9YbmK2NNQ5miiTQrkoofzGaimwQx5jJATxZGuzK09I4WqXGozJn8r3i
         9yWsLfkTSpViIRwr1CaJZ0qlnA8VMqsZ1noE0HSlzcUM8bXFQlZRZs+F0F/yRuc0I7d/
         uglzpFNtiA/QMYGrmtIihkazKy5aSxrLmHbLntanXjngM0t6On7Am/+QMvIzli7jC/lC
         fBtLkySdSMvrDxpZyrigemBZC47mA+xYeD5mW1dGymo0kM/z8giI8HWiBhnPneg+FOAF
         tPVk+h63XOW68OWNfCmqHwcznOcZXMDgHYlWXRIjXMEEBINVFpzDf7VnB3YSAyEocdol
         depg==
X-Gm-Message-State: AOJu0YzLQ4FruD0Rc+47gFrIkzgKJNBGjRt60mN0Ez2s9VEgQTxr9sJw
        kiaLzIZUqaUi/BhdxhmUyo4Hqpu6WHhyGvxOAcr9
X-Google-Smtp-Source: AGHT+IHMZ7K62AJlySjlMPFIy8zeLAvEkBfdRUPwKwJVobEe9JC/Pf51mYdPvPNOjhtwev3xItUazqZOTc2y/aMTQfc=
X-Received: by 2002:a05:6512:484b:b0:50b:e65e:9511 with SMTP id
 ep11-20020a056512484b00b0050be65e9511mr238815lfb.71.1702069751158; Fri, 08
 Dec 2023 13:09:11 -0800 (PST)
MIME-Version: 1.0
References: <20231205092555.35617-1-vadim.shakirov@syntacore.com>
In-Reply-To: <20231205092555.35617-1-vadim.shakirov@syntacore.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 8 Dec 2023 13:09:00 -0800
Message-ID: <CAOnJCUL-tCn+KNyczz6aXNbgOb1RYeYk45i0rjy0h=rYtcMbAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: perf: ctr_get_width function for legacy is
 not defined
To:     Vadim Shakirov <vadim.shakirov@syntacore.com>
Cc:     Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 1:26=E2=80=AFAM Vadim Shakirov
<vadim.shakirov@syntacore.com> wrote:
>
> With parameters CONFIG_RISCV_PMU_LEGACY=3Dy and CONFIG_RISCV_PMU_SBI=3Dn
> linux kernel crashes when you try perf record:
>
> $ perf record ls
> [   46.749286] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000000
> [   46.750199] Oops [#1]
> [   46.750342] Modules linked in:
> [   46.750608] CPU: 0 PID: 107 Comm: perf-exec Not tainted 6.6.0 #2
> [   46.750906] Hardware name: riscv-virtio,qemu (DT)
> [   46.751184] epc : 0x0
> [   46.751430]  ra : arch_perf_update_userpage+0x54/0x13e
> [   46.751680] epc : 0000000000000000 ra : ffffffff8072ee52 sp : ff200000=
0022b8f0
> [   46.751958]  gp : ffffffff81505988 tp : ff6000000290d400 t0 : ff200000=
0022b9c0
> [   46.752229]  t1 : 0000000000000001 t2 : 0000000000000003 s0 : ff200000=
0022b930
> [   46.752451]  s1 : ff600000028fb000 a0 : 0000000000000000 a1 : ff600000=
028fb000
> [   46.752673]  a2 : 0000000ae2751268 a3 : 00000000004fb708 a4 : 00000000=
00000004
> [   46.752895]  a5 : 0000000000000000 a6 : 000000000017ffe3 a7 : 00000000=
000000d2
> [   46.753117]  s2 : ff600000028fb000 s3 : 0000000ae2751268 s4 : 00000000=
00000000
> [   46.753338]  s5 : ffffffff8153e290 s6 : ff600000863b9000 s7 : ff600000=
02961078
> [   46.753562]  s8 : ff60000002961048 s9 : ff60000002961058 s10: 00000000=
00000001
> [   46.753783]  s11: 0000000000000018 t3 : ffffffffffffffff t4 : ffffffff=
ffffffff
> [   46.754005]  t5 : ff6000000292270c t6 : ff2000000022bb30
> [   46.754179] status: 0000000200000100 badaddr: 0000000000000000 cause: =
000000000000000c
> [   46.754653] Code: Unable to access instruction at 0xffffffffffffffec.
> [   46.754939] ---[ end trace 0000000000000000 ]---
> [   46.755131] note: perf-exec[107] exited with irqs disabled
> [   46.755546] note: perf-exec[107] exited with preempt_count 4
>
> This happens because in the legacy case the ctr_get_width function was no=
t
> defined, but it is used in arch_perf_update_userpage.
>
> Also remove extra check in riscv_pmu_ctr_get_width_mask
>
> Fixes: cc4c07c89aad ("drivers: perf: Implement perf event mmap support in=
 the SBI backend")
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
> ---
>  drivers/perf/riscv_pmu.c        | 18 +++++-------------
>  drivers/perf/riscv_pmu_legacy.c |  8 +++++++-
>  2 files changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index 0dda70e1ef90..c78a6fd6c57f 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -150,19 +150,11 @@ u64 riscv_pmu_ctr_get_width_mask(struct perf_event =
*event)
>         struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
>         struct hw_perf_event *hwc =3D &event->hw;
>
> -       if (!rvpmu->ctr_get_width)
> -       /**
> -        * If the pmu driver doesn't support counter width, set it to def=
ault
> -        * maximum allowed by the specification.
> -        */
> -               cwidth =3D 63;
> -       else {
> -               if (hwc->idx =3D=3D -1)
> -                       /* Handle init case where idx is not initialized =
yet */
> -                       cwidth =3D rvpmu->ctr_get_width(0);
> -               else
> -                       cwidth =3D rvpmu->ctr_get_width(hwc->idx);
> -       }
> +       if (hwc->idx =3D=3D -1)
> +               /* Handle init case where idx is not initialized yet */
> +               cwidth =3D rvpmu->ctr_get_width(0);
> +       else
> +               cwidth =3D rvpmu->ctr_get_width(hwc->idx);
>
>         return GENMASK_ULL(cwidth, 0);
>  }
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_leg=
acy.c
> index 79fdd667922e..a179ed6ac980 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -37,6 +37,12 @@ static int pmu_legacy_event_map(struct perf_event *eve=
nt, u64 *config)
>         return pmu_legacy_ctr_get_idx(event);
>  }
>
> +/* cycle & instret are always 64 bit, one bit less according to SBI spec=
 */
> +static int pmu_legacy_ctr_get_width(int idx)
> +{
> +       return 63;
> +}
> +
>  static u64 pmu_legacy_read_ctr(struct perf_event *event)
>  {
>         struct hw_perf_event *hwc =3D &event->hw;
> @@ -111,7 +117,7 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>         pmu->ctr_stop =3D NULL;
>         pmu->event_map =3D pmu_legacy_event_map;
>         pmu->ctr_get_idx =3D pmu_legacy_ctr_get_idx;
> -       pmu->ctr_get_width =3D NULL;
> +       pmu->ctr_get_width =3D pmu_legacy_ctr_get_width;
>         pmu->ctr_clear_idx =3D NULL;
>         pmu->ctr_read =3D pmu_legacy_read_ctr;
>         pmu->event_mapped =3D pmu_legacy_event_mapped;
> --
> 2.34.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
