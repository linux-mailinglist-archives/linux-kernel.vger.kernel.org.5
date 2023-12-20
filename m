Return-Path: <linux-kernel+bounces-6831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BF1819E32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC9A1C2265B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDC82137F;
	Wed, 20 Dec 2023 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJdZiz2Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF02137D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so3860754276.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703072142; x=1703676942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NamHnT73jUJNImDK5rKe/+cirCI0RyTQ89t6M3BsshU=;
        b=uJdZiz2Z3cBrfdAR78dzaz/pmMmgFkky6ljRBqB5HCOyiE7t3nGMNPAPZnA9sFtvKe
         qXcDvoUv1EwMeXKRbklGKMW2Kg2feTFUIdAzRZjxs7LI5G1P5m72NjvJ9hoLfjTxGUS2
         HHk9CVQGUwqH1HC5HT1GdI8eEebf731KvpUScqdrJv1kcIGZ20VLg+v+NWtWXEBW3mt9
         usGU47SmEAqJp/jeeBoH+InimP1/CrmKNk6cfFBteHtvM5vvXgVG1u+Be4IEUTb7w/uO
         S741CCsk78IYGrvtaja0ijv7h5fC2Z5ESs1jdtD3ahi7jqNPMZudtE3shBbJ1HdekUBC
         HMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703072142; x=1703676942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NamHnT73jUJNImDK5rKe/+cirCI0RyTQ89t6M3BsshU=;
        b=tOFSJRG+8814eK5UyO9+7z4nN3PsePvDPJr8IHStXkp2ujNdPT9D6chutxR5CYTKE2
         aksitiLObWu6Yde0e01lJWaEic3DDQ9v4cz8qPV/pyxf+xnnKrQSmWHcK1pp7M7RGfnm
         v0VkNmt1X9pVssHbEVj6xhCtfd03CJIFx5HRl52wLjiq0VicQ1BPnO0gW1wdjwj7CHBk
         bljYd1+3JFDFCsfSxvtqN6kwGz7MdDOEsa9u+4yHjXgetXaaM0gk3oK1xadMN/O0q9fE
         p8rMsfWLBxx5PsDt5tTkZ0uHfdYbIgo6IEEYcBQYAR3xAYDf5moerloICImOYWeSZpMc
         2gDA==
X-Gm-Message-State: AOJu0YyuphUrSZ5eQJiy+Hdr9YhKDGPp03pmBu/xMTToOllmQUac0sxu
	sKFZREAzL7Azwtzt8rOzLMAxRa0Ydo8NQD21CEQCOg==
X-Google-Smtp-Source: AGHT+IHhZGNaq/ykMCVlsxZIoP0nT75ImyBpYvveH4wnPNiv7CYjde8jYs5CQxRD1ieGxTVBWFi5UTqJ9IacEiNfp2k=
X-Received: by 2002:a5b:712:0:b0:dbd:5536:33f3 with SMTP id
 g18-20020a5b0712000000b00dbd553633f3mr1538189ybq.39.1703072141977; Wed, 20
 Dec 2023 03:35:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219201102.41639-1-brgl@bgdev.pl>
In-Reply-To: <20231219201102.41639-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 12:35:30 +0100
Message-ID: <CACRpkdZ7BO455gN1QBVdSqe3VupYaEnnDbGty031nj_uPXgHfg@mail.gmail.com>
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> extra_checks is only used in a few places. It also depends on
> a non-standard DEBUG define one needs to add to the source file. The
> overhead of removing it should be minimal (we already use pure
> might_sleep() in the code anyway) so drop it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I see you pinged me to fix this and I didn't get around to look into it
even, but you fixed it just as fine yourself :D
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

