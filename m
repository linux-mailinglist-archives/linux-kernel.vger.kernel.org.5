Return-Path: <linux-kernel+bounces-109247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEDE8816BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CA2282DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185566A34B;
	Wed, 20 Mar 2024 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGF0L05k"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC0524B7;
	Wed, 20 Mar 2024 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956563; cv=none; b=X7s5l4mQ1GRvWgK7i19+UGHWM+6q+0liDRCAxxJdU6rG90CPaGSsjXY7FBWQY/mun8nv48srwQsIAm8PhuRJq9frO7Pj59S0Resc7bhHYjtSLzlv76oYWuTENl98FGixwcGqdA5x5NpQFZb/Gz+FmJur5hqPEPFQY8PZaz6oevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956563; c=relaxed/simple;
	bh=8L65Or9/rr57UNhiffCl+0rh3Lazf36OqwDy6Z2KAvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5znT3ZsEtsKY+l1/T7OH1NKz7+IEZXGsgcS/hL1TuMSBTP1gTBMQAG5UQ8TWZOocQXe2dWrvT2jEyAdaJFOSNxxacANqPPaSIaQ1KNG2wMSGt7Fu+rGqed4nDzHqO7pI8Yfcr/rJB4N3y1lONuMgrhbmtWUg8AsZRmEHaivoOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGF0L05k; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso154427276.0;
        Wed, 20 Mar 2024 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710956559; x=1711561359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PNmrfeclRSaZ0piCvl3NPFSnMqmFKWwWU1pPxBzzB4=;
        b=fGF0L05k7M08tVZj9Jq4ghWmERcf+t9Cr4RixarbEDwaj0vXy3QQ7spMgdp2gIG1Fg
         rs4JnDooSiRwAV5jNmkquvqwnIGslVzJMdgZGyRWMwJ0zMNNQx20in3WcQs6Vx1YC+IS
         gupl2txQuUt+zrTNvatq8ljNhfV6xvnyppb+HbYYPyVIsdCrLFh6WtDvGBsqUJKDdrNt
         GeHsN/WuixP32W4t5aTEkMtjc4IkfEBGjHfs4TET3Ofi3Vd/L+FWXeF+VcgjysR6midk
         XcFJ4bP70KmGgvWADFiFCa71k16OvL6kJar9cptFOT/U8CyxphY56n8bWlrL/GIxEI3H
         xWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710956559; x=1711561359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PNmrfeclRSaZ0piCvl3NPFSnMqmFKWwWU1pPxBzzB4=;
        b=hNavRp/Nfh7fto4q2xrMX1Z/urLb4S+1eC1q3YSWQCAnaQNJQ2/Ni1KiLLiTmN2Nsx
         9UgoRAis73nNBPPZaCqpHL3inoFhbnpxPFs577UFneo9Y9t61KQuqbOazHGGbu2gyZBR
         5V09xqH4ddFF4d0L7FFNpQsDuoaxMiPSYsRdRO9l4tdBsHIkuccPWzJBdUfhQV8cn+1u
         v9CK+u7Sj50N1xre2weGQhH1kvhKlE4/2f/xAcpZLW20wyQwNNXi2g68GEngNVJZYFrp
         YIEfwQvhp5fuevaBTqR+u6CDugeLu3gwkNInHFNj1IwmjqprfgYdC/IyzWIERglLwVQ2
         fPsg==
X-Forwarded-Encrypted: i=1; AJvYcCUQp9sEgs/lP/TkddxXpHONsuzp9Y8r42ntoMDVxFEZC2ziSh9KQRngF37w4DaNkJpBdt3ooqU+Ls1Ma+MP+hmg2ENceCk1g/KRMtFvQNk85HgXcr8uCjf0TFti5Y0xaIYy1gE=
X-Gm-Message-State: AOJu0Yx/CISFKtwAQh4KNJjDv54PcvNYJCcGVABNKLj6TOe/pzCVn9hi
	6YPB88BbyBe/EsAuZvThRHInGe8WohKxHt/nQnIYIrtM1hsXgWSKs7LwMvjixjwWTAiNKy3Cov5
	J+n3fgjO3LVniZGNO5bt+fMbBSIpe67U6
X-Google-Smtp-Source: AGHT+IF1vHg3nWNn8XTf2zs//TlcE4NB9URz9j93fR3rDahcsKwH8Qh2oWbvidfw1UwEtC6WUuLogrROJAMX9zdn2KI=
X-Received: by 2002:a25:c747:0:b0:dd1:6cad:8fd3 with SMTP id
 w68-20020a25c747000000b00dd16cad8fd3mr284023ybe.27.1710956559522; Wed, 20 Mar
 2024 10:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011193444.81254-1-jandryuk@gmail.com> <CAKf6xpuJe6Cza6bow3QxDGf1viu0kish7Y8YRN8haXL1oEF3HA@mail.gmail.com>
In-Reply-To: <CAKf6xpuJe6Cza6bow3QxDGf1viu0kish7Y8YRN8haXL1oEF3HA@mail.gmail.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 20 Mar 2024 13:42:27 -0400
Message-ID: <CAKf6xpv2oDpPB3wWh=Fz_ahDVgmvw2MSj_q3RYqQ8NG6km5Tuw@mail.gmail.com>
Subject: Re: [PATCH v3] Input: xen-kbdfront - drop keys to shrink modalias
To: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Phillip Susi <phill@thesusis.net>, stable@vger.kernel.org, 
	Mattijs Korpershoek <mkorpershoek@baylibre.com>, linux-input@vger.kernel.org, 
	xen-devel <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Do you have any feedback, or can you pick up this patch?  It solves a
real issue affecting udev, which crashes the Debian installer and
breaks the mouse for Gnome.

Or would you be okay if this patch went in via the Xen tree?

Thanks,
Jason

On Wed, Nov 1, 2023 at 10:11=E2=80=AFAM Jason Andryuk <jandryuk@gmail.com> =
wrote:
>
> Hi Dmitry,
>
> Do you have any feedback or can you pick this up?
>
> Thanks,
> Jason
>
> On Wed, Oct 11, 2023 at 3:34=E2=80=AFPM Jason Andryuk <jandryuk@gmail.com=
> wrote:
> >
> > xen kbdfront registers itself as being able to deliver *any* key since
> > it doesn't know what keys the backend may produce.
> >
> > Unfortunately, the generated modalias gets too large and uevent creatio=
n
> > fails with -ENOMEM.
> >
> > This can lead to gdm not using the keyboard since there is no seat
> > associated [1] and the debian installer crashing [2].
> >
> > Trim the ranges of key capabilities by removing some BTN_* ranges.
> > While doing this, some neighboring undefined ranges are removed to trim
> > it further.
> >
> > An upper limit of KEY_KBD_LCD_MENU5 is still too large.  Use an upper
> > limit of KEY_BRIGHTNESS_MENU.
> >
> > This removes:
> > BTN_DPAD_UP(0x220)..BTN_DPAD_RIGHT(0x223)
> > Empty space 0x224..0x229
> >
> > Empty space 0x28a..0x28f
> > KEY_MACRO1(0x290)..KEY_MACRO30(0x2ad)
> > KEY_MACRO_RECORD_START          0x2b0
> > KEY_MACRO_RECORD_STOP           0x2b1
> > KEY_MACRO_PRESET_CYCLE          0x2b2
> > KEY_MACRO_PRESET1(0x2b3)..KEY_MACRO_PRESET3(0xb5)
> > Empty space 0x2b6..0x2b7
> > KEY_KBD_LCD_MENU1(0x2b8)..KEY_KBD_LCD_MENU5(0x2bc)
> > Empty space 0x2bd..0x2bf
> > BTN_TRIGGER_HAPPY(0x2c0)..BTN_TRIGGER_HAPPY40(0x2e7)
> > Empty space 0x2e8..0x2ff
> >
> > The modalias shrinks from 2082 to 1550 bytes.
> >
> > A chunk of keys need to be removed to allow the keyboard to be used.
> > This may break some functionality, but the hope is these macro keys are
> > uncommon and don't affect any users.
> >
> > [1] https://github.com/systemd/systemd/issues/22944
> > [2] https://lore.kernel.org/xen-devel/87o8dw52jc.fsf@vps.thesusis.net/T=
/
> >
> > Cc: Phillip Susi <phill@thesusis.net>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > ---
> > v3:
> > Add Mattijs R-b
> > Put /* and */ on separate lines
> > ---
> >  drivers/input/misc/xen-kbdfront.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen=
-kbdfront.c
> > index 67f1c7364c95..d59ba8f9852e 100644
> > --- a/drivers/input/misc/xen-kbdfront.c
> > +++ b/drivers/input/misc/xen-kbdfront.c
> > @@ -256,7 +256,16 @@ static int xenkbd_probe(struct xenbus_device *dev,
> >                 __set_bit(EV_KEY, kbd->evbit);
> >                 for (i =3D KEY_ESC; i < KEY_UNKNOWN; i++)
> >                         __set_bit(i, kbd->keybit);
> > -               for (i =3D KEY_OK; i < KEY_MAX; i++)
> > +               /*
> > +                * In theory we want to go KEY_OK..KEY_MAX, but that gr=
ows the
> > +                * modalias line too long.  There is a gap of buttons f=
rom
> > +                * BTN_DPAD_UP..BTN_DPAD_RIGHT and KEY_ALS_TOGGLE is th=
e next
> > +                * defined. Then continue up to KEY_BRIGHTNESS_MENU as =
an upper
> > +                * limit.
> > +                */
> > +               for (i =3D KEY_OK; i < BTN_DPAD_UP; i++)
> > +                       __set_bit(i, kbd->keybit);
> > +               for (i =3D KEY_ALS_TOGGLE; i <=3D KEY_BRIGHTNESS_MENU; =
i++)
> >                         __set_bit(i, kbd->keybit);
> >
> >                 ret =3D input_register_device(kbd);
> > --
> > 2.41.0
> >

