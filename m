Return-Path: <linux-kernel+bounces-9943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6E481CDA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E45E9B23D90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57DF28DC1;
	Fri, 22 Dec 2023 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwqT6dcv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C128DB1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3ba1be5ad0aso1453840b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703266491; x=1703871291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvGWRGm6Ru4XGBpZKu6gweAX20hI25Bkb0ZbPmiUzJo=;
        b=KwqT6dcvOl2ITgL1oZiQMfKeksYnImheycXSUIfI0S4IAwHWwpd2sjat6yy4dcf6fr
         JSa6F8kEdPqFENJrzZ2o8jYyGTXBLqM/y/7GWUduSHvuTAvbDQNIhpGkdnpgshw3LRcQ
         5P3YFvquvtJHx2gSPd4RGvnf5QkmbCj8V4IVp4P6bhyHT97uVrp28mAQIEaiy56uQta/
         hmOVydHthaRWHeNAzyroVub902XfsV4u1sxP8gTs02SQjyOztT7DEd+mKK8cW7JRXDE/
         SSOF874f65rBfKV+13oOCx5jndl3oCy9wziFRyQwLD41zKyC5RubQwvYhlOF8tkbLaL+
         7QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266491; x=1703871291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvGWRGm6Ru4XGBpZKu6gweAX20hI25Bkb0ZbPmiUzJo=;
        b=pFQiL5EY0V98BzhXpvUOdeeRD6465+1gmhRxYF32NhBGUFG1gkr3rHQUtOHgKpZ+bi
         0kr4JjWsMhBpGVg9GlA5sSWm0kN0kzA+Bc/4NE2BI5SqnMSx64LuH1ExyGvT/9jZ6hTA
         VvrOFbGBAFoHG769DJao5oLwfwHqgD5PG7a+TVdFlSQcgwR/GjMUhjiZxKNfrViD/Lhw
         /M9nMJvdOGR43Up+Me6hG91NYK8TK+EpjmBMV+mtcjk/ZvY8kyNg7Ia9NMcSFIgpsL8M
         QIvsbwk4N+FDth0JeJFD6pUKELTm2AtYW7IssRt8wW8TzNUOMGLkBZb/r2E8g8wkqj9/
         YBAg==
X-Gm-Message-State: AOJu0YyqZ9DDMhZwl0EWfPmqYJxPLkveUpyZfaayLe0qKKqqtACPdZb4
	c9MScocgz6Ka3fplQZt8baS+IlBVyeplB43AhxfBuHQLjgqgDjUPbqb49ayV
X-Google-Smtp-Source: AGHT+IGsFvLPip9WksfY0biYu8cJZWzYy0Fvz5MQTKuFbjLoP1FUIwHsgaFJ7vTueB2tI4kwAVwarZzqcPPQBNX8i0A=
X-Received: by 2002:a05:6808:2f10:b0:3b9:e8d0:6df0 with SMTP id
 gu16-20020a0568082f1000b003b9e8d06df0mr2245390oib.24.1703266491762; Fri, 22
 Dec 2023 09:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222140017.2887224-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231222140017.2887224-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Dec 2023 18:34:40 +0100
Message-ID: <CACRpkdb9vd4_Cdv8LnhpyC5N8Cs+CSvwYGzG9Hw+z=Wv_moK2w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Step down as a reviewer
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:00=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Too many things are going on, and reviewing GPIO related code
> seems not the best I can do, hence step down as a reviewer of
> the GPIO subsystem.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Fully understandable.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I hope we can still loop you in for anything ACPI-related?
I would feel lost without you there :/

Yours,
Linus Walleij

