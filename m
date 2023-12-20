Return-Path: <linux-kernel+bounces-7388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9258281A728
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394811F2273C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA069482F4;
	Wed, 20 Dec 2023 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0BIZ1Vv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039A38DE9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbdafda6155so7711276.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703099289; x=1703704089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/hbo7J2frnI9kAcgSjgY3xoG0ekm9nQwa7Ih1omnQ4=;
        b=U0BIZ1VvqXHypq1VUp/aYEMSvgCCZ4DpS0DuRc2S19FPF78tnUh5l6Wq0mwdOIdgsG
         Wevz/ecnMmiAO1JruO3hRJituWTJnATl4EOX7fbJmRvFDkxPnc4wWFPV2HNHVHhfxFH0
         FK14ANAclxYxdjaRciMCv6mEQPoZLBHo/7Jx/hT4sj2N6TPs9cO5E7s0a+3x+k6v61NA
         UBOh+G1zXW+hGOwdhIQl9taWuu5FeZQkSqQhg52YyMEHzsUsvFWGrN+h3id+2iQPMGT8
         /Hi5f4I+XdjiGvVWQjLBdJ7Y+1+td91WTgF3evB1EZfFJ2WbJsMEkMT6l3t6aobuZqaX
         ys+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703099289; x=1703704089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/hbo7J2frnI9kAcgSjgY3xoG0ekm9nQwa7Ih1omnQ4=;
        b=Tg82WA7FF9NFDwEHhc/Rry4J4AS9dU4QMHPtMKl695R+rcsjRYbb2lJTYPzWtf43lJ
         JMtUBJA9eSAcnyPAj4KgdcAl2viZaqIHfV4EGe0w9BrsD+6mKe94DdEWa3bgyUsJ0Cnt
         2qsd5E5sVtCOKCtASsaO7oWN9ZAyPEUlQgf7q3ZPlefgGDdbJ1IJjwbRfs9KRsyFlCvB
         VUiMtWUxzEEPYTS4mQZH63tAA8TfjfmZE7nIrFaKgWB4esZqOBagt4mdr3SvgsYxRagu
         PPCzzxAfXaJlr1Uhle6DP6ZvexXKG5+FOz2k9QAgBOV+8onB7vhUnOUgmaNbAKdNEODt
         0xyg==
X-Gm-Message-State: AOJu0YzuWmBJNnNULxVE8T68xP8M5ih0D0bMF7els46mAy8w9DdhEONH
	g0AZvwY7OzCL2M15lAFiQiSsYRGUcX85QxYFuTwTDA==
X-Google-Smtp-Source: AGHT+IHES4XmlzfwBWZdC1UDww21Rn5I7OAnN+fxvvKEl2wobubYyI3zjvqPyMcH1YdH3qPmCuQCooUKaYAGGo1TwYY=
X-Received: by 2002:a25:c543:0:b0:db9:84c4:151a with SMTP id
 v64-20020a25c543000000b00db984c4151amr126523ybe.34.1703099289362; Wed, 20 Dec
 2023 11:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220184753.6472-1-semen.protsenko@linaro.org>
In-Reply-To: <20231220184753.6472-1-semen.protsenko@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 20:07:57 +0100
Message-ID: <CACRpkdZqjX39knEMVnhZPCZZAF8YN0yDww5nvS0tEn_pP0R2fg@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: Add missing bmp085 to SPI id table
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, Akinobu Mita <akinobu.mita@gmail.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 7:47=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:

> "bmp085" is missing in bmp280_spi_id[] table, which leads to the next
> warning in dmesg:
>
>     SPI driver bmp280 has no spi_device_id for bosch,bmp085
>
> Add "bmp085" to bmp280_spi_id[] by mimicking its existing description in
> bmp280_of_spi_match[] table to fix the above warning.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: b26b4e91700f ("iio: pressure: bmp280: add SPI interface driver")

Right! Thanks for fixing this Sam!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

