Return-Path: <linux-kernel+bounces-155051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DA68AE4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572A91F214BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE60142633;
	Tue, 23 Apr 2024 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUNa/QHf"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CA1420B3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872469; cv=none; b=qKPplGkuQwBsMMUlT1bYtbTNrZYb6DNXNqE08gwKyDynfzvjWGTZEKIZSc5ZOHuWRiVTt+ZcSQ3CYvBJL7MIfIFulAaKvPqu1cxv62deS554HDcEMNx9firfZJV7DAESAD1c/wufGrqR5PF1M1h3NY6nWgt/1dW76EyNho4mnjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872469; c=relaxed/simple;
	bh=jGSxB/aKBQrvQZyFP9ugxKa9qzrbfWhqVhGn/ZIkYAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ago4uCu17HOGaz3eg2q55gju3hB/5qOgNVrNicVEHPvb5p8XQuO7wJzFqlDHBxrLgQ89hdnhetgsrQVvo9WMMjs+G1TWx7LREbc6fNIh8jzD7LqEuEAnjd/Sl/3WyR6XZ1D7jrLy03vMYSb3yGMYOYQ0jMUwP0GdYKOnVKRQCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jUNa/QHf; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso5169205276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713872466; x=1714477266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHww8guo9joHfM40pOxCx1WuFD69gCMICsgCV/kfVdI=;
        b=jUNa/QHf+h7rYfkyPkjek9PKWLdqhYn8cYkiC0ZAa62e0AthIsdqVaYno2Psgu54Tw
         uGB5D8REfnmWsukIeVHj6PGddpntyXFlHNKuiTAHQ2UG44fKPlmLzBdQrn656KyFViXv
         36GuWW834TeQTyRaWp4QxurOJ6mxzmpSdThL4pbt8jFxflYLIE+TPUQoiMQqW7O1E6Ss
         PNMyVuXkYz0rU7Flh/7J2Sr1heGl+7Mae6Pw+gHCQJNuYwKw9U7X5KJRXRWCjSDd64ca
         +XqNq1ZFw+EAjP62mGVaLWygdTyauWXRSzDvP7nvO7Jta9NClP4bKUdaGAMRihp0Ouqb
         4qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872466; x=1714477266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHww8guo9joHfM40pOxCx1WuFD69gCMICsgCV/kfVdI=;
        b=mSEcJjSVa7PSfhT3ab7XLbjiP+LaDOk76N16Os+H+C+sAhuYXT7HlvM0gI0gBYz2gm
         33mBS9L+FXSxwTMu4xrMDvpJMZ74AfZXQxX06bXIKxes5oU7k3P0UWziA+tF5/Bp1N60
         YtZA1T4W3XKaxifhA+e1gaJofOwhk/aEI6JEvz6oYPFBiIwmDW6yHNeMxZQfZUpPOZhH
         fNGCnwijS0AgPIurJJYO7Ta34RDZ2eUQdAXJR3fAQyIteU3MA9n3eNHggSadrBvp2m0j
         KhwtkFS+Yx37OlpUxHvXypVSHkigdwGUT0EtXca7eh7fKlGnkcxShqAlPmExH7/i/hiZ
         tzSA==
X-Forwarded-Encrypted: i=1; AJvYcCXPCo+bUiqWo6qtEq+idWvAVdKpqCi35tx+RBXrL836eTjU2FTcTca4bvD6qCqrutpvRiSyXRLD/YFwZWGSwqTs595q6S0MnXpdMfMl
X-Gm-Message-State: AOJu0YxV716iRpx00IzRmpE8fhN9xcicNMZwlZcIJCUefRK5sWXf3blD
	ptX3+pUAaX7jl084YBAoYctKCWJamqpyeQJuhncyCxmboArM5EDgsH2B3QQE6cwnJov6HwgU9Vt
	g9LrIwiTDrI3W54vh/zndcsEzdbn3mqbOmJ5C/FBvV8RYTZtCqwY=
X-Google-Smtp-Source: AGHT+IG0zUJ0k+vOuaZckaNvNj9KvErNxit8stDC2Lri93dfWftA1haaHyaI6RFYiG/AC23vxxVy2y/4BpkWBRxblqM=
X-Received: by 2002:a25:bc45:0:b0:de5:5084:715d with SMTP id
 d5-20020a25bc45000000b00de55084715dmr1506637ybk.53.1713872466081; Tue, 23 Apr
 2024 04:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423022814.3951048-1-haibo.chen@nxp.com>
In-Reply-To: <20240423022814.3951048-1-haibo.chen@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Apr 2024 13:40:55 +0200
Message-ID: <CACRpkdaRxoEZT1_KyJ3QMDgBcciw1XUXKr=cEiPxbcwSnpmyiA@mail.gmail.com>
Subject: Re: [PATCH] gpio: vf610: always set GPIO to input mode when used as
 interrupt source
To: haibo.chen@nxp.com
Cc: brgl@bgdev.pl, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 4:28=E2=80=AFAM <haibo.chen@nxp.com> wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
>
> Though the default pin configuration is INPUT, but if the prior stage doe=
s
> configure the pins as OUTPUT, then Linux will not reconfigure the pin as
> INPUT.
>
> e.g. When use one pin as interrupt source, and set as low level trigger,
> if prior stage already set this pin as OUTPUT low, then will meet interru=
pt
> storm.
>
> So always set GPIO to input mode when used as interrupt source to fix abo=
ve
> case.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/gpio/gpio-vf610.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> index 07e5e6323e86..305b0bcdee6f 100644
> --- a/drivers/gpio/gpio-vf610.c
> +++ b/drivers/gpio/gpio-vf610.c
> @@ -214,7 +214,7 @@ static int vf610_gpio_irq_set_type(struct irq_data *d=
, u32 type)
>         else
>                 irq_set_handler_locked(d, handle_edge_irq);
>
> -       return 0;
> +       return port->gc.direction_input(&port->gc, d->hwirq);

Just call vf610_gpio_direction_input() instead of indirecting through
gc->direction_input(), no need to jump through the vtable and as
Bartosz says: it just makes that struct vulnerable.

Second:

In this patch also implement gc->get_direction() which is currently
unimplemented. If you are going to change the direction of a
GPIO randomly at runtime then the framework really likes to
have a chance to know the current direction for obvious reasons.

Yours,
Linus Walleij

