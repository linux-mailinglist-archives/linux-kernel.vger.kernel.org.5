Return-Path: <linux-kernel+bounces-106182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5E287EA69
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EEE2835F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C0A4AEDD;
	Mon, 18 Mar 2024 13:52:15 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4C482F2;
	Mon, 18 Mar 2024 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710769935; cv=none; b=r166SRhPRAO7ZX61KlwKpeyXgqnz/AvPZ0Mu2+1ii7cLy5dwhb9Rnha+d09EcqMl4RxgeMghzRARj+a62vdIpYR8DipXjT1QReJHqXv/0B1XSaOrL+QMPm5qVytCq1N/lOqguqeiwJIgMlHTFS96EF2Httq9NFST0VfQPtti5dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710769935; c=relaxed/simple;
	bh=PookXp4bPOX0npWy6gd5rk2aO3Vm9Zf52HsOGP+Nz4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFWbJtbKxjkoD3PeVECr/6ddTU6ms+v3cYaGFcpQPphv02HUNekgo22rOOv3kwW9j4r+6u+Kj9vmWlDXANNBm6v1sX7hRZ/zlTInm0DaIv/P8bkyl9JEbYn6LVddSQG2uEbiLyNuyijhK/giYgNYTtAZwPJSuBcjOV6mPEbUAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c380e99582so583082b6e.1;
        Mon, 18 Mar 2024 06:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710769933; x=1711374733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7ebsFZDfZ8wRGX/ymUxLQCpYnUCXb5v3M/6qeGcR2k=;
        b=hjfS2nO8SHKLtE/PoUkK8lSjYBwP/CENXlm/UFFmQ7Tom+pK1QMakkn4zD1SrWAI3G
         th6tHu/kjjMre5ZzW8Y7qw+zoGINfA4N/Dv8qSMCVPzaz/qt3r2t7aX/GWVbL783DYvT
         CrTWsteHGzyGiDZSw7FAte4PxrKo1M5j4dYWm5vRwbtDix7sSyYIwBYM6pxLDfsCwRc2
         CgYS2ooHk+gJUyDjhpNGjiGvJQ2nYRTyIYH0z2GUmb5F9t58p7vSik6HEYCRIe8oNfNs
         yhw2YoKZLFW4cZfcLSKeRzHzV1llRPt2NlCvDM2cuYf3w1a5gVJg6HnIlZkG/wRyLcwT
         Z1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWMATI41fj60/ceIxox66L1642dnYoWGPmP5sDwV4EJdGCdKIo0fgtTgGhl/pEEGtZpD/3yFbE15qgMwjJ7UZdiBv1HctRRUKfs/91ZnDD9MYmWJbJY38LXc51It1B9WrkJLpzf5A6/ZlOf17Kxte1x49WaM2rzOWQNnOfaIW2FobE=
X-Gm-Message-State: AOJu0YzM5NqZ8U8xepE7ccV/Q3Xv8Hkd7w/J3BFNstG0cTQH3ehw80nh
	P3+A/JcFszTo7a+iGd6/y5xmyabtdaBhW8993uUmzHIynjEQjGliOFYXwtNNHEZ15PUVRCf9KEH
	jzPLnQ08dm/G5qJkUO+H8rLICAbE=
X-Google-Smtp-Source: AGHT+IFkp+fjhly6fcg9naTNI6FjwK6V6nEo8JqRLqLJlYLU9NJHzdhKUmIPMkqXB5aEfMpA4Kog4/1ILyL5IzDJNzk=
X-Received: by 2002:a05:6820:d02:b0:5a4:5630:93d6 with SMTP id
 ej2-20020a0568200d0200b005a4563093d6mr9713906oob.1.1710769933182; Mon, 18 Mar
 2024 06:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318055054.1564696-1-d-gole@ti.com> <20240318055054.1564696-3-d-gole@ti.com>
In-Reply-To: <20240318055054.1564696-3-d-gole@ti.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Mar 2024 14:52:02 +0100
Message-ID: <CAJZ5v0hP0TR1zVc1hNMw+SnqCw7hJUcFM-J5Y6Mtgh-tnrrdEw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PM: wakeup: Remove unnecessary else from device_init_wakeup
To: Dhruva Gole <d-gole@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Tony Lindgren <tony@atomide.com>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	theo.lebrun@bootlin.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 6:55=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> Checkpatch warns that else is generally not necessary after a return
> condition which exists in the if part of this function. Hence, just to
> abide by what checkpatch recommends, follow it's guidelines.
>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  include/linux/pm_wakeup.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 428803eed798..76cd1f9f1365 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -234,11 +234,10 @@ static inline int device_init_wakeup(struct device =
*dev, bool enable)
>         if (enable) {
>                 device_set_wakeup_capable(dev, true);
>                 return device_wakeup_enable(dev);
> -       } else {
> -               device_wakeup_disable(dev);
> -               device_set_wakeup_capable(dev, false);
> -               return 0;
>         }
> +       device_wakeup_disable(dev);
> +       device_set_wakeup_capable(dev, false);
> +       return 0;
>  }
>
>  #endif /* _LINUX_PM_WAKEUP_H */
> --

This one is fine with me, but not 6.9-rc material.

Thanks!

