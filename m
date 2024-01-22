Return-Path: <linux-kernel+bounces-34033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD17B837228
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA1B1F319A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA0348CCF;
	Mon, 22 Jan 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB97EGsa"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4BC3E468;
	Mon, 22 Jan 2024 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949825; cv=none; b=blpNS14XFgBqDHBLNuuzksP0iiOgDu9L8FmdPvrQjWtK1sTOeZSnRwonK62gIiKgxuM4xQvvv7HplAOpWtswzLckJ1KDbrj/u4RwvkpVyz1QR9c/oUIWgEQaNEuH4m1conxHWHAluEhrZMavtEfOZiIE4k1AcX3WkQgysgjky/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949825; c=relaxed/simple;
	bh=uLNJMb+pBCr2u9gnsQd//+Hd4AmyWsnDNx+04mGbmgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sGBb4yropzbvAci9gg1OqBgtpJLhwl5mgaq7oiPVJ6pLZxbgBCzndQZCdrzZ3IgGPl9FO6QGAbD1l8N/OQ2jgvr7xEyfaasadL6assGESrS9pFGhZlO4benoKpgiecSzcAGzyTWUyoHybF5GceM1+aUDRT5s4WGukWHyArKCdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB97EGsa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cddf596321so36896381fa.0;
        Mon, 22 Jan 2024 10:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705949822; x=1706554622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K4gHjqnXgZ119aiLxxSd7f9CEexDg/S0xaGpiqsBsvQ=;
        b=PB97EGsaVdowpYEnHty1eKTo7TTB8ADVNi9M2LpDL9B/8V/jVH+tEaLjyzkbvhTUgG
         Wqo4GFLH34vpp2uP68ZxIEAcJlcz60sqnczRLuP88reJdXrh2O4ND7TBZ0YXdUrM9WLT
         vU8svwkhncpnuVNoEG8dLC4NUagWYzm8Nh+ftbgM8fMcGwnjSGYLpvsLViHOBxWbAX0I
         oUozfEgiXVQXw8JyqpFiLM5ax1b2E55xiWRRwc9/pD2xhPpO8l/5MCpUTsDIhZO92Vdf
         MDUQbDVwTGSomFYRbQfWOxA132+a4RfpNf876nCsu4Rei7DQ4RwOj/mStbsyxR+3BHhG
         8GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949822; x=1706554622;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4gHjqnXgZ119aiLxxSd7f9CEexDg/S0xaGpiqsBsvQ=;
        b=nz1dWgcgADvQak4nMuPEqt/LLjQFn+MAh2DN3L4gBIsLCt6cWHJnKqWB6eCP7NGAwT
         tzoRW8yOq0DEe6vqQUXRSqqKtJuhq+PmnmScVoUaPGF0O/MKxDD9+v8KLXgajoNJ+/Im
         00dJnp1WdKzetVOavYI1YfliC+tnveOGK1GDhIZBp/rnH+235KuYMlbub5t6RkyceMNe
         J3H40b+SqTzzrfnD0pL67W0r7XQDNm0SZLvLAhzosF77jyKAyouxbUmuo6b9uvsrx+Bj
         3OgOBuZK+srBSQXbS+A5StndMHlU3xaq9FiUuZd44PqHAHhMmczORi71s+cLYIGFLYvF
         De9g==
X-Gm-Message-State: AOJu0Yym0oX7As28fqVXJfI79KlD3dfYQUVOQpmHrWIvNw0JxmkvHDNm
	3f+Faor1YfoIndSe/6JWxxXCm01ExcxArwWZbCmdtk4zBH8vQjjficrRXIEQ
X-Google-Smtp-Source: AGHT+IETSQyj0Xg73LC166xzayH6guUhnBY9kn4Xk0teCA5IFLeJ6M0s2ewiOpNzWuC2xviNiiUSFQ==
X-Received: by 2002:a2e:a4ad:0:b0:2cc:dbf3:d53d with SMTP id g13-20020a2ea4ad000000b002ccdbf3d53dmr1848130ljm.13.1705949821509;
        Mon, 22 Jan 2024 10:57:01 -0800 (PST)
Received: from ?IPv6:2a02:168:6806:0:69e:e66e:2a53:42b5? ([2a02:168:6806:0:69e:e66e:2a53:42b5])
        by smtp.gmail.com with ESMTPSA id o9-20020a056402444900b00559dd0a5146sm7045730edb.44.2024.01.22.10.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:57:01 -0800 (PST)
Message-ID: <65a86432e076d98ca5dfbc24ba8a08bcbd48071c.camel@gmail.com>
Subject: Re: [GIT PULL] SPI updates for v6.8
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Jan 2024 19:57:01 +0100
In-Reply-To: <a3b7790b-ce5b-407f-8089-a18c52aa7a1e@sirena.org.uk>
References: <20240107223817.EDB59C433C7@smtp.kernel.org>
	 <d8724cd416494bb5cd5b0350266fce0cb7b3b210.camel@gmail.com>
	 <a3b7790b-ce5b-407f-8089-a18c52aa7a1e@sirena.org.uk>
Autocrypt: addr=klaus.kudielka@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-22 at 18:38 +0000, Mark Brown wrote:
> On Mon, Jan 22, 2024 at 07:30:09PM +0100, Klaus Kudielka wrote:
> > On Sun, 2024-01-07 at 22:38 +0000, Mark Brown wrote:
>=20
> > I just booted 6.8.0-rc1 on Turris Omnia (CONFIG_SPI_ORION=3Dy,
> > device tree: arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts)
>=20
> > and got the following error:
> >=20
> > [=C2=A0=C2=A0=C2=A0 0.090231] spi_master spi0: No. of CS is more than m=
ax. no. of supported CS
> > [=C2=A0=C2=A0=C2=A0 0.097358] spi_master spi0: Failed to create SPI dev=
ice for /soc/spi@10600/flash@0
> >=20
> > End result: the three MTD partitions I used to have on the SPI-NOR are =
gone.
>=20
> Actualy looking at the DT it's not immediately obvious why this is
> triggering - there's only one chip select in use, numbered 0 AFAICT.
> Anyway, if you could test the patch I linked hopefully it does fix the
> issue.

I wouldn't have an explanation either. But said patch, applied on top of 6.=
8.0-rc1,
seems to be a possible cure. Everything nominal again, AFAICT.

[    0.191427] 3 fixed-partitions partitions found on MTD device spi0.0
[    0.191440] Creating 3 MTD partitions on "spi0.0":
[    0.191446] 0x000000000000-0x0000000f0000 : "U-Boot"
[    0.191656] 0x000000100000-0x000000800000 : "Rescue system"
[    0.191796] 0x0000000f0000-0x000000100000 : "u-boot-env"

Thanks, Klaus


