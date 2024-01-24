Return-Path: <linux-kernel+bounces-36756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8396F83A619
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BECAB2B361
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3E182AB;
	Wed, 24 Jan 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT+xUCo8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371718045;
	Wed, 24 Jan 2024 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090192; cv=none; b=Ha6ji6hL2K3zt71GsD6WHdnYRMON7uma8Sr3L8LwJ0r/BAh/wyNxoX2IYF7krxnx8wqYHEOJxcH2Nhx/biOquEsUihFBYJgsTqXP0Hf3b5dMCpLkQe/Bv3Vkgv243J5bkyJtmBceR8VODp0Wk24y9bToTXfGKj/kqmGevomZ9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090192; c=relaxed/simple;
	bh=vQ+I9Ge+8bH1NA9WH7CqoqMtBiQEOSibipcnd/i3Qso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e57gkUQuflVtHQWgUcEsgXtezwQ6O2pxGFRnXtGtB/KLZ7soRBzwK95gh8musC8Z5NqtITVUi3wX7UTk3J/g/oZtEK9cobjdIPl2K0ZR2fRyJ+sPTdejyWuXgU7mA251YDbkpbRRARxU4JWo3APjDoEo+PC9isuYtdH4k1fWuuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT+xUCo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8244C433B1;
	Wed, 24 Jan 2024 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706090191;
	bh=vQ+I9Ge+8bH1NA9WH7CqoqMtBiQEOSibipcnd/i3Qso=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qT+xUCo8olWgqunC2fwyMUCPxe71wcF6swjsgLnths5AtynaNSt3Q7VPVIfo9Ra6d
	 gq7TwCNm5UF54c4Tw7Ub8jZG5zfrunm9o5YMOwqtp3VP2MJQfNWGXnAL9u0/ooelN/
	 d18topr4lldBvI9B2wji0KkF8wg1y1SLQOVq9gnr0it4Ef8bbDoW3JnUMNpmmyYUfY
	 M5SvglWKSpjO/tvPLOUrrCRGH/komGq7p93CDurqd/r2osBLaMpNPPojQPg0ZoNEce
	 e7btvPfKlmErrm6soS8BYAL8vRw8g4esrskw+sYb1mp159siTv74pLObiR24OsJ9aY
	 83BZa90fM48cg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5100893015fso1880330e87.1;
        Wed, 24 Jan 2024 01:56:31 -0800 (PST)
X-Gm-Message-State: AOJu0YwGNGM53ihFyQhDCHdc/GjC8vxhpe95j4Y7uWGje9w20uxZY3uP
	1RsR3qu5dcxmUK1v37HWK3OJcL9YR4hQhgvOilMxkfwGt8mYh/Zv3Q+OlA1JA5HQav0dZ1cxDUD
	7Oh5OJi1P/S5uC8pjNiQ7YAfluzc=
X-Google-Smtp-Source: AGHT+IE3rPZK17ixDxsL+YcPJ/Q2xlEvwkcSUy8VmnbYNcPTU5xivtsjD2pYBrLIsytxrVaBRIobhJSEJqchFBAWaX0=
X-Received: by 2002:ac2:5a06:0:b0:510:ca2:6b69 with SMTP id
 q6-20020ac25a06000000b005100ca26b69mr491573lfn.99.1706090189885; Wed, 24 Jan
 2024 01:56:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118121542.748351-1-maobibo@loongson.cn> <20240118121542.748351-3-maobibo@loongson.cn>
In-Reply-To: <20240118121542.748351-3-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 24 Jan 2024 17:56:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H45A4m-imDh8UZqXJ3WXduMyubbd1ze-EgZtqqbfjHt1g@mail.gmail.com>
Message-ID: <CAAhV-H45A4m-imDh8UZqXJ3WXduMyubbd1ze-EgZtqqbfjHt1g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] irqchip/loongson-eiointc: Refine irq affinity
 setting during resume
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, lvjianmin@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I can give an Acked-by if these lines are also removed in our internal repo=
.

Huacai

On Thu, Jan 18, 2024 at 8:15=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> During suspend and resume, CPUs except CPU0 are hot-unpluged and IRQs
> are migrated to CPU0. So it is not necessary to restore irq affinity for
> eiointc irq controller when system resumes. This patch removes the piece
> of code about irq affinity restoring in function eiointc_resume.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-eiointc.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq=
-loongson-eiointc.c
> index 6143adb1b73b..86f4faad0695 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -315,23 +315,7 @@ static int eiointc_suspend(void)
>
>  static void eiointc_resume(void)
>  {
> -       int i, j;
> -       struct irq_desc *desc;
> -       struct irq_data *irq_data;
> -
>         eiointc_router_init(0);
> -
> -       for (i =3D 0; i < nr_pics; i++) {
> -               for (j =3D 0; j < eiointc_priv[0]->vec_count; j++) {
> -                       desc =3D irq_resolve_mapping(eiointc_priv[i]->eio=
intc_domain, j);
> -                       if (desc && desc->handle_irq && desc->handle_irq =
!=3D handle_bad_irq) {
> -                               raw_spin_lock(&desc->lock);
> -                               irq_data =3D irq_domain_get_irq_data(eioi=
ntc_priv[i]->eiointc_domain, irq_desc_get_irq(desc));
> -                               eiointc_set_irq_affinity(irq_data, irq_da=
ta->common->affinity, 0);
> -                               raw_spin_unlock(&desc->lock);
> -                       }
> -               }
> -       }
>  }
>
>  static struct syscore_ops eiointc_syscore_ops =3D {
> --
> 2.39.3
>

