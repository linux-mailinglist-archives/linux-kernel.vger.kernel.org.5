Return-Path: <linux-kernel+bounces-14814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5D18222BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303C91F234A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAD3168B3;
	Tue,  2 Jan 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8sJ+WWb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C3168AD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so240a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 12:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704229024; x=1704833824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69LArWSUroy5YqmK5YMwHPfYEDKw0sz24l9A6OuFmIw=;
        b=c8sJ+WWb+B0pixL0ZvD4Eodpu9CnJ/2+VRZXmSUxm0bokRG/UuaHh3n6uDASQ//33S
         7Fe2IYk4f+uRCNCud2t3u18rNVS0KaJKhAX2QPmatTMsLuIR+v76WAxgmUBOLyBZQMh9
         /G5eXgS/B12YgXFqR/68kb5n2zzfqkRSU4HQt+z8Fde0HpEVtu2QkjHuJRwFBcZDAbFI
         PqqpnghYt1foT3zRTeBoVDGFPr/WsSxZlCJd38bbxu4CJqJFqIACqRIYjmRsc6IaTFxX
         1Z9hNjE4v97SC9507dALObGpXHt0yuzvN5pv/EdIvlR80OBDzgTOYfE0BTPGSqCctjT8
         GGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229024; x=1704833824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69LArWSUroy5YqmK5YMwHPfYEDKw0sz24l9A6OuFmIw=;
        b=E0q3uGfAAx4yKvdLHhZV/QUNyyqSEYt31X9XP8b0k6re1etTbiphP7WtwCtVifs2GE
         EWVUEl8vIW7QVCmZUiP4eO/NXKkibQr6My+r2OVrih3XEonZznS7tp8G3JsUkEjfzbeK
         v5TsaL+JX7cvxuw7O1FdHwfdCXqUBhy+OCgWF6SUogVNiNngBCQfZ36mVobjQpOYe+hM
         dBe53ewmN2laXSx273aIJBeJxWwnONI2fbQQMDfkZRUWresfak6jBL2dJKqJUwSs0Nih
         aafqHKqF7hTNUOtLkj6hjIItfQDyIkuLohhQO9DhdqvPyo6X3B8/k8cL7Zwctu8e9cqZ
         7Tpw==
X-Gm-Message-State: AOJu0Ywt9sCp8i2vXF7njgvHVdTO/P6WQyun0e21bWNw4kGjcYidhZs4
	bqUZhKdJU9DPXnb5PN8yhbSqVstRxAt5jHcTjQgUPEJM1h9U
X-Google-Smtp-Source: AGHT+IHneABEyNwgaIzKWWAAFye7HasjLAQgnTB87qYrI3m6yIScQ0WsFJI/oi3ByMeT0zUcdenq7GkK1hIHcnQOaHg=
X-Received: by 2002:a05:6402:395:b0:54c:f4fd:3427 with SMTP id
 o21-20020a056402039500b0054cf4fd3427mr10748edv.7.1704229024235; Tue, 02 Jan
 2024 12:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALzBnUG_8d-PLdhpHb4=mWUZ4oUguBqj3hBnE_HBHgdX1WoyVg@mail.gmail.com>
 <20240102192948.42392-1-lk@c--e.de>
In-Reply-To: <20240102192948.42392-1-lk@c--e.de>
From: RD Babiera <rdbabiera@google.com>
Date: Tue, 2 Jan 2024 12:56:52 -0800
Message-ID: <CALzBnUHRN7-hLJRX4i7PZNSBF+J8aXDcEWP+iKEMVVeNFmeVtw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: Fix double free in typec_altmode_put_partner
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-kernel@vger.kernel.org, 
	Chris Bainbridge <chris.bainbridge@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

I believe commit 9c6b789e954fae73c548f39332bcc56bdf0d4373 would
need to be reverted to apply this patch, but I'm not sure if that's preferr=
ed
over submitting a new version of the problematic patch that combines this
solution instead. Regardless I was able to verify the refcount on my setup.

On Tue, Jan 2, 2024 at 11:30=E2=80=AFAM Christian A. Ehrhardt <lk@c--e.de> =
wrote:
>
> The altmode device nodes of a port partner and of cable
> plugs hold a reference to the altmode of a port. The port's
> altmode contains various back pointers but these do not
> contribute to the reference count.
>
> Thus, free the port's altmode device instead of doing a
> double free on ourself.
>
> Reported-By: Chris Bainbridge <chris.bainbridge@gmail.com>
> Fixes: b17b7fe6dd5c (usb: typec: class: fix typec_altmode_put_partner to =
put plugs)
> Cc: RD Babiera <rdbabiera@google.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Tested-by: RD Babiera <rdbabiera@google.com>

> ---
>  drivers/usb/typec/class.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 16a670828dde..2da19feacd91 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -263,11 +263,13 @@ static void typec_altmode_put_partner(struct altmod=
e *altmode)
>  {
>         struct altmode *partner =3D altmode->partner;
>         struct typec_altmode *adev;
> +       struct typec_altmode *partner_adev;
>
>         if (!partner)
>                 return;
>
>         adev =3D &altmode->adev;
> +       partner_adev =3D &partner->adev;
>
>         if (is_typec_plug(adev->dev.parent)) {
>                 struct typec_plug *plug =3D to_typec_plug(adev->dev.paren=
t);
> @@ -276,7 +278,7 @@ static void typec_altmode_put_partner(struct altmode =
*altmode)
>         } else {
>                 partner->partner =3D NULL;
>         }
> -       put_device(&adev->dev);
> +       put_device(&partner_adev->dev);
>  }
>
>  /**
> --
> 2.40.1
>

Thanks,
---
rd

