Return-Path: <linux-kernel+bounces-86448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08AA86C585
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369261F235FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9C60B9A;
	Thu, 29 Feb 2024 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EYYRkh6Y"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD5A60880
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199510; cv=none; b=rrQlKxbGbjc/JuGDDT/r5mLCRARtP4MMf/HSDvc8i9Oh7bsZkEwPP9cwND0BIpTDKhlRyNGDRUs3JjQPtyVGFPG4KOs/Zvqlu8+rA8+BVDtXxfhJl4TWaKjU2rcKfaESa1pCiXOEqWpPpaZRfghX/3Upopt3hz2sWg+RdcIqLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199510; c=relaxed/simple;
	bh=ji0evMeodU7bNiEaX0y74fD8RtxAhbXOV6mH0WkgcmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwE/jTB7nSKa0t1RkEpJNpywsnxjCdQuim+0bwn/UQq8hJP5by4g9S4H6Mt/hYQs33b3pp45iQNVjyI6Vuque7N7QFnuFY7+VdAyOIGshlUPT2jMaLzZqhRulbuq933ouyx0+rmEkK+HcVKHvoQVZot2zoc4kjxnGVGPN/2Dt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EYYRkh6Y; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607dec82853so7102717b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709199507; x=1709804307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji0evMeodU7bNiEaX0y74fD8RtxAhbXOV6mH0WkgcmY=;
        b=EYYRkh6YFvJprq0PxQoOtB2ny6Rb3DoEOA787lqXdLP2zlcm13be9SdFq4UtszcBly
         VJi6Ni3n5LYKslcVDuOw8QK/hH633HvsuR1XIPzjyesrgSROG77Y4g4C2E9obsxc4xo+
         GG2uVf3A0yMnMLWUDSa5OFJ38TAG64lvcQC1VM8rPO06nTCtF/E7QT3T9OujgNY/4UyR
         bTuLDZnq8E3StaGO4JLlaW+mfmzY3RAhySqacYmPJcOe74eX8yhBi7fx+z0oJOx6ijj+
         8sTrXAKh8HXKIfO00R4gzf5nd4CUxNY+9ax4loYf+7iRrfardiKx7TqOl19krmNSJPFw
         6zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199507; x=1709804307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ji0evMeodU7bNiEaX0y74fD8RtxAhbXOV6mH0WkgcmY=;
        b=JQcHfkUvz1hsIb7qsjgR9nZq4Vw7f5h4KUHBlHBcvCxf2ZXefJrjpQPw9aKD18l08v
         v+BXlnA7rsO5IeSQB3mwqURXqTHuGdBGpGATzP148DZ6cLdYwJ5j9F9wFRGwbzgwothI
         wX5nvfTiO4cFDRRRSEAwgrRz6ApXkx2UyQJhHzYEuwCVIuqyGWOS2kNRb/g1RYHFl5z8
         bxox2ZEUCtjQlQ7+c63T5m88zd2FoBbTbfMsNtoT7xp/NI9l9Nnlu8pmIXwvFAUCgNlk
         mz9B1nMiV9Jyy5ib6rnPSo03zsklgKZf6RY3My6DjnZsxErBLch88x92S9dWGoMu1s7p
         frmg==
X-Forwarded-Encrypted: i=1; AJvYcCUuuTuy7G867ahZWIqscEpmErsUIiKGanavoJ8nI+5TgwfDL4l4khNutLrh9kOyawl+JhoFvZopqYlxApzLcFspW+MCJN6XLOBcZrx/
X-Gm-Message-State: AOJu0YzcWVUciByiy/ba/BepkyuyAsFlMoXim9y3nZzH1t6QXR0mP4mi
	scGj7dAp290LXKCcqeOeUmTVHG3rVSN8gbv36Bltt+5vjNb+1gJLtyyggC2INTM2B0PDgxszn6s
	pLDfAgqiJ8YN6BQDGo8yBBkzrVagDpOqkhtlK/A==
X-Google-Smtp-Source: AGHT+IHpUTC0tD4+eeNVpg7JVN9p3Nit+u2YhFzzaD2mD4WuXW+hkiH/3TUn0JnN4dt3kNq1EBKU3Os1w/KcVFMeNHw=
X-Received: by 2002:a5b:bc2:0:b0:dcd:26a8:7f84 with SMTP id
 c2-20020a5b0bc2000000b00dcd26a87f84mr1514094ybr.47.1709199507561; Thu, 29 Feb
 2024 01:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-24-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-24-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:38:16 +0100
Message-ID: <CACRpkdZpnHTNj7KUxk6WfSMzMsGk=c6Jzu=zy7UXpFjj_B5vMA@mail.gmail.com>
Subject: Re: [PATCH v2 24/30] gpio: nomadik: support mobileye,eyeq5-gpio
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

> We create a custom compatible for the STA2X11 IP block as integrated
> into the Mobileye EyeQ5 platform. Its wake and alternate functions have
> been disabled, we want to avoid touching those registers.
>
> We both do: (1) early return in functions that do not support the
> platform, but with warnings, and (2) avoid calling those functions in
> the first place.
>
> We ensure that pinctrl-nomadik is not used with this STA2X11 variant.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Just as I wanted it.

Patch applied!

Yours,
Linus Walleij

