Return-Path: <linux-kernel+bounces-12069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1C081EF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E576B2836B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF67745958;
	Wed, 27 Dec 2023 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nVn39BKX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755E45948
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7ccfbdd77f6so429073241.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703688880; x=1704293680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj9nMPZ/rmfT4qFV6S0ETvePHpuGlIZuLsYwJ7FOOC4=;
        b=nVn39BKX04zw62wzHQG4zBtSrp3XD/3zHKnZBPWbIXkl0pyQne/FhgU3jCe8XURsw4
         MNDzJ96uwc9zwg67MvjTnnTfcWzbriH2oUC9Rcz5P46ou+td3j2FyZY7fHpiGKztXm4G
         RMI3eBtt8h5dBhDGmDMihNNrjM0cbaECHz1z24lnieUBj9us2MiNOmlNV/QcWXXNzpOp
         IjLvtOKNo4FLYdZf+I2AqggX0/3heKz9iqMZtItxVZKZEhmi8/MMmXzYE3PR9lizlrzt
         /QIrHMqHzksMyj+i8cwzvzjLh/aat64d+xguQ/sJUsBrDVUsIWEoybpus4EHnufIVto2
         6pNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688880; x=1704293680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xj9nMPZ/rmfT4qFV6S0ETvePHpuGlIZuLsYwJ7FOOC4=;
        b=AxUL/8qCuYQ+0Ut5MX2QAp8yXNjVDTaxO23dx8Deo8/fzdVQwRuDaCxlkMzCEawiC+
         4z7r23+4tYD4UmpG/0Q+E/D+YzuGLdkUhuElC1RR8dzVPVkEtWlTIaj9h9IZ9WiiAH2p
         99hzQuY3dETc7nSyn7E3+tEtCFvYH3cOHZoFC3O+kEUOfT9cBOw3sOrSuUhfrJ6Ek+M/
         r0zwnF6W/E3Ir7z4XU7H91+SnsrBzP9XQ5R0rRUsHJO5fMjeD0LE7R9BDjV1jehUbQqH
         SjSC/fRdhjqc/f/baUMzs5I92vmTX/ixis9V21Yud/Paq8hVTEg4+G7LKhIPxlr26UHY
         NWLQ==
X-Gm-Message-State: AOJu0Yz1/HZrXmOvUmdOeGhbt6xAYBaQlFVtZeH5FOiM7myMLpA8+f9D
	83KZR2f/GJnh/Uv5ALEhpou2NkITBWK4u4pgvH+9WqdU6c2lpQ==
X-Google-Smtp-Source: AGHT+IGGh4kulY46eFRo4mhwu8hUsN2eKEl2yrpyzTgjAzLhxK7E/zmhT6AaWb6pG7m2DIyyQZRgjpJ2s6keDua20HM=
X-Received: by 2002:a05:6122:2028:b0:4b7:177a:25e4 with SMTP id
 l40-20020a056122202800b004b7177a25e4mr2949904vkd.9.1703688880030; Wed, 27 Dec
 2023 06:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222140017.2887224-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231222140017.2887224-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Dec 2023 15:54:29 +0100
Message-ID: <CAMRc=MdzuPkW15iRQLx8q-zKRM6aV1f2dT+uDDWg5GZ746OCNQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Step down as a reviewer
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:00=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Too many things are going on, and reviewing GPIO related code
> seems not the best I can do, hence step down as a reviewer of
> the GPIO subsystem.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1af56dc3113..8b686a9fa068 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9110,7 +9110,6 @@ K:        (devm_)?gpio_regmap_(un)?register
>  GPIO SUBSYSTEM
>  M:     Linus Walleij <linus.walleij@linaro.org>
>  M:     Bartosz Golaszewski <brgl@bgdev.pl>
> -R:     Andy Shevchenko <andy@kernel.org>
>  L:     linux-gpio@vger.kernel.org
>  S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
> --
> 2.43.0.rc1.1.gbec44491f096
>

Reluctantly applied. :(

Bart

