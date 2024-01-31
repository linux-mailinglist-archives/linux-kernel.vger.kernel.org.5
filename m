Return-Path: <linux-kernel+bounces-47089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9208448F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6911F23111
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F42A38FAA;
	Wed, 31 Jan 2024 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDreQZTx"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD638FB5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733144; cv=none; b=T4XGaiqZoOG6wQUX1S8jTpAUblWCzivn8XRTFnaxXFsjvP0XZa07bN/hCp4lONU3EcuOowKxA/GEtp4+yXDaafC2bXmp6w8NahKHzykmN6yTTQeDDuyzlp8B2lOU3TnrGcKMKlIWLlt960ZNlRy9+gJ3grKBFrKm6I1Idz5UKOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733144; c=relaxed/simple;
	bh=fkN7ecc9GY/Pf9d7J3+mRkDDaENf+g183+3swFSdqKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZblzkrQFrWaHKkyCYjovmBN5DigODfnwrjFA3QCXhPHBgGCYrOCO3n7NtmHGmQoykZKM/vr9kBhY7SDn5NN7L80TMzrsaroFfTWpCkqOGtk/54r1GnWH+dW2g9Kz+yRzWf3sLI2W/x1Y9BCR3HjuYSRkP3++zlrndtUHJrf8hj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sDreQZTx; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc22ade26d8so155351276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706733142; x=1707337942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkN7ecc9GY/Pf9d7J3+mRkDDaENf+g183+3swFSdqKA=;
        b=sDreQZTxi/spdYdhEQaxc3ATm7VIKNQPhAH3jjAJDlDJZwQDGsKYbq+rQkelsFrBE4
         tsmW4z0WilEKBwKTCOxDjaMeuSNRJQNfKAeBqd8HMtMw2BUXlrkNg7L6DfwaBSO+GVc6
         IuCnHlW1rzhhV+Gjdt25XYS6hfWffTRLEDXPayc6YxsacWftYl3UAK4f9ZcmuGUtOzvN
         6anmhG/vigQXnqgksXcXi/yh6yzq53wlfKog1bEqmaRnoGLNmKyOMO6KRvVMyceXLiXn
         DDUHp7AcLdE0rZXCXBAnk8gsInTr6EddWA7gZuszBxVxvOoPQivuvvue1oxS6R1zrdmW
         7PCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706733142; x=1707337942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkN7ecc9GY/Pf9d7J3+mRkDDaENf+g183+3swFSdqKA=;
        b=qVaCI96o/1lMD6ehiQBy3fA4KGgMhXJxfHq2QGFoMqSxVxyVSaK6W+bNBUzOlZCsBX
         iGbEfTmta8wNALNU7k//AOREOWvSpyfa6sNmiMXr/2I4aqt/NjW/2aJ54GaV+hfIwqTq
         dcBYlfoX1egQ9ZovMPPje3f+Q/QWYBhClgO8/kkZfsNwqPcXguaj35kAEVFIQ8tmjr58
         pb5LAxnK9ckXq2BISn6XmgsXOmMMUC/6IA/VonxWL1wMGu0xzHOLnBGJ7PpUHcD7P7Ms
         Z56xb6JJAePjWwT1MiJgGskpbMmyChcn7CAyDrHFRq7K4hRRTATEpPwAUadNSEMUcu2k
         tV+Q==
X-Gm-Message-State: AOJu0YwvDxRdQ1hNE6HasivSCTIpDTgWkO92kfhqcZYo4vupG99MTXMw
	8DXMLJEV5MhOjgcqWk734zxdxsaSd98j2Us3mFYlTYNXEKLq+lb1ImN5oofhHicQQlihmEFvAzJ
	0yX6+B2JA+GPdfzWGgkLgVR/ANym828jUbPsCvw==
X-Google-Smtp-Source: AGHT+IGGI2ZD5H88nBThWHOarCHkRy2VWKzhGBkqFvDGrPRtMKPDTD5nV7330lk/t+h5p/a9FJAWEx9XMNVshU0FoxI=
X-Received: by 2002:a5b:8c1:0:b0:dc6:cf93:c67d with SMTP id
 w1-20020a5b08c1000000b00dc6cf93c67dmr1376439ybq.39.1706733141960; Wed, 31 Jan
 2024 12:32:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 21:32:10 +0100
Message-ID: <CACRpkdZrKGHiaQc5NVq5ceV=++SE3j7xEfwD9FBWRz0GCFpMCw@mail.gmail.com>
Subject: Re: [PATCH 00/22] gpio: rework locking and object life-time control
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> We do NOT serialize all API callbacks. This means that provider callbacks
> may be called simultaneously and GPIO drivers need to provide their own
> locking if needed. This is on purpose. First: we only support exclusive
> GPIO usage[1] so there's no risk of two drivers getting in each other's
> way over the same GPIO. Second: with this series, we ensure enough
> consistency to limit the chance of drivers or user-space users crashing
> the kernel. With additional improvements in handling the flags field in
> GPIO descriptors there's very little to gain, while bitbanging drivers
> may care about the increased performance of going lockless.

OK I read this before but didn't understand it, now I understand it.

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think you should merge it all soon so we get some time to shake
it out in linux-next, hopefully any remaining bugs and cleanups
can be done in-tree.

Excellent work, by the way.

Yours,
Linus Walleij

