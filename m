Return-Path: <linux-kernel+bounces-86446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD2886C579
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC69292753
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50965605C2;
	Thu, 29 Feb 2024 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+NkVQ4y"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD275F86C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199412; cv=none; b=qbYPrv+XQSbajWsu6wu8HEK8uyk3pNPIL6DDtQLy3oyTl6/zOa9qyG71840LBbx0PIbKBiLzuXevyXnYVFZo31vz9L4yums+jdo8wP1eElSG7W25Jf+g0ELhiavvU5kNdCyjU7X9QHnCXlEA3TnCO1cYvAJ1w9PUI5wLF41KG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199412; c=relaxed/simple;
	bh=HRVE6hg2C8i2UwVPXbLbNe+/2xcMJm0w38qFCouRcX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nO/pV3vWmNdTb5scl44CAbR5t51zA5LfvEWq9sUAl2Hlex2lN+8aG7mnJWjTew+aewtXnjuVe6skdMuNj/z2/m5SMBhfZNW4B6HafUYCoP2LGUeb3SIIBKrYrPYrp2C5lsNOfJPPEG+XfoUpNGS54/vBrf/06kJjC04fuvOgnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N+NkVQ4y; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso784723276.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709199410; x=1709804210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRVE6hg2C8i2UwVPXbLbNe+/2xcMJm0w38qFCouRcX8=;
        b=N+NkVQ4ym+hJ++FuHGWxjCQntnhgkVRmzxwVeleBIaOaEfaso+MqdJ7pXEeiqu2l1c
         iTjOgvUsCG4LvuyDV51EmtTIy3iBs4qxbI+QiOhegFj1/+JVpLt01/xc+3/exjI4T7kv
         qBqacYCybOydjJT8n+JR0+bi1qja12bQOGApRr0i9D9yoy+ughHFyH1GOoneyZOBzsro
         /YqneMt7yNFDRMPiziP5ET0Y+zgicspC/OM1Pbeua4idX2n9O4BhzWSZPhI2UoBcen9h
         G/0UMurtPgSZbJizdEbmXq+Bq99wcqUhREtlnXiwul9CZzz7yYn9EiLXJtIIM0OMHKdK
         fTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199410; x=1709804210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRVE6hg2C8i2UwVPXbLbNe+/2xcMJm0w38qFCouRcX8=;
        b=Ru+X552fQ/xA+/RKSE2SpfM0TEx31yF6rO3FUFPPcUlwezrqokWlaF4DU4hTgRQU8O
         PYfjVTz2rcRBsMHZVwLPpldC1OQMjZxwAETWjosH0FzlwHlvbHNUXlBpeP5YE7iAP0+e
         qXBARBA6XHUc1j7K2Dw0ymPqo7ybX4L7TVgy0PeE0uy2W38jQvBNkOI0oXRSEyY7gVVw
         4LVflJ4X/W3KrUDAETew+QNCWVWXj+a6eIVkrjhk//qXhyrqC7+LzfMzUaWy22AwWgf/
         wjZliVC0b+/Y1mW57MUq8BeyuRDUKZUoH1H8604qnnI8N7mj21S42Yzfv8KeSh87GLIo
         nQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCWOo2930IJOVKds1j/EjltWCLPA3rupbI2t5LEEm5HHHY9Gh85CtJ5A9x84IKdK4cirWVN9Gi2zLf6tMiIYLcUZ7bMAMXrKrFIBeTwb
X-Gm-Message-State: AOJu0Yx0hxDVcZ0XsvnZEaSgW6DH6+PO5yecL+4ZyosoSIjMDrN2TSFn
	kUIERSyW2tGwsByHHNwgmhNv06GolBkAVyzerr+vbmd95WgyhBbmf/jbSR3YA1BGpqaRRqBrNC/
	W0bWshRx6BAuXFGhtRQFWtLjlsne4MhmuzVR9uw==
X-Google-Smtp-Source: AGHT+IHhsAuM9klDDxUX49OMI/K+reZg5M4GVu3UBpyFzS8Yyn8s2dq8RMcE87J3B6/nRu2TcRiTs79BHRiZCfGsL/g=
X-Received: by 2002:a25:c285:0:b0:dc7:4800:c758 with SMTP id
 s127-20020a25c285000000b00dc74800c758mr1523503ybf.10.1709199409964; Thu, 29
 Feb 2024 01:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-23-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-23-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:36:38 +0100
Message-ID: <CACRpkdYniG8Mf-Bybtq5t8VGZvMvBcugise7g78H19fPDn24aw@mail.gmail.com>
Subject: Re: [PATCH v2 23/30] gpio: nomadik: handle variadic GPIO count
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

> Read the "ngpios" property to determine the number of GPIOs for a bank.
> If not available, fallback to NMK_GPIO_PER_CHIP ie 32 ie the current
> behavior.
>
> The IP block always supports 32 GPIOs, but platforms can expose a lesser
> amount. The Mobileye EyeQ5 is in this case; one bank is 29 GPIOs and
> the other is 23.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Patch applied!

Yours,
Linus Walleij

