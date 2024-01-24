Return-Path: <linux-kernel+bounces-36745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0071F83A5EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314C91C21246
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE01862B;
	Wed, 24 Jan 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNcizLo4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D7218622;
	Wed, 24 Jan 2024 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089896; cv=none; b=mDpdZ3ek5QdQMelxrSVgxFNQsctJhmoDftPx/CUMDVwgaeyhpsZlCb9QfmjD03aicKHv8yIrhFQqo0bB5q3FByJ6SnCiIYSCA8Be+It/Zsp1s6+yRc1Lx96inwcdmYqg6iWP7wM/g7KlIT4L7sJdXmxPBZBvvE+yog7xtcFfUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089896; c=relaxed/simple;
	bh=7M8cHvNbWMGRFnzMcdPpfzTmbr50voDcLVGu7wSwkPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqSEo6CqjTLtHslFLWiAqFx1c6+ZSuD6ziavZZ4omXUToIFxX3PM5VQJthjoFnvGgMWZ6yzY1FzZFVMIYGwXDWKKlAmUVUndpaZv6qMBoyTMIGnJUHJbQ6YqqGFYmV0L9Xl6tMLl/uUq0xDsJP2plKJP/U1a0Re9UebTznUPeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNcizLo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5611CC433A6;
	Wed, 24 Jan 2024 09:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706089896;
	bh=7M8cHvNbWMGRFnzMcdPpfzTmbr50voDcLVGu7wSwkPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hNcizLo4FfjSKMfh7TZCZZmCjNiHMawDalvAj6G0J8j98C7bpYilNxGrWZwQFlAVc
	 GiPWZxNCkPKNcpCtmAscVfnO1UuJsmyb9nzhpql0j7IQzHxZn4cn+oCwYWdTPDtMmL
	 g3+Oa1YQeEJUReF6VY8MPUYPEGJOjJ+VCvExrVIQmnixCHJxwgctmGpfOxVyKUwT3f
	 gK/xVJfgZyZWhrBtIUYVghknYuWyZDy3Y/Zf+D0NRZ6RbePyGgdVzXqD2SIWpFgvbk
	 3/GbpxhrswUuSoQPPRWfl0vF1cnjEn8Yg4iINnDlHDzrLtpjZhEm8H2VeMkJTrQDDI
	 4NVbfr34g5/Zw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so3278269a12.1;
        Wed, 24 Jan 2024 01:51:36 -0800 (PST)
X-Gm-Message-State: AOJu0Yyzq9ofMRl1JIQnV8Jbj0wSQhf98Wjq4Sv9duDhYxj+BFK5aj92
	RsIQXFCjKAGj6qDwBV0s0WgZyyMGkHtkgVx8rWn++xa+tPLKFifUkdCNdRtfqlrmvxtglqDN1La
	Sj0EkoER9EhApR/y8KgWc8tnSVJc=
X-Google-Smtp-Source: AGHT+IFGif40CQVv4h18+RjuN8f1p1H8jT6js87HIIXt2Ebh5WJRKD28KlaWbjfcVNgAh9UTwQ4hEc0OT/fiPHc+j9E=
X-Received: by 2002:a05:6402:3507:b0:559:6c9e:96fe with SMTP id
 b7-20020a056402350700b005596c9e96femr1835986edd.37.1706089894679; Wed, 24 Jan
 2024 01:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118121542.748351-1-maobibo@loongson.cn> <20240118121542.748351-2-maobibo@loongson.cn>
In-Reply-To: <20240118121542.748351-2-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 24 Jan 2024 17:51:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5-da4AvtgHu1Hv0sbXddab6Mqg6eCkwJzr32Xi4A97yQ@mail.gmail.com>
Message-ID: <CAAhV-H5-da4AvtgHu1Hv0sbXddab6Mqg6eCkwJzr32Xi4A97yQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] irqchip/loongson-eiointc: Skip handling if there
 is no pending irq
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, lvjianmin@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Thu, Jan 18, 2024 at 8:15=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> There is one simple optimization in the interrupt dispatch function
> eiointc_irq_dispatch. There are 256 IRQs supported for eiointc, eiointc
> irq handler reads the bitmap and find pending irqs when irq happens.
> So there are four times of consecutive iocsr_read64 operations for the
> total 256 bits to find all pending irqs. If the pending bitmap is zero,
> it means that there is no pending irq for the this irq bitmap range,
> we can skip handling to avoid some useless operations such as clearing
> hw ISR.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-eiointc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq=
-loongson-eiointc.c
> index 1623cd779175..6143adb1b73b 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -198,6 +198,17 @@ static void eiointc_irq_dispatch(struct irq_desc *de=
sc)
>
>         for (i =3D 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG;=
 i++) {
>                 pending =3D iocsr_read64(EIOINTC_REG_ISR + (i << 3));
> +
> +               /*
> +                * Get pending eiointc irq from bitmap status, there are =
4 times
> +                * consecutive iocsr_read64 operations for 256 IRQs.
> +                *
> +                * Skip handling if pending bitmap is zero
This driver is shared by Loongson-2 and Loongson-3 series, for
Loongson-2K0500 there is only 128 IRQs, so I suggest only keep the
last line "Skip handling if current pending bitmap is zero" is enough.

Huacai

> +                */
> +               if (!pending)
> +                       continue;
> +
> +               /* Clear the IRQs */
>                 iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
>                 while (pending) {
>                         int bit =3D __ffs(pending);
> --
> 2.39.3
>

