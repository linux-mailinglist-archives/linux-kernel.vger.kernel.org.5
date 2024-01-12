Return-Path: <linux-kernel+bounces-25028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207A382C651
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825AE1F22E64
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701BF16418;
	Fri, 12 Jan 2024 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="Fwq2AjHI"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36816168BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cd8b661cb8so20997321fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1705090655; x=1705695455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdPl62Kj42qLAAkF8TWMuSZ2lBBKNdyCgrrnQIbbjq8=;
        b=Fwq2AjHIyFpG2IaJ27tSwuuZ/xbbtesbwdSGnd6CwtobljvZ7E0DFwPgUTdmYoexcY
         Z+ec2BIYdtWmKXmDBYsEK641IaYWtWjiv0XK0gbiBAqk6yFbPGB/JmHpx3v8nGVx/nFl
         7hS5P68rLMCdpLUCIAQ4QOp3xnKdIG8kL85Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705090655; x=1705695455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdPl62Kj42qLAAkF8TWMuSZ2lBBKNdyCgrrnQIbbjq8=;
        b=fGE7B2JkGH94j1o2NBFsamcRovIGMU+JaObtn9SxHrRRnNR36NDl3H74mS77jkCMFL
         xeYv+i9/WLhiK0TBYjrfGRBR+e1yRQr5RtBQQnLDRtDYW+5f6/+7/4A9pb0HP/0TgQRJ
         SQO1XB6wVeduegJcqTAgaPLmx/vs9PGuOj4DRGDYcsXPyjrLBy687ZyE7PBqyEAr0QEY
         oM8khzjXfwN6WdE4KQKHxS/eScxx91RVuP46CNcag7BFMgGQtvClhcPmpkGz56iOp/qK
         dvJJUqWHc1agNtqZzpt40PrcS1Cb0Cwp8URdonXKyiaj8iFbeSThENbqtaDMy9Q6NXRm
         bUgQ==
X-Gm-Message-State: AOJu0YyYcIqBJwKTHn/HHOSqz0Xr/Tz24gzfH5DK1YK1JhuNOnc/veu3
	gReEfMlFsb4QvoIoJP5TWn+z/VleTDNDo7dzf9HMsNeiFqCr
X-Google-Smtp-Source: AGHT+IH9QK11T/Suh1c1OYYHTXmVh+no7GMm/AzsKYmS9El+CD8gOLnlidxHzce7VuVJ4ZtS2BQI67YGB4XrpVAbABo=
X-Received: by 2002:a2e:740d:0:b0:2cd:900c:d5ff with SMTP id
 p13-20020a2e740d000000b002cd900cd5ffmr665638ljc.0.1705090654991; Fri, 12 Jan
 2024 12:17:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110073917.2398826-1-peterlin@andestech.com> <20240110073917.2398826-7-peterlin@andestech.com>
In-Reply-To: <20240110073917.2398826-7-peterlin@andestech.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Fri, 12 Jan 2024 12:17:23 -0800
Message-ID: <CAOnJCUJuDk6euX_XKiQ3H=TSGU02fgGgqSq-WycDwurq1XkDHw@mail.gmail.com>
Subject: Re: [PATCH v7 06/16] perf: RISC-V: Eliminate redundant interrupt
 enable/disable operations
To: Yu Chien Peter Lin <peterlin@andestech.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	alexander.shishkin@linux.intel.com, andre.przywara@arm.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, conor+dt@kernel.org, 
	conor.dooley@microchip.com, conor@kernel.org, devicetree@vger.kernel.org, 
	dminus@andestech.com, evan@rivosinc.com, geert+renesas@glider.be, 
	guoren@kernel.org, heiko@sntech.de, irogers@google.com, 
	jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com, 
	mark.rutland@arm.com, mingo@redhat.com, n.shubin@yadro.com, 
	namhyung@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	peterz@infradead.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org, 
	sunilvl@ventanamicro.com, tglx@linutronix.de, tim609@andestech.com, 
	uwu@icenowy.me, wens@csie.org, will@kernel.org, ycliang@andestech.com, 
	inochiama@outlook.com, chao.wei@sophgo.com, unicorn_wang@outlook.com, 
	wefu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 11:40=E2=80=AFPM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> The interrupt enable/disable operations are already performed by the
> IRQ chip functions riscv_intc_irq_unmask()/riscv_intc_irq_mask() during
> enable_percpu_irq()/disable_percpu_irq(). It can be done only once.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
> This patch allows us to drop unnecessary ALT_SBI_PMU_OVF_{DISABLE,ENABLE}
> in the initial PATCH3 [1].
>
> [1] https://patchwork.kernel.org/project/linux-riscv/patch/20230907021635=
1002738-4-peterlin@andestech.com/
>
> Changes v1 -> v2:
>   - New patch
> Changes v2 -> v3:
>   - No change
> Changes v3 -> v4:
>   - No change
> Changes v4 -> v5:
>   - No change
> Changes v5 -> v6:
>   - No change
> Changes v6 -> v7:
>   - No change
> ---
>  drivers/perf/riscv_pmu_sbi.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 16acd4dcdb96..2edbc37abadf 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -781,7 +781,6 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, str=
uct hlist_node *node)
>         if (riscv_pmu_use_irq) {
>                 cpu_hw_evt->irq =3D riscv_pmu_irq;
>                 csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
> -               csr_set(CSR_IE, BIT(riscv_pmu_irq_num));
>                 enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>         }
>
> @@ -792,7 +791,6 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct=
 hlist_node *node)
>  {
>         if (riscv_pmu_use_irq) {
>                 disable_percpu_irq(riscv_pmu_irq);
> -               csr_clear(CSR_IE, BIT(riscv_pmu_irq_num));
>         }
>
>         /* Disable all counters access for user mode now */
> --
> 2.34.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish

