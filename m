Return-Path: <linux-kernel+bounces-46090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E35843A49
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282B3B26A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2603B6F06A;
	Wed, 31 Jan 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+Fa4+xk"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954B6DD12
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691619; cv=none; b=GvkcFdA+lwkjbzlH0f+48Mlw07dsKUjH8Q2Prhvub7DNJZUSDRyIYrNIVLUGtl78wAQKsm6WAI1RF7EuBltN/xnNNj0+js/PXjLJWQ6Okfn5j8aPqFQiXDjj3r7gw4pVW9Q5KQ6+iSe/Xz5TFwbqc5mQN0WGh3uBFVJdS7PXWEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691619; c=relaxed/simple;
	bh=4P30cDZJoK8lB7gKvnrdCDa1fyR371TkfVJY5FVRBso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WE09jEDJMvddECEHROJXDizZJVviDQrQypgHRkG0A/aWf97DoIVewP89bOFOGzCbqDyc5V7WpAM7augJNUQBzDBNwSBX26eVm4BJ9EQrWtb6do1diXeOuTg4r+LYIAyFclWAiBvnQsVQRwbHdfXq8hrfUdvOYI7zAnPGoW+kRYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q+Fa4+xk; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff7a8b5e61so45972817b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706691616; x=1707296416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P30cDZJoK8lB7gKvnrdCDa1fyR371TkfVJY5FVRBso=;
        b=Q+Fa4+xknqGuZ1jER6gHM0aX/zbkOIh0YiJ+8zfTalq208itEMP9X2/C53ym14Owmn
         qcfYTBF1sSYpBR1fcivEyZVD2k4QoDWK8mJAgGiNkUNmxdg88wz1l3tvSJy0uW8T3uq+
         L2yB/lpLwjGc48eD9ExRg9UMnbZfJqydDoTLHyRB5L6MUI5QVNgNO6/VFOs4qdU5Hlyo
         VUGZeOC7GnOaLcJRQdlR/Pm5LcgH2LcE8KGlXGhzO+bBYtz9KUl1cy2gjtWkjC3LHyrO
         brGFTg1rsnZQiSgoNlOejRqpLExbszszXpoBd/lQW0R4INJrrWK9gMflsOe6I0s0/DSI
         vwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691616; x=1707296416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4P30cDZJoK8lB7gKvnrdCDa1fyR371TkfVJY5FVRBso=;
        b=A/7kmQ2rwoW+evAr726CBLZfKjwPtGt+y9JKumEZLin5dpBqMsGPbl6LmABXMZ6Zyh
         CwoifOPvya/w6hbDOdGRJAxSShVDot3e6Nub5ZYwqCXExDxrDvWXtymdZtRSeeodpQEQ
         QWDjejwRb4LowqC7sz35ikZgbv8T+/9ctjHBCs5CfElcSacrctJ1ebf8aOm+mYR9NuHG
         sT96cUUxCyvCs+KoqH412TMUxgfh/avdv98jojLkjF0qx8Ph8TZ+cWPRDTb900CnLfEy
         xODDHdD1uyez2uMcAc83hRjE5pUE2pdmAV7uVH6gpHAvMkh/KLzvWNWD6a+UMA8CIRjo
         cTXQ==
X-Gm-Message-State: AOJu0YxQsg3suSaJnF4fRIcsLxzOzfLpx/wu/zHe81mSg19zmZdWiHMn
	IyfRmsGmQt+VbvXcuILjtqfTmHlcYbpi/ov3uKvrlJpgMVJzODP/K2YNo4bjZlLY+a9QHuzF7YX
	mrzHbfW6A8Pn1qs8jFerF+iMcBgVAG2WhV6L7eA==
X-Google-Smtp-Source: AGHT+IEvB7JEzDy/bd9wdN/APqpYnJcD2om3sihib43VyDrw9Rp4bAVf9j6uDJjuR1z5asPY3/CLOdSDCQOVGQayMGA=
X-Received: by 2002:a0d:eb16:0:b0:603:fd33:8b81 with SMTP id
 u22-20020a0deb16000000b00603fd338b81mr708880ywe.21.1706691616679; Wed, 31 Jan
 2024 01:00:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125081601.118051-1-krzysztof.kozlowski@linaro.org>
 <CAMRc=MesG1nYSxx0osmQEEXCvs-6B4s4=TFYW5wD8pOXpV+OcQ@mail.gmail.com> <a3d24e7d-404e-4c02-99a2-8838ee7028c9@linaro.org>
In-Reply-To: <a3d24e7d-404e-4c02-99a2-8838ee7028c9@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 10:00:05 +0100
Message-ID: <CACRpkdaus1oRCiafiJjqTkARcKBuxvNfeqDrve7ZdG4UqnNX5A@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpiolib: add gpiod_to_gpio_device() stub for !GPIOLIB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Peter Rosin <peda@axentia.se>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 9:59=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> [Bart]
> > Why is this needed? Users of gpio/driver.h should select GPIOLIB.
>
> The third patch shows you the user which will not select GPIOLIB. Why?
> Because there is no hard dependency between one core framework (RESET)
> on other core framework (GPIOLIB).
>
> The first two patches are added for the same purpose, even though there
> is no need currently.

That reset driver implementing a GPIO chip has not been reviewed by the
GPIO maintainers so I looked up the patch and replied, we have
review comments.

Yours,
Linus Walleij

