Return-Path: <linux-kernel+bounces-118930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1A88C157
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2551C394BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E4F6F068;
	Tue, 26 Mar 2024 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PEZXVVHe"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4006E616
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454335; cv=none; b=Oh/QFcQCE4r3RfUbSkZWMPU/tgim8kubNN5GqejhCBsu+bxnSRrXx3XBPfwLgd7M/9xZnpqYALHIj8ymvH/GVsER2IRvKk0y5360eoAmwL19VsTuQEpQ+VuP1/OJ+Cu9CDso4o9Byeqrq4YjNjD8YLrly7gZIZwigbAcPPwnSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454335; c=relaxed/simple;
	bh=mSuJQzY/x4nFRGAWr6w24/5X9mMqGb6qSo7jdxE2Vfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3CLyaP5vKT59utpjmftOSEJml5gIg4uK7d3m6yZ7YTIHikt3w57d3hilgt4Ur2OGiRbPXIbwNOGYCsiCizGn6GxCnTs0qOSgVFID0By7D7Ox4dsDW3My5Cffg7IPVZbIfgWEYwqVIPBWwwmT0RekyxT0bV6xsv9g127m22q5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PEZXVVHe; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d4a901e284so104875871fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711454331; x=1712059131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL/jmxxtIm5wkejRdpCLJvo91BH250kAbxPb/fDHf7E=;
        b=PEZXVVHeSd2FtVWuReIHQGluKEAhwSGNTMy3bIHvL9ZgJ3ub6nK8r5XSqfuBxIbAHO
         vvYOvVyi6iJN+pKzzO7Fe+kkK7l2T76OpJPNNEQ+TDKQUDaP8YvAkSrlcookVc+5thfG
         PlNNeoy5IeJDc9qSF2wGnGrFU+tHnpSLoP3GFySSDhKdEs4vPqGE/vaZ8DTP4NPAYv4o
         VPNF5JGnGwDoqiz5664WRwFtNGg5ZF1imCcAy3rHb5xnsXDy0VRmS4hqwfbZkoY55dUf
         Q7Zp0/BUeog4FN+ELlflCQdLzXC0lUQiBn6+Ruv7/i87jOCK4s/h78LvsMQym70UffJq
         BcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711454331; x=1712059131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zL/jmxxtIm5wkejRdpCLJvo91BH250kAbxPb/fDHf7E=;
        b=AuTBysm0D68NA5v1jOGQ9OegCYPwPi50LXds5KUfFhYGMJPtoBT9EdD3HXRkxDmZEj
         KwrwZBl1Bk0fZjbmANWCTPN+xPGZ6qYOBJq9ofzlygVM3VKeP0AWJGI20GlKDjEV6YU8
         nimL4PyVJsuhWcdV9P353OqODcdbgsFIv8vYGnMIJdxlfafdaJyYEh7jAob/GIe3FR0I
         edUyNrHJHiDcEMMHhuiL0mAIVQjn+CJrLGDnSQdOrJOX2QO/bfsPnkEq6TaGbel7kF+W
         6lMh/iGJu0Zw+UXSELXeQPkm+wk8NsiirvNGyUAjUv+AVOXuLQVhWUclcgkLAv5bwrw7
         k6XA==
X-Forwarded-Encrypted: i=1; AJvYcCUFWiioLGncQDfl548zcC8wzzB+uOEHqV4g2RfIP4bot2dURMFpHjs8r0Z1I0HJfwCEUqNRPsOFZr9EGbxwG+2XMk9nRNVmL5IekLI7
X-Gm-Message-State: AOJu0Yzn1NbrA51NL6qmTdJSq8/0K1DpDZz9gmIWUGuvay7STwE5tbjB
	3lwPpK6eWt1uqBAlojtHJZE46BKr4I/bkmCJ1CyqUjRNEPmCJkqkUpz/UsHNrmmrZ03XnzUd8y+
	wHCJ8U6YP1AaQuzFSZryIOtMkoN4XDe+dwUdVxQ==
X-Google-Smtp-Source: AGHT+IE/wUOqdcPxZFJQNNGXgXfUkl7+qojfXRZVcxjVlMA+00ZQ+LEJXyyGYTRHAzgyIuUAeJ7COMQDg6fwlTUM2JE=
X-Received: by 2002:a2e:b90d:0:b0:2d6:ba1e:a54a with SMTP id
 b13-20020a2eb90d000000b002d6ba1ea54amr6581217ljb.51.1711454331513; Tue, 26
 Mar 2024 04:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325171804.3375280-1-andriy.shevchenko@linux.intel.com> <20240325171804.3375280-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240325171804.3375280-2-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Mar 2024 12:58:40 +0100
Message-ID: <CAMRc=Mcf0b0HwAcT=ZQ31rdsuWSDJkg=r9Z6Ni1Tcrg-KCsXsQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpiolib: Fix debug messaging in gpiod_find_and_request()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Ferry Toth <ftoth@exalondelft.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 6:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When consolidating GPIO lookups in ACPI code, the debug messaging
> had been reworked that the user may see
>
>   [   13.401147] (NULL device *): using ACPI '\_SB.LEDS.led-0' for '(null=
)' GPIO lookup
>   [   13.401378] gpio gpiochip0: Persistence not supported for GPIO 40
>   [   13.401402] gpio-40 (?): no flags found for (null)
>
> instead of
>
>   [   14.182962] gpio gpiochip0: Persistence not supported for GPIO 40
>   [   14.182994] gpio-40 (?): no flags found for gpios
>
> The '(null)' parts are less informative and likely scare the users.
> Replace them by '(default)' which can point out to the default connection
> IDs, such as 'gpios'.
>
> While at it, amend other places where con_id is used in the messages.
>
> Reported-by: Ferry Toth <ftoth@exalondelft.nl>
> Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Tested-by: Ferry Toth <ftoth@exalondelft.nl>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

I queued this one for fixes. I will take patch 2/2 through the
for-next tree as it's not really a fix.

Bart

