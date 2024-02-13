Return-Path: <linux-kernel+bounces-63078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07CB852A95
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662482842EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F6117C62;
	Tue, 13 Feb 2024 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZwWm49vI"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19618AE8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811866; cv=none; b=B9cGmg7qhl8zpG9Y1vAbZh4xQ2jim8+6VK4OX6ZpnuIKEj2FHUBy1waq8+vQUAr++gqErNB7vRmbgRJiWUr+ekbiZhNjU1w5nOgq2YaaXAB7ARayCa4oP/3JzKIovmrmY1AJTYgjicWdGZzD9rKVC0bKhFNpCrRSYAHZFoxRjMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811866; c=relaxed/simple;
	bh=wSCAQBdMfTC+3MndVZbkwv4BtZJdwtzZ+Uis1k9VN7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucOZ2pfSonRjOuYDpDZS036fY/Wu2ceycAqGCkkA/I0xXXQcwvHZdBPdZpKYWldmQpLEsFKnB5HAH3gIlK2WAng5SawRv0qLDlhgOrG/TK2yzyjeW8lmvce+iap1MK1+NwNAFu+YOPLdDt6bE4Nw5PEkYfwNoF6Lcz/+lUYsVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZwWm49vI; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4affeacaff9so771982e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707811863; x=1708416663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyx00npWeFsll5nwI/taY+6s7E/z5NPem7hxp9luVYI=;
        b=ZwWm49vIZS8z4ksySmHSXfVicTDTwBRgL2MO12IdFYCBn1If+SJBNLQvrLDoR/MjcQ
         5rMYm0Z8ZVUqgkvKhzMMOJafD4WJ2+6VFEpkqaPpOR8b23zZR2mJVC+Xk2RKT/8O4WQA
         tISIWG6jVAt2WBeDmVBboCs3Yg96GX0kJEfyyNbaQzkKlzVYGGuKI97TMddh6nEvboDv
         VbiUMqTLcrtUA3RTRWP60i2zLtCgdwEKODfEnNLRzaqIiGbblvxHQFOY6/MxJRX0GP4V
         pwCMkBk4vN3PrsuMVKQoFqn2alU1opzoW+dAcasd6umzt9f6XLybT5na+RZuVErknwji
         5YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707811863; x=1708416663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyx00npWeFsll5nwI/taY+6s7E/z5NPem7hxp9luVYI=;
        b=hZkwmBulB9r1u+Ty13oaWagYVyg6ZDodgeLbur8oWeEKz7K+kEzx+q76PAHmK6h6Q/
         Rti8Lf7n4jqWjiZ/AVxi7iBpyhSQz9cYCD4ISyCe1dBKbyxKxwN3PffcGZPlK113wz+J
         8St3fQRdLTuXb3hI6d8IZdSZH68B5ubf7Y7SB8gy3nfcBaN9yhGr2bkgVsEIQ9lnInqk
         2huNI788uikoSSymZbJFz4DXWO8UbD/JZZKdNlpXW8aUXDKUItKACN0D06OsiGUfNLJL
         zirzzmWnTpTHT3xOJD5fK+tS/tG/I6xd7G90MDlD2ogEeXyKvyO8qw+j/gPKAP0Cu8LP
         9fRw==
X-Gm-Message-State: AOJu0Yye2sCf5UXRr+ZvMTEt7f4lgX0t30pMq4N4QK1M0it1EWwN1Jh1
	RWWfExbr0uPvCivYTT2t07nKuKd4l+jT8zYH66Ke1nO9Pr9V2YicPguwambnFrj0A0KKw0ivR5X
	S78w9VyEthtU/UTSVJ1j9hmibcoBtoXFaLwVMpg==
X-Google-Smtp-Source: AGHT+IGr0rY+BYn3KFPOnwH21/cIEVqFi5fSMMU1bOGVy5YdyOfJaSi6Db4qCj8odk6BvfgVKZLys2G4N+i1W6bMMBY=
X-Received: by 2002:a1f:dd84:0:b0:4c0:3cb3:446f with SMTP id
 u126-20020a1fdd84000000b004c03cb3446fmr5048576vkg.4.1707811863050; Tue, 13
 Feb 2024 00:11:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208095920.8035-23-brgl@bgdev.pl> <202402122234.d85cca9b-lkp@intel.com>
 <CAMRc=McrFqa-nS3L0qGZ+eCff79jWrEZLmg-OJiNw6+FQ44i+Q@mail.gmail.com>
In-Reply-To: <CAMRc=McrFqa-nS3L0qGZ+eCff79jWrEZLmg-OJiNw6+FQ44i+Q@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 13 Feb 2024 09:10:52 +0100
Message-ID: <CAMRc=McLsY47oAk3GWp0Cecb=+fEtRKjJ_L3kyKkxYkEnwME7A@mail.gmail.com>
Subject: Re: [PATCH v3 22/24] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 10:20=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>

[snip]

> >
> >
> > [   76.432519][    T1] gpiochip_find_base_unlocked: found new base at 5=
12
> > [   76.434591][    T1]
> > [   76.435240][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   76.436545][    T1] WARNING: suspicious RCU usage
> > [   76.437813][    T1] 6.8.0-rc1-00050-gc21131f83abc #1 Tainted: G     =
            N
> > [   76.439873][    T1] -----------------------------
> > [   76.441158][    T1] drivers/gpio/gpiolib.c:219 suspicious rcu_derefe=
rence_check() usage!
> > [   76.443364][    T1]

[snip]

>
> Paul,
>
> Could you help me out here? It seems that lockdep complains (with
> "suspicious RCU usage") whenever an RCU-protected pointer is passed to
> rcu_dereference() but is not actually dereferenced later - in which
> case switching to rcu_access_pointer() helps. But in the case of the
> of_unittests() it also emits the same warning for
> gpiod_direction_input() where gdev->chip is fetched with
> rcu_dereference() using CLASS(gpio_chip_guard) and later actually
> dereferenced by calling guard.gc->...
>
> Any hints as to what I'm doing wrong?
>
> Thanks,
> Bartosz

Seems like these can be silenced with rcu_dereference_protected() so
I'll use it for now.

Bart

