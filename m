Return-Path: <linux-kernel+bounces-71468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD2285A5BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF42D28490E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA20374EE;
	Mon, 19 Feb 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSq2QUxK"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2553770C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352406; cv=none; b=Lh1nRcLmk//tBzwtPeEZecVSw1xpLbEBlFD4v1lHyHPWvPQAJ46ncfzh5FA4Tk0lqa0anTkIiVghuXeKvSFX8xv7GFOccwD0KJ15lg7jeieGhyFQSBmyj+k1FmVCTHh9KZTrTzS5A7NR6Zc65tIvCULhHY6pzuSuBnotfp6tZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352406; c=relaxed/simple;
	bh=2nX/YnHE1p43cnsHv6Bim498iWoieRARKM1TgHyY85s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPxDb82WyEhhGRqIrts/VW9X6g0M7KFBByoPk+M1j3JO4+xIVz8yc9Hl/er0C0uhNf5S/lFZWd/1aGYH4Yr7qke3+qSppYFCJgjHBBquy903sFwXGWEbWhqurQ4Jf5/bQRNiDEq4Le7FAqh/jhTRCsYQ/M4xgB7Oj9StCpNgGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aSq2QUxK; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607eefeea90so29824417b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708352403; x=1708957203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nX/YnHE1p43cnsHv6Bim498iWoieRARKM1TgHyY85s=;
        b=aSq2QUxKAAwTkg3NmeAaX/EMjD0mSmrOFMlrS0lHmfrWmwTMEqHnFEcySZXZV2H+2M
         LuZSe/1Qo1FmmC88kid51+z7cYlqTxkX2+1HqeRFgJ9+49EpYEBuP+aVgsVfAQ7naDwc
         QVFnsKDHhcUe/LJZ4nHa+P5xfI/nmTi6fIlyII964v8cgtlwvPkkm0efypubwZIV781W
         NkXvq2dweib1i3aio4cjL1vPSlBv08bWe7OCoE1ItcPr1lal7PQBbyjcLPpZw3ACaeQE
         t27D5SG1rVns/Y5BOMx7Am2WJjnzNnwc377A4/n9fbNeTZBTgfECHZTn+k9aHSIFbfOn
         bA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708352403; x=1708957203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nX/YnHE1p43cnsHv6Bim498iWoieRARKM1TgHyY85s=;
        b=kmbzBt88cxwpcSonCOZVQOc5CVT3QIKEvJevH8kb/fVQPBpIb28WbyzbJ+WzD6Xx5C
         5+ipj7rYU4VcrOTa/xtSqTKq2wJP1G/RgMw+WbMzgRIq9eOkAMipmXF1FIrYjZRlpRH3
         q4sUx7ALXwesikGAgl5G4k55rn+5f00mGkaDkNrlPVnbr60E3OC5MgCe2T69/zDiVL3G
         MgTcnWxr0TPRccObXLN4XXu85168xFkLUc03CFqmBk5Az1dMhLVPdvBK7O+kBPBrMOIZ
         Wq9KZltnZ1rb3irl0pY1zzMnXjqnq73MfKtdx7RYPAKRLefNHkr71EXlPWCwrgotVyLC
         HtrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpzkKLFSJgouYtMiOmSh55krwbg2laHKzzKXNhSJhtAfvKyMuOBgwGUBP3GnBEglUt9SkuAO0VDFfG9xsqucqJvLsSC9UqbUqP9cZh
X-Gm-Message-State: AOJu0YxH/e44bou4AwXBHQumMQsCSasgqFlJeBBATl6m7M1ymbIYLhGd
	wFFPqx4XvjnLXm0aNBG40IkP29SmmzqimShuAe42S+lkjiCPSmA/EBthtB2k1Ommvjll1q/+BK3
	Mkvdd0rkMJ9qgMXpcd8j/Li5rYnl7wNjK7R0h2g==
X-Google-Smtp-Source: AGHT+IHldURV+ELvDsbB5moG6WmCWelWvIBYktW8b5Mz2dp3lcXYunz9Xw6VKQY0hqSHGeV+ncjyeXIC2hByFdLnUQ8=
X-Received: by 2002:a0d:df0b:0:b0:608:11cc:cf38 with SMTP id
 i11-20020a0ddf0b000000b0060811cccf38mr3472591ywe.14.1708352403287; Mon, 19
 Feb 2024 06:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-mbly-i2c-v1-0-19a336e91dca@bootlin.com> <20240215-mbly-i2c-v1-7-19a336e91dca@bootlin.com>
In-Reply-To: <20240215-mbly-i2c-v1-7-19a336e91dca@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 19 Feb 2024 15:19:52 +0100
Message-ID: <CACRpkdYC=vVBA-s6GmsaED=NdXfsr0JDzzF+x8q8C3tqQ0F8YQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] i2c: nomadik: support short xfer timeouts using
 waitqueue & hrtimer
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 5:52=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Replace the completion by a waitqueue for synchronization from IRQ
> handler to task. For short timeouts, use hrtimers, else use timers.
> Usecase: avoid blocking the I2C bus for too long when an issue occurs.
>
> The threshold picked is one jiffy: if timeout is below that, use
> hrtimers. This threshold is NOT configurable.
>
> Implement behavior but do NOT change fetching of timeout. This means the
> timeout is unchanged (200ms) and the hrtimer case will never trigger.
>
> A waitqueue is used because it supports both desired timeout approaches.
> See wait_event_timeout() and wait_event_hrtimeout(). An atomic boolean
> serves as synchronization condition.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Part of me want to go and fix completions to handle hrtimer timeouts
for submicrosecond timeouts, BUT I realized that this is a bit thick
request for a simple driver, so just a suggestion for something we could
do one day. This is fine with me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

