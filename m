Return-Path: <linux-kernel+bounces-136584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CB089D5C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3A6284E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62918004E;
	Tue,  9 Apr 2024 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="24aIgIE5"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02E7FBBC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655772; cv=none; b=pcaAXTOzbCdYN0vJOfsJdo58s6Zhmjn5bloRrL5cbSdoUc78xzaYAuf4Jl+EdPr7IFKidPbX0l3GwU0AgMRb2hBXdz8+CCIqKLNGEu1hWtbg941VKeN4DnjzzRQ7X+SrO6oLeXqCWiTaGhl5hOPLExg/S0S5HS8VJ/7l7zQRaCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655772; c=relaxed/simple;
	bh=ytL7QdYp2hCqyew7adjYY1rWgd8CDCZw9v1gyruAj60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVFv9G8ekX3Rkj8yg/AGuPuifRO2ta7xssfuFxbD/7J91PVzZnfLrDPSKWLWtmag6Jmu5vcxXjMW5cWsvn7GujgOKNdTK4gICczS93bbaK7p6fnasEw4whO2FOgdweyMeOL21PnV43IbK1GTLCt+6lVKlv1MH2Kea5YXPKqAyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=24aIgIE5; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso68090771fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712655768; x=1713260568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRkNsSj/lYNCA3MRycU0zvpqCVRND9tlWV8O4KsTnlc=;
        b=24aIgIE5l28MQNHvET+s3C24ag0SoSC46oVvfz/e4VBtyuEWZ5PbH/Omv9IktBmAXW
         fPCm2/G4EdjNcxxrfkZHCIucBiZmWMnVAcGrezFIQCW1EeSrebkCULblOK2ow2AEBZA6
         ScKTVLz8SkDxV3ZuI/GnoQg7FTwAtHEaWGLfU+2tVv+Y/x4sRsWbd2dBM1008heX5Ekz
         xQpF3v9tAGD+bSzz9zfYR5p96a57/H6Qd4xMkK4LrIPSj5bFiYYbEgMztmrPgMkRAu8k
         smePAjVlnlP5QSduD0z1R3/IkWL/t6F7AUvnkDwAsT40D/0PbwpFw1swGMm/RYlr2pLM
         yMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712655768; x=1713260568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRkNsSj/lYNCA3MRycU0zvpqCVRND9tlWV8O4KsTnlc=;
        b=So684ao+4dPZppucqiPVcKY4JVhNcTnG6wp1CURR2rLtqU74UfWgSKWwxINsP2zft1
         ws2aI/O94qo2iiP3lkB+VMUjY0UntZVNxnRQ531crimGSDnOXotg7rCHCMeHGEcTqpJu
         59qsCFNBmBZNYOkDBDcWAfmeN8/IfGT3OO9gJwO8n1IA/Ms8tN3eSFNv27GGi7wTXdqP
         xPPI/lTwgEYrya+NArnQxi6xAr8peWMUbB0dW9cwvbAO/5X3ETzQJeKjzAGfBSZMoMFc
         2WQPwFLI+p7JOV4A/+DoSoYlRLPcnNxf5uMGhpR/3RRBguFmOC7M/jfgR8+zIp8tap8A
         mHlg==
X-Forwarded-Encrypted: i=1; AJvYcCUaISAIYMigQtbB2DJQfC6RWKPaf87NlJbRma6Ca0WsFUAdwDGYWmfYjoCsIK1yxd3bZsPN1PCA+aNmzLHUPNMQgGmTagnaD1Y+9Fqq
X-Gm-Message-State: AOJu0Yy/jE3J3ChosNHcXGfM60pZoJr31cPGkRnZyeV3T2TxHJnj6U2X
	B52r77sFWkX+vmK/CuA4utQMeuFnUxrrZfT5V7Vv240U7uVh1S6pNAHQAO5+5t3Lw11mLuJ4RJr
	4fMZm89AMcS6cpeTLCohVPNS2RUNrxxccoKqh7g==
X-Google-Smtp-Source: AGHT+IGLok3BTsdCtcp+mQF0FlIfpGRtTXkNrJj6FjV/E2JhCIYngUvEmtKxHaZSUGiU6FzXlS6ipOOBorjeZLPGLJA=
X-Received: by 2002:a2e:854c:0:b0:2d8:5af9:9097 with SMTP id
 u12-20020a2e854c000000b002d85af99097mr6406610ljj.42.1712655768359; Tue, 09
 Apr 2024 02:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com> <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 9 Apr 2024 11:42:37 +0200
Message-ID: <CAMRc=Mf73fFHo83gNvDXGy9BosB1MNz_=8kt56hLA12bPBb8CA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:17=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The GPIO_* flag definitions are *almost* duplicated in two files
> (with unmatches OPEN_SOURCE / OPEN_DRAIN). Moreover, some code relies
> on one set of definitions while the rest is on the other. Clean up
> this mess by providing only one source of the definitions to all.
>
> Fixes: b424808115cb ("brcm80211: brcmsmac: Move LEDs to GPIO descriptors"=
)
> Fixes: 5923ea6c2ce6 ("gpio: pass lookup and descriptor flags to request_o=
wn")
> Fixes: fed7026adc7c ("gpiolib: Make use of enum gpio_lookup_flags consist=
ent")
> Fixes: 4c0facddb7d8 ("gpio: core: Decouple open drain/source flag with ac=
tive low/high")
> Fixes: 69d301fdd196 ("gpio: add DT bindings for existing consumer flags")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-of.c                     |  5 ++---
>  drivers/gpio/gpiolib.c                        |  8 +++-----
>  .../broadcom/brcm80211/brcmsmac/led.c         |  2 +-
>  include/linux/gpio/driver.h                   |  3 +--
>  include/linux/gpio/machine.h                  | 20 +++++--------------
>  5 files changed, 12 insertions(+), 26 deletions(-)
>

I don't think ./dt-bindings/gpio/gpio.h is the right source of these
defines for everyone - including non-OF systems. I would prefer the
ones in include/linux/gpio/machine.h be the upstream source but then
headers in include/dt-bindings/ cannot include them so my second-best
suggestion is to rename the ones in include/linux/gpio/machine.h and
treewide too. In general values from ./dt-bindings/gpio/gpio.h should
only be used in DTS sources and gpiolib-of code.

Bart

