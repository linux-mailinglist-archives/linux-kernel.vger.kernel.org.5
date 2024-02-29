Return-Path: <linux-kernel+bounces-86371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983A86C488
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B2C1F24BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E021D57883;
	Thu, 29 Feb 2024 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYyyGafn"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98057872
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197815; cv=none; b=MwN9gtOFQYUt9f9c8zV6DSfhpxvJaBXmpjdt1cqXbRJuhM6vKA2Z9l7q9sxCS4LQnQRz+nDEqMgtaSn/ebPzu3M+/CgKDkZjOZCkJAm199HleXQJ35543qIcEbgafUwxEeLWnSuTdULuKy0JvBORbnR13ygXiR3UxExO3nid9sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197815; c=relaxed/simple;
	bh=tYdJ+lGX899NpFpW1u0FUrL3zEubIxJzBAKKeOGPMZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGVMwY/mgi0N92+xzBQbIft9Awg91OjyLeBMx0dSiPaY3TilQRMeG5jU+bj0yxjBVNDNBiJvwR1cKyghYZqSObve95X92z/2Fhse+Oeh4K6f0bRrKBT6uYhEx6fAHwPWdhgfplGPYjuasrXJB461A8NCEY3YEl0ejfwkkj5MBd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VYyyGafn; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc74435c428so772427276.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709197812; x=1709802612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYdJ+lGX899NpFpW1u0FUrL3zEubIxJzBAKKeOGPMZ4=;
        b=VYyyGafn8fYGXuQTh2xN5c5sQsoO4w6w3ncvrXbvv04Sj5JaJXCb2ooJugwbKjCxKH
         Mhk01/9IhHaCijLawXqFNJnBA95C8jGDJgcrJtRpodS962DD7MLXK8rNCZwaPG/DDYGA
         UHUDCBwG1ejM8SBLtN1eBQorWj7hLPNQNZlXa+dR9SIbjS525p9fgoNrKLW3U4wHrcx2
         Fd02ykhD43s/aZsIO1cSHs744aKGRMU/KlfbdJkmBf22/Dnujc3zSXQw4TXhjH14mybV
         nMGq30zi7x0Ps21bqgq6UpLaPHO3Qmlk3t5Ji4b2DNDVNPphQJdKgKct3k5q30plN+jz
         q4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709197812; x=1709802612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYdJ+lGX899NpFpW1u0FUrL3zEubIxJzBAKKeOGPMZ4=;
        b=Fl+xfloTaSUx8Q0ndOvAGz9jKgzEsxPeAoBlt8WncSPAf6PYR2ggSQO9+IcbVnrsTs
         FPbAfqcMJzTlvtpsz5d0LK4kJOHnJCEZg29UJY+qx7Ne64D5AOh5SpxEWaBjSbV9l/vk
         bIenrfRyKuowWD477+8qGGuwN3eH6TZdRqTsuw/4bO+YW/0hvjERi0xvjzDAmUY4tyCp
         +Gaxmi0kO/q+czVmHNC1qyxfnH2Zj6jhP46BAIvhsW+vDxYn4p+TKL+n9xN2pQ1SVlBX
         PXrjgKW9dP5St7hLH7TZRT6b2tcTAlOqtNiMAP3GxDnE/prSe8iNuHOin7pOezziNR0o
         5duA==
X-Forwarded-Encrypted: i=1; AJvYcCUuazRjOI4LA/S0LiHIinU1xJm0wHNxa8iJnZlFITHf7VUu1h8+CzHD2ye7OGF4U3AT1KTDVhS9mNiuiuVoioYDqeoC6nmdEAiV5oE/
X-Gm-Message-State: AOJu0YzqmgIbsl7cn33X/YYDxpmJ0et49hBpaJJNvF3dgBWDIU4OrSMq
	7hRzBE/x5680xU15a9F3Z3QFTQYlr7SCfkPO8Stk9cxKPwFJqyMdeyoME/Sk4741bPOg6G9bTJd
	7CEt906JYnLaUurwKWOMrGQ1T6XwUFkkj0XoLoQ==
X-Google-Smtp-Source: AGHT+IHXJtcxUypOTtLEATMHHzOH73b1Xs7hatFkLIIKeftmFvPSBf+tk6/aFwSpb+kgIHj44bbTi43CvloDA6E8K+M=
X-Received: by 2002:a25:ce47:0:b0:dc6:c32f:6126 with SMTP id
 x68-20020a25ce47000000b00dc6c32f6126mr1820937ybe.22.1709197812659; Thu, 29
 Feb 2024 01:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com> <20240227-mbly-clk-v8-1-c57fbda7664a@bootlin.com>
In-Reply-To: <20240227-mbly-clk-v8-1-c57fbda7664a@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:10:01 +0100
Message-ID: <CACRpkdYT_A=PAn83tJvKibLAjcXekw-WABERgKQQFoFi0dxSEg@mail.gmail.com>
Subject: Re: [PATCH v8 01/10] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl:
 add bindings
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 3:55=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Add dt-schema type bindings for the Mobileye EyeQ5 pin controller.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Patch applied!

Let's start applying stuff so we get down the depth of the patch stacks.

Yours,
Linus Walleij

