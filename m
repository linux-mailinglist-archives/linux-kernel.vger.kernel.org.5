Return-Path: <linux-kernel+bounces-16454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702B4823EC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DF71C23AE6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DF4208AD;
	Thu,  4 Jan 2024 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aSOsN92H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92719208C0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7cc7d0cc419so114813241.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704361178; x=1704965978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61KUe9jqsXYQoO1QYQkTPTk8aeh1CA04cUXPGRuI+s4=;
        b=aSOsN92HHr/ys1+v+LlpsnalHLS9rchbo3C/zFi+gLSvBo5CjQCcM2enJDd2/GLzkE
         BCSgWxKeSoSWilSa2cz010MOrD6N9QGew9X6UWFw71yppwI3tL3Ur7BI9TIk8jld4l88
         v93JkJkSLs1+7RNBaC5wnAZAHWuF7llm3P0c+kIPMgZo1Az3PEU0G4pDOm8TAKQd0L3T
         2y09fFJVJEl45EinAVL5VkdVj0y3ahcq81rc7pNbMuon5gNc42h+smUVKfhtNmjrdZmb
         Mx1gLRK55mf8ylr1xN/Ex9xgrKQ1kQ7wisoU0yO5PXu4nf3U8FhJSqRUW1Wy6QR8/1Bj
         0V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704361178; x=1704965978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61KUe9jqsXYQoO1QYQkTPTk8aeh1CA04cUXPGRuI+s4=;
        b=fqyCUqpLdkowJ9F6sr5+q9ka/qEeu9D7a0uDwKTQAPQ7m/FC6q3RXLToLeC6jAG956
         GiW4Y0ZRtqryuTtdfKGxDX82mrntqavDTAC2lB6FKrEwMe6fMCjyBrwAFHv72JFAYHeW
         Ew4PLN7azNv3+BY8uC1NJmGQLImhNWYcZXP5qqXS2HlheeMC+nLTC1Ef4v2vW4AS8c2a
         lRTmosvRJSB+8Ch562fEpnM5Mp6uVvXY6A09LKL5faO0EWrVAifIOSbkqOD8rTUadWPL
         TPHjGKqxS0CyR0BGFk7w5VS8c3uc7falbRsgebdZKK5aqZFE38Jm8GctYjDQelKzs2+0
         QdvQ==
X-Gm-Message-State: AOJu0Ywn5t6v+6hb+7MP05etmh6AMsWQ/q33ob3PCLMKUTbBHELXKGqN
	32z1WS54iwqhJBQ2Jy5kHocMXnGylwpKIfzX2z6gff7yRnTYlhp7KWEo+42f
X-Google-Smtp-Source: AGHT+IH5krxCMGszS8p4FxRjAHh+2FsupY07JyT60raT4qA9xlHXyTb+3/PpVOgFzWiUJiqYa/de835vl0Fh9EzL2m0=
X-Received: by 2002:a05:6102:14a7:b0:466:f402:3db7 with SMTP id
 d39-20020a05610214a700b00466f4023db7mr227210vsv.35.1704361178510; Thu, 04 Jan
 2024 01:39:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102155949.73434-1-brgl@bgdev.pl>
In-Reply-To: <20240102155949.73434-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 4 Jan 2024 10:39:27 +0100
Message-ID: <CAMRc=Mfj6Fik0qfFiC_LvBiBdr5PP2sqNNAPQpKzignmwHCajA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpiolib: use a read-write semaphore to protect the
 GPIO device list
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 4:59=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> I'm still figuring out how to keep GPIO descriptors coherent while
> (mostly) lockless. In the meantime, I found a potential race-condition
> during GPIO descriptor lookup and also figured that the correct way to
> protect the GPIO device list is actually a read-write semaphore as we're
> not modifying the list very often and readers should be able to iterate
> over it concurrently.
>
> The first patch in this series is new in v2. I realized that we must not
> wait until .release() to remove the GPIO device from the list as this is
> why pinning down the GPIO device list during lookup would never work -
> we always could end up re-taking a reference to an object that was being
> released if it got looked up between when the last reference is dropped
> and the object is finally removed from the device list.
>
> v1 -> v2:
> - add patch 1/3 to fix a release timing issue
>
> Bartosz Golaszewski (3):
>   gpiolib: remove the GPIO device from the list when it's unregistered
>   gpiolib: replace the GPIO device mutex with a read-write semaphore
>   gpiolib: pin GPIO devices in place during descriptor lookup
>
>  drivers/gpio/gpiolib-sysfs.c |  2 +-
>  drivers/gpio/gpiolib.c       | 62 ++++++++++++++++++++----------------
>  drivers/gpio/gpiolib.h       |  2 +-
>  3 files changed, 36 insertions(+), 30 deletions(-)
>
> --
> 2.40.1
>

Series applied.

Bart

