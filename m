Return-Path: <linux-kernel+bounces-3599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A031816E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C1A1C2435A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C427EFC8;
	Mon, 18 Dec 2023 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y5ytsrwe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15ED7D89F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7cbeaacbc67so81312241.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702903431; x=1703508231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfvHtKUU7XlgS0LyrkbLQeM1LtY2gjMvOvyId5ed8lE=;
        b=Y5ytsrwecuPJmEE3VR8/HkEu6C9J6FFodIgkUAv6VHmmRq//Idi5JBUd4C5w9tb2El
         e3wQC0NeMZQlwF9OdOdL0LQpNoJIJlaev/4ziBxtqRVB9eFKlrtfe/FXrvQQ1e9kZEEm
         H4fp5gQUIaGQTttbv/YMJRRpo/jy27/L54QvILdtRRja+AIDNSeSCv8f6TVAIGuNb4SL
         /u6EVVpvZp7MlHBlQrWwJoDPwYZd2lFbrDszPlCWwtzInLggiNjdKwobAXtGK0NtHaOF
         X+7Png7qt86idqkJYgL3R4HnvF4IKUSWmf1eFosnLpHQRbhPNEsv+3cK/VPl10uy8GYR
         h4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702903431; x=1703508231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfvHtKUU7XlgS0LyrkbLQeM1LtY2gjMvOvyId5ed8lE=;
        b=VNykYoO1AHJy2+kWXwJvQUINICvKpDLYcKZFZ6qqETgaPZZbDLMj62eUXf620ImEuC
         1fw4B50uCieVEznDzcaJTTC2PBj6kBE23Hp7GBGl8scZCpNLBZtGQGhXkny2NDQDmI8y
         g371D2ZZo2BbpD6rGlL8U5MORfF2dEmuixUSBlb4xCny0IsHwtDPxY7pYOfUO6Xeh0/h
         s1JAjIXvv7pCBjFyLOnUou3tFUJWRHIlZBY5MpwJx7VOaXITwGxrF2mKLT0dS9wXz+AZ
         RNhSXKY4W1NLqzTzJPylJb7j0nBKkXQnX07lU5BXLxfkQVTXDNCI22v0rUsfK/yClDuI
         hCfg==
X-Gm-Message-State: AOJu0YwFj6JeyThyQVQeVkAiNa+5FIwHQj4tLkW8dvFXXa9kM6ch/HJ6
	YSf9YNZvMTIgtGAloQoz8eW87QaQH7+eUhwhGv0LKA==
X-Google-Smtp-Source: AGHT+IGDnDXa/gihpusavmilYaX175FCWpQxfi9PEjSjb3l334z11qxmvtQUeNtqT1ahRB3xuGrYEOYJOkOM3ZlNPJo=
X-Received: by 2002:a05:6102:3913:b0:464:7f21:17d6 with SMTP id
 e19-20020a056102391300b004647f2117d6mr5500298vsu.15.1702903431622; Mon, 18
 Dec 2023 04:43:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 18 Dec 2023 13:43:40 +0100
Message-ID: <CAMRc=MfZm7TDHRRLrDmnyj3vmbscmpveR0fveYfsGz0SdaskKw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] gpio: mmio: Make driver agnostic
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 8:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Driver uses so far some OF APIs when generic fwnode ones can be used.
> Replace these APIs accordingly. Note, this will help to clean up OF
> headers even more.
>
> Andy Shevchenko (3):
>   device property: Implement device_is_big_endian()
>   gpio: mmio: Make use of device properties
>   gpio: mmio: Clean up headers
>
>  drivers/gpio/gpio-mmio.c | 53 +++++++++++++++-------------------------
>  include/linux/property.h | 26 ++++++++++++++++++++
>  2 files changed, 46 insertions(+), 33 deletions(-)
>
> --
> 2.40.0.1.gaa8946217a0b
>

Applied patches 2 and 3.

Bart

