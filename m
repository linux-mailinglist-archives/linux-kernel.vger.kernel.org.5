Return-Path: <linux-kernel+bounces-33061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F08363DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B951F258FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3423C491;
	Mon, 22 Jan 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Pj3gFJYL"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFD3CF42
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928490; cv=none; b=jjQDGtBhh+BqvdzLXJVsenGB9Djlvt5hanbtInr6rKXIkOCErpjuj8qfynIm8TCjeq5mJXYaJ3Yzthj2mcJiyjfUxUZwTgqRnpdFvkOfu1V3xZzsnqfpiaXU2fugtKrOulzA4TICUntT0/DdSA7InLhZBbJO42tLmajBdRPseMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928490; c=relaxed/simple;
	bh=JLkHdRG4MECfsMfuvLTyMo7K6W1AR8tRDwe3AS/o6xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxTQTvnaoXfx5erV3l1ghY9OOKCqYMBaSYdRnTSXiFf5FSwtUw9AgYw1itr2Ygd4yJENW/t35iTvi+8FuQXBi/9CPXsAP0jxW/S2CSQETGzX9pcO8h8Kx4dTNECm/OyRzWMiPqakuNMrP/+ECcAPo/qGuyZC1vJtlrq6AieGieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Pj3gFJYL; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-598ee012192so1331609eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705928488; x=1706533288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zd9mO083dpZJlRLnVXPFnP1+kIWlEICA3F6gDa3yy6U=;
        b=Pj3gFJYL3BlMZkNaZl9IIOu0vQZiDmXpJ1zOPe4dj7MDRuOpnTz1aihuDRbcjONttW
         ZJFAfFBe/6Ce6e5twJUxJNsupBi3ib2jgEXllHzzRE++z6rYj2fagvtv6WDtIpJ1tsgE
         HPeXolhkctV9SVtujzQ9HLsIy7eGi9DxYsrzFTPG0fPSas6MzIduBpa25lcc1087ugeS
         9iykR5smJmQrwKn+Sr+r4kkT1a1HZoozFTx8SISsEhxc5aPsQB+taHytsAp9hN8FVxMa
         PzXqXVU2ooWqfTa9jUv0J+1APRkI9/Aea0JVkNA50pGEulbFmANo67DpUcwjoyAI2/5E
         2qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705928488; x=1706533288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zd9mO083dpZJlRLnVXPFnP1+kIWlEICA3F6gDa3yy6U=;
        b=BrazmbQh5qifyL+bF37QgmRo+vJhgsE3aYKyrXoP036Rcw+blXfFO2dEp59K8n4GiN
         Rf+WoOqEY4cIBkaDw78NiRcyRNN7bU5AgrXsjFUU8rxPg7r7G+zX0Ol06E4OXYluIl8j
         sD9hErNT9+a4QkaQnJCcIwEuk2Nq1N3FpTM/3NUOt+8pGiOXUvO8PZGMqD3XoL/9/Bdg
         5682lXLXs2bzme58lCIsv09J1ZO7YSNmzE9/KmwPKw02uKI4JIyGC9V2zZ7meBlddFu1
         kG57819MQ6L1a8hrQG4haF7llJSV0+NLBcj6A3z4yTrJBiHQQgFtoPihNdH27EV3Y0Se
         2qKg==
X-Gm-Message-State: AOJu0YwOVhOs3GaxgrQelagYn1jF2hZEXo9GrV1E1MaAVNK1SGLrwOVp
	Pq6QMxyoM80oQKjRL5TV7iC0zr4w3tvsRbytnkHXwHUXJMPzC0ymNWOPcrtu5T/BDTu4ws8ndWq
	4HIEcXcMd+1cfapVPQz5x3I9W+rKSoSA2Irt1zg==
X-Google-Smtp-Source: AGHT+IEuT9JlKcOav07ptD98xxAWOjrdF0Rp568/q++9ntyWb3hkbZTF/CuNjZus9XW6zDJKqC7Arxjp6PtCINNbh5g=
X-Received: by 2002:a05:6358:4b0c:b0:176:503c:498a with SMTP id
 kr12-20020a0563584b0c00b00176503c498amr731285rwc.57.1705928488672; Mon, 22
 Jan 2024 05:01:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122113640.93162-1-warthog618@gmail.com>
In-Reply-To: <20240122113640.93162-1-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jan 2024 14:01:17 +0100
Message-ID: <CAMRc=McCjcZLWXRkT-UjKMsJTL0TbZXRo59chnjQzb5fewkT2g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Documentation/userspace-api/gpio/ to
 GPIO UAPI section
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:36=E2=80=AFPM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> Add Documentation/userspace-api/gpio/ to the GPIO UAPI section.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>
> Now that the UAPI split out has reached gpio/for-next it can be updated t=
o
> include the new userspace-api documentation.
>
> "No capes!" - Edna Mode.
>
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..2d0bc0e128bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9148,6 +9148,7 @@ S:        Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
>  F:     Documentation/ABI/obsolete/sysfs-gpio
>  F:     Documentation/ABI/testing/gpio-cdev
> +F:     Documentation/userspace-api/gpio/
>  F:     drivers/gpio/gpiolib-cdev.c
>  F:     include/uapi/linux/gpio.h
>  F:     tools/gpio/
> --
> 2.39.2
>

Ah, makes sense! Applied too.

Bart

