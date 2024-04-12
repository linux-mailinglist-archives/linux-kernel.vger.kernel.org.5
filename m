Return-Path: <linux-kernel+bounces-142226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6628A2928
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B92528256A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4CA446B6;
	Fri, 12 Apr 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnL+1Sr3"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA650277
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910037; cv=none; b=Ugoh9pbxMePFgiEjimrezLoWJ88nlBbf8ZU+jZhSbvjQA7WYMRlc9ooM5BjzCPed6K1koKVBr8T4PVfaHafiCIXbFhyNZWn0IMjwwCSrQihSRV+m+4NFHwXK1EGvnGKNsgSm90il0LzmbnRyM7Kj52GK9cKf0QCDiGz56Pdes+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910037; c=relaxed/simple;
	bh=Aedlqc/+sWlrdhS4ESFI02d9zvfrw3+3l7iIyP8GAJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3u6ijHntTwZ9thEbf+LhLqLWcXeBtbEuVfZ6G9GawFwXxNhY4CG1rD4LkKJMXy2P6WBzK2xCf6Jheh3aeZerrgWrvLfGXbQ7j7gKnEHq2617HaZweofLeeT/KInEyZ5HBaBoQaR2qJkNPoqUuEAQLot/96QeWEhLXaD1xiMLfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pnL+1Sr3; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so636627276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712910035; x=1713514835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aedlqc/+sWlrdhS4ESFI02d9zvfrw3+3l7iIyP8GAJU=;
        b=pnL+1Sr3OS3NKG3k5J+w65//o3EjhVJplqV+2KPYVP63ibnUzivdsegG5bMc1NmFl+
         winlpfLRlFAJotdxT8oxc9y6xP7pWKNw2hUw+fTdsNjzjtHC8ZYwouyuKAoBhPostRBW
         Sj3U9COIS5VSZKXRLfVDPnCHSWilWEmLMlnTGJmeeNs+NuUhMR/0kF7aFVhVCJbQZueB
         vt6QpCqkvPdz7rwHiYoJ/lnCLELf6oVgufcOiBmPmlrRTfT/sIR4GEZyii2z5xjdJJCo
         pm0F0n/bxuAuXKjkNmaktu5Xx601a2Jh3uVwW9Tcaz2hQHCyFUBUEfsEqhaA7depus6a
         EEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712910035; x=1713514835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aedlqc/+sWlrdhS4ESFI02d9zvfrw3+3l7iIyP8GAJU=;
        b=aQIoUJjiXxns2uDoNowW/h/CcUj253LXVKJK1qPk2mpJ3u7GBwfBQHUHJNP/Xti/vx
         P5CKxrYSXti2n/x40yd+H0n8V0o4lcp4b1D5MpqdwOGnU3hGz4pIqtGonun79UfT+lyw
         Trzui9GUsBSnzY7Q4vXfr5Kfp+BckzoLTiPwph/AVyCuU871tiiwC4ZbhtpqGh7u558d
         6pbCMhhLq0t41JFNEpucL3vmlwyA9ME89Uyg9jguQbd5r1tvLiDR8ataexjsUd3FWFQ2
         DGV5WTdSTzNt96wGfxyUAQeeDry5190HzBb2bKbKp0iDuj6NqwSs7ww+/F+ih9R4nKnX
         l/lA==
X-Forwarded-Encrypted: i=1; AJvYcCWYXOwFaldt2H/M+dZAGdqIBZw4tBOrF9RmMbJSDiJYC66IhOUIcVp6Cwh8eq0q6OFfhc9TSNsXVdNXvCLQFTJ5SCnPnIH3TCZy3bNm
X-Gm-Message-State: AOJu0Yz0krVApqb8Rph6Uwfi6clxA8avRZ2O2+qXIm0tTRIOjrbq9G/R
	CLvv4toQQ4Srrq9ybW/rN5w+wOmdnb9ehSAKp5s9BTvKy39AxIGhiU0tnI2Leni49qeXjxzFEar
	0wWk5fsQJdYykHa7H6z7X88VvHpRYlmEvVJVjng==
X-Google-Smtp-Source: AGHT+IG+4rQ6Eh9nveJlqBaXSsAk+9P2sQbLBF5MFuUjpO/kkQmwqe5TMpDLQMsN88iMDs5uoLIqTTKAs7BUYZSSmZw=
X-Received: by 2002:a25:900f:0:b0:dcd:40fa:7bd0 with SMTP id
 s15-20020a25900f000000b00dcd40fa7bd0mr1617358ybl.3.1712910035197; Fri, 12 Apr
 2024 01:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com> <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Apr 2024 10:20:24 +0200
Message-ID: <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:17=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

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

The way the line lookup flags ("lflags") were conceived was through
support for non-DT systems using descriptor tables, and that is how
enum gpio_lookup_flags came to be.

When OF support was added it was bolted on on the side, in essence
assuming that the DT/OF ABI was completely separate (and they/we
sure like to think about it that way...) and thus needed translation from
OF flags to kernel-internal enum gpio_lookup_flags.

The way *I* thought about this when writing it was certainly that the
DT bindings was a separate thing (<dt-bindings/*.h> didn't even exist
at the time I think) and that translation from OF to kernel-internal
lflags would happen in *one* place.

The main reasoning still holds: the OF define is an ABI, so it can
*never* be changed, but the enum gpio_lookup_flags is subject to
Documentation/process/stable-api-nonsense.rst and that means
that if we want to swap around the order of the definitions we can.

But admittedly this is a bit over-belief in process and separation of
concerns and practical matters may be something else...

Yours,
Linus Walleij

