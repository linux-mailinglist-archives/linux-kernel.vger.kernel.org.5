Return-Path: <linux-kernel+bounces-72169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6ED85B045
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E816F1F2269C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC13411CA1;
	Tue, 20 Feb 2024 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azThkOh+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D3FC19;
	Tue, 20 Feb 2024 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391604; cv=none; b=ZYJrP3ar+EtMBUFdEYywQA9nsZ9r0n7IkeBVfXEeS6tJmcWvKmVit9JbXuNkrsaEsDiK2VOutOsXKizpdUvyrIynk3C3kv32SotqaU8/leTwHmoJSnW2rjuhrARbj+Jp74PXYt8G4qymx9Nyge1unRvrhPE7M/JCwWow3E8GoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391604; c=relaxed/simple;
	bh=1OOQqs9gGIXShrtHtgrk0GR+vwo9fMIkwu5VM+GuMys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvqYTutO8m6iiw5fkS9IoJWmcQYM3A0ZZaqItCm/qvvXIdePvKSRYykzS+5KCLIRcCcB5Q0a+OKmMQf8jQz78fLMAn+3eXVpjF5nfng8iJxplJLjfYR+Jo4Xq1pUgTElilEMaQb89rSp9vvy2pc3JB5p5F4xneJPElZ1EjsAijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azThkOh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9689FC433F1;
	Tue, 20 Feb 2024 01:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708391603;
	bh=1OOQqs9gGIXShrtHtgrk0GR+vwo9fMIkwu5VM+GuMys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=azThkOh+4ID7iBbpzd1V5Wp4tUfENPWQ2pzbvUXmD8WiMz6wXRp/BkhVpv2wuk0m7
	 +m4cD03Io2mm0+2rDv588oA9Rs5FwcHpkDgz2VQMRm77eNkRRy3A3PhoJP+lOkGTWl
	 /BAZXyb9we+C76KKVBOakfjKpXBYRfRLBp3SMyExBTiNGqY3P5z39qfLwb2kwPqxew
	 9/j/r2zuA2OjAd1hBR1teJaoYE8xLDT3XNskHnmVyN0GdfimHXal/1R12o5w4x0to2
	 qApMHYjeGuLoefTwvV2YmWhejJCe6uU1VWDkDge5WgiAzXMU9uBbYyxnX2UCdRtmki
	 Ualrcw7+6BqmQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a293f2280c7so687078666b.1;
        Mon, 19 Feb 2024 17:13:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzpfqTkrXytClPZmK830GYjaMYpHV7JzdyXXdXZdYYYDt4HX6W7DB9aUNRJFZrIxrE9/hr/rdLdJ4PUc5X+iVxTmlrkUO39qii5g==
X-Gm-Message-State: AOJu0YzCDbbnWuiPVhJnEGMoXyHkO/ej45IOraLKFqfN8wVAqs1J3rnQ
	3jJ5B3vwHguXnJaLe9PMSE0izjyg2IF1CHhMRjPf0hHwkPZDcOr/WsEbQhE/JunYPOBua1yk0hO
	8xI6xeoXDZpKefpYLpOhK2EjGWjs=
X-Google-Smtp-Source: AGHT+IE7PxUhN1XOXgivV1Cc2EzKxF/mEBfoR8lYdOioedLl7MprCPMe/OT1IaKwNhEcdnS3m5Y3bH0S5S8Q0MuR4j4=
X-Received: by 2002:a17:906:f258:b0:a3e:d20a:f1d9 with SMTP id
 gy24-20020a170906f25800b00a3ed20af1d9mr1620905ejb.11.1708391602008; Mon, 19
 Feb 2024 17:13:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219153939.75719-1-anna-maria@linutronix.de> <20240219153939.75719-11-anna-maria@linutronix.de>
In-Reply-To: <20240219153939.75719-11-anna-maria@linutronix.de>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 20 Feb 2024 09:13:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRtNJUw6rr0w2xR5gNMw6ab8diTq-h-bX8HcaX5qbmoVQ@mail.gmail.com>
Message-ID: <CAJF2gTRtNJUw6rr0w2xR5gNMw6ab8diTq-h-bX8HcaX5qbmoVQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] csky/vdso: Use generic union vdso_data_store
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 11:40=E2=80=AFPM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> There is already a generic union definition for vdso_data_store in vdso
> datapage header.
>
> Use this definition to prevent code duplication.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> ---
>  arch/csky/kernel/vdso.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
> index e74a2504d331..2ca886e4a458 100644
> --- a/arch/csky/kernel/vdso.c
> +++ b/arch/csky/kernel/vdso.c
> @@ -15,14 +15,8 @@ extern char vdso_start[], vdso_end[];
>  static unsigned int vdso_pages;
>  static struct page **vdso_pagelist;
>
> -/*
> - * The vDSO data page.
> - */
> -static union {
> -       struct vdso_data        data;
> -       u8                      page[PAGE_SIZE];
> -} vdso_data_store __page_aligned_data;
> -struct vdso_data *vdso_data =3D &vdso_data_store.data;
> +static union vdso_data_store vdso_data_store __page_aligned_data;
> +struct vdso_data *vdso_data =3D vdso_data_store.data;
>
>  static int __init vdso_init(void)
>  {
> --
> 2.39.2
>

Acked-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

