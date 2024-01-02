Return-Path: <linux-kernel+bounces-14927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BBD822493
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B8C2876B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1E171C4;
	Tue,  2 Jan 2024 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsilkCjj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC7171B9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e75005bd0cso89550577b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704233578; x=1704838378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGUJijc4OnYyIel7J37KEqrTE1jlQtmqCqdxc5ZaayQ=;
        b=HsilkCjj24/HE77B6kTgN6uROOSOGzxYdIcPPESg82BkeLzb8h+QXhqf0wnKXJYQ78
         MpTKdcexihC70+CRpZjUrNM/wOvA+VO4Ee9LxR+iUEENR8cDCqvSFoyYrGxzF+ZPzlN+
         r+NyQzTPBEM6U9LjXAZKK2jSaw4hLaiiH0+dRYMZ7CNhDUPRGHxgIZAFho1lppSTNb0C
         ROUULkq3g8Ie4pB4dHTl6ltNFvgNhAQ095YJ3E7hTsv/KqX5jkyfJKAnpzwgURtTMkl1
         2oAanYqhP9GpGXo6FmK9mibEuBKehARNX1rGiZ5pl4d++ylyIuwzIaCD/Lp81xo7iou/
         3Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704233578; x=1704838378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGUJijc4OnYyIel7J37KEqrTE1jlQtmqCqdxc5ZaayQ=;
        b=ARgVt2rSCIRjRYUonUI2yw/MTPraXF/AgZV4T/Fo0ag3Nzbofl+aJAiCSGKsZ7GJO6
         iBukmU8KUH9SzWa+ptfaGC3zbbB1oLs4q7p0Jh4PnWfkUH4KfT59PvOr/H+6lp59Zwuh
         A/pvv5R/nJqR1eMk6lwF887v3HKFVEdAzFb0GJG536vpwlxmryNdVbCkeBUsUSBDiNhO
         dLZXVvJQUybhMM5ebCZT5F1ZCDdTvSHpGHY3eKHV9jK5YbrMtnsn/EySC+iRHll2T2SD
         ezJr9iMzcDWfC9HjKP5k694yr5Fg05PTbM0MzFZ8TNyP2Ia+q07aUAhphLut6cHxzpfv
         AUZg==
X-Gm-Message-State: AOJu0YyqoyrXlBuIF63gLjLCYWW85q862Vfdqgiw4yPqYv+e+zGJ/xPE
	gyCDReH74UOJQ7jOa1a6KorMBID6dtnwn1W0vFT7qlBnP1NAHw==
X-Google-Smtp-Source: AGHT+IE0xJZcg3E/ZTqtVst25+xM6cxuIjy2yKCWB3vdCkHEi2RBGv/FY3KBQnb54tf6I1Rn04uiu/lUVOVp+Gc9dWY=
X-Received: by 2002:a0d:da46:0:b0:5e7:8d32:dbd5 with SMTP id
 c67-20020a0dda46000000b005e78d32dbd5mr14305900ywe.41.1704233578063; Tue, 02
 Jan 2024 14:12:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102155949.73434-1-brgl@bgdev.pl> <20240102155949.73434-3-brgl@bgdev.pl>
In-Reply-To: <20240102155949.73434-3-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Jan 2024 23:12:47 +0100
Message-ID: <CACRpkdZ6ZUp79OqtWKSR9teqRcrpX6DwmsDmRsh2yxFaX5mTZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gpiolib: replace the GPIO device mutex with a
 read-write semaphore
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 4:59=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There are only two spots where we modify (add to or remove objects from)
> the GPIO device list. Readers should be able to access it concurrently.
> Replace the mutex with a read-write semaphore and adjust the locking
> operations accordingly.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Looks correct to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

