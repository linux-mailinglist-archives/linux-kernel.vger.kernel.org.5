Return-Path: <linux-kernel+bounces-47050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF9C844879
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47261F234C3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AF53FE48;
	Wed, 31 Jan 2024 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4y/x8dc"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D43FE27
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731851; cv=none; b=JYlDs6eUSiaAoNnJy1g5Zvuup885FxoQdycbSiF3xzNDt4X8ccaEfX7zEoXhC+B6QxsugQXIVOKG+jceVq/CcMTXmcRq+Gkld9RpQVLZ5a3fd7P9xk8kaICZLz49+QMBdf7yt5s+sTkz8XJZbTT9pWwpDmrA4SjbmamfUesjBvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731851; c=relaxed/simple;
	bh=zbht5rbF5vwft67Ip62P/qWqh70GKmzfR9gnSCxmPkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmHNo4mG1sqSco90Lzn7dY7jjoNwfTHH0JM2X8HqehiQ8IDa6e3XsR3g0Na0sRpepZTfYE5l0qOTxqFzsdHpckn0lYVoszyMD+WvZcnZwbvPpenUomPt1Ys3HO5jBeGU60u5ydLFW5daoAolOnZKTDJDuAC4qjsxYDJE8zbLttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u4y/x8dc; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60406f4e1d0so1661387b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706731849; x=1707336649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbht5rbF5vwft67Ip62P/qWqh70GKmzfR9gnSCxmPkQ=;
        b=u4y/x8dcGgROzaYLzS/8/AxiNOWmu4xkUI7NombK4f6U2jRDzQxQGNQeYC/jcVmrB0
         vYoeGcfKlKGc3lq9WBZBx3O55EU+RiPpj9P1NRobuZVxL5N8McvPicI3tcMZ9gLGMhvQ
         CDob0BQwXfw+D0kRBGOr9GGpU6+SPMfo3rhi2aoCicHkVANFUJ13bz8sqANyovcxNnY0
         cGqoHr/+WiwQedi20Ryp0xby2ZIxSTipjSoYJe5GsUK5avhcwYZKBJrGqhaxzT5HK5ug
         9xZF4T5lokf/B2G053ptpzfDg4+1zwiGd19iwsGjWm6FtdjObVt6reAZinTyZy5DjVGC
         KAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706731849; x=1707336649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbht5rbF5vwft67Ip62P/qWqh70GKmzfR9gnSCxmPkQ=;
        b=hX+PNMEKqKae9auyu5rU0XTFfeiLyg7sBNprzFlldNAIma2wD9UiL9m3Hts87mI564
         H6jiwgbbnoCZgZfukthtHhi4UXBkgCRh0hGh+ZwMXbs/tm8PhyQkQnEdVsf408+UyPtI
         OwCxmkcDJvfCxj4gKpkUyWoA6yrQxF9Uhw6GxarQRc1089Vw3aKfAeYLj+Xqoln5pnD8
         +WU4G8iAcb0cydBr5RFNUa6ohClibtesxNlFM2l0Psn17WsLY9P6iGwBGN+nCJ1Ri8Xy
         7zCinKeoCYbXYuWZQ5aPagrA/428NOt+qvcPgIKkC6bKHx0FG84bWyHhmVfzsulcEr44
         Lb/A==
X-Gm-Message-State: AOJu0YyZfMsXE7hcHKH7YH9VFLIcp2sH/FmJwfZ9xpZBGo2TpE+V+dEn
	Q/aw+r+Yv5DakwhKx5P1nFvVuV8vNzXAFFQuH3z36z6p7bWx4BCOMgWFXoLOMoZCCwR66CZWvgI
	r3MYx4IDbZ6G0lvGNtAj58GB3bDeBlFbj2Gkz3w==
X-Google-Smtp-Source: AGHT+IG4x4rsv2xknv/jiQVp0Dua73Me5S7piuf0s2bsHE3HvZ1Cbph3+NUYOuCP8+nCqT32PG6U+mWJWBCOQiJJ2S4=
X-Received: by 2002:a0d:ea4d:0:b0:604:666:4232 with SMTP id
 t74-20020a0dea4d000000b0060406664232mr103933ywe.16.1706731849106; Wed, 31 Jan
 2024 12:10:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-15-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-15-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 21:10:38 +0100
Message-ID: <CACRpkdb9kp-a_Su8VgBwv1bWx-cOoH1R3GP9UH=pcbntGUviMw@mail.gmail.com>
Subject: Re: [PATCH 14/22] gpio: cdev: replace gpiochip_get_desc() with gpio_device_get_desc()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> gpio_device_get_desc() is the safer alternative to gpiochip_get_desc().
> As we don't really need to dereference the chip pointer to retrieve the
> descriptors in character device code, let's use it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Excellent.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

