Return-Path: <linux-kernel+bounces-36748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DFC83A5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFB21F2DB37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBC818639;
	Wed, 24 Jan 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LohNP/1W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10A1862B;
	Wed, 24 Jan 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089969; cv=none; b=TG/nqmHRCoscbNRg76wBybJwpKgK68NtCq591AtNB3DpRSfsicyQ3FCHynjJOJK+SBXt54583iSSfNSlNIGk85d3oY6j4M+NdBr1qVt9uNWzbx6kW/msuF4hNynVzA7PKJdYbV8AoFXH90DNUvmuzQp+rYi6rMjDx4ZEB2p+3fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089969; c=relaxed/simple;
	bh=25EbN1mzjVCHuiUk7bybepZ+ZKPqcs9G8ruiHFzlSOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtkVI5VPGNiASSxaIyUb+IpWaKHdYxdu2iz0L0rxg7b+tTgZHaH6YQsoD+n7dCoBznX/a+Zh9tGglYER95k2zSHByRClca4TObDDFP+DU6GgftEdST/HNyUyOGVEv2H4/aA97Ghkr5Ah5WtvQWxzmgQNE7t7F2EC0ku35F3moNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LohNP/1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5626C433A6;
	Wed, 24 Jan 2024 09:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706089968;
	bh=25EbN1mzjVCHuiUk7bybepZ+ZKPqcs9G8ruiHFzlSOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LohNP/1WsXyvDwB6ZKygdTeX5gGsJGwHTcP8DUMUVNJIoqWWxaeTKWO2rwQ7pGdMe
	 Wi7PuJYn7Ait0IUYTY5YSrOPtKNVt02Zq7kaK1vrqZstPs/Clz6XXvfeL8R1AlZH0e
	 ZWqtTpvJLsNgdxFagjroCPf4qvnbST0SA/l51bYa0mkm/OoAj5/dVQgE3orY7WPmai
	 cdxgMzQQNckRX6EN2Zn66xnLdYOe+AHCNlWaJ8Ts4vGg2iwMShmvg81npuALXESq6n
	 TmghtQH34bN4NDRWiWNwoVDBo2KO1Db05a01hWwMzreegJ3WO+K9sLU6EfFSHuvilG
	 TCgTD2r6ZDQXg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so6607323a12.1;
        Wed, 24 Jan 2024 01:52:48 -0800 (PST)
X-Gm-Message-State: AOJu0YzDuOrONT+IVSwaSGep+2nAzGgcKYOodnpTPdYuxSjjja9KPzCh
	Ia4F9v2BNf6UT9XON585KDdRQ4QWd/mNpYVdK72kC8U2iKV6g+cmNPy7KSEu9iIclpi1oqLwJGz
	+C8/CpN21NEerOWlbwbcYnDXQIyU=
X-Google-Smtp-Source: AGHT+IFSvORXsCyI9FFQ4azhLnmjHti6TOi5ATesVQ/VgI+SXE2UF1JjHJkkjjXZa7Cg/PLX3C+VGzO/U1ajcX3RRxc=
X-Received: by 2002:a05:6402:1bc5:b0:55a:8431:ba7c with SMTP id
 ch5-20020a0564021bc500b0055a8431ba7cmr934471edb.37.1706089967348; Wed, 24 Jan
 2024 01:52:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118121542.748351-1-maobibo@loongson.cn> <20240118121542.748351-4-maobibo@loongson.cn>
In-Reply-To: <20240118121542.748351-4-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 24 Jan 2024 17:52:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4q0B3fXjkwtEQaCLk789UkLbWe8Zd8L7bMLWea1yq70w@mail.gmail.com>
Message-ID: <CAAhV-H4q0B3fXjkwtEQaCLk789UkLbWe8Zd8L7bMLWea1yq70w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] irqchip/loongson-eiointc: Typo fix in function eiointc_domain_alloc
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, lvjianmin@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

But I think moving this simplest patch to the first one is better.

Huacai

On Thu, Jan 18, 2024 at 8:15=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> There is small typo in function eiointc_domain_alloc, and there is no
> definition about struct eiointc, instead it should be struct eiointc_priv=
.
> It is strange that there is no warning with gcc compiler. This patch
> fixes the typo issue.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-eiointc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq=
-loongson-eiointc.c
> index 86f4faad0695..1a25e0613d50 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -252,7 +252,7 @@ static int eiointc_domain_alloc(struct irq_domain *do=
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

