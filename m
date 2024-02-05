Return-Path: <linux-kernel+bounces-52210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A1B84956B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADDF1F23818
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632C111CB6;
	Mon,  5 Feb 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="f6j+pZbl"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872CE11709
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121821; cv=none; b=kDE/MrPq/ejR0rWOAnrn4LH39nqIzdbu2ETefw2bCBdQk4s8niAYN7os+3KKzxnV09GUqTIg48EfRN8PR31Iw6FrgOfwii9dRCpT4G2ZPeKrQPKb8ZaUohvCAvX63wN3P6EoWMYt8xPQ2xtjy9lEvUOF48SN1FMaQtc+6YxX0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121821; c=relaxed/simple;
	bh=nlIMxqjJPSzuxtueVeijM4g7c6JXyj/R/N8/LJ/xQio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCtiZzjEGGmNcg/X+AbtnwpYbcnPnjWBGEaxnMAZOtp2ymjLlkw+GwJQtLnlCuGzJ04tcG8/GEq18I9ySINzRz8LLx6OuSLwVLYVye5KDVptRE1G+j2QYJ6dMFPZ7qTK5pkGRZ1T+FhK+paKhonx8VLDB16nPB6q1bMcBtIpGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=f6j+pZbl; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-46d27358039so45670137.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 00:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707121818; x=1707726618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNCUJBIaTHFkHjFjWMjXIHtC7NKJHWwr9gHKOI9UqWA=;
        b=f6j+pZblpL57ylpLIYExLLWQq0HBBrWQxXMkceR2/Mvuh3nns7bX/gTevUPg+MQ2uN
         xcusP9D5fZtZ6saZc3cWmVKc/R5m8L01lYH4V/1XZVhkyRWJrMQE4URkD7ux+ZAPwFqh
         xKncEB5v2mEEdiNME1tZUVaZMberVmWnt/7lsVZS14mTgv4BFZcdwo/wELQ8/1cqj6I3
         vYfxYPRQBCGBjSGln+pbmBRvwEgPdMNisD7CfXYpOfdLb69Unq5vh+IBeMOHEHGMEYYR
         LE3svIGTvz2TJjQkJLh0YHOOVIF2bqOVqGpOYULUDbomJBB8G2omWIkdRRo8yD6Xko2p
         J4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707121818; x=1707726618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNCUJBIaTHFkHjFjWMjXIHtC7NKJHWwr9gHKOI9UqWA=;
        b=PxLWejfEfPM7nXG63ArVJminLDCvrr2nEMCWoO6nF2ENUc6uzwKLZ8+GOGwbsAFZ5Z
         AwLkZMG24LlnMIahRklZPyRc0JVtxEu7pbbN/ZS4oemHnw1anMDThL+jYyAvZispH+2t
         ZZWCMDZUT2bVD0RlbTkzEV4ImibZ2svZSh8InSwHga7bdhWdZHqbBuDkKl9XpS2Qaxkn
         FJqnX6l9moiEL10z0c87s3f9KICXFHxHOBh+ksxNBRlPEvheI9iHWC9wwgX6xiGFyNym
         f8rEFxQz3Lfjx/TlOzzc1JCvAIzIIOlLjRbhMBHzbnf9gk64y67he40qvWZmeFrRPKcU
         0Gow==
X-Gm-Message-State: AOJu0YyfWcui6IIc7XPdaF3tZWClNwOXJfSL7GTJfTWogI7gVdTzSJz3
	dy+swQtz4cwcjUFEaVmR3Xgj/dR3UXGbUET5V2+tvdlQ+D9dy+eqB4c1C+gZsALDkfsgQ+S9uU/
	aLkxwWQkEac4SzQM8EheWigvbhGZYlBjKkMs82w==
X-Google-Smtp-Source: AGHT+IGHJM13AnHqcxTdJ7seBTXZ1xKUz8/lRLWAbrplrgbQQv3QnDgC2qllQbRvzT9A/qvGNwDI4f6ANUPuAbNLE7A=
X-Received: by 2002:a05:6102:21c1:b0:46d:237c:4d6c with SMTP id
 r1-20020a05610221c100b0046d237c4d6cmr2355500vsg.1.1707121818496; Mon, 05 Feb
 2024 00:30:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a8396308c995959349fd40e61199853a9b711ece.1706783050.git.michal.simek@amd.com>
In-Reply-To: <a8396308c995959349fd40e61199853a9b711ece.1706783050.git.michal.simek@amd.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2024 09:30:07 +0100
Message-ID: <CAMRc=MdkFpvkpsrc6k5GgH4kk3V+bNX3_G4z+pRdPWSm9QH-Ew@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: gpio-pca9570: Add label property
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, 
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Sungbo Eo <mans0n@gorani.run>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:24=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
> Add a label property to allow a custom name to be used for identifying
> a device on the board. This is useful when multiple devices are present o=
n
> the same board. Similar change was done by commit ffae65fb1ae4
> ("dt-bindings: spi: spi-cadence: Add label property") or by commit
> a53faa6bfa3b ("dt-bindings: hwmon: ina2xx: Add label property").
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml b/D=
ocumentation/devicetree/bindings/gpio/gpio-pca9570.yaml
> index 452f8972a965..6f73961001b7 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml
> @@ -28,6 +28,9 @@ properties:
>      minItems: 4
>      maxItems: 8
>
> +  label:
> +    description: A descriptive name for this device.
> +
>  required:
>    - compatible
>    - reg
> --
> 2.36.1
>

Applied, thanks!

Bart

