Return-Path: <linux-kernel+bounces-68631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA578857D88
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F75284AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ACE129A89;
	Fri, 16 Feb 2024 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zHkbhh+P"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AE1292F2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089605; cv=none; b=HBKJTTwyqKIS7vUC2zntxqWKX4p0NsGYqH67hBURcs/yn/TvxdqbT/FxamFcQcvKKYcB5zxlqqLyc88cYfvaxfCuJ0FBZTxhQuD62uVSfGK5B3F8J12nNm8BvhXcnTgqvGpJyRHMBZ9uHT5itr2WTS8TmVUxChe0zpTfQ6pE2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089605; c=relaxed/simple;
	bh=oIiDRMEbbLxh2NMVvXuVZOzfsezcwPFoldYPdeq/AbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vn415DE+fOjKh5lkRa28l8csVyNrg85eNXKOiyCFUXiS6yFAjtZEGLHYAzX1rwmpSRC++kH4ILyPo0a3JIBO84Wl0XXJQV/AeUion4qGdK60GezOlnkuIPjctZyrTxkHmu3agvLqwj7WkdLNJLLoA7auVegZXerqyJyuOJGRSvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zHkbhh+P; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4702ab0e9d1so393758137.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708089602; x=1708694402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfGxcPxgpqvVu7pn9g9q/ypersVX9C8Adoc2SdohQL4=;
        b=zHkbhh+PxlpcfEpGA2fhij607y2yi6ZYT2CCdrFMRkNfJm47GoJ2nbfAyiLxjPRgBJ
         snNNnKi+OZHSD2ASWPy7dEGeOuDNeH4vkxko8kFxW+MRy9K9S56amYxaP9n/yi3sED4O
         A6/uRrsRsXaUfzZMJcCbALsjKCtGVwF1OEwGO4/3tGvPXLg2s2rV0jqpBJZMIZeUwrBW
         PCc3GD6TmeaHGwvGOLVBtOpv0QEx6bD2dNkpLwPulRjh+wA6y0UuS5OEnaCuSXtmjCoi
         53Klbi/xaUfcq7DOR6dLmGD0D61CZbgkUaEbpf3d77iA1vAe/vT4kUwqhUaxfPZiuDRA
         uu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708089602; x=1708694402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfGxcPxgpqvVu7pn9g9q/ypersVX9C8Adoc2SdohQL4=;
        b=Dz2ocIQImwF36EcZIk5G+a3NrMY1HYr1wWRxn2g1G70swTImeyCRiZdaB25z5Wvg+U
         X+SIQTcSKpkARqYg9tfLj0T08cYYBas2LbC8xJDgx56jpTglvWj9+xRTKKEWaRK5DRVv
         Yc+1/NrS4mabcnBMX7p+aOWsugKy3Q+cSRS4knmQli+VB2IIrsHe36VlW9nR836Yresx
         tl5LxBFOPHSLdw5SnbSWcavP4iWjKwGRJ6t0Q/aziEF5LMwtpSJqkJ+w8D5+TI2oky5+
         yD+NtKTMrLEF5FRuzGOo2cjWui/TA4pdKXdMeJ7oejLj4F7QUw8spGczPnBtYSszAyWb
         Ihgg==
X-Forwarded-Encrypted: i=1; AJvYcCUmAf375R2H0gjCIJ02zG59e4BrbKFG096WSy2CHdHrbNutW6nR3iBm8kUMIfV9Yiuagc1+6xiYLcKOdidb5eAtXJNjVh4Cd9tE1JYz
X-Gm-Message-State: AOJu0YwlT3KEW3ali2Sg6EhvG37T9pLohh638tfnpKTsO55Bz0KrhpQa
	g4Yicj+sH+9pTZsapKFtMQDef71xJkAqEaja4sk7eVr0TUM+ElhSTbGu4i3eS88OT3n8OHNP7BA
	FmUXS5CnhT702r+Z0Y1sLY8jrvAkTvt6Isrhh7A==
X-Google-Smtp-Source: AGHT+IGK2SB9sektHQUi+tLu8JuF/SmQ8r9soL0NJ+fvMufwT1z+n3PbFC/Fn3sCcuqvpQxVdiQ36d1juc/A8lTJTH4=
X-Received: by 2002:a05:6102:236d:b0:46e:ba66:f40e with SMTP id
 o13-20020a056102236d00b0046eba66f40emr3677342vsa.10.1708089602382; Fri, 16
 Feb 2024 05:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216125959.3766309-1-arnd@kernel.org>
In-Reply-To: <20240216125959.3766309-1-arnd@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 16 Feb 2024 14:19:51 +0100
Message-ID: <CAMRc=MdBbzff5BppY4Hjwfi=SnmYopnFxg1AX4QsGt3Y+-g60Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: cdev: avoid uninitialized variable dereference
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kent Gibson <warthog618@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 2:00=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The 'gc' variable is never set before it gets printed:
>
> drivers/gpio/gpiolib-cdev.c:2802:11: error: variable 'gc' is uninitialize=
d when used here [-Werror,-Wuninitialized]
>  2802 |         chip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt),=
 gdev->id);
>       |                  ^~
> drivers/gpio/gpiolib.h:277:11: note: expanded from macro 'chip_dbg'
>   277 |         dev_dbg(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__V=
A_ARGS__)
>       |                  ^~
>
> Use dev_dbg() directly.
>
> Fixes: 8574b5b47610 ("gpio: cdev: use correct pointer accessors with SRCU=
")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Hi Arnd,

I seem to have beat you to it[1] and my patch doesn't change the log
message so I'll apply it instead of this one.

Thanks,
Bartosz

[1] https://lore.kernel.org/linux-gpio/1542ef65-508b-45be-ad5c-63ad124cb1a2=
@samsung.com/T/#t

