Return-Path: <linux-kernel+bounces-108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8054813C54
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517F01F2251A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEC16D1C4;
	Thu, 14 Dec 2023 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iYRrOIhB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ACB6ABBF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7b71b10391aso321975639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702587942; x=1703192742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYSEL7MIgSG8trWNPr7NB5+x5xH37jHR4RltoDZ173Y=;
        b=iYRrOIhBA68YyyJHlWUUlgxTPLLZgUBmrsdxz9j7DinbKPiHy5B+b5l67KhumnxeuH
         S4adang1PkSlav5B4HsMJaCA3QcbAqXcFpEL/ohz4ZFrOdLrAhgBV/0znlYt5Ihoj7pj
         1JChNZsY8QtalPfEp0iiSG/StmEmwNA+4FXuWMYKGBxcvtSLCoOBNucV32DV/onfSJ5b
         WHVyE6492+PyMZcqa9kyAgpf3CBYMjtXxvwbw+FbSwV5ZxwcVI+iRMNZu1ZfBeIqYF9+
         ISR1yK3WDMdFhMnApB5ODyPGHoc79HyhPX4PhbFePTKbXMsEFXAjfTgAXe5lGeX7k/Zh
         j29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702587942; x=1703192742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYSEL7MIgSG8trWNPr7NB5+x5xH37jHR4RltoDZ173Y=;
        b=iDc+XjWrGVMd4zEnGAtYyucjfbfn475wtcezsRYTYu0X3yjNcy4yemO+FHwy0b9vxI
         4OnZNIg68kNEfNDtvRETYBagFAzAynS9Nh3J7WFOc9JWjieU84BVGUrFN5mkRElEv5lA
         y1G/lIDR8sXHnv5zad0AygOvoZL1QZ7ocl5nmh1aCjkCfDjY1rKsTaSPr1UFJia3n0vy
         QAoq8umZ8e6zJJHKxAI0YDtFApUcidF8vwMLY989L1HRkgCvIotNV1tqFBFBc5Do8e7U
         J6krAAcdW7YAOx2rJo9h3yuQsYYdKGmsPvX/iCpey9hwUN4dKFNh91yK+I+tzKI7GZaO
         Hk1g==
X-Gm-Message-State: AOJu0YzkAcQagm8WMMOI7h5ixKaHqDlLDekDahTZU4tR7ZOlZw/YJCa+
	LmU+vok2XTrj4V7oJpHo6vSuyxZCcVDYh90+xJ2f5g==
X-Google-Smtp-Source: AGHT+IGxr066RC4yxlfM9efuBAZLfPmRjNI8ZkOw8V4w3KW2qA8hkeyLMtUVXb3U6UCex4CgLOS6TSWV9tl6OAhk7Uc=
X-Received: by 2002:a05:6e02:19ca:b0:35e:7693:7a21 with SMTP id
 r10-20020a056e0219ca00b0035e76937a21mr10610379ill.83.1702587942177; Thu, 14
 Dec 2023 13:05:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXsxc8953uAfizLv@smile.fi.intel.com>
In-Reply-To: <ZXsxc8953uAfizLv@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 14 Dec 2023 22:05:29 +0100
Message-ID: <CAMRc=Mc7fc2sM41oDNhCavvfZHCzwv2Y_ToquFwD+BhkVHwbhw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
To: Andy Shevchenko <andy@kernel.org>
Cc: Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 5:47=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
>
> On Thu, Dec 14, 2023 at 11:08:05PM +0800, Kent Gibson wrote:
> > On Thu, Dec 14, 2023 at 03:56:37PM +0100, Bartosz Golaszewski wrote:
>
> ...
>
> > While I think of it, what tree should I be basing on?
> > These patches are based on v6.7-rc5, and I'm not aware of any other
> > changes they may contend with, but best to be on the right tree to be
> > sure.
>
> General rule is to base on the target subsystem tree. In this case
> it's Bart's gpio/for-next AFAIU.
>

Normally the patches should apply on top of

    git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-n=
ext

Any conflicts between maintainer trees are handled upstream.

Bart

> --
> With Best Regards,
> Andy Shevchenko

