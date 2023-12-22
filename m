Return-Path: <linux-kernel+bounces-9984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A88E81CE22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D91B1C2095C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20E12C190;
	Fri, 22 Dec 2023 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8x1n+VH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8E2E637
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbd71f33cd3so2010970276.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703267502; x=1703872302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCjV6fjtLNH5x3H55hZxl+1y0FuIxxcKcoHuCuyhtB4=;
        b=D8x1n+VHawXZg+1hryLya493jDOiMGK1YCkK70aKtRJLKAkoS2ICs76O7gjXnqSEpm
         ETGnG5aUCSAoUc58vgqwjUDeGFlvVuA4CnWzlKBQ14vbL3tNoRSdMdEiVZnpVMLeVrF0
         uZ9TqHamLsX72lv/z9OkC9Yt/LehhrgF3zkEArJ/NMWCRGt+jRMjS7qV2qyH+MNh2UiK
         qYZ26hpvFlRXYfUdFdRFVab1flrx03kzJXVsguk5CX1RWkLwk/7ifK354pf4mjG4gGLM
         mTedjxUT8Z1cENP5uvn/seH15pDRciQ1Qr91xYiNka1VaQC1cMl+mBPt3zBbL18H2Pkh
         oCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703267502; x=1703872302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCjV6fjtLNH5x3H55hZxl+1y0FuIxxcKcoHuCuyhtB4=;
        b=NSy4AJgAwzxZKF8MxsFUD51fkNWaVNkvmEXwBzRvL8/RYu+tjH9RLlbxmZP4td00Mi
         N4nQL9V4+BaRxrgpcIvzjoaWO7Hb4Bk4R2rYLVkwWnnSCKrSYyixJQXkNxc56qxVL5U3
         SowZE08GFcmtXmc7rq1cQvHTLyoeGx9QptBfXyVKWC3BZ89tKN5zAAKPHuXlVMgDRKXy
         jRKriQLWsH8LhAJLHR+QNixKz69DSItLlf7xt6WqZwJaKQclCwaGdmQT8yDfoeaxYXmX
         hS6uB3XTGQbSMau6ELWBw9aCsqEOPLUCqp9n8OkGyTPtwYMP4YmdPwqni6wnH5aAsWqh
         z29A==
X-Gm-Message-State: AOJu0YzGNPMQFlfbmflpjZyXRt6ScdUv7VCNHrmuBua/YOc/YGzzC82U
	DvdrDvoFDIZMcDRPBiAbmERVBhXW5LJaVx/jkdYKTCHt/GrRng==
X-Google-Smtp-Source: AGHT+IFwM7I0XkX8vmzOkYUSUylo3B4O346tEUebZhgDmXGbnTgxuxAqc0HXd40WPEl8VBkD8J354qKBO3ydasHbBOk=
X-Received: by 2002:a05:6902:18d0:b0:dbc:ea09:b545 with SMTP id
 ck16-20020a05690218d000b00dbcea09b545mr1509915ybb.111.1703267501916; Fri, 22
 Dec 2023 09:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221185702.24685-1-brgl@bgdev.pl>
In-Reply-To: <20231221185702.24685-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Dec 2023 18:51:31 +0100
Message-ID: <CACRpkdbuJ6bzXGwoa7nMKYb9U+EsaKeE8ZQz0XhQYX4Ukdz44A@mail.gmail.com>
Subject: Re: [PATCH] gpio: tps65219: don't use CONFIG_DEBUG_GPIO
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Tony Lindgren <tony@atomide.com>, Andy Shevchenko <andy@kernel.org>, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 7:57=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> CONFIG_DEBUG_GPIO should only be used to enable debug log messages and
> for core GPIOLIB debugging. Don't use it to control the execution of
> potentially buggy code. Just put it under an always-false #if.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Maybe I would have simply deleted the code, but OK. I bet some static
analyzers will promptly return complaints about "no #if 0 in the kernel" :/
In this case it's an OK compromise.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

