Return-Path: <linux-kernel+bounces-109989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0B58858A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8DE1C2192B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA6C5F84F;
	Thu, 21 Mar 2024 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+6CBuyI"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DB3C17;
	Thu, 21 Mar 2024 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022256; cv=none; b=ZxFrVioMe/6Z2f2ttm5YhkJqPb7UlycFWvBBEgNfSn8cJYi/5cNHvIefbwnEx+Jg1u/xK2YhidKFjxHBIrLGdc/o01qxWsZpfbF9vHOROPZXhU6il+BJcPoE3oe2arfhVBo2DKQ9zEtGpTUPiO3EbAHZcaXTu0KG3e3LbTpgzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022256; c=relaxed/simple;
	bh=WKo7lMBV3y6mSyjQLzk2rabAfgWOP15LEZqx38+JJJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY2QpRizj+w2iV8YewsWj4xYLMA2EqXZEar0wYMMekzDT6EAagqvPGm7dj7acXukhN31HcZHG+p95A4vWpWVk6v1TZyrn6pT3v67P8QYrK3GjqlWUvYdkDyUmFlPdYsdGn1aT5VOElVYKQw1HqkLSiFfLB70rIhIWUMo4tFiOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+6CBuyI; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so909444a12.0;
        Thu, 21 Mar 2024 04:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711022253; x=1711627053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WKo7lMBV3y6mSyjQLzk2rabAfgWOP15LEZqx38+JJJw=;
        b=b+6CBuyIDunHRwF4dW3djjwT0DuXG7rRyAETzGlrUvBHAyvCn8Q8T5E3/HaNTr7/fO
         kfBZllwE3E48EfHIyOzNo9ypvmmh31fn5RGzRybQ5nzMI+q4dB8p6OqoOBRwQb3eed7Q
         tbe+TwBWIzo1wbgmMPfF8GVQQSVmvlEUz/8LbXxFigqsJmf0IhXS66fyikw7y0ni2qHb
         zCz1PdVSUSymvxlC13IsngODOcb9qCS31RUr4ZD1V8kdy7rRQdBMFFTfRo6Dgt1IK4yI
         ll8Twzvvwz9ZoP6hzObRAOQo34nU5b1Ae8xuAn7d6rjkgkbfrI57VwAL1Sl67pqetGIl
         Eprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711022253; x=1711627053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKo7lMBV3y6mSyjQLzk2rabAfgWOP15LEZqx38+JJJw=;
        b=wBsGpfb2OUH/0UlNrqUrPYGIxACFr8AxlQFJuuHNnSd2EP2gPjMM7zkEcQTEpeg0SH
         +hMcu6pbmeSmVx2alkS13Zmwt9M6bYmLtxXwAxQsbuOQd2es7rRBo/FQZAWq0bKBq7mw
         CnIdg7j7YPY4bHpR3RnhJp6yYE8D8cgLZdEN6UlmdnO9ZIjgFkcLOcQ2wB3L8sPtjKYd
         GfTfwTMHfS/Biq79b6b69VAd60saJv/YdAkItVauwYxjbwEHQhOemTmvT/44GC+S+1b1
         MDSHADNC/ojHry5zohRHk6GzE/nlUDJ6xrOkFvpD3D+lI2uUZjLaaaUGrntFAwLo7+E4
         0m1w==
X-Forwarded-Encrypted: i=1; AJvYcCWPaYmExLg6AXJMU+7fj4qAPaSnvKFhAFFsUDyBa0ZA04/2BcOiwitDJmkS+9p/9FqvLFKGM/wpnINeUPVYWwHbBLXtH6kxi9bnExq16nns0Fp6t9YNrIMNo/NnOeqjfYTcQujAdoJLpJJN3y/sKBvpzL4nu5AIfJ+VZdjHy/DGcg==
X-Gm-Message-State: AOJu0YwNf05Qa+dP8Z9Dl+8RzVq4G5/jVQ2XJif29IzGeMfk1JaWkhYA
	eFqNMvFk38nDPLxt00n+PLcxyb0TXimZn8cosz0jgyBDAwKrAOYoAfKOewp1SxrJeJq/JFn0KkC
	BFkYLBlhJV0mup/ZRB66a2mzUsuQ=
X-Google-Smtp-Source: AGHT+IHgxJcjpLLDV6C0F9FTKvUt88fHTWgTQGM4RtwmlfR6vttufKSeVESgX3vn+TpNUWCIG3JcM6sJM8oKVMreYOk=
X-Received: by 2002:a05:6402:194b:b0:56b:b698:accd with SMTP id
 f11-20020a056402194b00b0056bb698accdmr3635745edz.25.1711022252514; Thu, 21
 Mar 2024 04:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-1-4d9813ce938e@gmail.com> <CACRpkdasa4VBZUk2gwFjwCQyHkFyozokXqeOJqM8hq3BqmCJzQ@mail.gmail.com>
In-Reply-To: <CACRpkdasa4VBZUk2gwFjwCQyHkFyozokXqeOJqM8hq3BqmCJzQ@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 Mar 2024 08:57:20 -0300
Message-ID: <CAJq09z6SPbW8+OuatS1y0miRO+3U4u00qCBYfw+_-jzfZithBg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: realtek: describe LED usage
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

>
> > Each port can have up to 4 LEDs (3 for current rtl8365mb devices). The
> > LED reg property will indicate its LED group.
> >
> > An example of LED usage was included in an existing switch example.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
>
> But... is this patch even needed at all?

Yes, leds is a property already supported. The only purpose for this
patch is to limit led numbers to 0-3 and describe that the reg number
is the group.

I don't know if there is a better way to add restrictions to something
already defined. Anyway, if that is not necessary, I can drop it.

Regards,

Luiz

