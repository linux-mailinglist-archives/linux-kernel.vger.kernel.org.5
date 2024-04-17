Return-Path: <linux-kernel+bounces-149212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667068A8D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232EA285DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A76540858;
	Wed, 17 Apr 2024 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aQ94PS7H"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2358D2C859
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386857; cv=none; b=kiqVc2HsFTemPb6GOLk1goXXodFP/wLfkag39wA7ayAU2kdc4CwXBSrgz4y08Q7c+nw/F+ZhzuqE00Vh5TGu5ekhAMKR5ou58bti2GjlN6+v8+GhRTdbIX5WABH4XQneUUH3x+DabZ10KRtQQXS2jAoAnIu2AV5d1pj9qc5Rdao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386857; c=relaxed/simple;
	bh=WDdRomGwYIj9LAM5YN6npSc5eONnLOEwIE5znWDSutU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCx27iWQnWzr7Ulpooh9GTzAdxmp9ZzR9w2gB4STBbXJFC0jRMt9g7B+v5R8X7WyEPr9NNwo1wYh3ELbg3mIjJ3u0wE4AdyP6Q0YAmZRYIWyt9eMHnxFoQlxgXTh8KpVsEOv4sLLHKdizJCOxQqxzgLaKcS9eJzfV5/VriJmHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aQ94PS7H; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51967f75763so92345e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713386854; x=1713991654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDdRomGwYIj9LAM5YN6npSc5eONnLOEwIE5znWDSutU=;
        b=aQ94PS7Hlq72H2jimONDaLrmFvoGNwMzNezPgigXjoHjEImsMafYALMRuR8GKvQjTk
         O9f9ErJz0SCUF2kq/rPxXY2K0yAas2vPfEfL0AIZZYI4SurgHKIYO5o/h0SI+fRcrVZ7
         wZ4JUmsNVKF+LJuQuLsDwbAlu9qity5IHXi+pm7s9dTJp5itrTVQc+lcW66mzfv8ysLd
         4Y8MygcE48nRaS/oYlg0gEZSqnuz2YTZUK+J3vAjRCK1H44YanpD6Aj/mG+ySblUAFt2
         4QGQ/q21pmGi/c2OdMy4Ydfa15K9OPobbgcnT0u8KlxocIx9Z18TGpYC6LgSeM7DGdOG
         LDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713386854; x=1713991654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDdRomGwYIj9LAM5YN6npSc5eONnLOEwIE5znWDSutU=;
        b=nl8x8gEAcqtjTG0Hcx1YG9IwOXbw1pO95vTIGxEvEIG5amV+8012cC8MTd2BkNFpYW
         y5k+cShkYzC6wtJ3+HyGl5Lo87lerPlwqUBR3GvHin0M5fYZA/M5aJuxBtpEhlzoZ1RQ
         wr82U6GbjY27wUGfdet5GEmnZ+ehO4sTp73Y9VWByOCeXBhqidzRT/Ls+3aKsF4KF4Yq
         Ej5BDNAzpr9oUQlgqmosIAeFTNQ8+nhBlg170V0v3NDhSqvuLtCNzCnua6WLZGwbCU0d
         4cUQ8/LparfKaBEm0FMkIr7IesJIhynlyBDelABDDJYbcX/lI/1U+FXcqtYrHYeo+TxD
         7mhg==
X-Forwarded-Encrypted: i=1; AJvYcCXnBujhqjxwMLQ3yD7aRKj27bpy0LVER+4l6JnEgbOKIX531sVCaQ2cj82RVcBwES6e1Ro4OjypGLMPoEFS/2lTReQ9nwYpXDyu4alM
X-Gm-Message-State: AOJu0YxZwDehY1fqzypj1VPOBOcZXJF4kvu3qMOI86S2wSDnaOHrzY0J
	qELlZ7TscbSHaKknmsRvxHbu1OKNKvZnbULvEMlnqiK5yWVdH/WmogbScpRGHjPE4I6OHzJ0zg7
	eZrBtbHqZe6PaCMMPHT3hx/74CEOdVpBLt/Nq1Q==
X-Google-Smtp-Source: AGHT+IF2JtxDcBcGf5KQ7m9jQ2Ck/N7MLJAwJpQMTOQIh1QEQUjpIuMwqAGFdic86q1ciV1N+WqGSAPC6I4bcJOi3qc=
X-Received: by 2002:a19:4310:0:b0:518:6f95:1a37 with SMTP id
 q16-20020a194310000000b005186f951a37mr239045lfa.33.1713386854355; Wed, 17 Apr
 2024 13:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221213208.17914-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mfh-ojboNUELXfszKUbZRfeZn9vsN-HMTdMQv6my6ZrdQ@mail.gmail.com> <Zh-oku-XzpcH_8FH@smile.fi.intel.com>
In-Reply-To: <Zh-oku-XzpcH_8FH@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 17 Apr 2024 22:47:23 +0200
Message-ID: <CAMRc=MfO_7smzcG2+FM2EHNb1FbqS7PbfJuzBH6gL6KXT2fVUQ@mail.gmail.com>
Subject: Re: [rfc, PATCH v1 1/1] gpiolib: Get rid of never false
 gpio_is_valid() calls
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 12:46=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 27, 2024 at 02:06:05PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Feb 21, 2024 at 10:32=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > In the cases when gpio_is_valid() is called with unsigned parameter
> > > the result is always true in the GPIO library code, hence the check
> > > for false won't ever be true. Get rid of such calls.
> > >
> > > While at it, move GPIO device base to be unsigned to clearly show
> > > it won't ever be negative. This requires a new definition for the
> > > maximum GPIO number in the system.
>
> > > ---
> >
> > It looks like a risky change that late in the release cycle. I want to
> > avoid some CI problems at rc6. Please resend it once v6.9-rc1 is
> > tagged.
>
> Not sure why resend, but I missed that somehow. Can you consider applying=
 it?
>

Applied, thanks!

Bart

