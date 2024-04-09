Return-Path: <linux-kernel+bounces-137053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AF489DBAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC58D1F22DDC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B01304BF;
	Tue,  9 Apr 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CaxnLlfk"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846313048B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671318; cv=none; b=WNShhszRdm0iKyfX182zPCc72LUWTp+ot56x0FBvBD8nbspVjApfODcgWmPyhfIvCEDxUF2c/IxeZ4pyqYi1HVaX36jmaj8nrmT5WJwTBlAY7x8YlAwQ3pB0kx31Szwc4yauxL0bR4sbwgokB9r+w+MlO5/d+flJBtfluQy2C9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671318; c=relaxed/simple;
	bh=WVcmmCzMCx0qOzeVSGr+rFq9VNZEW9SgsVKpHYBH4Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+L6kd8ZDl79lcJNMBNAjUVjJfDTEeSrEfYeVWshIN+hJMmguhq/lcMrQM1Ywn5u+/K++xvRuUYupQmriCuiACuSHycCfxjfmIDARSgdGCMWi8CkxEVX1tJHLoP44GI9fHRllfqYDE2hCl96E0uml+O/LL5XnRnePil5FP8Fjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CaxnLlfk; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d8b4778f5fso3378481fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712671315; x=1713276115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVcmmCzMCx0qOzeVSGr+rFq9VNZEW9SgsVKpHYBH4Jo=;
        b=CaxnLlfkl58JCtUZ30X0CvE8NXIjWzFO+raSJK0f+8v5cA++w8o7nSIKRV/WiXk1Ku
         Gpx+3WOpNNvwNs34VFEROSlvvHzsAdXrNBWyrn+fI82dYbD/chkBIc3nsGXhtegAykgV
         OSNUzjdM+N2GULEUYuSuzd6v7fC0Ase8IZ31FfcsGehbn1NXSodIHVNRIQgJkNBLhj6L
         gybIKYW7pIuWwSd/V+xAXrkYI6i4cE2F5nsNwis8z22FiAh3/+p8KCyDqzU8vfTMk5xx
         x1xOyeicumDJaw4SeyNQGIPb4YE2skLS6ObYEDdgjK5eEIJursIvu7cs392T572mZHPU
         PoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712671315; x=1713276115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVcmmCzMCx0qOzeVSGr+rFq9VNZEW9SgsVKpHYBH4Jo=;
        b=gJLSdGkKmBDacwGQ4QIt5IgHTP3s+Qlh8FgHzGeXSRbsnw55xZ0A0eq6k0vNKf8+jc
         7CJDUrrR225f8B93nGDy3Px/xkYZ/JY8a/txDchYB1ZkIUpz/JRpe3H9MSM5mSD4y1rb
         mZN5dypcp81CPt7u/xvCfXqSt5f1mnq0kp1kt+aeKvKIayWl4Chk8uoDLS6TxjODRQdQ
         /FjndfciSP6/ERzKEli9KzLjcOrva7KVUb4GR63usfQiQsUKZQaMUZzEWiYGxGtZ0oqV
         LCuaI+25S4rhbjYXyz3sY+yvO8Wb4bqC4KgmkByvEXBKNMzOK/TD2qnc5YvbKPgNmRyF
         PXQg==
X-Forwarded-Encrypted: i=1; AJvYcCW92W19GLmtmMQK9cdRcrh/BLGAisn3k9fOa5wi0VKFF/PYWc0H9VzY+T2wBDi4MZmydgKb7WVjoFctl0Vuh+ZIraFiNwsOWWT1osMb
X-Gm-Message-State: AOJu0Yy9Vw1uPVl90kbzb3cIC3RSpzdJdejn461GjAgXD0rdfUmpEWu+
	1ESKuOMKV7joMHVEFKmSEfdbWswwD6gu03wDwUpXPB7E80RMBhlR12582aYCwlWka3HOcZGAlgz
	q4HIr920rxgpNgHJm6gjuf950MTjASO2zQGOGxg==
X-Google-Smtp-Source: AGHT+IE0BTLqNhCg/BINBcFyauRaMvF/trglatuDvkvJ1Zps7+gNBKvwiRvgYkhWF8C4ymW2ozFLRyADZMwLTSRX/9s=
X-Received: by 2002:a2e:87ce:0:b0:2d6:dac4:7d4f with SMTP id
 v14-20020a2e87ce000000b002d6dac47d4fmr10185577ljj.4.1712671314663; Tue, 09
 Apr 2024 07:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-3-andriy.shevchenko@linux.intel.com> <ZhU57jB_pVvDz0ZR@smile.fi.intel.com>
In-Reply-To: <ZhU57jB_pVvDz0ZR@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 9 Apr 2024 16:01:43 +0200
Message-ID: <CAMRc=Mdzc2gSEX0h0Uwcxr2qMgwLLXfhJda=3AkNNYsDBQre7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: Update the kernel documentation - add
 Return sections
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 2:52=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 09, 2024 at 02:12:51AM +0300, Andy Shevchenko wrote:
> > $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -=
w warning | wc -l
> > 67
> >
> > Fix these by adding Return sections. While at it, make sure all of
> > Return sections use the same style.
>
> Since there shouldn't be hard dependency to the first one, can you consid=
er
> applying this one, so it unblocks me?
>

I'm not sure what the resolution is for % and HTML <font> tags in the end?

Bart

