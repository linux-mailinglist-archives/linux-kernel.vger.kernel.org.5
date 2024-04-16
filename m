Return-Path: <linux-kernel+bounces-147549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEAD8A7618
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDEB1C21C61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626D5FBA5;
	Tue, 16 Apr 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="arJ5KGVQ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68E56B7A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713301693; cv=none; b=NinoWVJ8TFii/0ZyXoxFxKqkywIdiJ8XYxGTAveUjA2vrcs4W4mk1Ti/OdWBV7RHe3lEFV7OdnYP2+/sMukSh7XZX/BVnS6lx3sO8KoYGmKx9L2fgTc1O7m8g+SeN3cPxFSFClj8n1lGzTdRjTwWmpbCs8q8NXXeL/hZzgiI2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713301693; c=relaxed/simple;
	bh=UtU4N8okJqSAEdf1gnSV4ZXUyH8a1M/0//8qvJWf6cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5QLcRyXMd/z5o+d2D1cPaKMDXGvI02B2BR1CW423Sr2HooXJr/Nj8DiqxhGDadj8n2ISFt89mZRQpDxBtFFwem7mmGeWUGhJNIGPyO75YGq46WswN7og693od/i9O7B1+lfAyYHFwkEfNzo0qc15RBsZj0YvipHhvsMeVgfhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=arJ5KGVQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-518e5a74702so151944e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713301690; x=1713906490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtU4N8okJqSAEdf1gnSV4ZXUyH8a1M/0//8qvJWf6cM=;
        b=arJ5KGVQS2l3pHCWt+SSVMZRDcS3ohbxb5NTEhA/lnOPBqE8TwNQxvHYBSBzYA/Da2
         jIGozS7S1xtC3FBFW6Rd4+REeDmX85Cpw8G8o+iJYAL9PS9IMWtr+XNVRHrvZvnmnpx7
         bGPIRwmH/WQ0RbNNoBmspIQXcGyRdzjEVL1oWNcmMNAtVYwMMMJWnyu8JFfXvHB5E9cz
         BopvktTDI5oo9NRjUY4LpFeWOGCmJX2CgOcx9DQQWWG+NH8hQKFTpxVvy9tSb9u2cwVU
         I1xIllDoOz6cwN9ObB/0pUMCJKWXeCF840twRtvm3Ot55cUioAzELVybLl3R+PIuycll
         I5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713301690; x=1713906490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtU4N8okJqSAEdf1gnSV4ZXUyH8a1M/0//8qvJWf6cM=;
        b=tvlEC2Ivw0xZhOxXONj4dcLEbMcmorFpXIa3dxwnzB1toUGu+V128Mkt9I7SQsi5Bl
         ceke/k/db+xQAHhK/+mMklNPXnjfAc2bpMgazBMWlE/8/m35OATOlAELF6wJKaGkHmEi
         SMuRfObo2VdBgBUKfm4ClYX/Y0vXzqJ4nYlJNrCMPXofMv6USVJ6tC7rqla1av5q5RKN
         Y3H1Ooapg/MqSgF0duzKBnyHEiLz+U2TFsMCu3BZ/uNbqzBg8PnUL2yPMajO6FoCs39e
         HVGemhvzOVf+B/xKD0EKogvFiEOtd6WrAFTyuuBSGX7c9QDkzHhy+C+x3j1C0oZDlfOx
         /MmA==
X-Forwarded-Encrypted: i=1; AJvYcCU+ub3SIFBQ0AuHrcFmOHYlwZryDjSv3/pk8GXXiKqYS3ay4QVnXbkZcGd+PH+EXJMM3wWJ8oveGTF3YgylDERWU5yZOopJnaHJLL9M
X-Gm-Message-State: AOJu0YySdk/e//1NPaYKU5khUz9BClMyW942Bl8yiYWcGYh+A4iavFaY
	C5I8Nh36iS9rs2/f7UlqCJ18E9U4ThJypsBLP7L89Iz9+1Qm7pi7T5U+B8DI2YPiw61gtdBkrI9
	Hvuu/A3wUjK8Sd753D+j4h+iQxKjCoW9fb4Tggw==
X-Google-Smtp-Source: AGHT+IE8/UaVIMjV4kmwMH0LjKA/GWyrorfbQqNq2ie3gzWFSDuXaYK3c2mtzJXVYq5vskx9fsdHL6C1Ceqc7XdUXW4=
X-Received: by 2002:a05:6512:1106:b0:519:3643:c3ee with SMTP id
 l6-20020a056512110600b005193643c3eemr586278lfg.14.1713301689792; Tue, 16 Apr
 2024 14:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
 <ZhlSaFWlbE6OS7om@smile.fi.intel.com> <CAMRc=Me489H-mTfT1hfUsY47iKwoaVsf6sgkiBwBVkxJOBo9UA@mail.gmail.com>
 <CACRpkdZRp-DFQgb3=Ut27DHd1w11_aEY0HbLjJHob=C5Ek-dyw@mail.gmail.com> <Zh6FkejXcwBTAqIR@smile.fi.intel.com>
In-Reply-To: <Zh6FkejXcwBTAqIR@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Apr 2024 23:07:58 +0200
Message-ID: <CAMRc=MeXV4_MT5_DKYtHqO+324dFJnr+Y1UtR9w9mj-y2OOqAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 16, 2024 at 02:22:09PM +0200, Linus Walleij wrote:
> > On Fri, Apr 12, 2024 at 9:44=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
pl> wrote:
> >
> > > IIUC include/dt-bindings/ headers should only be used by DT sources
> > > and code that parses the OF properties.
> >
> > That's what I have come to understand as well.
> >
> > I wonder if there is something that can be done to enforce it?
> >
> > Ideally the code that parses OF properties should have to
> > opt in to get access to the <dt-bindings/*> namespace.
>
> Whatever you, guys, come up with as a solution, can it be fixed sooner th=
an later?
> I mean, I would appreciate if somebody got it done for v6.9-rcX/v6.10-rc1=
 so we don't
> need to look into this again.
>

I'm not sure you got what I was saying. I don't think this can be
fixed quickly. This is just another bunch of technical debt that will
have to be addressed carefully on a case-by-case basis and run through
autobuilders in all possible configurations.

This type of include-related issues is always brittle and will lead to
build failures if we don't consider our moves.

Bart

