Return-Path: <linux-kernel+bounces-8934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DD81BE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF332879FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2520165193;
	Thu, 21 Dec 2023 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaGnen0K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC08F48;
	Thu, 21 Dec 2023 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a235e394758so125149966b.1;
        Thu, 21 Dec 2023 10:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703183700; x=1703788500; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XusJbdD9peLIn0/lu5AOTE42XTxhjnQwjLdM8QhS4w=;
        b=GaGnen0K/+w+5Lw8ukyylZsTFz3dZL1tR2bPc0v4s7etRHsBssk/9HbI/YImUNHG30
         xsM8Xt0A9mz3EGm88s6WcPx1xL384YvCwHGcQk26/peAa6R/YKwySx8Fy+sY80C4xCXb
         ozonCOWyJRw4LKCUuLFzo1B0dVum2+3b4f15udAJ+r5cGBn3NSQ4nTFulX5+vgBsHrAd
         x3CCHyIN0RQTq3HAlFrGK0YBIp5sqh4VVeOdWXaQAe9ZilyR2HS3ImfdCC/h0QAhdEIy
         NgogJGZovoHOEttKMGl+AjqS06RAQ/UYVbiY2wYK2BVsfWspSWV6awPydCDv5nAxpnbA
         4Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703183700; x=1703788500;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XusJbdD9peLIn0/lu5AOTE42XTxhjnQwjLdM8QhS4w=;
        b=G0PDxVwNnHGduHW1clrIPqiQqcCLJgsTGjKNqvy7r1CCu2mp4ymoXF2JQunpigd7AI
         NtmhyY8XFS4ny1Ma6SLPBIUz4WijjRmD7nJmbyE9319zb7uUIJhnqUtkRQugeCJbCCMs
         ygRFxQ8gkJni0X49MUSqoOjT7/i4E7TpPLWxIPw3tTeLIsHSLaLhj4YFHZ/e0aM3OxVr
         m7XU0G7+FPkht/8zOP38Mv4EW//eCLDEwn9UB71ivMw5PM1ME2KG99YpR5w1ZXBf5jTs
         /ipSdY/FmIx97YiUcsxjt5Has9R5bmMFSOIYfNu7gUVXttYxiyS3T7+qJTo29Z701u3R
         cWcA==
X-Gm-Message-State: AOJu0YzQ9uWzkTDzefl6BASnbnUqQvNentHQgXfeITWoU1kbzJIgykHk
	O38Qe3wf1wfRTFxkD+NNwE0=
X-Google-Smtp-Source: AGHT+IGkhC1hdH5qalsT33T8BdD/1LRZt63F4Ais59OTSQZUHynUahA5isAYeKK0uLrmHkQutNRduQ==
X-Received: by 2002:a17:907:90d5:b0:a19:a19b:78ad with SMTP id gk21-20020a17090790d500b00a19a19b78admr104231ejb.112.1703183699977;
        Thu, 21 Dec 2023 10:34:59 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id jt4-20020a170906dfc400b00a2369d8ca07sm1219804ejc.203.2023.12.21.10.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:34:59 -0800 (PST)
Date: Thu, 21 Dec 2023 19:34:57 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Sean Young <sean@mess.org>,
	Flavio Suligoi <f.suligoi@asem.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: (subset) linux-next: build failure after merge of the pwm tree
Message-ID: <ZYSFUZf8NcK5vvLv@orome.fritz.box>
References: <20231221165805.0c4771c1@canb.auug.org.au>
 <170316329164.542553.8341559295114557258.b4-ty@kernel.org>
 <20231221125801.GG10102@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EDqCKJEpkPSV1hLC"
Content-Disposition: inline
In-Reply-To: <20231221125801.GG10102@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--EDqCKJEpkPSV1hLC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:58:01PM +0000, Lee Jones wrote:
> On Thu, 21 Dec 2023, Lee Jones wrote:
>=20
> > On Thu, 21 Dec 2023 16:58:05 +1100, Stephen Rothwell wrote:
> > > After merging the backlight tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >=20
> > > drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_update_sta=
tus':
> > > drivers/video/backlight/mp3309c.c:134:23: error: implicit declaration=
 of function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werror=3Di=
mplicit-function-declaration]
> > >   134 |                 ret =3D pwm_apply_state(chip->pwmd, &pwmstate=
);
> > >       |                       ^~~~~~~~~~~~~~~
> > >       |                       pwm_apply_args
> > >=20
> > > [...]
> >=20
> > Applied, thanks!
> >=20
> > [1/1] linux-next: build failure after merge of the pwm tree
> >       commit: f7baa9ccef93ba1c36a8ecf58c2f4e86fb3181b9
>=20
> Actually it's:
>=20
>   f7baa9ccef93b ("backlight: mp3309c: Rename  pwm_apply_state() to pwm_ap=
ply_might_sleep()")
>=20
> But don't bank on the commit ID staying the same.

This is likely going to break the build on your branch because
pwm_apply_might_sleep() is only available in the PWM tree right now. In
any case, I've now pushed a commit that adds pwm_apply_state() back as a
compatibility stub, so it should be okay for you to drop this if you
run into problems. It's always possible that somebody else wants to add
a new caller of pwm_apply_state() and in retrospect we should've
probably done this from the start, at least as a transitional measure
for one or two cycles.

Thierry

--EDqCKJEpkPSV1hLC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmWEhU8ACgkQ3SOs138+
s6HaAA/+IJB2HvxpmeREwYbIr+AxbGWibBE0j7MyukgIsTB3WBz1j8beoPip2x4g
WC9oPB2zyPr+iYvRO+OIVe0S0VcDk84Ue+/c9GjOnWcJIdn62uKnTA0FCPtC0cwq
X8ppXLEuQhFdXDafhpXq+UNIlJJcR5daZdg/vb1mnKEei3yPAJjiP9CdqxYZLePG
8I7qqqTuUKlOBUWVOBxBAnohAFPJCte0NagRNfikDrPSAkF0SbnDMpkza3F/xAQm
mEgnmJenShreiHYafaOQZfA6jozSQJ5AqdENzqYpgJObEYh1n+GuVCsiJYN2in68
dj2/m/Z6Oqk7206Tasle07Es741pAHKmxUrGM5V8EKF2LkKu0F/pnq5MheSFpwIC
QzOAWOdASjtzV0tEvG1UksonrWcVL0b/E6YuQBU2i8LS679LUnUTwtSMLY4gOXEk
2PA60ELOxUGNLUKrtohfDDnvXQ549MI+37I4f2+iIAUBa1qouNCxQQ6xN+2RtYBk
GIoNw+bQCBNcKkTjeNfmKQQ5h6oO5FZfWRbolgaVnx+VP1Ndz4rnkipFwUjzaEWL
lWe+PvmrDiw1Xrk5oBh6YsByX09DXk4sUKLJvttV8f9d2nKAmJD5pifuciVgd9yZ
2dBO9agHzWAJp7WB8MTdlrhy4XJUaZ6uQNPE12NAeYjtYeAphZ8=
=zYOM
-----END PGP SIGNATURE-----

--EDqCKJEpkPSV1hLC--

