Return-Path: <linux-kernel+bounces-47055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E7E8448A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52C91C22B62
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D983FB31;
	Wed, 31 Jan 2024 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDaNr2Ao"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D523EA9B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732252; cv=none; b=so4nwXyzm7Rfe9VaBKxSFvxqLxbn5O6qUSjsOtASVhLwwCdV5ZUUmXdMY0MnLUqfuIK6Xfc6CUfwnA8zuAT+es78w9ZqKtn0Xula/7LaAkBJtdYbU9zAikksikLTuk3Btfe0y7RQ9Lulqn5b88GA2DruvARpGY/MDDxDnkvZpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732252; c=relaxed/simple;
	bh=BTliOxaTIKtdhGrJh/+gt3GB4Eb5h9IjYdumB/YLq0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a54wSTljgoYwWxO5QUo+sqdm+zZZAQq3HyZpQqdv92Ur1Aq7THHjEvzHRvWmFKJ5ENvN6/92oZ7GWB2AeeWwV5Ha+BGtQVKwV2C7/BoB3xOonbMZzxteFCAFzWiA6HuLAtxN2xXdrC+gHGRIaMwGUUfznjYotzgaJubKcvjke2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDaNr2Ao; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-603fdc46852so1627837b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706732249; x=1707337049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTliOxaTIKtdhGrJh/+gt3GB4Eb5h9IjYdumB/YLq0A=;
        b=fDaNr2Ao7hZVgSbDc7CNLOsmpj3bC+iwhd2SUj3SP+CzQhOMOsmvbfg34cmHtQNrYc
         Ef2wfDFIpj6Xvw8duIyahJAIcbpqmohmsaRLg9DGFoIqi0vRf6SzYxXbx0x3sUmN/Who
         G8Gtk90ShAagF1E+4U+nRpGF3dQyerPmDJspIHm/7pesqdD50fyj1JLp2EdggjsH0naa
         X3Shu9my5CTY8ehHsrd50zOJMAzD+08XFMGORQNsKZdupksGQ5tAxcGnz6iKbrXOdfCQ
         TGJ9JLKL0WjQ6kLzW7xnCd5I+HkHWtdYiMKRIVGWNiRUNSQolsQT8ThO8e0bELCc9sU1
         tvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706732249; x=1707337049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTliOxaTIKtdhGrJh/+gt3GB4Eb5h9IjYdumB/YLq0A=;
        b=kQaRCmawLWui/cKwlQfMFvWt8sVGbeiDXLzZ/AYZURvzzKJKo5V8CIMEHk9y/SPip5
         ji5jWYTWDByqDEdlrmjQHDollTcLf3BaFIWoyCIcuLqr7Sd/2d9rnzes+daflLOPoCf1
         CCyjfUPX8cMu+Cm7HTAqemNmrBLEN0Ohvg8servuvN1tkG7jv/MtZklG3IPbWgJB3rAv
         uYDty5QeXWQ7Fd95nxKdXm/XWVgWNwcxYPaYrz1jnGz8EyB2GeYUCy0oSRZ9+c9gVXrc
         /xbVxKAdPR0Xkgg6dnjF9RaPAUNdOPjDykuKj8Emg8gI8pxUvGqosQODwjMb7lykcKMu
         d4kQ==
X-Gm-Message-State: AOJu0YxKqbhzGgosBhjE2alFlBWV7qyAMrI5Q7aCvQaHr2JpjtVsGQI/
	TLXtc4dJv3/nZNeJJUeE2gk+6MZa11hJjrIZn65Nz1Eeg5aoNrQicV5J3OhxVzIBJVWut/njJ2U
	8yfFBrI9Ul6kPWMqhy6OpFc5b/gCUkUPUP1SWAlnkV+ZLzuoHWvk=
X-Google-Smtp-Source: AGHT+IEqmyTd4gqkQ6kqF8ce/gDvES+VmPNb/Xegyl4QD24HktmyP6vfTyAaWq3IqSksBdtOEL9MC58IPSh1Ru3fWGs=
X-Received: by 2002:a81:ae5e:0:b0:5f8:f50e:bcf9 with SMTP id
 g30-20020a81ae5e000000b005f8f50ebcf9mr2827329ywk.20.1706732249448; Wed, 31
 Jan 2024 12:17:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-19-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-19-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 21:17:18 +0100
Message-ID: <CACRpkdaiECDm3g0HOvBgRDrEieM9A5+AMfN2GFkRhP05XY4L8A@mail.gmail.com>
Subject: Re: [PATCH 18/22] gpio: add the can_sleep flag to struct gpio_device
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
> Duplicating the can_sleep value in GPIO device will allow us to not
> needlessly dereference the chip pointer in several places and reduce the
> number of SRCU read-only critical sections.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

