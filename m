Return-Path: <linux-kernel+bounces-25868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE10D82D6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60BF1C21771
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C55F9F5;
	Mon, 15 Jan 2024 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mD6V0ZKY"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557FDF9C7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7ce3c7566e0so1913173241.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705313752; x=1705918552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F63g5TCHfS+ybr9y0m7zDGbIPC00mu+XgQYirt8SpiU=;
        b=mD6V0ZKYqQy/Vm1ewV4M80fgdGvmb9oGTGRDiEqzU8h2SCqJhruvrjS0uJBn2VtSoP
         q+dmHedgy7P2edCjNm4wLrXlFCAtOaFBS4WK7XJhRGt7efkVDkkwy0gOgIuLDVVarCKm
         0Nb2seAUIRw6TGCva/NlFW4Dg/EjUYTHrSRU/Cb5wd0snuoeAu9y4WAwULdqfl3VwpqS
         w0D0Os557OAnZzUlytw8M5X/TOUoIyCjDZcht3032U2ZVLKFsmfJ8qUyPNRlLeXVcflQ
         snkC4NtYf3MYsAHoyfZ/D5VvB7Mhz1gO1lFkYV+XfgZ0BrKeH0bIXbiylL4NI20As7t4
         cDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313752; x=1705918552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F63g5TCHfS+ybr9y0m7zDGbIPC00mu+XgQYirt8SpiU=;
        b=SC+Fd/SJoh4Y+R0hxvFmlt9eazhJKGmJdq7RRsUjqcsjnrkXNLnek1H/5Ebb132SRK
         GR24+pftIvOruRIOolkty61ciQVEfvzRDgLstvbgKeBOwEd1DrXOf41Xl+YwUY5mdWNN
         Q36R7Rktqb28dsbzzYTr18T9++trM4qnZN1anybQhTJEWvMEdZ6gm9GQH2s6yg3Nuiga
         3Jgsz3rwwi2dA6gQoNr7syaPo67M4P5dJyHy9AEVyzEumEvJPwjrQMvf4zVxpiOKPMug
         a1spY++feekOWwDZ3pUiYyVmbekj+uc77mgZ4Saq0VbwCqS526xw0gIjuwmbuhsapZjd
         zMSg==
X-Gm-Message-State: AOJu0Yy7SPL/UsfHj/z/dbDh1P3LltFcwVm1Mz4kjyn8d89HNZWFQFmB
	P2zPLZ90QQm2j/Z6nU4hnCijvQAFS5s/qMtZuKt+pbWP4BoDOA==
X-Google-Smtp-Source: AGHT+IGg+0cHeGdJGNhsJFz7pNukIbriiGOWqVvFIfIITRW2tE6ZGKf1COC6BJFOWvcn8gnxynR+TqaORxERAHxnKjI=
X-Received: by 2002:a05:6102:22dc:b0:468:1cc5:ed88 with SMTP id
 a28-20020a05610222dc00b004681cc5ed88mr1232263vsh.23.1705313752126; Mon, 15
 Jan 2024 02:15:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115052140.18858-1-rdunlap@infradead.org>
In-Reply-To: <20240115052140.18858-1-rdunlap@infradead.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 15 Jan 2024 11:15:41 +0100
Message-ID: <CAMRc=MeGmN1xEEGhXV=zY9kKJayBbF4UABZEK4ieQPxzVefHfw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: EN7523: fix kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, John Crispin <john@phrozen.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Felix Fietkau <nbd@nbd.name>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 6:21=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Add "struct" keyword and explain the @dir array differently to
> prevent kernel-doc warnings:
>
> gpio-en7523.c:22: warning: cannot understand function prototype: 'struct =
airoha_gpio_ctrl '
> gpio-en7523.c:27: warning: Function parameter or struct member 'dir' not =
described in 'airoha_gpio_ctrl'
> gpio-en7523.c:27: warning: Excess struct member 'dir0' description in 'ai=
roha_gpio_ctrl'
> gpio-en7523.c:27: warning: Excess struct member 'dir1' description in 'ai=
roha_gpio_ctrl'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: John Crispin <john@phrozen.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Felix Fietkau <nbd@nbd.name>
> Cc: linux-gpio@vger.kernel.org
> ---
> v2: Add commit text.
>
>  drivers/gpio/gpio-en7523.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff -- a/drivers/gpio/gpio-en7523.c b/drivers/gpio/gpio-en7523.c
> --- a/drivers/gpio/gpio-en7523.c
> +++ b/drivers/gpio/gpio-en7523.c
> @@ -12,11 +12,11 @@
>  #define AIROHA_GPIO_MAX                32
>
>  /**
> - * airoha_gpio_ctrl - Airoha GPIO driver data
> + * struct airoha_gpio_ctrl - Airoha GPIO driver data
>   * @gc: Associated gpio_chip instance.
>   * @data: The data register.
> - * @dir0: The direction register for the lower 16 pins.
> - * @dir1: The direction register for the higher 16 pins.
> + * @dir: [0] The direction register for the lower 16 pins.
> + * [1]: The direction register for the higher 16 pins.
>   * @output: The output enable register.
>   */
>  struct airoha_gpio_ctrl {

Could you add a Fixes: tag too, please?

Bartosz

