Return-Path: <linux-kernel+bounces-64331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2F1853D29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27651C273F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF0E61674;
	Tue, 13 Feb 2024 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HLBdByLU"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18F62144
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859798; cv=none; b=hD4L6i6JmgNC5alPST4gYz55z3snNt2jOuZzv3I5Jqji5/q2x/ou/lpkvjhGydMCEAxRfy8WWzVahbq8udeJUi9f8ZhNbhNg0aqHsjrbYmxcdPitwgQjLsRyITpoObFIib/kJrkkb0FNlz95ddHqMQVgZCY7g+3UUsX+8/xtFNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859798; c=relaxed/simple;
	bh=o1itvEeV8LvxyIcYXdwYU40slMynHwwlOpApN5Ly8Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJiyfXRzB1NNfPINCL/zZF0DX20zNzhIqK1v8MnKsslrGZnEfLf/z2b9Y+n/9YbY1ePXuUrqYOV0eVArhPDLBgcBxvoIw2kR0x43Y+jVr6a3GfOryynKcAt3hncrdbdlV7O0GavuxtzUc29eVNGeHOpH4BoJitZDQdyubFqIr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HLBdByLU; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso4491330276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707859796; x=1708464596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1itvEeV8LvxyIcYXdwYU40slMynHwwlOpApN5Ly8Kg=;
        b=HLBdByLUVfJKKCP+rBlx1VzhmanWNu3IYFi0/UxjnAzX9AQFRHv4rjNrt0Sl2gVUtw
         hC7xWWesP2hKpaVh6lmbLxUWxkCkRe8TxDN7pRjVJCROuXyfvuX6v5gAZQkdfQ+X10jU
         SDBRDMjeQxz4nF40gqBCD8ldm2r8hVpsu9hsNYQnOaQckkwYQtPzlLeD7y7ggXdzyJ0p
         n5X3wZ4997ZZGuSgNDIohQ9SWiPN9WtYjtsGOtBADseqHSaIQXRpyMsEOzWM3IKfTNi7
         ochLIqyNztOF+YFkBPdnt6WJbbnCvy9x42fCLuq7yzcUE5B6uzd44FG0bXUKR1nDwJ0E
         zSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707859796; x=1708464596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1itvEeV8LvxyIcYXdwYU40slMynHwwlOpApN5Ly8Kg=;
        b=DXEbF6p3s+5s2gcoxKS+YgEXvAvERbYGqEQaZgmWzqDQLRG446Eq24u03KSt2A0o42
         qvV/uM5OTsfaf+uUih3SW7oMHwVqUpEGzR3nothncDA4f/z6d2IAu96LmMJKmeZrDS0c
         PPaC/VxqoCOOVFJ2XN2lfk+929K7BcMOI3wqsmr0bq+JKEnr7JXqkX+X0ieGoNKaacC5
         vJgxWvJaHpKVd7iq3kGjZnQXN1elcmZADNJs1Ll5RwkyvV1vdKcbJVenjgWZCF2mPoQC
         NjkHfEcpT5hGpzI2tLNd655icoYbSxX6DDWnMNeU7HsvBZoX/nMiykTKa5HzfoyNY6Np
         8YDg==
X-Forwarded-Encrypted: i=1; AJvYcCW3l6qAmZzANey0Q2d5XLE6mDoc2j96NUwgPGN1reBId9iNKWOzRaud/WDliymCAcdiH99zFapU+oyhSAacvGzQ3N5cOg+qZ+HA9WYP
X-Gm-Message-State: AOJu0YyQSYqgOisN9ovziUo0a7bIiX3TVX6YhHb7XnVD1sSX8jsZ5D9p
	HKtunInV0B2SSyCwEt6ZHPJPZo1YqMqIF3ax3zMkRivcMB6bGA506pJmgUBrAUcwv20WqD+fVaf
	5eWTc/5DdnF2IHAGxPxtE820KR2MBqvO4t4n7xg==
X-Google-Smtp-Source: AGHT+IE6Hn4KEA1CCZ5bUfGs/Lvut+AenGj0UJMnAqTB0xOfHh21zeTj0SjsLn4VnQD+guWwO3Cv2/0eNjCGw69OW40=
X-Received: by 2002:a05:6902:2082:b0:dc6:4062:1341 with SMTP id
 di2-20020a056902208200b00dc640621341mr509698ybb.16.1707859796006; Tue, 13 Feb
 2024 13:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213093108.13922-1-brgl@bgdev.pl> <20240213093108.13922-2-brgl@bgdev.pl>
In-Reply-To: <20240213093108.13922-2-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Feb 2024 22:29:45 +0100
Message-ID: <CACRpkdY5fVNJBhVDrCb0cbrsWAKAZBkCACUgSjWGoHqtnaJJtQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: take the SRCU read lock in gpiod_hog()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:31=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> gpiod_hog() may be called without the gpio_device SRCU read lock taken
> so we need to do it here as well. It's alright if someone else is
> already holding the lock as SRCU read critical sections can be nested.
>
> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_devi=
ce with SRCU")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202402122234.d85cca9b-lkp@intel.co=
m
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Looking at the CLASS() stuff I see this is definitely the way to go
with the code now that we face massive scaling. Nice work.

Yours,
Linus Walleij

