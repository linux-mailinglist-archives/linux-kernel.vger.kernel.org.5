Return-Path: <linux-kernel+bounces-48364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535AE845AF0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB5CB2B519
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F073E62171;
	Thu,  1 Feb 2024 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYF+RqoW"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA11779E0;
	Thu,  1 Feb 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800033; cv=none; b=ldynbnV3G3wbmiSYsfAe8IK26pFOiMTDxNl7S6rysZ7QkI8DWZBXYHPQ53nc7Zmjz2W06yeimqkH3481vejTE1QbCpRfl9VrgMyASehRXuri+HOIScQk1pM8YTwH1DzWhmPqvjer0i9yK59sNSWQa6f0TPn06IihgCnlLUwidx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800033; c=relaxed/simple;
	bh=h3pF1J2Y7kD2DXqK7FYxLp/Ne6w/RwV/LgnGUdj/cGQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=k0RHOhUw0d7KG7YkW4RikzNdRk/038WiAu7I8oP/Rtxa6jQri1IgqkS8d9qyvfSLOYxx84Rq/+v+fz9CUloykpfOS8sD8J5SgtGyJ3bz9h9ZtA/izwDIadTyIDEQ7Dgyi5Gzz2tz/yEjDvznnrXj5RY12y/YyTQsuoyTTfeNPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYF+RqoW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55790581457so1457656a12.3;
        Thu, 01 Feb 2024 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800029; x=1707404829; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6kNM7+P4ZoD4vrIwh2/Maqu21Cod8+oG65RL/+v3EI=;
        b=TYF+RqoWfP7RuD1udpB1vLIWDgEA4c5QVL6inBdvGXaV8GpmxetwYxelbNnhZx3CoJ
         7qpp5OpZhXEHvDrzhiACXM62fsulEgUbC0Ly4RiLprjDMaV4WHn6ptatexa/SNOuGS8S
         QagZ+yLX3XPOqrBiWxwDPTkDu8PZlv4scr85PRFHAzQXOQDAxSxH8cgaPNWr5yRW9Kl7
         sRMImerRrxIC3+ENGcmoIFn/6Ffq8cKMlGxlXe1sbSsr+uu+3jC6pPnul28L7q4pm7C1
         DltLkjhyKXklWPnTKjr1ykL5tYttANfWTMpmIp2gKSgKR1RbiRP6SDq2ZPJZF6J/ohYL
         QAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800029; x=1707404829;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c6kNM7+P4ZoD4vrIwh2/Maqu21Cod8+oG65RL/+v3EI=;
        b=DEzCoD2ARG1NIMMMBBAjcDHkH3jDVZEgGLiSWAPz1qvajDCa36m1rsLDBe8XsoBnpD
         UWrHYm10Fi1Il/L+Zu5SACz8ekpIcj7nfxtemprgGmW+XVtF69fShHva1/ako0V2g0M2
         5undDsWL3jhV+51YUfmNNSN7AE91jvbVZYNYVwwNnajXz27+fKga+DpFiMqYi6zes3GG
         R3Jo37INo3yzDP00gaxKr8cdZorY3PaF1dIz6cSNFBCxYTyCPkuwV6/avqM+BR5wzWYw
         jqBRGbLbbE7IHE2ckUKf8HiMmmztmcxbAW9Y0ERf+mjbxe2Vhtk1r0gu2q+XsejRG+WK
         SrnA==
X-Gm-Message-State: AOJu0YyLmbsRFdZ+rCm6UMZcUuOUb8fEZsUXMqoefTXuxfngrpF/RjBg
	T6MDp/wAtEN6LOVw3p+8LPceahnjraYvRSHt/jRy7XMZWyrlXuou0ZtwUIRA
X-Google-Smtp-Source: AGHT+IEI6GYkYAaN2UQKxbqF0jFNrD3InRZixcUzz3s7038/VKRQQv7EOijspj3ZPOcnbX5jFyRbng==
X-Received: by 2002:a17:906:806:b0:a36:459:51fd with SMTP id e6-20020a170906080600b00a36045951fdmr3768397ejd.69.1706800029163;
        Thu, 01 Feb 2024 07:07:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXXxpiQCZJqEx19t4J+GfFAE2DbpEq/i69JR4Er4q/chEhvQHsLUDkBsKj51c+JLihAYJLmgBJD2mhWExfdhRDwrGMLfbQL7YLTit/iaGvwuJT2QqNLzdmpyqUpuyuWqaC8pXo/ddj8k2+ehlLkALMvr/OjAfNiB58MNSSgNSfO3ThmS7v4lwNwgG/N/BAqnCtJ8kjkr+Wts1LCfWNQ1fb+gjz5mlzQXxKCUaAlo1mTl3OF3+ZXlEVe5uosT3ZB9843784RZi5ZsmhG1Oxnkg49eAw=
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lz13-20020a170906fb0d00b00a317ca8b422sm6006663ejb.92.2024.02.01.07.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 07:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Feb 2024 16:07:08 +0100
Message-Id: <CYTU44ED147E.2V11E1VTOPYSE@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "Thierry
 Reding" <treding@nvidia.com>
Subject: Re: linux-next: Tree for Jan 29 (soc/tegra/fuse/fuse-tegra30.c)
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>, "Jon Hunter" <jonathanh@nvidia.com>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Stephen Rothwell"
 <sfr@canb.auug.org.au>, "linux-next" <linux-next@vger.kernel.org>, "Kartik"
 <kkartik@nvidia.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240129143030.16647483@canb.auug.org.au>
 <d0e1a7c1-06a2-4fa4-b4f8-df149af8eccb@infradead.org>
 <61e8b6ae-fd30-4443-8473-6429f6de8768@nvidia.com>
 <dafa2fb5-276d-4c87-b003-4b7f30d44f0a@app.fastmail.com>
In-Reply-To: <dafa2fb5-276d-4c87-b003-4b7f30d44f0a@app.fastmail.com>

On Tue Jan 30, 2024 at 11:59 AM CET, Arnd Bergmann wrote:
> On Tue, Jan 30, 2024, at 11:46, Jon Hunter wrote:
> > On 30/01/2024 04:06, Randy Dunlap wrote:
>
> > Looks like we are missing the following ...
> >
> > diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c=20
> > b/drivers/soc/tegra/fuse/fuse-tegra30.c
> > index 2070d36c510d..eb14e5ff5a0a 100644
> > --- a/drivers/soc/tegra/fuse/fuse-tegra30.c
> > +++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
> > @@ -38,7 +38,8 @@
> >       defined(CONFIG_ARCH_TEGRA_210_SOC) || \
> >       defined(CONFIG_ARCH_TEGRA_186_SOC) || \
> >       defined(CONFIG_ARCH_TEGRA_194_SOC) || \
> > -    defined(CONFIG_ARCH_TEGRA_234_SOC)
> > +    defined(CONFIG_ARCH_TEGRA_234_SOC) || \
> > +    defined(CONFIG_ARCH_TEGRA_241_SOC)
> >   static u32 tegra30_fuse_read_early(struct tegra_fuse *fuse, unsigned=
=20
> > int offset)
> >
> >
> > Kartik, can you send a fix for this?
>
> If I get an Ack for my original patch, I can pick that
> up into the soc tree directly:
>
> https://lore.kernel.org/all/20240103102654.3779458-1-arnd@kernel.org/

Sorry for the delay on this. I guess you can't really apply that to ARM
SoC directly because the patch that introduces Tegra241 support is only
in the Tegra tree.

In any case, I've applied your patch now, so the fixed version should
show up in tomorrow's linux-next.

I'm considering squashing it into the original since that'd preserve
bisectability, though that'd probably be of limited usefulness because
most people doing regression builds involving this will likely have one
of the other bits enabled.

Thierry

