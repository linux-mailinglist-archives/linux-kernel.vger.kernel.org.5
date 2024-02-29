Return-Path: <linux-kernel+bounces-86444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F0A86C571
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50AB928E19A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA86605BE;
	Thu, 29 Feb 2024 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TnoDzhTP"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA945788F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199380; cv=none; b=Bab/2eaGoNqmwWNmQg57qN81mmvYYCG7MbppTm0Riic2qlVxygB7tU8n/ymjWqCxCzq3qyv92Vd5xq5KkAiIMzxusz2HP4c9/m63ZT896EYRTah6CeaEDv6YXf07ni9SNZ7V8pds4dEhBkaDAVYvXH8+/Ys6l1C7Eyhj8NDBWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199380; c=relaxed/simple;
	bh=NIqCg2Lig+ehBNYGyTvhpjqd6T9MIQgC1nLdSgKx46A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWyUwx+EAz/XqmrSC5r87sWCeLVZHuwymubuSeZXowwUS2D67Gk979u8GhBTXuAa+BdKZKuE1fcYK2We+zOoLxYdDagZqb+xvCCv6PpLqEjHAOty3cYV6WISCDvpaP2dXoANRLCBq/KnlItwbrtcIKQfhmTAwEZ9mANaZtLjRtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TnoDzhTP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6089b64f4eeso5981437b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709199378; x=1709804178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIqCg2Lig+ehBNYGyTvhpjqd6T9MIQgC1nLdSgKx46A=;
        b=TnoDzhTPL1NMEZWMb9nWQeHeTZInkBgPurxPFKbH38pZIo44mqQN+t6kAy2aVwxtwX
         ygc0IC1VlxoEdbV1zVbiW/Tuk7tUaI6FR9L5hYq/cjpqoq+s0alxRTDL+tQiVmkph/5r
         jhsdwpAY/PeTtiDYGgLJdsQI1dP6yeSs7H0XyjbgQaL6A8CxF7xfgAxQNO+n+ljguT6W
         AuAx1TfyDCFT0fci2mNf20G0doXt1oPguN4lNCxkQCR/gHTogrdQT1qVFbJ2z5FHfDJS
         bLetwnTif5DKGj8evqSdsQ45zXUKFLfL3CnmaKJAUzYNPKslEM2Rj2+AtuHQAdMg0gOi
         fzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199378; x=1709804178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIqCg2Lig+ehBNYGyTvhpjqd6T9MIQgC1nLdSgKx46A=;
        b=PggUQC/6nfyUvO3t6ymzxl+btLGeNNnhEKL2I7dQ6jr4J6DSls09PZYvO2KqA7qgJH
         2mb/GqeKsDktdxo0+v3cGeRNoDaxgIqBYq6VrBXkeWiF8MZK43hz3/JccaqRYyQqtsm1
         4SI1tQrzbzpWTHZV4Gpu2qGIZ1Zv8NWZCsXRv3PQMDf5hHCxVXHccw3mTu5cA0XJEJTS
         yzyjR1goLvi1jT9rLbdyNTeh4SetT8euhU4K709ts8u/xCLajFSrR0iqOfyFdf7doX32
         x+AFhlbxzbJEa2ujX7gwDuijKF2bkIC/RxQgJAINpLrS3uJzu4sk/2KWmb8j6iVYo5Gu
         ol/A==
X-Forwarded-Encrypted: i=1; AJvYcCVpAMCmvP6e1MLxrpigoyrp1RrXrqV9CXlgwVZsVDNmRHZezMp0cgc6KS+MCHFzT0FwHkHNrMhkJN0q1jgd2QDc56kzFed4J5Qi/d6f
X-Gm-Message-State: AOJu0YwhxyhKaJ72kzTJ7zILeeCpyx7/6HPl7mecXYGzwOULexlu1ciO
	yox3i5kQTVPGTO5tDSl6DUIcYtX7LN7FhImvDp5fy6K115Pbh6Yu4O1gA7yZBTrhibuvjF2xvrM
	Udd1ruwDxSRjSJQuOXrAx+++Gj/dAm1MZdqzCGA==
X-Google-Smtp-Source: AGHT+IGmwaMXnIIeUIA6Bhmf0jz+VJ67d+9hoLzM+6q8PV0Woj1UIg0FkmlH8MD2QBtjAqYNuO4XZHGyfTuC4wsmq/c=
X-Received: by 2002:a25:aa67:0:b0:dcc:4a0a:d0ba with SMTP id
 s94-20020a25aa67000000b00dcc4a0ad0bamr1554828ybi.63.1709199378444; Thu, 29
 Feb 2024 01:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-22-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-22-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:36:07 +0100
Message-ID: <CACRpkdZ01WqbRDA2B-8cM98RkPtcRbpf06oF2xHhYdfHqPhACQ@mail.gmail.com>
Subject: Re: [PATCH v2 22/30] gpio: nomadik: support shared GPIO IRQs
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

> Support a single IRQs used by multiple GPIO banks. Change the IRQ
> handler type from a chained handler (as used by gpiolib
> for ->parent_handler) to a threaded IRQ.
>
> Use the generic_handle_domain_irq_safe() helper. The non-safe version
> must be called in a no-IRQ context.
>
> The Mobileye EyeQ5 platform uses this GPIO controller and share an IRQ
> for its two banks.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Patch applied!

Yours,
Linus Walleij

