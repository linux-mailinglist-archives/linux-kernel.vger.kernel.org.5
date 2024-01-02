Return-Path: <linux-kernel+bounces-14926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BE382248E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09A21C22D02
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F57E171BF;
	Tue,  2 Jan 2024 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eiMKZW2b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7F1171AE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbdb8e032f7so7510397276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704233507; x=1704838307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUkbBiUuVMzTbWWmItv83q47EW5ST9RyNXeRT5N6ii0=;
        b=eiMKZW2bmWmLXtsHYIezVQVvFXEwuW1njOThmYxfRzpoqoVFmV9UOIsjUDyTymTct9
         uFCv96mXkaR3ChiqkdWSSbwPRvXaeV46QS8vFJEi1raUNmmdQqzqxD2lWUlX6jC5qadF
         0TtYzFfdmVWGXIGSJjtdYfrfENTGL4SKe2F2xii36/FMyrXpmYJnQM4tdhDM9lbXbwlB
         ZKM3Goa6SqAgr9ACFuJ84+mxFhRSyGGpt/FTUQxyhBTZNW5gLsjCpcG20TQhBHCqFeen
         p++N4CrqRIpDDekGHCiWQ4PBXZGNYlH5qvl2MD+arOq95MQhSd2geLRgb5EA5WtbrrF8
         7NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704233507; x=1704838307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUkbBiUuVMzTbWWmItv83q47EW5ST9RyNXeRT5N6ii0=;
        b=sqn3Nuav1jHneUW2lkHnZb2SB/N7SYwXr+CelNQY1BFmd2hl3iZAA+gSeADtepC6JF
         eEsoN8J2gYEVBByCoxBf09eXMyMV9Gu9uPx/Q6WpEamR8Umbc4iEvXysB7HiLQtHYE5r
         26QiabnKTcMOpo85HIJNG4lnatGf9EOXb+JXD1jWqPn0MbU76rq/UnyrxgqVJZp4+ggu
         aE27iGJGVSf1cWNc+gbG1gKQBafxgu3iISML6vLL5TjNK9+Ov3jrpsyMOcbhFxEvhzdn
         W0yJz9Cje8IVdUCkc5SMZ07rID0WG7WVRDDQauiC+Jf6aUUtx9eKSf8sM7sIx1WqKICA
         IMcg==
X-Gm-Message-State: AOJu0YyqN1vS/8yWUJ3e1thaHFCa1QaEg8J5XeJmH76RUxHuLI4jtL+6
	dqVq3zCsOxD6mmi3XMDl/pdK4F4DdH5d8YOxgsnLN/bEwvrqRg==
X-Google-Smtp-Source: AGHT+IEAGhFaQz3UTikPn0AjQLiK447FBnNQWFqmOYFoCSaSLf5Js+lGVNlsv6Lqv2RwQnwe5NDZRFCdyyg9fOv058c=
X-Received: by 2002:a25:6804:0:b0:dbd:be02:76a1 with SMTP id
 d4-20020a256804000000b00dbdbe0276a1mr76110ybc.22.1704233506915; Tue, 02 Jan
 2024 14:11:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102155949.73434-1-brgl@bgdev.pl> <20240102155949.73434-2-brgl@bgdev.pl>
In-Reply-To: <20240102155949.73434-2-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Jan 2024 23:11:35 +0100
Message-ID: <CACRpkda9djEoMdu2bqz5DWSSbeUxsdVxV9NXvnvzE70UHJgJpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] gpiolib: remove the GPIO device from the list when
 it's unregistered
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 4:59=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> If we wait until the GPIO device's .release() callback gets invoked
> before we remove it from the global device list, then we risk that
> someone will look it up using gpio_device_find() between where we
> dropped the last reference and before .release() is done taking a
> reference again to an object that's being released.
>
> The device must be removed when it's being unregistered - just like how
> we remove it from the GPIO bus.
>
> Fixes: ff2b13592299 ("gpio: make the gpiochip a real device")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Makes sense!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

