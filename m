Return-Path: <linux-kernel+bounces-8975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 648AF81BEC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A124B1C22DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ED9651AC;
	Thu, 21 Dec 2023 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRn0ytAz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED8C65198;
	Thu, 21 Dec 2023 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67f91d48863so1122176d6.0;
        Thu, 21 Dec 2023 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703185602; x=1703790402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o/7eQynnq+tKv92W5LUZCaPAo9Z9OkF3qOy+9qnNEY=;
        b=gRn0ytAzsdt4+aLWw+SqqnM3oGBBgeEzmSi4Own9BfEd1OswkebMXuc+G5jRBCHjj5
         sfmgzFg/msxRgx4Ck5+2XMFGxHSK/togwunWQAm1jRjSM81y0NbpLjHgGXvZhNNgWW1R
         joQXyEwd5jhWbzWdZ2mz4zv41hoNgotu7mVN1GhRjMiJcxusJRNY7lDWsaBoZmXDM3Io
         FjkXSJTdPRBT3ChmjdCWKq5jDF1+TEv2Jf9Bk4wXkWuoPwtakobnSiW2duH5dvhz0dHI
         1mKpiRa9iqD4lLCklZocGpNAG5gMVBQoTRIV1r0OUQQrmzU4Iahr1hzzvQBYtSnS543d
         jakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185602; x=1703790402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o/7eQynnq+tKv92W5LUZCaPAo9Z9OkF3qOy+9qnNEY=;
        b=XAHl9aCzYd+ZJZJdmbbe8YgE+k2egqpqgI3WQUJuayYZpOPnk7KLbg48qaF2XsjAS8
         AHOzsjC/MhX/Je2b+rKsaqCNGBPktmkqU8wSL/nqWFuwpGYtH0UXn952wZqY4yQoBHVh
         XnXHJBKSsIUjMV3zYadvLxLhftAReIBBHA6FXtFKpMWeA0Hqmv/KNATI/BebbQxUXk/n
         DPDadCpTFTw13aLg4dzu6E8A27Wf4q8VQT1nOiFqMEJXqWah0V6YWCVfahpfvLi6suEu
         u/NAPl39wlPw3lUjqvBbtE/okcE4TckFh0LrqCL1CEk6fPd722OLFFdMhNwmvrUCSx4t
         wNiw==
X-Gm-Message-State: AOJu0YykTKArAVkvFfR/0ZnrPv/YB5dpJFn5YAeZdPzMDCpNGaLpBvNC
	okbY9xThoGY2zejgpP/m3SI2OV46mZNYFnHdqJo=
X-Google-Smtp-Source: AGHT+IF9G06Al2ozO8xM8hcDNKx6bcR8us3O8/kosV6Kdc/RyPg/urwfqDc2w1ZCGKQmHMOWSOq8veu8tJj3V7ORjaw=
X-Received: by 2002:a05:6214:4112:b0:67a:9fc4:ceb8 with SMTP id
 kc18-20020a056214411200b0067a9fc4ceb8mr231942qvb.60.1703185601970; Thu, 21
 Dec 2023 11:06:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221185702.24685-1-brgl@bgdev.pl>
In-Reply-To: <20231221185702.24685-1-brgl@bgdev.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Dec 2023 21:06:05 +0200
Message-ID: <CAHp75VcDSs7ZKGbNYupErVVNz_s9Y+xu+25Q2+aZVgORYq8Rpg@mail.gmail.com>
Subject: Re: [PATCH] gpio: tps65219: don't use CONFIG_DEBUG_GPIO
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 8:57=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> CONFIG_DEBUG_GPIO should only be used to enable debug log messages and
> for core GPIOLIB debugging. Don't use it to control the execution of
> potentially buggy code. Just put it under an always-false #if.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

