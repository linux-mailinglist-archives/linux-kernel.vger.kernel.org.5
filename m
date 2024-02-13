Return-Path: <linux-kernel+bounces-63833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE7C85351B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC71B24900
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B970B5EE94;
	Tue, 13 Feb 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pD7zKTm8"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C55DF3A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839473; cv=none; b=c4leUT4FKTDlsz21Yt99JzjY9tkniz6VnijPSWaVQZaYooFz+nC8LPi7PB7fIo6tMd0O0s85SyEh2wzuFKAjw06jNZhF+iGNMBj3zfvJTJMa3Gi9iKiw41ED8rSUxyPjYRLbBjxcvCgrst568U/r4bDHIA3bzlmC3fpoZWNokzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839473; c=relaxed/simple;
	bh=qHDRkqY3kkFkB1NcHRRGMNVhib7uLrwYARmPcz70D4c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRDhDQ+OvLU862ooCM5W2pgPkTtG86bK5GZPL0UWkodfGG6wFvqaBW1PH9iPWcI3xpKxwjfR0aJRAL8kVVhd0DnEgT8YRrNmjaN7l4+9GdAJV9G/LQdIpMplYqHlHY5weEDOPHiWAZgaelpTjtOpJdXbyhPTb+wd+XzhuRUCumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pD7zKTm8; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6727B3FA81
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707839460;
	bh=PqDyS1H1K/fgosXDqnPB4MGkbFe2muNuJORUG4Z+IbA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=pD7zKTm85khSfoDW9yNqdMgRpWdYY2nWRekb+7okxqF9l7/QYKIOwwpXoIWILvVZg
	 OGAD34Ytz9A7N4qKebPXFm3G790HzmXrgOUP68b/vjp4tZoHuYHL09TAb3PVKfecKn
	 cdHFpmAX/djGqLxysMqg1mhVNpYgKiUlxc2LdBerwQxetSGuJvfK7DOgecna5uZvFj
	 tMFd1DX3LEkQKrKY/henZsDynAtFe18CTE2e4jIMD5gKTOpwJ30W+QA0rdzmiRyffd
	 flFuUoNjlmQY8oSz83j83k3cl7Ayl7srfDdoz1gA6Y+o8MIUIzhTc3qeOtK0gG3fHt
	 gbQpEeg9tK/Vw==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42db2604f93so5866301cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839459; x=1708444259;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqDyS1H1K/fgosXDqnPB4MGkbFe2muNuJORUG4Z+IbA=;
        b=iMzVpi70lBgcWuqhtKLWDvhAVWcIQ95Wr/J10QZmrrfLHPDUUbLR5tvuIebVbWDf+k
         kpmeOgxdMEUAI5S7bIlHUo7n6AjRNsevYHScue2Byu0ZCT9qiCamfTQgTH7AA+tEgSLu
         Yc4U6SIw+FPicUq5SFHmgPxNd9KK8+7hhazh3qXa2N1vzKdTjWzq9Hxrb6qpCNSqSPKo
         5thL2Cg2iH9SeIm/5tufXGCXJzstMh31uxRWK5iXSakeeMetM4AKOTfoKwRLFHTm7v4C
         QXEjb2r7nQtM2GwvQf2Di669G0ANFiUrarpHcKw4V8fBG+oAzA3FHrIX/lnNDX3RheMA
         vyrQ==
X-Gm-Message-State: AOJu0YwuLCAiw9tOpOWuAhZhK7HBvzPC01bQedwoK30DAtedpM0icAP8
	Jl3o6LzoXbj0ilRbzqPiJIauCHL6C5rNQ08pBKvAbY5pPf2QLO8K4xX/ro8ViZ3SXHWXjRO5ThG
	QCgnzHvzKisaISVZvO9n94qFg0GN6w+ZMhC9Syv62tfeGQZE/s/W2hzfRsHIGYGb/LRk4RGGjAh
	eJ3iysBiMWcoVjoG8k7+oBHSOmYDbtemVkh9SUOyPgnEv3AWaAkALe
X-Received: by 2002:a05:622a:1106:b0:42c:3928:86f3 with SMTP id e6-20020a05622a110600b0042c392886f3mr11501542qty.49.1707839459046;
        Tue, 13 Feb 2024 07:50:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHQyoPI0wxKtVPCeLp3fl0yJNJIsSPsu5VT04yEP7zIQdzx8woRDQ98UPB4t2EnAdJ2f8tLMNm4riVmabc3fk=
X-Received: by 2002:a05:622a:1106:b0:42c:3928:86f3 with SMTP id
 e6-20020a05622a110600b0042c392886f3mr11501526qty.49.1707839458723; Tue, 13
 Feb 2024 07:50:58 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Feb 2024 07:50:58 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240213142856.2416073-1-ericchancf@google.com>
References: <20240213142632.2415127-1-ericchancf@google.com> <20240213142856.2416073-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 13 Feb 2024 07:50:58 -0800
Message-ID: <CAJM55Z9qiQ6GpzKbYORQP12sz4V67UBGfWChZJeHvD_5j_d93Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] riscv/barrier: Define __{mb,rmb,wmb}
To: Eric Chan <ericchancf@google.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Eric Chan wrote:
> Introduce __{mb,rmb,wmb}, and rely on the generic definitions
> for {mb,rmb,wmb}.
> Although KCSAN is not yet support,
> it can be made more consistent with generic instrumentation.

nit: this commit message has some weird line breaks

>
> Signed-off-by: Eric Chan <ericchancf@google.com>
> ---
>  arch/riscv/include/asm/barrier.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
> index 110752594228..4c49a8ff2c68 100644
> --- a/arch/riscv/include/asm/barrier.h
> +++ b/arch/riscv/include/asm/barrier.h
> @@ -20,9 +20,9 @@
>  	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")
>
>  /* These barriers need to enforce ordering on both devices or memory. */
> -#define mb()		RISCV_FENCE(iorw,iorw)
> -#define rmb()		RISCV_FENCE(ir,ir)
> -#define wmb()		RISCV_FENCE(ow,ow)
> +#define __mb()		RISCV_FENCE(iorw,iorw)
> +#define __rmb()		RISCV_FENCE(ir,ir)
> +#define __wmb()		RISCV_FENCE(ow,ow)
>
>  /* These barriers do not need to enforce ordering on devices, just memory. */
>  #define __smp_mb()	RISCV_FENCE(rw,rw)
> --
> 2.43.0.687.g38aa6559b0-goog
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

