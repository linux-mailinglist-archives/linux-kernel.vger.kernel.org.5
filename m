Return-Path: <linux-kernel+bounces-9355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E0381C47A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C036D1F257F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1E0539A;
	Fri, 22 Dec 2023 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzrPEMDj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDFD259D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70495C433CC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703221158;
	bh=McigOYJGTbTlBgkW/13sW5rGuU5A3iVHhSZKdRel1E4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CzrPEMDjXGiV44R3oMrkPdZK76g6UVyVWBwBl2kmKLh3r/dQd78Prb+sp24b+mT9Q
	 gSc6UqX4j4K303lTo5tLXPQeEDYcZhFy+aK8ogr9Wa4rhCERW8tXYZbuKMIlP7mejL
	 l5qyNgTaNt03r22Vy+Yd8J66DZwXl7T9vSS5SlNlq+RQlfmGvZ8DJt+JIGn2KlEgDa
	 TLRHOXzEu+XrGccTJ5xAZqDJIXDZApa3aJ63CyVBUhegj7tFcnF9+wWCuDvbtyhOiQ
	 EhCnq2HMAwui5ZKxw8g8aY7EORtmaTBZI+/E+hys0YR/M+/NJBk6vHiLuIAr7SNby7
	 Fkf9S6wvLgMhA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2696852965so427154366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:59:18 -0800 (PST)
X-Gm-Message-State: AOJu0Ywct840nmYdhltdmB2AzE+5GOHxKQbLgJjxx0i6XVpx0mfHAFID
	i7z1vP4AKoIVr1myEgt6yi4/iwi11WUVqJtSol8=
X-Google-Smtp-Source: AGHT+IG6DCrn118fcfKIzPkDW/GHZ+Xwvym3jTMtc6WjZreQi5yWcKV08KOk10IicouK84sHBYlj7omosnN5EE1NYAs=
X-Received: by 2002:a17:906:6b8c:b0:a26:6d82:3261 with SMTP id
 l12-20020a1709066b8c00b00a266d823261mr1603737ejr.38.1703221156693; Thu, 21
 Dec 2023 20:59:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222044554.25656-1-rdunlap@infradead.org>
In-Reply-To: <20231222044554.25656-1-rdunlap@infradead.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 22 Dec 2023 12:59:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6pXSuj+bpf=skMYLQh8znboT6YxAA4UXokwm60-aXa8Q@mail.gmail.com>
Message-ID: <CAAhV-H6pXSuj+bpf=skMYLQh8znboT6YxAA4UXokwm60-aXa8Q@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: signal.c: add header file to fix build error
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, 
	loongarch@lists.linux.dev, Kent Overstreet <kent.overstreet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Randy,

I cannot reproduce it with the default config file.

Huacai

On Fri, Dec 22, 2023 at 12:46=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> loongarch's signal.c uses rseq_signal_deliver() so it should
> pull in the appropriate header to prevent a build error:
>
> ../arch/loongarch/kernel/signal.c: In function 'handle_signal':
> ../arch/loongarch/kernel/signal.c:1034:9: error: implicit declaration of =
function 'rseq_signal_deliver' [-Werror=3Dimplicit-function-declaration]
>  1034 |         rseq_signal_deliver(ksig, regs);
>       |         ^~~~~~~~~~~~~~~~~~~
>
> Fixes: b74baf4ad05b ("LoongArch: Add signal handling support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: loongarch@lists.linux.dev
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> ---
> v2: repair Cc: list
>
>  arch/loongarch/kernel/signal.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
> --- a/arch/loongarch/kernel/signal.c
> +++ b/arch/loongarch/kernel/signal.c
> @@ -15,6 +15,7 @@
>  #include <linux/context_tracking.h>
>  #include <linux/entry-common.h>
>  #include <linux/irqflags.h>
> +#include <linux/rseq.h>
>  #include <linux/sched.h>
>  #include <linux/mm.h>
>  #include <linux/personality.h>

