Return-Path: <linux-kernel+bounces-16254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D1823BB0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704831F25EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B24179BA;
	Thu,  4 Jan 2024 05:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xzbd5741"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2A18647
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 05:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso121755276.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 21:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704344876; x=1704949676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR4TAdpORcUfD0xhX/PDqB5I0l6LiG232iyhYtTdcXk=;
        b=Xzbd5741oyKnhhvoEHSeULcVgIj6YBH1khLLgns8y9PBG9eorUYHxMDjmEOSqzXdvq
         +yy2UPFFKQpGIvKOWoFVyVszX8zBkbIb+8Z4sRJXgIbHFyQXGaJ6MCVfnJ+c7I2QtsMz
         KI/tIjv1V6vFWxIaLEKCFNvcWSzmXtPFRYCxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704344876; x=1704949676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR4TAdpORcUfD0xhX/PDqB5I0l6LiG232iyhYtTdcXk=;
        b=Ul4f0Aj3ov42xbEyGrPpTS1TzuhJpjEsSnLfKmjsCdzzU2oWTC7gmBcRPfZgzcB6h6
         ILpEGBgMNs1SRorbtjlKT8OiaKXoO9I3VYZ1RDfT6EaeNoAb0rPTwqhNKvcWPnvmhch7
         /488064Ic9EELL+SIf3U/zvDnnmz0soMB6EriaTerR3zgDS1Z8yHrB1+y8tZ39n4T7xM
         oxb5ZKvR4lzBp/vJIhpTpHN3dTuLAu53PfrJS52hp02wl7Rebcpw/AuK9pe/IrcdKYJg
         x2qGfNnJfHnhjrU0dV+pFPmy+cMA5SkMJqU5I3IQdfVd9nwqjuOxe6856dT2kalLC14x
         fV8Q==
X-Gm-Message-State: AOJu0Yxm3MpNc+HCC/lc6ItPTzo1rWZL18lYe3YnogZjYFxb1VuxejjM
	m2pKHNFKsb2C3J/YCG4Wm9QJgLM8sh63IsBYxPYJRXaLcoiN6Vg6QatVhew=
X-Google-Smtp-Source: AGHT+IHI8p2FEmfb/7z21GPJ+1pzT9xTz9PkM/BO/OWWKOOKxJHUnn9pfn76e0JkEyVB52kC9L//CEt7wXYhpXkqWtI=
X-Received: by 2002:a25:ab93:0:b0:dbd:5d43:953 with SMTP id
 v19-20020a25ab93000000b00dbd5d430953mr69780ybi.43.1704344876252; Wed, 03 Jan
 2024 21:07:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127204206.3593559-1-zack@kde.org> <20240104050605.1773158-1-zack.rusin@broadcom.com>
In-Reply-To: <20240104050605.1773158-1-zack.rusin@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 4 Jan 2024 00:07:45 -0500
Message-ID: <CABQX2QNjc7-wVZX1hZVbOjNmz+ow0xUOtn-XjpK-5p28-onpTQ@mail.gmail.com>
Subject: Re: [PATCH v2] input/vmmouse: Fix device name copies
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Raul Rangel <rrangel@chromium.org>, 
	linux-input@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 12:06=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com=
> wrote:
>
> Make sure vmmouse_data::phys can hold serio::phys (which is 32 bytes)
> plus an extra string, extend it to 64.
>
> Fixes gcc13 warnings:
> drivers/input/mouse/vmmouse.c: In function =E2=80=98vmmouse_init=E2=80=99=
:
> drivers/input/mouse/vmmouse.c:455:53: warning: =E2=80=98/input1=E2=80=99 =
directive output may be truncated writing 7 bytes into a region of size bet=
ween 1 and 32 [-Wformat-truncation=3D]
>   455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
>       |                                                     ^~~~~~~
> drivers/input/mouse/vmmouse.c:455:9: note: =E2=80=98snprintf=E2=80=99 out=
put between 8 and 39 bytes into a destination of size 32
>   455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   456 |                  psmouse->ps2dev.serio->phys);
>       |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> v2: Use the exact size for the vmmouse_data::phys
>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: 8b8be51b4fd3 ("Input: add vmmouse driver")
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Raul Rangel <rrangel@chromium.org>
> Cc: linux-input@vger.kernel.org
> Cc: <stable@vger.kernel.org> # v4.1+
> ---
>  drivers/input/mouse/vmmouse.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.=
c
> index ea9eff7c8099..74131673e2f3 100644
> --- a/drivers/input/mouse/vmmouse.c
> +++ b/drivers/input/mouse/vmmouse.c
> @@ -63,6 +63,8 @@
>  #define VMMOUSE_VENDOR "VMware"
>  #define VMMOUSE_NAME   "VMMouse"
>
> +#define VMMOUSE_PHYS_NAME_POSTFIX_STR "/input1"
> +
>  /**
>   * struct vmmouse_data - private data structure for the vmmouse driver
>   *
> @@ -72,7 +74,8 @@
>   */
>  struct vmmouse_data {
>         struct input_dev *abs_dev;
> -       char phys[32];
> +       char phys[sizeof_field(struct serio, phys) +
> +                 strlen(VMMOUSE_PHYS_NAME_POSTFIX_STR)];
>         char dev_name[128];
>  };
>
> @@ -452,7 +455,8 @@ int vmmouse_init(struct psmouse *psmouse)
>         psmouse->private =3D priv;
>
>         /* Set up and register absolute device */
> -       snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
> +       snprintf(priv->phys, sizeof(priv->phys),
> +                "%s" VMMOUSE_PHYS_NAME_POSTFIX_STR,
>                  psmouse->ps2dev.serio->phys);
>
>         /* Mimic name setup for relative device in psmouse-base.c */

Sorry, I missed the original discussion of this during the
VMware->Broadcom email transition. How about we just use the exact
sizing then like in the v2?

z

