Return-Path: <linux-kernel+bounces-17414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0934824CDB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A74E286C40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FCB20F4;
	Fri,  5 Jan 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6cPsyvd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A01FB4;
	Fri,  5 Jan 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9bd63ec7fso742096b3a.2;
        Thu, 04 Jan 2024 18:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704421228; x=1705026028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdKKoG5sMgJHVoUCvXqbwYc32tQqsp4CLU2LbLkdqVc=;
        b=D6cPsyvdmQiSGxLex2ew8Ze015vBgvY//iSdh5u+9YVCIXBmVma75Tg5T8KNX19dpf
         R9vhZybwIYHuw9LhVuDEYtbF/r8PyZflpOMofvyHvTd+w7pc1JsGAVeoV/R6taVwEKRd
         t5qNUi1zYoyVSZvFv9QVZp2u7fb8WVtBIIoiM+Vobv+rLs89AUw1TaOFYiJemR/Cr/Qb
         jr5YBFgNa62QUf7fuZ299bX9p9jOn6PhrnBqU9q34gOkH0aqRn0epxtMlZ34l1nRFpY7
         rDfB62IjjAUSfbO6bnndENlt5KAOr9q7qvvdYsd42q0G6MYvaqm+OqPFriMuygwoQyDL
         UqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704421228; x=1705026028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdKKoG5sMgJHVoUCvXqbwYc32tQqsp4CLU2LbLkdqVc=;
        b=xO3b+Q5C9rVQZByfJfu5Qxy4l0wIBuEgQjKViFUwhicBVtI1nNKX8x8fvGuUSczk8f
         ikXCU3ouHVyupm7d044q3hFIBSXgw45om+h8AAmf/7OnlFgq7JrIaBYEoaFYvbArMJKx
         jrYwD/e680XFvliHfzZ9UNb7DbFXMFpoD5VWPWlFfz1A2hmKQqC3mZlScKH35k8sSkaF
         yWggbbMehjTFtfm98TPI3F0HAUR791En88s+VQPZfoyml3S0TsbD9STcrVEeT8QkFG63
         Z2I8mosDUjMPrHMmdV17lX8RjLTyZJlb12faw+aECuJIJ9XBdK2sdRIv2J6XR8lOvGJI
         Us5w==
X-Gm-Message-State: AOJu0YwXNzQxc0dhaIVGfbojk4F1Spl4aejuMY2TQbqBt8WMT2Z9UXIn
	0f9zCdHkFjztgKtxeo5fXkYY0o5qKb1KUQ==
X-Google-Smtp-Source: AGHT+IFpoDDyUe8N3BJdgkWMF9hUnYUE2Yhvonrt4B2jMoOifNj9mkPaYHPrW8tTywQc7F/N0yCJSw==
X-Received: by 2002:a05:6a00:4604:b0:6da:16e9:9b34 with SMTP id ko4-20020a056a00460400b006da16e99b34mr123666pfb.67.1704421227888;
        Thu, 04 Jan 2024 18:20:27 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w9-20020a056a0014c900b006d9bb4400f0sm318203pfu.88.2024.01.04.18.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 18:20:27 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 282F7183770AA; Fri,  5 Jan 2024 09:20:22 +0700 (WIB)
Date: Fri, 5 Jan 2024 09:20:21 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sean Young <sean@mess.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Flavio Suligoi <f.suligoi@asem.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: (subset) linux-next: build failure after merge of the pwm tree
Message-ID: <ZZdnZZKygnDyyb-T@archie.me>
References: <20231221165805.0c4771c1@canb.auug.org.au>
 <170316329164.542553.8341559295114557258.b4-ty@kernel.org>
 <20231221125801.GG10102@google.com>
 <ZYSFUZf8NcK5vvLv@orome.fritz.box>
 <ZZaCQahr3t8CUumD@archie.me>
 <ZZaplFvjLADNz-2m@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w2Uw4f0A5UHcdBF2"
Content-Disposition: inline
In-Reply-To: <ZZaplFvjLADNz-2m@gofer.mess.org>


--w2Uw4f0A5UHcdBF2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 12:50:28PM +0000, Sean Young wrote:
> On Thu, Jan 04, 2024 at 05:02:41PM +0700, Bagas Sanjaya wrote:
> > [also add Jingoo (additional backlight maintainer) and Linus]
> >=20
> > On Thu, Dec 21, 2023 at 07:34:57PM +0100, Thierry Reding wrote:
> > > On Thu, Dec 21, 2023 at 12:58:01PM +0000, Lee Jones wrote:
> > > > On Thu, 21 Dec 2023, Lee Jones wrote:
> > > >=20
> > > > > On Thu, 21 Dec 2023 16:58:05 +1100, Stephen Rothwell wrote:
> > > > > > After merging the backlight tree, today's linux-next build (x86=
_64
> > > > > > allmodconfig) failed like this:
> > > > > >=20
> > > > > > drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_upda=
te_status':
> > > > > > drivers/video/backlight/mp3309c.c:134:23: error: implicit decla=
ration of function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werr=
or=3Dimplicit-function-declaration]
> > > > > >   134 |                 ret =3D pwm_apply_state(chip->pwmd, &pw=
mstate);
> > > > > >       |                       ^~~~~~~~~~~~~~~
> > > > > >       |                       pwm_apply_args
> > > > > >=20
> > > > > > [...]
> > > > >=20
> > > > > Applied, thanks!
> > > > >=20
> > > > > [1/1] linux-next: build failure after merge of the pwm tree
> > > > >       commit: f7baa9ccef93ba1c36a8ecf58c2f4e86fb3181b9
> > > >=20
> > > > Actually it's:
> > > >=20
> > > >   f7baa9ccef93b ("backlight: mp3309c: Rename  pwm_apply_state() to =
pwm_apply_might_sleep()")
> > > >=20
> > > > But don't bank on the commit ID staying the same.
> > >=20
> > > This is likely going to break the build on your branch because
> > > pwm_apply_might_sleep() is only available in the PWM tree right now. =
In
> > > any case, I've now pushed a commit that adds pwm_apply_state() back a=
s a
> > > compatibility stub, so it should be okay for you to drop this if you
> > > run into problems. It's always possible that somebody else wants to a=
dd
> > > a new caller of pwm_apply_state() and in retrospect we should've
> > > probably done this from the start, at least as a transitional measure
> > > for one or two cycles.
> > >=20
> >=20
> > Hi Lee and Thierry,
> >=20
> > I know that we're still on New Year vibes, so some things are not up to=
 full
> > steam for now; but since we're close to v6.7 release and v6.8 merge win=
dow,
> > hence allow me to ask:
> >=20
> > Stephen Rothwell is still complaining about backlight tree build failure
> > due to f7baa9ccef93b, yet it has not been fixed so far. Has the culprit
> > been dropped/reverted as he requested? The worst case is the culprit sl=
ips
> > through and become part of backlight PR and Linus will likely not happy
> > with the build regression (maybe he had to fix by himself).
>=20
> This should be fixed by 9a216587a03df, and on current linux-next I can't=
=20
> reproduce the problem any more (x86_64 allmodconfig).

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--w2Uw4f0A5UHcdBF2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZZdnYgAKCRD2uYlJVVFO
ozZnAQCIq1pIwZLfPonLM2X6j/segPauOJ/3srupo9smbstFPgEA2vMrv0GGTvjA
8UO4PwaPrS7UIn+ScGfmOiFvn2U8mA4=
=8d7a
-----END PGP SIGNATURE-----

--w2Uw4f0A5UHcdBF2--

