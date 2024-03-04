Return-Path: <linux-kernel+bounces-90437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF70886FF28
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA74E285322
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E93321AA;
	Mon,  4 Mar 2024 10:34:27 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A5249EA;
	Mon,  4 Mar 2024 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548467; cv=none; b=FiamtVMRm2Kjy7lw6oaM3hVK5gCzi9X7AEnvXdFQJX3Znf+fVLUK38In0D8J+j4YuVmgftgtcZtPZGzEJ4kFg/Aw3H4z5tckAeBP3/3rVMjVxyceI3PaGimiRgmVqoHSYfJXyoXPW8Ivn92VQh6WfZxWY7skyAciDmNHfcOSLzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548467; c=relaxed/simple;
	bh=GnMIo/pAd4JHLRP1VZXlqka2oS6REd7bI010ZIuZm+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWWAZkN5KgK6+v3otMxYDOs9JAiea7ElbHF2po36GFvLufwQm1adhBa2r9mSFNVyAPYkJzxbsPHMc3q/5NBsVHPoeCpK84+ZNQubEmjW8PoEBLTZF3Hbt3eqzBqtW5JxDnixIkVnM9/pYQGff9mX4w50WE34VRPECEK0lZlAvz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60821136c5aso28861637b3.1;
        Mon, 04 Mar 2024 02:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709548463; x=1710153263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnMIo/pAd4JHLRP1VZXlqka2oS6REd7bI010ZIuZm+8=;
        b=Tgnt8DTX9VYO85UQCn5zwwWOhHYNRPCia7Lb5QsrxqSx59dXlny2BKlhdadQgxUf2a
         lzt2NOL282XgeQQ0h9SPLdu3t68Rx4mRYhfFDXraTDv/o6tbHyCnWlHiMuHqytPrT0oS
         J0ZlAqMGSRIBkwQm0+CtiR7VsFFjftGL7Nk9pR50zuso2Gp1zS8D8imErE7tqZH0zjB4
         f22JuXINqas4scXn2BJeQ5z4yA0OQGuga3WTSRrUjnLukvjdYmGwYD2/QnWe8b5D0rIA
         1QoicaN+buxY9PItdBx1bv0g3obxji2v+CFeDaiRKeQ+kFRR4MDmGfyN4DgxJdVxlVBX
         BwUA==
X-Forwarded-Encrypted: i=1; AJvYcCVhD9GAXg0D6xNuEVD+cuZa9A5MVmk4i/Fqer/00pfSQsAkIowrSXCchhGXlcVfEyvxYUaUEFjwd+JKczirnRxumQ5TAeutm6LirV3UtH0XVyzLgSSZqFXQlVkJ84RxBXEcXgrFXuSp2ZVnvQN5WSAyvhNDcCI2mzWuuRUa0MkJ/g==
X-Gm-Message-State: AOJu0Yw9ph6Q9aciFyHKSMLl9iinqgOlHFAJ1NEvHAKWq+QA8VrSLK/q
	kX7IfHfU/s3cm9Oe/1qhU9zbAMF1Ad2o38SUY5PilOudDbbhVyIwaFOLyMx0gOs=
X-Google-Smtp-Source: AGHT+IHX930ZUrQfn3sruS1o3KTGvcsMAaJR2gpkCVcT9jsiz2lXYaGoLy4Csg21BIWb1vOGL7pj5g==
X-Received: by 2002:a81:9847:0:b0:608:c440:620a with SMTP id p68-20020a819847000000b00608c440620amr7990467ywg.13.1709548462884;
        Mon, 04 Mar 2024 02:34:22 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id u62-20020a816041000000b00607c9160c22sm2553915ywb.119.2024.03.04.02.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 02:34:22 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60982a6d8a7so36294867b3.0;
        Mon, 04 Mar 2024 02:34:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzWclLHPvm8Tgx2cHWhjBo9UqVKzt1pxcsl3Qr1zRE581xlyNsv3Nm9uJHIsAU1ucnSo+sxludaeGNWTwnKmRSRKcuxEVSL2gfbSvBX2OjiMzVmu+ElVamX9nOCKOY3dlTlM0tnhExIvuCprJiA6SDUZUkesbLsBEZWF5agU3ANQ==
X-Received: by 2002:a81:6d15:0:b0:609:879c:a72c with SMTP id
 i21-20020a816d15000000b00609879ca72cmr7227414ywc.42.1709548462066; Mon, 04
 Mar 2024 02:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <010ea3a0-929e-4912-ad22-9f0cf5b1a3e2@redhat.com>
In-Reply-To: <010ea3a0-929e-4912-ad22-9f0cf5b1a3e2@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Mar 2024 11:34:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX2CtKuY5GS=sJL2rYhixzgtXBQQpef-h=2GKRX-cNOjg@mail.gmail.com>
Message-ID: <CAMuHMdX2CtKuY5GS=sJL2rYhixzgtXBQQpef-h=2GKRX-cNOjg@mail.gmail.com>
Subject: Re: pm_runtime_early_init() defined but not used, except on SuperH
 which has its own definition ?
To: Hans de Goede <hdegoede@redhat.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-sh@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Bartosz

On Sun, Mar 3, 2024 at 8:53=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi All,
>
> I noticed that drivers/base/power/power.h defines pm_runtime_early_init()
> but nothing under drivers/base uses this.
>
> A grep over the entire tree shows that arch/sh/drivers/platform_early.c
> does use pm_runtime_early_init() but rather then including
> drivers/base/power/power.h it has its own definition / private copy
> of both device_pm_init_common() and pm_runtime_early_init() from
> drivers/base/power/power.h ???
>
> Also the private copy of pm_runtime_early_init() in
> arch/sh/drivers/platform_early.c differs from the unused one
> in drivers/base/power/power.h, but only when CONFIG_PM is not set.
>
> When CONFIG_PM is not set then the pm_runtime_early_init() in
> arch/sh/drivers/platform_early.c is a no-op, where as the one in
> drivers/base/power/power.h still calls device_pm_init_common()
> in this case ...
>
> I also wonder if given that pm_runtime_early_init() is not
> used with the exception of arch/sh/drivers/platform_early.c
> if the dev->power.early_init flag check in
> device_pm_init_common() is really necessary ?
>
> On non SuperH the only (1) caller of device_pm_init_common()
> is device_pm_init(), so it seems to me that the code to
> avoid doing device_pm_init_common() twice is unnecessary.
>
> Actually it seems to me that the entire contents of
> device_pm_init_common() can be moved inside device_pm_init()
> and the dev->power.early_init can be completely dropped (2).
>
> Regards,
>
> Hans
>
>
> 1) Well pm_runtime_early_init() calls it too, but that itself
> is unused and can be removed, removing it is even ok-ish
> for SuperH since that has its own copy anyways.
>
> 2) With the exception that all of this is still necessary
> for SuperH I guess.

