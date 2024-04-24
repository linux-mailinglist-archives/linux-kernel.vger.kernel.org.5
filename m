Return-Path: <linux-kernel+bounces-156546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B408B045A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042F91C2245B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B92156873;
	Wed, 24 Apr 2024 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="w+Id9W/P"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C013D8B9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947485; cv=none; b=GwBsG0WST4Fk+sjt9A+7cZOhz3AXulOuVXYkYlr7lkJgB2ZwWTVwtfPZRmzy7mJtZdktdgtipJJU6k/GIJeID+2gE++YuoylWe+JMRBD83M6K/wStkFLa2ywHoKju6PDXyiZFjADYziL2zK6bYSatNY3dm5NeBoo/tu1LYIOtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947485; c=relaxed/simple;
	bh=IjjbvorUSg6P4VFZn7dSqLjzf30JrNYIj5heKyHMN6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/5RzTH2mOizia+0/C+Xh5fcn2Sz3bIVEj+KgIEftIYfD111sGiW69uLiDpf7JhqU1c0HPJvxjSFK094jeMoLtg6OMPTYO2eElhFLTh3PyC8GN8qh0BhJ19X8r8UQl5rr+6vY8nAAn+8RTJn3rv2UAFe0gCmOFBR7zt6yMCmTPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=w+Id9W/P; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51ae315bb20so5415236e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713947482; x=1714552282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJGoWBDSb5fGAuDy7m4mg3bWQD/UzHjf/v/1vmc9dmM=;
        b=w+Id9W/PgBlMXw4lM5uq+21DzoXXQW08FZFhJP9jHxL88u2/Ab1eAMg/6OHzzEx70/
         x77k/1eX6MBEw+D7mZN/Q2JCYxkOs1QeC2uWiuZ68mFaZS7qoOU1LdxEAHlSTzQzzJ+M
         fPg0ObSmd2fgkIUj7zHryuQenW78nnCUyrS4ZCB3R3XT6BICbxPkhAiRtX+jPeJemIu9
         s2B/CfZMtrxdjQxJKsboz4XDpJkSCqXmeatxkM67ok8vDWqX+3yR+8McSjcemUocHi1v
         3YkNmcm/NFEzPzwV5aLEaObkNz15z6v1hZN6iVSoCusgtaEFZXMVwqv3J4jz1JCz5wy+
         622w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713947482; x=1714552282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJGoWBDSb5fGAuDy7m4mg3bWQD/UzHjf/v/1vmc9dmM=;
        b=j8U+WKcFYtaVVkYG3DLYZKMwgxX80wY1t5g4WWS3L6hmQyn1R2IKIsfX9kbqXIgSD7
         C41buUaB4ec+vVdTU4mHRrUCQRtaGUieSUpvrTQudWWEqSNoM2foNKQrGa9ROu62nZAu
         t7hf1oIq0KO8QbTaXAYEOxa58hA7cEfnrGR/3JOhQQWGxYnopZ+PdQYHPeUNvOAHbKa4
         TNcZKwc35Nb2If7dixVvg6fIdJcNmpixtIUxmI0gvQxB4Y7Tz6oZ1tpo08Q3lJLXLVYF
         jE4uVJ+tnPDaJP2tbh6azOgbt0RXiTOoC9UfziarJQtlTnjxeiWPnMigCTgQcak418UG
         aP9w==
X-Forwarded-Encrypted: i=1; AJvYcCXNDVo5M2qBCbsvwB9UfdAK/uv+nbJXLWkIJKfNatlmUz6A1TSTfpnkD2ovc8ssO+3XO4WH30FDA2hQg8eDvXKqoVNqL0iXgqIGswt6
X-Gm-Message-State: AOJu0YyjdBuOas2QO+SQ6dMnS5VrL1x4JsTuAUntiYasgheBGR5P2qSJ
	WqugkkSAL2o/BpeCkmTDH7bnGL8D0hGOY5qyt/053ySmLPBKvEjN6dfC2b2R7gtfzod1yMtFpXi
	R46pEcCD6hf8ahyWZWlv6LshKXm4TdpitaarcXQ==
X-Google-Smtp-Source: AGHT+IHeUW2RFaYOi3EycgzRf3cpJgpILPKKGH3hJf5GGNnk7Y0P6bC+UwOLzxXOL/FIEabzxw0/mhkkL0RbdpCF7HA=
X-Received: by 2002:ac2:5492:0:b0:516:cd83:71ce with SMTP id
 t18-20020ac25492000000b00516cd8371cemr1176615lfk.31.1713947481572; Wed, 24
 Apr 2024 01:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACMJSeu+fUdYoxue-q=DxFdvtopgshQY+i2kpZMP-RGOTqMu_g@mail.gmail.com>
 <20240423120011.21554-1-pshete@nvidia.com>
In-Reply-To: <20240423120011.21554-1-pshete@nvidia.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Apr 2024 10:31:10 +0200
Message-ID: <CAMRc=MfJokORpEOMkOmQdzTuZxcUAcnmpdEyJWKqvT0gCpuzbg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: tegra186: Fix tegra186_gpio_is_accessible() check
To: Prathamesh Shete <pshete@nvidia.com>
Cc: linus.walleij@linaro.org, jonathanh@nvidia.com, treding@nvidia.com, 
	sfr@canb.auug.org.au, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mochs@nvidia.com, csoto@nvidia.com, 
	jamien@nvidia.com, smangipudi@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 2:00=E2=80=AFPM Prathamesh Shete <pshete@nvidia.com=
> wrote:
>
> The controller has several register bits describing access control
> information for a given GPIO pin. When SCR_SEC_[R|W]EN is unset, it
> means we have full read/write access to all the registers for given GPIO
> pin. When SCR_SEC[R|W]EN is set, it means we need to further check the
> accompanying SCR_SEC_G1[R|W] bit to determine read/write access to all
> the registers for given GPIO pin.
>
> This check was previously declaring that a GPIO pin was accessible
> only if either of the following conditions were met:
>
>   - SCR_SEC_REN + SCR_SEC_WEN both set
>
>     or
>
>   - SCR_SEC_REN + SCR_SEC_WEN both set and
>     SCR_SEC_G1R + SCR_SEC_G1W both set
>
> Update the check to properly handle cases where only one of
> SCR_SEC_REN or SCR_SEC_WEN is set.
>
> Fixes: b2b56a163230 ("gpio: tegra186: Check GPIO pin permission before ac=
cess.")
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---

No changelog since v1. No Thierry's tag. Please resend.

Bart

