Return-Path: <linux-kernel+bounces-42549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CA28402F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F7728485A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BBC56475;
	Mon, 29 Jan 2024 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s856pUGZ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA6537EE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524807; cv=none; b=DNmQEdb/hJuxRWCkdagNEwRKUlkcqyP5pX9EhXC0yiKjJeGpPLNtBwYwu+6ig+PslGBp++uYhMUb3fzPmRxhqXLZJWJEtogDG6Kqeq/wp0yC9X+si48NJF0564fF6uNap5fqfuAPbbHm/Rfw+SSiFCUhEXcShBcjs7FWQ52pByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524807; c=relaxed/simple;
	bh=WaFE+pXwPRypPxIRaulg/gFvImbvbsthbSmM+meA068=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ry5KG19diUf4uFwpY91pKeTHXvRtpEI3ThSD4+bmhUFlNQYC1IKPaDYMpuwU/xjYKWFkYSTOmNhbOS2BBNqecjjZvO6WT7Qf5klvLFLyewdRmpfLq4wBIClKd53A/EmgJIw/kGkoShWY1wVWvbxxTidQ3RufXp69nnB56tcFX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s856pUGZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e80046246so13437605e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706524804; x=1707129604; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J0JbM0JGF1J7IySg62RrNatTS3/ANKn5efUsptKY4Sw=;
        b=s856pUGZ2tkBV2hqYXDZkr81tQsbD1UyyTRw2HdlLGVR+VwiC7bv54bsLYS32vfU9k
         t3UjPfLuEqQuAond0sJTSU4/gQmWCpk2G7mjusYpnnarsI0AcKIwJzwxJ3rYeH8bPEbO
         pNuyu8CnkR9FaBKUjB43YrEFC8T9x6theEnsY13vbmJszEFNRW097FPPQOTNm7rPQVE9
         dXG8ttrI/JTHPMXECOTaVmHvY547JjLN6FGx8MaiRRSHL+FeMs1/SvUlqB885XkTD6FQ
         SCbpxTtls6zx1zY1kULe7rlrzlEe81kS5B4fi6s/jjkZ/05z47nEQpliaJd4LLM0wEms
         2bfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524804; x=1707129604;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0JbM0JGF1J7IySg62RrNatTS3/ANKn5efUsptKY4Sw=;
        b=nnUSGIWnQBa/I6nqSpAzTYYFoNlKSxQEHUEA47oB3TNUGFmNfuFsFt+Cp0g3ffzHcx
         HwzAcSKqnyRdMChncVU1aKDmyB3B2g/E0j1MGc68NtPrwVFacFFIac6U3nOYt+JKRejf
         5UsGFmqt8tTj1RW3IDIy0APCV7eLzeWwm8C9Y1OFVqq7jXU9To82GNl5RPNffhkx2Ts8
         3BjkIa0onDLf3GV6QyIsfStcV1KwlkE0Gexl/rffC/GyyCOf0eOqLknqih9y1M5eJuQQ
         KK+TAxZcIzuKGw1PkC+EyoQRDpuk4yKbwqYDXjZAHV7OhSWfOz4MZ3kyCqFySOxhpOe5
         KL5w==
X-Gm-Message-State: AOJu0Yz1zOT/MRGgfx6zSx9y5k06yiPaaDTMmqSRNvvjI9eECFDh4s0T
	wN10sc0N/4QOOsPY6WBmenz4Rdtg5PGPh+bT+e670xGy4G09bYcq4sV/sJQC9+Q=
X-Google-Smtp-Source: AGHT+IEgR4YcDqRDiTudYYipsxEtqbgIADWVwpxpCcbuB0Tw75yxRycXmOHhf4ySXorJ+nzxIfUq7g==
X-Received: by 2002:a05:600c:1c12:b0:40e:fa51:3526 with SMTP id j18-20020a05600c1c1200b0040efa513526mr993752wms.10.1706524803970;
        Mon, 29 Jan 2024 02:40:03 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05600c1e0800b0040eec3f384esm7001854wmb.42.2024.01.29.02.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:40:03 -0800 (PST)
Message-ID: <0d3236e90604e82a609d205c6fbb56fd882ecfbb.camel@linaro.org>
Subject: Re: [PATCH 6/9] arm64: dts: exynos: gs101: enable i2c bus 12 on
 gs101-oriole
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  linux-kernel@vger.kernel.org, kernel-team@android.com,
 tudor.ambarus@linaro.org,  willmcvicker@google.com,
 alim.akhtar@samsung.com, s.nawrocki@samsung.com,  tomasz.figa@gmail.com,
 cw00.choi@samsung.com,  linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org,  linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org
Date: Mon, 29 Jan 2024 10:40:02 +0000
In-Reply-To: <CAPLW+4m4G+-zFLGr6Bp-73-mERCofxDiD7F=2fd_Wq+18iTs9g@mail.gmail.com>
References: <20240127001926.495769-1-andre.draszik@linaro.org>
	 <20240127001926.495769-7-andre.draszik@linaro.org>
	 <CAPLW+4m4G+-zFLGr6Bp-73-mERCofxDiD7F=2fd_Wq+18iTs9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Sam,

On Fri, 2024-01-26 at 20:58 -0600, Sam Protsenko wrote:
> On Fri, Jan 26, 2024 at 6:19=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik=
@linaro.org> wrote:
> >=20
> > This bus has various USB-related devices attached to it.
> >=20
> > [...]
> >=20
> > +&hsi2c_12 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
>=20
> But there are no bus clients declared here? A bit of explanation about
> how this bus is being currently used would be nice to have (in commit
> message); e.g. maybe it's used in user space somehow, etc. Because
> otherwise it doesn't have much sense to enable the bus with no users.

As per the commit message, there are devices, but:
* most or all don't have an upstream driver at this stage
* it does make sense to enable the bus, as enabling it allows working on
  the drivers for the devices that are attached to this bus

Cheers,
Andre'


