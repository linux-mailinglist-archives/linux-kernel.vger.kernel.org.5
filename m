Return-Path: <linux-kernel+bounces-42682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1698404E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C7E1F2202D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F211D604D1;
	Mon, 29 Jan 2024 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ5Q3Xdv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0FA5F565;
	Mon, 29 Jan 2024 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531009; cv=none; b=PZbiPNeIah4ZbPCKfgDoi9BIhbMsn8/eMLRbGvtmBdEEw064ZtLogdmtbE0eKugbXmB5Kz1CzI/JjHih5KKasqovMEwjjpzd0oHWuWSpWx1CPRk2uPEHrdpp1E+lA4J4XvtJjg/G22N/NLW0oUR04AosVRk/v2ycU0HsvrImhKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531009; c=relaxed/simple;
	bh=cfyTA0f7yX/vB8d5Cuti9FF050a8C9p/xz3ob/RUpSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWsOs5vA8pn2ZBTtNCwr+J/eQ+3Yu7kk75ylAEe6Gqxf85Fe+uqwDW5OeM8yXx601U2JDL4Wina3kr6kUeLJVIFSRK609RG2DRxrF/RDrEJ7dmGBFQFp0vda9PAZj6my90P1oAzQoq/ASCD8eSSBq83+kZUVPJoOQm76b4lANm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ5Q3Xdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD717C433C7;
	Mon, 29 Jan 2024 12:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706531008;
	bh=cfyTA0f7yX/vB8d5Cuti9FF050a8C9p/xz3ob/RUpSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aZ5Q3XdvDctQAUKkj4OwwI37rtGVYocee4CnzJmabz+Sin9GHxxCQqImsMJFBAV5H
	 tvrRoxht1MvYAi8iY/is85tePxEsL+hZx0n/maInrVIjYsK4QF0wouOGol/wGP7Boz
	 xTJAIRSqIZzHRppUff4lhs761ZIJGg9Le6eNZVFYxM65+TWZ+I2Jzimd9Hrsw19qUd
	 NI0DJ7a9Dmaro693iOV5zbiLSchKBMfvQ26PMmBnk1HyFH84AyXkH/fih4MYYqePgo
	 zs9ai2dN3PZUvQ9Zo5Ea52hWDBytFpDf+8yQ2orX+Yf4JCEKYtvqSP8aEwTg7EN+Gi
	 Kwp+l+3VumWMw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so2414441a12.1;
        Mon, 29 Jan 2024 04:23:28 -0800 (PST)
X-Gm-Message-State: AOJu0Ywe6RyOubKlFOkyOC+F7YPaL8c7m83753JZlh5+wg0VKVnFsdDf
	Tk4/yiYJpShCRVPVObOEKldcQFTKcA6MXcuNItDGaeQxHkOOE/5QRCvRMHBg8oEh2DBABsPP9QI
	cxzVjfcHkMhswrC4QltQ8kOD+Q3E=
X-Google-Smtp-Source: AGHT+IGJIV50uQiqG0CulZDIWwEaLa6WKwT+PnZ09p/gnLDuRVgx2nf8dBmnCep3bkhzb2PAyb1GFOXrSx0XVaDyiwI=
X-Received: by 2002:aa7:c1ca:0:b0:559:cf9b:c3f9 with SMTP id
 d10-20020aa7c1ca000000b00559cf9bc3f9mr3940636edp.34.1706531007204; Mon, 29
 Jan 2024 04:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125113623.2043061-1-maobibo@loongson.cn> <20240125113623.2043061-2-maobibo@loongson.cn>
In-Reply-To: <20240125113623.2043061-2-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 29 Jan 2024 20:23:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4w7BYpoBbudpu3TiR5COHoBRFHHra9URdK1kczpeZbGA@mail.gmail.com>
Message-ID: <CAAhV-H4w7BYpoBbudpu3TiR5COHoBRFHHra9URdK1kczpeZbGA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] irqchip/loongson-eiointc: Typo fix in function eiointc_domain_alloc
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, lvjianmin@loongson.cn, 
	Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

We usually use eiointc_domain_alloc() rather than eiointc_domain_alloc
to describe a function, but it is not a big issue. If you will update
a new version you can modify this.

Huacai

On Thu, Jan 25, 2024 at 7:36=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> There is small typo in function eiointc_domain_alloc, and there is no
> definition about struct eiointc, instead it should be struct eiointc_priv=
.
> It is strange that there is no warning with gcc compiler. This patch
> fixes the typo issue.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-eiointc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq=
-loongson-eiointc.c
> index 1623cd779175..b3736bdd4b9f 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -241,7 +241,7 @@ static int eiointc_domain_alloc(struct irq_domain *do=
main, unsigned int virq,
>         int ret;
>         unsigned int i, type;
>         unsigned long hwirq =3D 0;
> -       struct eiointc *priv =3D domain->host_data;
> +       struct eiointc_priv *priv =3D domain->host_data;
>
>         ret =3D irq_domain_translate_onecell(domain, arg, &hwirq, &type);
>         if (ret)
> --
> 2.39.3
>

