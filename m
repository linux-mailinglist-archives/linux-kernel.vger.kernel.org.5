Return-Path: <linux-kernel+bounces-6807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B3E819DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF31F22596
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F821351;
	Wed, 20 Dec 2023 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xcw6Ze/2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB92110F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-db3a09e96daso3822804276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703071078; x=1703675878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nJTG0ksd0dIqzS4wveRxbem6Vl/tCOC3BG2PhGa4/s=;
        b=Xcw6Ze/2f0ywoX9xSjDFQHMN7AVqn+C0yf7Tk0sGcxOxmfb9MU9Nl6oBCaojgujn9X
         abKeHjzgQSVwykKaYRT6W1vlzAN9NFdZ3kmFGVyZ7ivkO36aeu3T1GRQ24ai0eaA7qGb
         kbXWqCKpzpPSx8Q63v+Ys0wzrcWANBsrqz7+2YuPk1qK5qBAvLfKZI/KT77EbwWf5DDH
         gorw9XyB4Y9oOZB9K7TMYrt79Uns2lX4NXfbU07lT1djZ36fq5s5ZH2Zj0s9d1Hf8Pf2
         43fjkxSz+wEZuRd8HVkXEs00mnqKaWlGGvqFdAtZPAZRKb0PCJFDlD/54lzH0vOsmYQv
         N5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071078; x=1703675878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nJTG0ksd0dIqzS4wveRxbem6Vl/tCOC3BG2PhGa4/s=;
        b=r15y6CZCU3ilQ1fNvqGEfZ6HeDs/klLDxLP5/np8Tgkmh2y/fsKsiRhh9ZIVwzuLb6
         mFUMhfQCusNXR3tAe5KR9OxPkTQG3COvIYhGFEgFd+8WCoQ94b8l2zmqQWJrOQkc3pmJ
         6ZRYW2FQ+F+V1CW/sM18QyPUeZcNhM98NWSugGSJ2UM0o6UZDoyoPGdqRsOABAJFeqPX
         at82xPgo44dHRiJDhYtRfxt+W9RN2BzA/Y8ed8K4Q4EJdiu7RWlh0j99Fk6qPvTZaA29
         hjFgVPMa40hT7SWmaKQQrRkVKNvQMs71og0WWhPkAPrvDQCBqzix2iUdfCIOOwYq2cwe
         GpAw==
X-Gm-Message-State: AOJu0YwC5KHHohyyCCa3a/i2yHsWjsIHGnEXUClzfDoGjIou3KEyuNQG
	SKP7z46NvyG2LPxrKs2ha0ZHPtyMoeYzAqcABCAwrg==
X-Google-Smtp-Source: AGHT+IFrVolfsITFdT8gAueqj3Ol3WsFvnrs3ZaizYL9MCiw0cxlXcnOnph16YBPZRvMSNFZBgwuXYYs+l6OuYCjbOI=
X-Received: by 2002:a0d:dd4a:0:b0:5e7:7a39:6977 with SMTP id
 g71-20020a0ddd4a000000b005e77a396977mr2290216ywe.53.1703071077953; Wed, 20
 Dec 2023 03:17:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215155300.21186-1-brgl@bgdev.pl> <20231215155300.21186-2-brgl@bgdev.pl>
In-Reply-To: <20231215155300.21186-2-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 12:17:46 +0100
Message-ID: <CACRpkdbNmhfYfWyY+xUjeBHLofwwd+PUH9tai4uYJGpqjiKc6A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpiolib: rename static functions that are called
 with the lock taken
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
> Rename two functions that read or modify the global GPIO device list but
> don't take the lock themselves (and need to be called with it already
> acquired). Use the _unlocked() suffix which seems to be used quite
> consistently across the kernel despite there also existing the _locked()
> suffix for the same purpose.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

