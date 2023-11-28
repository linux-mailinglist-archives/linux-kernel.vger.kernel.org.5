Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2F37FB361
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343925AbjK1H5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjK1H5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:57:12 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED5098
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:57:18 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bbb79f97cso256320e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1701158236; x=1701763036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFL2mcWcdAVs6BZTrdM5FwmZN6clmYE/rKpAVrYnpAo=;
        b=HpWEpt0mCzEVm79xcQ1D6xQ0tpYWQr6QDj7VZGXJ83UMuhNYc/zFchI7EsNBFHzsFy
         vcHSo3VXSeSKDqr0Q1Pq4dU2NQ6QQ8+sTU0ycwa8Ox41G9lYNb8roSHpDPx6jyJ6K3B4
         D/Q2f0ClG8YC0JxjwnP2rnpSXfuHrW1O2N2nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158236; x=1701763036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFL2mcWcdAVs6BZTrdM5FwmZN6clmYE/rKpAVrYnpAo=;
        b=T81tQLTqzHfWMCXTox+uPAjSTMoyxKHKCJFlJL3AV0hllsczojZYMxfSYIES9/U5Yc
         BBy1xk7MwDCoj+2zCpboq/eo4MBWzjG2u3q+VtxLUNQ/ABzhv9gxXKKp19UUpK/NFjXT
         7v1sk5ZRw5ogu/hz5WNZscB6F98rT4fYCjPFlGm6LEv7kmPWAU2WkVr/eo1N8iacTm0L
         tGBzlXN+SvdrF68aOhbZjZzm9s6nRn7dsxQXBvkuC2NCsf+zx65CRujS5n0Xxur/jAAE
         PvBVtAULmRP87jkd2A6Ok09NC3mcRUo4KWGbZJO/xen8eAownpnvQArp5NM0QNrA+yik
         bsEQ==
X-Gm-Message-State: AOJu0Yx9egdovobXCSALt2gJ4FyonNS1yLTPajjYsnS6CJvKl5n6iQW7
        Y3I59Ii5n7EpTDSo5fMEQuStiGp1qq5RsiEtVIwu
X-Google-Smtp-Source: AGHT+IF0YE9iFAZnfnriN3ge4xn3oGGu5vb7Hm91JHy0EeU977WhV2dstXisf+BZATo1haW3DuOREq3VqihD6IYpXcg=
X-Received: by 2002:a05:6512:1251:b0:50a:aa64:a6a9 with SMTP id
 fb17-20020a056512125100b0050aaa64a6a9mr3901542lfb.16.1701158236161; Mon, 27
 Nov 2023 23:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20231127095403.272424-1-vadim.shakirov@syntacore.com>
In-Reply-To: <20231127095403.272424-1-vadim.shakirov@syntacore.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 27 Nov 2023 23:57:04 -0800
Message-ID: <CAOnJCUKjruQRbZXCHx+fNS34dvfNXDozWEm=Yr_KnLKOYc3OgQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: perf: ctr_get_width function for legacy is not defined
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 1:54=E2=80=AFAM Vadim Shakirov
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
> Fixes: cc4c07c89aad ("drivers: perf: Implement perf event mmap support in=
 the SBI backend")
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>

Legacy PMU shouldn't enable perf sampling in the first place. We need
to set the capabilities accordingly.

@@ -111,14 +116,17 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
        pmu->ctr_stop =3D NULL;
        pmu->event_map =3D pmu_legacy_event_map;
        pmu->ctr_get_idx =3D pmu_legacy_ctr_get_idx;
        pmu->ctr_get_width =3D NULL;
        pmu->ctr_clear_idx =3D NULL;
        pmu->ctr_read =3D pmu_legacy_read_ctr;
        pmu->event_mapped =3D pmu_legacy_event_mapped;
        pmu->event_unmapped =3D pmu_legacy_event_unmapped;
        pmu->csr_index =3D pmu_legacy_csr_index;
 +     pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_INTERRUPT;
+      pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_EXCLUDE;
        perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
 }



> ---
>  drivers/perf/riscv_pmu_legacy.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
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

Having said that, there is no harm in defining the width function for
legacy PMU.
The common riscv_pmu.c fixes the counter width to 63 if ctr_get_width
is not defined. We may be to get rid of that
as both drivers will have a valid function pointer.

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


--=20
Regards,
Atish
