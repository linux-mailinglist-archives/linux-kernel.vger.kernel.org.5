Return-Path: <linux-kernel+bounces-72036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 927DB85AE1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B99B22A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21E54750;
	Mon, 19 Feb 2024 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yaKQvI2I"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA954FA0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379806; cv=none; b=toXLjITAlTVFGdAJxtuCFvkPZpZgF6gFWLtLnCCgWLLTgQQxgn+vZ9+2z7bFYqv97jL1oIfdM8CuFAtTqx9EU6r9N6oBNO6WO9RggHgoAZgkg++MJb/a8xOKAZ58kMF5ZFK/tlcSgPlTnyRkzevdGL7b1w7caQpxMhymWSDw00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379806; c=relaxed/simple;
	bh=jnwZE4S2VTxOOE1MLufKwv7MLtdIeQ/H3SGA6T3ceVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KF2t+vgN4AiEzXAnuAT/kwQHi7nnAucpmygv+W8H6E1HGeq7L8/IkJLEfj5Xsx7GHVjeHi1c+Hwq8ZF6TQ33nYJr5WGEbCWQ1U26hV2mtiago4DABV/EMpZ4QZozjuLuz56x6ExxzoI+PPiOrzy5XwajJdLkDp4TRUM5sSLBj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yaKQvI2I; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6085ed1e916so2144297b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708379804; x=1708984604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/z7Oth3uWYAoZv2gVpy6Dr4nj1eg780SKedkbWLNvY=;
        b=yaKQvI2IzjqJefvDuWLsiN7ih+t6Ar2DuN96gdel9Da/lXfAe0CyXVGlmNudhJragY
         SAxpmWT2IVinRNrzaJaze/UJLrcjIRBH8gjrEnF9nZ7xUMQ5Pz3qeezT/EXGY2GVF1kG
         /RhvKWGnszItfi9V84Pn4iLNaaupRH9Jh0hhSQxQ3BKz2ozGC04VFtpP4wDrXDup3BUC
         GnQE1aEOmZFViAvgWMKX92tXQuzI7AzuTftCAMqsZGoVRH5X/Fpwz6l1ssAPm2UKJCqw
         js0vmBGHx2zMjkUn6Y6KwefSnUaOBQNEjChV3pz0PVUurPGG3A7qcpAVjAuxKlwJvzmI
         3PdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708379804; x=1708984604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/z7Oth3uWYAoZv2gVpy6Dr4nj1eg780SKedkbWLNvY=;
        b=R/p6NYB23nEewGcjwq2GH4UFCxn82euRIc3sqKBYi5AUqPOl6OKLs99oK6i+UacTZG
         0/ImOBY5Rk6gXOC4M6WWPck1nPCcsNjioywQBHlzfKvb+6+nGdcsigVqIkSuZ+y4Bawm
         yPqJGCApQzv5spfg9JoGW2h0TM4rskB8GngiU7EGGyAEz/flQNC/pSg4WCOSMcFfaVyK
         vDLJ55I5kHxViGgU9jS8X6HYg4ljIQ/s03RaHjY0JKUnZEDqWWJx/C+KrHAcs6ftTdqA
         OT/X6N29ojLspNek3q8feyzlQ4Ps3djd51npjtel9wkMGRQ8TcBUmVUv/eeD+8FRLUm5
         QOeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVww+mKV0ZJkzuLLQME1ZHGn4xUmQ1ge79N4jCceb4SGzCMGojDAKW51YfhmfKOLVn2oaWKqTPsy8JRQfbkbeJY6kv3ixKNtjQe4CLE
X-Gm-Message-State: AOJu0Yz9gsUnczAtCIFHDgfH4XGRle+VqyVHD2YudR36hgKVQEnQ+yxY
	6opqo/SHz8jh93hsC+O4E/tg+uAaXOvnPEUzolitU5enW46E8KP9S/S6P5zXlakooK/xwp+Ec5U
	/t+HNmn0LcdIO5eBPZ4ZnjxrwahB1QqikIkvgOA==
X-Google-Smtp-Source: AGHT+IGcz7rDFrB3H96NwCEBK79eVL4dxmtjY7EUMR+E2Y+tyM0OKpEUleavbf8K7T1I+Q8afEbrz38cYzH/dDLZwL8=
X-Received: by 2002:a81:ae41:0:b0:607:e8c7:f9c9 with SMTP id
 g1-20020a81ae41000000b00607e8c7f9c9mr12782963ywk.1.1708379803904; Mon, 19 Feb
 2024 13:56:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com> <20240214-mbly-gpio-v1-13-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-13-f88c0ccf372b@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 19 Feb 2024 22:56:32 +0100
Message-ID: <CACRpkdbq_QxdftNGOv3+-SpfrV_qPTB-m-atdY0hCE_s8DK64A@mail.gmail.com>
Subject: Re: [PATCH 13/23] gpio: nomadik: fix offset bug in nmk_pmx_set()
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

On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Previously, the statement looked like:
>
>     slpm[x] &=3D ~BIT(g->pins[i]);
>
> Where:
>  - slpm is a unsigned int pointer;
>  - g->pins[i] is a pin number which can grow to more than 32.
>
> The expected shift amount is a pin bank offset.
>
> This bug does not occur on every group or pin: the altsetting must be
> NMK_GPIO_ALT_C and the pin must be 32 or above. It is possible that it
> occurred. For example, in pinctrl-nomadik-db8500.c, pin group i2c3_c_2
> has the right altsetting and has pins 229 and 230.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Ah good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I this something I could just apply as a fix or are there
dependencies on other patches?

Yours,
Linus Walleij

