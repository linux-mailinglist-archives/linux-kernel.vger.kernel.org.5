Return-Path: <linux-kernel+bounces-86449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F1F86C58A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EACA91F22C79
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D066089C;
	Thu, 29 Feb 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sMAZZZV9"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C760875
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199546; cv=none; b=qNyAnvey6ZgktOTkZ9KHxT0BLwq64LVVkRH0uIhKgTlLs5Q4WhD2JXqOSSH7atHv1c401uFrwtQnDwnWoUxhaYRb+Rxx+sndOLP7GLyWFrgOlY05kyKx1qWQq2hmp54e+qJWzWW5SUKCo2HQ0aD/r5xujcv+JhJ1BIiGeYd1prc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199546; c=relaxed/simple;
	bh=Id/0hLb1OoVGa9urk2OII9ZHzTzUCiC9fqBjkpo4oTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Apm21gcNceiDrYSrBierzu9tT23Gz4W/kyAu39+y/pmFAwPC/FFlpkhByeCymWz1IVq8RZwC3iGVvgjeDIrIxepscG1185dNhwD9pkLQV9f2sutissi4oZj4bZCFIIs9pUVzk1Xj8NM2EOjpuRjhhT2LyHHd2/gwHRgvFqiT1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sMAZZZV9; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6087396e405so15177297b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709199543; x=1709804343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id/0hLb1OoVGa9urk2OII9ZHzTzUCiC9fqBjkpo4oTk=;
        b=sMAZZZV90iPYI4/G9PGJcTNCCMvv5Qd5Fcc8Oegz654V2iHCOAvmzhvHLmVmUHUM1C
         jjyQ0MOeoX/csV6JLIxyt85OZa9kVEizTi1jw9NblPqmOlxcbEwX30IeRfY6J9IFIawA
         AbV+bcXUiJD9z8nn6J/VpEfUMBanERNJjGQ+YeH1sLYoKet6NPi6pEL03YUtgNeyyfos
         m780tFibJOfT+Da2Z5wNZlCQCPhUToDXgig+2tqJvzvOfIqUghowkXm30w6UdRI86dkG
         vDpGNc2Tn1wtjnEYAkQgWkCeMlYgzJ7BVSUzlujOb3R1r1QQBaVdhvSenerGvD/usYQj
         a8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199543; x=1709804343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id/0hLb1OoVGa9urk2OII9ZHzTzUCiC9fqBjkpo4oTk=;
        b=GykN3slKHOTabb+Z8VHOtvZBMG3FgaOg/936kk5oe8j+I/dTC4oI3fa7UIamXBOFLR
         bO1WhDhVN6XukJIBn7Gv/OmjBRJQUuRM02RG3f2Qv+QuDGAcXh2Qh6oVY34mTEN+d7me
         6HKlTHwthwNaRD74lZbIp4p2QKrn/EqsNQ855aHFhVk+R8nuhsyyDUmSTzZswahmTVX7
         qVUC0lYEXP8N2vokfKp65eAlbFFlyysOEE9hvN3D4OgxrH1l0Y1EyG6HoFxz9RNVUNH3
         F7G/5wR8EsTFPL0wQKcJfzjMKgxVmLL3bHFUFZCnvME6d3n9jtcmDMJy41/JslAWZkTF
         mnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsSTsd7ajL83L2bIPMzTk1146+oCS+ob+ZCAYaFdNigk3Z5FbgAJs5NLt15Zs/J7sKBgDSI4yQW505Vxgrf+68rq9n3KRjAPgdzy57
X-Gm-Message-State: AOJu0YyIHFnoVdNB+gowU/ocbqA2o6Tb0mpm/2QDX/rPAmKjgTZLeiuz
	pTAzalEH0exF8K6hVzjbj3LQgbf+s5DlWM6nZ4/smIw0Q3pzgAT2nlwZdP94yNf3DECU+GrvqCH
	I3+UmJM1qnTtkPUQDVkCrXf9wpFXQuzNUZtfmcnWWqaMvFLiK
X-Google-Smtp-Source: AGHT+IFptHANPFZRp7pQwEznjk6ScLV2D3Oe6Z2gcGFVq3bPrlRpc7Zj2hsVukPM6YMB6JUz8/NILyAx36hRTe8VGnM=
X-Received: by 2002:a25:8308:0:b0:dc2:2d55:4179 with SMTP id
 s8-20020a258308000000b00dc22d554179mr861584ybk.17.1709199543032; Thu, 29 Feb
 2024 01:39:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-25-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-25-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:38:52 +0100
Message-ID: <CACRpkdZE-hZGPg-1cnFZ_amYT6t3p=fOpvEOcsaZY3E-Y7_Weg@mail.gmail.com>
Subject: Re: [PATCH v2 25/30] gpio: nomadik: grab optional reset control and
 deassert it at probe
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:28=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:

> Fetch a reference to the optional shared reset control and deassert it
> if it exists.
>
> Optional because not all platforms that use this driver have a reset
> attached to the reset block. Shared because some platforms that use the
> reset (at least Mobileye EyeQ5) share the reset across banks.
>
> Do not keep a reference to the reset control as it is not needed
> afterwards; the driver does not handle suspend, does not use runtime
> PM, does not register a remove callback and does not support unbinding
> from sysfs (made explicit with suppress_bind_attrs).
>
> The operation is done in nmk_gpio_populate_chip(). This function is
> called by either gpio-nomadik or pinctrl-nomadik, whoever comes first.
> This is here for historic reasons and could probably be removed now; it
> seems gpio-ranges enforces the ordering to be pinctrl-first. It is not
> the topic of the present patch however.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Patch applied!

Yours,
Linus Walleij

