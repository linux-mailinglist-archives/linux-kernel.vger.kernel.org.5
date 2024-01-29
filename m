Return-Path: <linux-kernel+bounces-42687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6AD840501
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A631F23224
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ADA60860;
	Mon, 29 Jan 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWVExexi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14060869;
	Mon, 29 Jan 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531288; cv=none; b=Q2M2vQdUbKKBOEjubxBhaSS13oWEntG7tG/CxNdiq7e07G8vNsHNWSNM6nNDfDHNMDZ/13S2MR3R1ui6ibmkMyzRakr45iRL2XkUFTeVsjN8upPouxGprNnw1gMOEZfqvx4HuPo0ZAqaDqs7F1ax+phZOCCsyWcElQiJQ6tfsN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531288; c=relaxed/simple;
	bh=MpQ1lW4yakQfV+Kx9OI2bXUFeKAATtST58XhOAvkQ9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPDhhYMULonGtusFuMc5bc8SV86icAPhkRmQ1d8oW65k8LHUa3dym3tlJtLjJe7vpZVsgt7xe7FtsILsRbXXl8ohsqEfBrtHFB3iCG+OU4qeAvKNcBD7aWnLgyC3erjLxCoxs8eZMNwimoElUKwoEF8PUK/oYw54wRTw9KH6+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWVExexi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59849C433C7;
	Mon, 29 Jan 2024 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706531288;
	bh=MpQ1lW4yakQfV+Kx9OI2bXUFeKAATtST58XhOAvkQ9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AWVExexigNVbmJDVoow/JF1nxxjEDRcZtmteL1DmwEWe1zdNIc+ZaFh4+9A/38BY5
	 wAmC3NRz3e9WTTO2dpOKVCxusYnn/9Pu0zovoPwDzP6x6EGoySUU2ndYRBw9nqdSoG
	 mYkGFHtbCCVTLUAWDcbVvEqqfmystTO+SMsvkyBzc6YdKzRE20J6dkP0wgcEoDeuFA
	 pneuk7HWfhsOlDYQ1NB5r3WuW3InCDrZb/DUDcGa/nVXC8g7CLH137TKymUSjNb1lk
	 hXyg4kxDFuwoQSj6A9Ahcg+mIDHX3c8rWjYB/QJp3nt0acst4jnxqrt8ej6owtu1vJ
	 zD4vpdGLw84sA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so2502193a12.1;
        Mon, 29 Jan 2024 04:28:08 -0800 (PST)
X-Gm-Message-State: AOJu0Yxev5jG4i7kUGqi1P+yhDgqaJRAam3hX0MbjPWpKAK9jok7QK9Q
	y5Qp3vwmvv2Kql444hBr2Nzy4dkqt80ikB7x9LG5EZEbkwPAVur5Pg1A3+J8QhEdUPr+b2cUjdf
	UjWpkHaP1Id0CoLimxw63Ci/8hkk=
X-Google-Smtp-Source: AGHT+IH2Ut9DECLjhp2VufMBUkzdiIibV5WT+fSEKMnQ70kRxlTuU/kEg9bgSd7CeLa7ZHJZ6f7AmoqqH5AssTGd3Dk=
X-Received: by 2002:aa7:cfc1:0:b0:55e:ea24:8fbe with SMTP id
 r1-20020aa7cfc1000000b0055eea248fbemr2620334edy.26.1706531286683; Mon, 29 Jan
 2024 04:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125113623.2043061-1-maobibo@loongson.cn> <20240125113623.2043061-3-maobibo@loongson.cn>
In-Reply-To: <20240125113623.2043061-3-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 29 Jan 2024 20:27:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7wBBx-8fVfRoujMUJuLbQWW2oKDbW6A52G2S_pqmTK6A@mail.gmail.com>
Message-ID: <CAAhV-H7wBBx-8fVfRoujMUJuLbQWW2oKDbW6A52G2S_pqmTK6A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] irqchip/loongson-eiointc: Skip handling if there
 is no pending irq
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, lvjianmin@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

As commented in another patch, you can use eiointc_irq_dispatch(),
iocsr_read64() to describe functions, and it is better to use
Loongson-3A5000, Loongson-2K2000, Loongson-2K0500 rather than 3A5000,
2K2000, 2K0500. Besides, please always use IRQs rather than IRQS.

With these modifications,

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Thu, Jan 25, 2024 at 7:36=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> It is one simple optimization in the interrupt dispatch function
> eiointc_irq_dispatch. There are 256 IRQs supported for eiointc on
> 3A5000 and 2K2000 platform, 128 IRQS on 2K0500 platform, eiointc irq
> handler reads the bitmap and find pending irqs when irq happens. So
> there are several consecutive iocsr_read64 operations for the all
> bits to find all pending irqs. If the pending bitmap is zero, it
> means that there is no pending irq for the this irq bitmap range,
> we can skip handling to avoid some useless operations such as
> clearing hw ISR.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-eiointc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq=
-loongson-eiointc.c
> index b3736bdd4b9f..6a71a8c29ac7 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -198,6 +198,12 @@ static void eiointc_irq_dispatch(struct irq_desc *de=
sc)
>
>         for (i =3D 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG;=
 i++) {
>                 pending =3D iocsr_read64(EIOINTC_REG_ISR + (i << 3));
> +
> +               /* Skip handling if pending bitmap is zero */
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

