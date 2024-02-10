Return-Path: <linux-kernel+bounces-60286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A38502A9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319A91F2416C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0318C1173C;
	Sat, 10 Feb 2024 05:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnlL/Av3"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F2CA42;
	Sat, 10 Feb 2024 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707543459; cv=none; b=OMtLLXSmDLJcZ4a7I8qGDEOuVuKJ1vgHT/YXpJ6QrJnNdLDeIWtAxYotA3x8eZVgTE0lKn05VqeDDLtwbgyX1JB6WAWo6YQpzOHcUs2UT7fauq7asa8sZZX3B9QThGuYuAmvmrYwEG+Umt3SeQmXAPkLcIVgnsu54iLyT/HHdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707543459; c=relaxed/simple;
	bh=8KaPNPOu00x4HPRhhqMa5G5kraKAW8Mgafgk58jhqow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPAH09H1a8I4uirwk3nedr03C9BUevQ0kguniyMbr5+v3igBrh/h4gCvwD6cp/w5ebMoMlBCrLRaER95wvJWjcdqv/gz2uxi53f5J6GZogO4og6Ex2a2T14A+K3KMYEOZsEUy74tbxTsjMbYXamFBUygm/ksbUyOjAsrhIw9T8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnlL/Av3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d73066880eso14843215ad.3;
        Fri, 09 Feb 2024 21:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707543457; x=1708148257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iduAe03jvNVBF+yirDMkXDVfB08Ir83jdZ6XGzswDA=;
        b=jnlL/Av3Eata2uwbZEwJA5Uxk1sasWD5K759an3XGHxBmLM5A4SKKC/t9KrDZsMmjv
         kD9/WmlHh6aM/6XXMQR3Yk0yiVSv9nyUMQsaDEBkUEc4wYdjG+3JxE1Df0E7bu7vfEj+
         BiVFbGbVowq5tnDh44+QVCMmiU7PoSBHx3z/mHUtUpeIv4HLFe/24EpBMBx7yMdWgO6U
         l0Z1GBLAMqZZ6s+Ge51cDsR783kAeSqkdCL4VypIcTvXzWJqG+GZjQwZDzkw+EUXgS8+
         Cp13WzOaa62cZwIjwO4uBJV4h+1wBqB68CuEy+2Ct1oPFtp786KLE4RT2BV/xuiAf2+q
         jvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707543457; x=1708148257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iduAe03jvNVBF+yirDMkXDVfB08Ir83jdZ6XGzswDA=;
        b=uRV6Lk3uM4tlj8vuOY+8XKMvfb68CzAOYRCyv6MzutFaYb7A6woIdCLkkMprDAQnpg
         RRJjYCJhjQksqu82huB93++2JFQ3h61zWmt1dbpyVOT5I4KIkJ+U+b8XUqBjoS+JAOFr
         gniAyunR4FhOIFNPTAEmOfaJylTbzpPA8/+JC/mNNR2+GcTorthZjF37VBIhKvzlTr76
         fHbaCxiOVMkNe9EdrrffyqYdnMk0S97Dra748wlxWBstYLgTOGsaJxP9toPVcvwOzEmG
         2aox2pLiS0xpZdPM7/qfVmErb5anK4NWo2CkrbwwUl0ZcFZUcLOk1lmhHcc33tXjtf+q
         2Lzg==
X-Forwarded-Encrypted: i=1; AJvYcCVSZUbSZl6KPTuE+o6k4O/acjv4Y5DT+q9w1+sD5SUglj8rxiUwoqTUPQLsXvJBpEr1ckjhRfWEwoglILWyaSfMhfOyaHB6F3v9QUexKn85ZYwKi3k0bUiWJi2XT0F0jQ38db7izO1xXA==
X-Gm-Message-State: AOJu0Yw77g2GXTPkiA+vvSmo9RMblYjXsHemD04ufjDt1rNnG0OBBrWm
	2ApjbIG4xhmey5UaqWxwPbjg3glZ96rOmZwh9zM991H2Og2QgdVS
X-Google-Smtp-Source: AGHT+IEkEDlxxyHKlwoTkmVCYoaIiva1F+nWCVm5H4JyHN+8056czWxAIXUTjbv5Zj3BtP6TGokJhA==
X-Received: by 2002:a17:902:f68e:b0:1da:2122:be96 with SMTP id l14-20020a170902f68e00b001da2122be96mr252741plg.13.1707543457078;
        Fri, 09 Feb 2024 21:37:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhdibQ5Gi7LGqm38Ov1k88sdySntTXN4Rr+QM0xEvaOpTgRzf0UKdHYGzNEPeGAN25d69eRgJxBltghQMGbNRDUNH53+r0rKAHMilR67YpbB/rvIApRAV84gKSpP3CZdbI1Q2VkqByY8Zx9rl1SA3DKhvAMCmY786S/fDiowBzmWWGLTpvIFHQgUN8qDX+STfAUPQ6ASIgDGgut4phHUfdlxXFBbZm7mOzODrynKj21PJ5tKMV886nFIfRa3oEvxkA5fRfzZwmgLcI0c3YB4PM8ZueXFrhz3yqv2fT/aPFWhMGg20NNFUcuWaCq18+DJHvi6yEj2BLnZQZsKOT
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id f17-20020a170903105100b001d8fe502661sm2370512plc.19.2024.02.09.21.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 21:37:36 -0800 (PST)
Date: Sat, 10 Feb 2024 13:37:30 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 23/24] gpio: remove the RW semaphore from the GPIO
 device
Message-ID: <20240210053730.GA187163@rigel>
References: <20240208095920.8035-1-brgl@bgdev.pl>
 <20240208095920.8035-24-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208095920.8035-24-brgl@bgdev.pl>

On Thu, Feb 08, 2024 at 10:59:19AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> With all accesses to gdev->chip being protected with SRCU, we can now
> remove the RW-semaphore specific to the character device which
> fullfilled the same role up to this point.
>

fulfilled

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 1 -
>  drivers/gpio/gpiolib.c      | 4 ----
>  drivers/gpio/gpiolib.h      | 5 -----
>  3 files changed, 10 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index ccdeed013f6b..9323b357df43 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -24,7 +24,6 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/poll.h>
>  #include <linux/rbtree.h>
> -#include <linux/rwsem.h>
>  #include <linux/seq_file.h>
>  #include <linux/spinlock.h>
>  #include <linux/timekeeping.h>

Shouldn't this be part of the rwsem -> srcu switch in the previous
patch?

Other than those nits, FWIW the series looks good to me.

Cheers,
Kent.

