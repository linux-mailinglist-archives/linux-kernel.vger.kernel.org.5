Return-Path: <linux-kernel+bounces-7033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB281A0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF631C21134
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A024D38DE0;
	Wed, 20 Dec 2023 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EI4iGy7y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0BF36AFC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ba00fe4e98so4359592b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703081314; x=1703686114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnoZsHZnEYcQ46Kd4Lu9crr2sSJLKt3dsvDOoA3QbMw=;
        b=EI4iGy7y0HcpweynZ3G4nxlD2neIneIReyrx3U+ZhQQ2Ws+Rw+tjlNLy20iOn9Abid
         69RgmF6d74ET7QmV6hH9nRd9vd3P8PKQrpyiu7fBRZiRI/adHgheKhmbcC4hS576Ft0N
         SaN5qRQFPYSi1qmkDudUe/fhWZnM/1d5d0n9GSg0tI/weBstQZ9b/23DYDpMvw2V+E55
         +IPMfYecd6PdFPHRbJzrbVW14yIFd/ZaoH/1AhHo/CGvn9p2Jj0HLSpOXg8lRkr497N4
         XU92j1sRlkXWQKw3chrAzIFAg3prTWNDP10izwLz1pwJxpblANkprvJc1XCO0f3Wuqfm
         bLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703081314; x=1703686114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnoZsHZnEYcQ46Kd4Lu9crr2sSJLKt3dsvDOoA3QbMw=;
        b=DI6S/x5oivHR8H6RV6ndOgeG4qf+pLlWiNOrfAPK24FcNaS4WHtf6vSYZfzf7BzcZh
         62g6MJq2NaY38/oTOo+8fgth++ZVxdnnUFUKudUbSQWnVD6QImwSPMa6TYV6TmOINjDw
         ub6v1usLMmlGK/dv5fpJFhUuDjWREAYhuQjcAvAtmMeMbIULk6hbeAnIQUVbQZlQf/8m
         aa86lvZO6XHrQjZn6lDesXXjmdKo9DcTNwXqV05JvvgrMnaKQD9sIi3cMDe8NgaHzzwA
         S9z/dJkp3wL3WRtz3KMpqk30OeKMCq/yMg2WGnUIslTJ2Xm4bhiQqNSnq2MXMzCqyziV
         zqrg==
X-Gm-Message-State: AOJu0Yy36I75dfwaDrXH7E5P9v6+6unSrXINTo3Y9W1jOlag2saWxeag
	EdYRz/TwzjHHtOnL/jud+ep0WixcDKb1I8wocHAcDQ==
X-Google-Smtp-Source: AGHT+IFFY4slCaCs05mER84U3vXe6xaUXr+pRDcYc1I6qLkwNlDilN+SZ+3SlD4MTvEyaNXi+77Z713nyT4YhivBp3U=
X-Received: by 2002:a05:6359:4c22:b0:172:ab3b:cc1e with SMTP id
 kj34-20020a0563594c2200b00172ab3bcc1emr8595804rwc.4.1703081313727; Wed, 20
 Dec 2023 06:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219201102.41639-1-brgl@bgdev.pl> <ZYL0MWAQ-frYLnZq@smile.fi.intel.com>
In-Reply-To: <ZYL0MWAQ-frYLnZq@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 20 Dec 2023 15:08:22 +0100
Message-ID: <CAMRc=MfbwMPQPM+OPzh12Hvbe7Wx9+vMwDn7oz=gFdfZ5N2PXw@mail.gmail.com>
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 3:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Dec 19, 2023 at 09:11:02PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > extra_checks is only used in a few places. It also depends on
>
> > a non-standard DEBUG define one needs to add to the source file.
>
> Huh?!
>
> What then CONFIG_DEBUG_GPIO is about?

Ah, right, it's set in Makefile. I didn't notice before.

>
> > The
> > overhead of removing it should be minimal (we already use pure
> > might_sleep() in the code anyway) so drop it.
>
> ...
>
> I agree on might_sleep() changes, but WARN_ON(), see above why.
>

See above where?

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>

