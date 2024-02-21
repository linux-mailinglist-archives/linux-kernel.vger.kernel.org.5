Return-Path: <linux-kernel+bounces-74818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246F385DBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A731F24823
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7B177A03;
	Wed, 21 Feb 2024 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUyuvw68"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779F55E5E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523122; cv=none; b=NdCscdaCiAlnGpAAZ9QSzKKWvcnAqpBNzGwGiSh9brDK+FRQwCHC9I+rGGQmqY6zli0eFYPL9HY1CKk/6IXfVl++6bXLgnIG0QBjSWqUu8yK7oIPeaE3v8l/ASuOxz0J26/6C1NFxcj40N56i5Dxa8chFiFxojDGTKdfmDj6lvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523122; c=relaxed/simple;
	bh=uko49LY5PDi6sJGCc3e37qoxszoEEaGB98cU8E8eW+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKeacJjvCaV9bWs1izaAJZjOW/cLSyoASKJNOxh4omES3EGjkxRb/JTkav1CGs7uQGdDxy8wQ8X6SN2mYlRV0rmerC8K4BJOKW8PlfCokUbGyajaqvWykVfAHg6+I0kX9AeNuFyIrCDB+wufyu7KYycTw5DtykE31h/ZUOBkkmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KUyuvw68; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc745927098so620505276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708523119; x=1709127919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLd0dJHTNtVDHjhS0Xex16qn1DWjQskUbDg6XGDd1Bk=;
        b=KUyuvw68RXeyNuMRTTY83+f468Q7iU2AeJan6dROpwKidGcuOCUI2yKWvLDpLhOAZP
         IS2cmHzaKbs8h5aPGcGGuxuZp4VDGTFY+AbcudSXYBCnnSnhjnpB/GuF6DNUWJWSbtNB
         jpbL5s+Z6T2r12j/iWh6QGm+XYdHNIOOBvUoHF2gPVb721yvzDFUxM58RMD91nth7Cg7
         KHL8sc9Y5Pah7GxZ3mVKOLxJxMPOrEY9+8ovwjNyNrfqFwKS3ZjiTNw4ZwG5/BKHC3Sh
         fL3HmeUYhvqk+ZRss1YLvjKHp0eVytglqTbMpf3PW7MeaEetlTSWVBGwpqnC09NZ0gVB
         vsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708523119; x=1709127919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLd0dJHTNtVDHjhS0Xex16qn1DWjQskUbDg6XGDd1Bk=;
        b=gr98mXnEam5Q2k20dv9TpekAwKNtEIhg68bZjfaieQ8mNfSN+fZXKuYpSHVw8U2XUE
         6U9nVv0b/AQn1/zouxIh2h8lpvWkvxPf0L81+g10b6N4l5GNHb/LMadB/1pmseUp8Zuy
         ILAVrLSO4vgr5p+8EwvWqj1i3sAc7qyHckwjimlvYAeo4R1WCxsZMPdQaznCZ88wdkpp
         mN2iqlHdfxx/of9i8hxmDKKaZyU6iMyk59MmhWT9Tgmq7RSHSLYGY7v1XwwI6qQ+JybD
         4oZHUhG9HOxf8BP4pnupKSAw73wPDQhrQTxHQxNBwR4YXwUjw7ZOIAkgIvjuY7DkJgEA
         /i7w==
X-Forwarded-Encrypted: i=1; AJvYcCWXMzf7QKAVoyNkcpMUiXivfnq8393+J68K2F023K6HnmWKnneQrkj82+3BpA6omiL6iuj0mDuL7zyXDPad/8+9SfvCcXGBNBSF2bnN
X-Gm-Message-State: AOJu0YxIpYnpPdlBpjELX2/a+iqosAaZLT8JJCRX6Iim7LODiKUOAIKq
	d9W5hURnS5UN/fxHdQkOKr9ecWiin3u6FdnRQntZoL7iXztolbgSWddbnEZVp+OcBpjqr5mDPyH
	dCRtl/NHeNaP3T4y8VWuOVw7gPqFtHq/8fWIOrQ==
X-Google-Smtp-Source: AGHT+IGFBZLHG4YEWBicAng577AS9VIS0KD8vWVWha8/tAFMiKzC1C1Hv2xo8F+45n6/9msqO0M9ChNKgr/xdK8THek=
X-Received: by 2002:a25:e0d2:0:b0:dc7:5c37:5420 with SMTP id
 x201-20020a25e0d2000000b00dc75c375420mr15835997ybg.60.1708523119618; Wed, 21
 Feb 2024 05:45:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com> <20240214-mbly-gpio-v1-18-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-18-f88c0ccf372b@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 14:45:08 +0100
Message-ID: <CACRpkdYb4V5EouMBYRRrZvLT1v6zKEtjHGPAs5orDKoo6dz6nA@mail.gmail.com>
Subject: Re: [PATCH 18/23] gpio: nomadik: support mobileye,eyeq5-gpio
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

Hi Theo,

thanks for your patch!

On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

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
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
(...)
>+       bool quirk_mbly;

Compulsive abbreviation? I would just rename it:

bool is_mobileye_soc;

Nevermind the long name, it makes it crystal clear for readers
what is going on. (Rusty Russell's API naming guidelines.)

With that changed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

