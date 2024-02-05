Return-Path: <linux-kernel+bounces-53814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C670484A6E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391D31F293F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76985A0EC;
	Mon,  5 Feb 2024 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y/BuByBu"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EBD58233
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160957; cv=none; b=VDaxwc9kqh9bn+RZsybFXynfjcezm+iy97/MFFQJc6jJN4c09f6/CCP7SvkysqgH7USYiUylwGLIu3H1/fcwPnNTuqsQCVKCe9LrpYvuaDKmHU2GsatHmoIqKCi8LkOD6GqaEj5v+BPCDVuK1hUF4kHkreLBhB6q5CTu7kbH5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160957; c=relaxed/simple;
	bh=NwBlikZijPaOxVrOlduCDZWMNDt4ZvQHlENdA4RHTFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMoqMCgBd/e6kMhxxnzr454Fe8A/qkMpXiSv8vToaLKfvGA0YGgrwl+R8uM95YxmAGeuBff8ClMtqxjpmLKP3RWFVzbMXUvCe9TiYmbm0AlhrLRkN9VMoKg5BEI3bwpTCPq9+/Z8j9jc0AIrTSK+feWLKYX9XoHhtBiap4/06IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y/BuByBu; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-46d2c1077easo437622137.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707160954; x=1707765754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggfb0KYupuME39WhX88C24P8RaPJxHV95I1dCnInQMA=;
        b=Y/BuByBuyI2Tq03VlSoy49UG2U8FwWs1fN84YXJuosPT+ZRc56M8FrJRGb4LKNuPaG
         q/PAszUkgTXQyvdPawTChQEkENGTyoqlxO1eL3pmJ6iHoEbzoXn82PPAJ9jV4ooBAWLE
         Sr/5Iw0qzmfxDnVb9ajw6sJmFpjndBlhhaC87SWL4TY92/lWCXi46vMt++/eOPjKLIab
         iGuOlAfEfXXV6txEpWk47M2C2oL6oEPZ7A8E4XUF182hF6YikcwPbtvE8Q8q6EXbtrrk
         Lqjpqc/2aJEQ+XzhIvq+UDSpFLMoCRATdEdsqva9Eozh0fQTWI0lezz8WH02MPVw8Nff
         s/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707160954; x=1707765754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggfb0KYupuME39WhX88C24P8RaPJxHV95I1dCnInQMA=;
        b=ULAKQlbq+cHDKbcOCuHIgotsJusJpGkS421egBolwZGi6h2WwNZqMO5bKfMUA3Klkw
         LGrJh7JX343zqYHTw4NVKA/u/VGTwyvA8TSnvinZIbcsBQL2RZ0yazOZ8SJYB3TzxsYG
         7JBdTTpzJYayBHKM0VonukMboeGuhXs9rM1gI1la4sar3ELcPaMjLCKu0ryubTXXzdLK
         abgte4s5vpuFJElyskD4pQE4OVQtNUrV9F1dJzR1Sn+XSAjnXQys2eFOaCnr5aGXg6Lu
         0X6RQUNKIIIUBy7eDW0XHmKUm8Uynt2FopYVEGp6I4LtNEPpt6zclivOdlV/CIXbdZIL
         xtiA==
X-Gm-Message-State: AOJu0YyX+gwhbHDzNshjmn1q5w5vJ4vfklawoCuckUvSk1zJDJux1sY4
	BBZql3a2A4196syRN2wYnW7py3SBi8IXG5cRWRKyFCnIiT15J+aWVdzrkRB8OdQokytEFYIzmpN
	sqtZEzauCr6MtgvEPGHmfCpSm3Yh8sTgfZN+qUQ==
X-Google-Smtp-Source: AGHT+IGinN5jGIXyMjYWCHv7zGef7C+W3Cca5ToqMKJR8rYfg4GLYCIiNrDzuvavfG4J/wZUrrpovhDMcV4YKfU9XF4=
X-Received: by 2002:a05:6102:2749:b0:46d:282b:9e8c with SMTP id
 p9-20020a056102274900b0046d282b9e8cmr958024vsu.25.1707160954437; Mon, 05 Feb
 2024 11:22:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093418.39755-1-brgl@bgdev.pl> <20240205093418.39755-18-brgl@bgdev.pl>
 <ZcDS60dB39y-B6WR@smile.fi.intel.com>
In-Reply-To: <ZcDS60dB39y-B6WR@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2024 20:22:23 +0100
Message-ID: <CAMRc=Mf+nTw1iwbDvmF2=93KxEimxBndVEhdp9V7kAzvGqizTQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/23] gpio: reduce the functionality of validate_desc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 2:47=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 10:34:12AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Checking desc->gdev->chip for NULL without holding it in place with som=
e
> > serializing mechanism is pointless. Remove this check. Also don't check
> > desc->gdev for NULL as it can never happen. We'll be protecting
> > gdev->chip with SRCU soon but we will provide a dedicated, automatic
> > class for that.
>
> ...
>
> >  void gpiod_free(struct gpio_desc *desc)
> >  {
> > -     /*
> > -      * We must not use VALIDATE_DESC_VOID() as the underlying gdev->c=
hip
> > -      * may already be NULL but we still want to put the references.
> > -      */
> > -     if (!desc)
> > -             return;
> > +     VALIDATE_DESC_VOID(desc);
>
> IIRC we (used to) have two cases like this (you added one in some code li=
ke
> last year).
>

None of the consumer-facing functions does it anymore. Not sure about
this, maybe it was removed earlier.

Bart

