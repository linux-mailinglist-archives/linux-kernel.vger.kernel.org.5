Return-Path: <linux-kernel+bounces-6810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D74819DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D541D287AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94121362;
	Wed, 20 Dec 2023 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBtUPpvz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE3D21346
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbdabb23e91so243610276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703071220; x=1703676020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ts19aDh9Y+uEYtwA159YtXFlbdYpuc2+dTBf9e+tLA=;
        b=OBtUPpvzJcOjCdf4UgozcJBzxizD68+MeqormSinuYZqaZPyDZygMX7q/6w+Tx26B3
         8m3wkVfbUJFpEYGKYjrgCntbCxASogSUfQir5Komc18HZVyNnKq9QKUxGrmrcHu4zyeI
         qe/++YtyUtoZmXL6TTKtplCvQ2bWtPx5L3TnT39RMQEdKFLxDitbWNPHCzP2bWskym91
         apn5dhBzPvaaPWR+8ufHDXZndMQphThwYy+RRR5VVo4ZHJZc3cZMCpsfvSpLSdhO048X
         qr7GHdlKls9zD3ZGNwTxL2w78a3qOvB41v0+FvMIi5ICs/wEeSDw9OleHEDD57U42Yyh
         RvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071220; x=1703676020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ts19aDh9Y+uEYtwA159YtXFlbdYpuc2+dTBf9e+tLA=;
        b=M2tJA1MMuHx3FbLrOZ9clBQiKhJzx2J8Xr4bpT3+BnbHfEOhu58AaWEEDpVtMQ/97C
         EGEoO75u4ezjH4a4LV7QQHRQwFagOThiyAKcbx1/fpS9W2mNitNVzPker7xH7HaiYrw1
         IOVEX7DPYQvaXKF+z566OWoJnmJE2prYTvXiVtlyRKiU2W3MaX//D/JhO2XwG2RIYUbF
         AfVkvl6MwIKfVnQ1N3FBK5xDP2sxhyJl0X97d8R3x+gdc9WWUWeF03wQL2t/T3I0z3gg
         pDyk+fsH7U1anT5AffB8VxdWqj6i+v328tidOoPu7TMYiS+/1Gix4z5kJqx+gUbigGvf
         ou0g==
X-Gm-Message-State: AOJu0YxyQaymW5BL6kxfyQ7dZ1BHs4BhujLxfG2wUfRfy+qy8qHgYSml
	s+Gjv4SksJlQZSpFjjXQfxYkKMwDn1yu6UTGjRQ2TM9HGrm+mt3J
X-Google-Smtp-Source: AGHT+IEeQxHg05YpcChvpZ7Exy5g8Kv2n61cNJG+8dfGVBVggjeSBz/CrJZiwlA3U2vDWizkQQjD9YAmwfcim3SeoDQ=
X-Received: by 2002:a05:6902:531:b0:dbd:6584:ca3c with SMTP id
 y17-20020a056902053100b00dbd6584ca3cmr1126598ybs.35.1703071220041; Wed, 20
 Dec 2023 03:20:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215155300.21186-1-brgl@bgdev.pl> <20231215155300.21186-3-brgl@bgdev.pl>
In-Reply-To: <20231215155300.21186-3-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 12:20:09 +0100
Message-ID: <CACRpkdYXz6Oi+ebdaW9Lu+Yz7ZyzKEwA1-unSnTEBEQhfOEWkg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpiolib: use a mutex to protect the list of GPIO devices
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 4:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The global list of GPIO devices is never modified or accessed from
> atomic context so it's fine to protect it using a mutex. Add a new
> global lock dedicated to the gpio_devices list and use it whenever
> accessing or modifying it.
>
> While at it: fold the sysfs registering of existing devices into
> gpiolib.c and make gpio_devices static within its compilation unit.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Excellent patch, and a conclusion of the previous discussions on this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

