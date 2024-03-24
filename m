Return-Path: <linux-kernel+bounces-112829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DF7887EC4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FB61C20A40
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6378CFBFC;
	Sun, 24 Mar 2024 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maprH2J4"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82310A3C;
	Sun, 24 Mar 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711310269; cv=none; b=SDF8lpoXYFMzXXrw8pYU31DrOmruzeC9YVVih6qIf8fTk8G+QA/zzgoAeRg4Odw838jsDGI+Avj31tg7lgSxyOKs3j6HIueNeAataXy1do4zMuGW6t2L0GGqCz2kf332yXbHV57/XxeGlOPHsLBqj+v1PoYbYqP8LlTK7lkDElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711310269; c=relaxed/simple;
	bh=lg3kSg+bqI7JQzEKtAQoAr21sTsP2afkIOflNBDtQVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6ExOi05/gdw/mLXrxCuyuu62fFKPM8tLn27yUmaLogVSc5aWBLZlo6Bjv8AkhSS1WaxqRwWpFbcNFkua7wrgd9SP2Z0RnU894IanhcSWvBt1553m8F9qL+UjApdiZyJ3l6lWRVOfHKsP+XxYeexOc++VX70b8ZXjj5CZMq+g+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maprH2J4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a450bedffdfso422126666b.3;
        Sun, 24 Mar 2024 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711310266; x=1711915066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4IPlP6THkrkzdSIlJOyjo59Thug/31oXQ6SWrMV7JI=;
        b=maprH2J4tllBSXMqOSb6mn5VIkZgzohxfz9OkpaDdSf9SyVWnaONF5Iol8LMaRytxz
         zGpZL6kzZ7REfQ2SqdKdStzHo2hVODTwFR9JZtEzHeN21DDywC83rAU3kwZugQiUzxK/
         FfMSUfm3C4sRYV3jxzpSZ77uUqQdIoslf1KdKPAA8XGhedi/+Iqg12m2SGBSYVTLRyI+
         JCAV1vHoASTj5U5UQSUbawDOXH8lGrkOexam6SONLiLO5ElC/yVxsLCRf1qCNPNzfU/E
         0oll6sTsCj0ARTch8o7a75u/dYvakbcXUohMadDRWRtTNv+GmG/59LzdxRLmuq2bNbTx
         jrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711310266; x=1711915066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4IPlP6THkrkzdSIlJOyjo59Thug/31oXQ6SWrMV7JI=;
        b=J/rmVcVGCezNDlLoagIMzupjtLhX2NhU/jP3abXcy8GV8Fz41F2RahHrW28WhjUGBO
         clxCnLl2FJV7h6bSuCLm68PvrEPsva1gdfHffl0FfJZuKZuDGwZa4WwhQkMBN0L6KHxL
         jLtXEcaeAFFNWd0JliXMHjg1JMmO8ztGGiFLy21V4vnHRL37nwxbOWzOGPfRUZXdXGyh
         GOlFO18Swbr3naZGan5AD/jH6qVcqM6FhBlGFY/Dm2fBLGI7uP1t0GuWPBF7JZufNH4T
         SkdTgOanZCIslsRH14Uj5pmzm7dWo7O6Xc0O70a1yCpRnFAvpV0Sc5QnFTtcI0xIbVTe
         Xpcw==
X-Forwarded-Encrypted: i=1; AJvYcCXHRchXKjVDjgtKT0N5iu4Jz0EJjSlNAa6z7XH/nje+XscnUoEAsmsCKk4XLfIslQ0eCpatSehf3LPG9eksN/YpJyjfYM45ENdN4DVpBC2suIwZs+SRSKfcfjygIGK4g41jt/nju6kOYYhMlfRqdl4tFUmLokGss6Gn5igx9wQ/B4ZkoW4BY7+qxDV2U7HMSSA8uZhtFG06zqJWFccQsXXh/pVdhd9QZg==
X-Gm-Message-State: AOJu0YweUNTxfiXFgG/CEONTA8f3wPDEWilvcfLooQ3urpUWykiPWHR4
	b9DRhYz9YZHtpVCOM6v7sQqJkPgINqERDt9cI17uiRzPc9ecvDhJaj+SFDZnHwyL2Jjl8AGJ0Km
	3BvMbGcz0OxCOg8Sicg9+YIstifjM2d3CYRA=
X-Google-Smtp-Source: AGHT+IEFjPMkPi7I5EWm+abAes/bngmSQZQVeOkjRaOnuFzJaLMLEr25KfKquHTPuZGLqrLP1se8F+n2HwEI/ky/5PA=
X-Received: by 2002:a17:906:2688:b0:a46:8c40:7a3a with SMTP id
 t8-20020a170906268800b00a468c407a3amr3489936ejc.26.1711310266196; Sun, 24 Mar
 2024 12:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324150107.976025-1-hpa@redhat.com> <20240324150107.976025-3-hpa@redhat.com>
In-Reply-To: <20240324150107.976025-3-hpa@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 24 Mar 2024 21:57:08 +0200
Message-ID: <CAHp75VdosbYNKU90QWt+6SU_i5dWC94=xZy0GXiKvoQeDF30wg@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND 2/6] leds: rgb: leds-ktd202x: Get device
 properties through fwnode to support ACPI
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 5:02=E2=80=AFPM Kate Hsuan <hpa@redhat.com> wrote:
>
> This LED controller also installed on a Xiaomi pad2 and it is a x86
> platform. The original driver is based on device tree and can't be

the device

> used for this ACPI based system. This patch migrated the driver to
> use fwnode to access the properties. Moreover, the fwnode API
> supports device tree so this work won't effect the original

affect

> implementations.

..

> +       fwnode_for_each_available_child_node(fwnode, child) {
> +               num_channels++;
> +       }

{} are not needed.

>         if (!num_channels || num_channels > chip->num_leds)
>                 return -EINVAL;

..

> +static int ktd202x_add_led(struct ktd202x *chip,
> +                          struct fwnode_handle *fwnode_color,

Can it be simply fwnode? (Originally it was np, so I assume there is
no name collision)

..

> +       count =3D device_get_child_node_count(dev);
>         if (!count || count > chip->num_leds)
>                 return -EINVAL;

> +       fwnode =3D dev_fwnode(chip->dev);

Why not dev?

> +       if (!fwnode)
> +               return -ENODEV;

This is dead code. Please remove these three lines.

..

> +       .id_table =3D ktd202x_id,

Seems to me that you may split the I=C2=B2C ID table addition into a separa=
te change.

--=20
With Best Regards,
Andy Shevchenko

