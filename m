Return-Path: <linux-kernel+bounces-16478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA7823F26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81E328699F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C45E20B07;
	Thu,  4 Jan 2024 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHvn/+ID"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7690208D3;
	Thu,  4 Jan 2024 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso10615439f.0;
        Thu, 04 Jan 2024 02:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704362566; x=1704967366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SsqoTQQ6S/KQGXZbxBXDB57O2mR0DxuaSI6RPEYNPsE=;
        b=iHvn/+ID9nSerrZ9c3P+OywbM4YjQ3dtPL/eQhpdVYAE+PCOM77hlz3qwZLVxHdGCW
         yGmxg44YeaPaxIgfOKdm17XAR7K869gRaIrE8CQnb2gzFbfYp9YRWp/mBZueRZlqUWn1
         XrU9jKqAsIMWPp/MZ2epH++mkXdkfLlMCj4B66aBIKcYP7/nCk982d5IBHATSlhQ9f/1
         nt7R41Bihu75umSMYm3m2P7ZGKjLKPeQ+h84xj3lzIXhM6nlLt+k+mCN1NkSzPQC6ky2
         FOUpNCRyII2K3yMkafITzpya/ZVCU5y1MJgLLFmb1SsntEJfETb/+VgXtkZBnIik3cvS
         1UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704362566; x=1704967366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsqoTQQ6S/KQGXZbxBXDB57O2mR0DxuaSI6RPEYNPsE=;
        b=bcm9MIXCTC1InyYzfXjhhNyojveJzwpCoVaZ0E0a2EPywSRcOZzThm7E4DA47x89M1
         Q7MGY91pk0vQBrXUV5/4Mt0K6efFFD0C2iyURdO2zSQAuyYTWSJ6sMvLcQZzR3fB9Oug
         GpiCYGMH3yrO8TUSsz9F9qJI8XHoq3BRVYsyUP2TU4oHx2siWI4XB+l+aPWU2pLz4Ev4
         1lxBhHBopwXBkLqXVLlOR0Mb5CxcOnuUMFtWZFF8pNGI4ZC98vkNj860XHqXnwLAouvV
         05tfrluexD5crdhozoXNOfua2P+u0zyjW1Ux8FtF1HfxXj1PpvH8XWW/yt8JiU+bycBK
         wkVg==
X-Gm-Message-State: AOJu0YwzXcEurvvI0+8loIelg2jdBIDYGhRBJSGKUSb+mpF/8u+k7g8I
	scVHy4Z3hpYC7iTLumrL9Kq1J19MNOrX5w==
X-Google-Smtp-Source: AGHT+IHtMu0xJK7BgXR1mY9KqI8ZLSMyeedAVcmhyKe3ivPI1qN0EGK2LBFepnpRDMyyXgJILbV73g==
X-Received: by 2002:a6b:6505:0:b0:7b7:fac9:b3aa with SMTP id z5-20020a6b6505000000b007b7fac9b3aamr320812iob.29.1704362565707;
        Thu, 04 Jan 2024 02:02:45 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g33-20020a635221000000b0058ee60f8e4dsm23870038pgb.34.2024.01.04.02.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 02:02:45 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 582A91837AF8A; Thu,  4 Jan 2024 17:02:41 +0700 (WIB)
Date: Thu, 4 Jan 2024 17:02:41 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Sean Young <sean@mess.org>,
	Flavio Suligoi <f.suligoi@asem.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: (subset) linux-next: build failure after merge of the pwm tree
Message-ID: <ZZaCQahr3t8CUumD@archie.me>
References: <20231221165805.0c4771c1@canb.auug.org.au>
 <170316329164.542553.8341559295114557258.b4-ty@kernel.org>
 <20231221125801.GG10102@google.com>
 <ZYSFUZf8NcK5vvLv@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QNFbmQpVZ93cppeG"
Content-Disposition: inline
In-Reply-To: <ZYSFUZf8NcK5vvLv@orome.fritz.box>


--QNFbmQpVZ93cppeG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[also add Jingoo (additional backlight maintainer) and Linus]

On Thu, Dec 21, 2023 at 07:34:57PM +0100, Thierry Reding wrote:
> On Thu, Dec 21, 2023 at 12:58:01PM +0000, Lee Jones wrote:
> > On Thu, 21 Dec 2023, Lee Jones wrote:
> >=20
> > > On Thu, 21 Dec 2023 16:58:05 +1100, Stephen Rothwell wrote:
> > > > After merging the backlight tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > >=20
> > > > drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_update_s=
tatus':
> > > > drivers/video/backlight/mp3309c.c:134:23: error: implicit declarati=
on of function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werror=
=3Dimplicit-function-declaration]
> > > >   134 |                 ret =3D pwm_apply_state(chip->pwmd, &pwmsta=
te);
> > > >       |                       ^~~~~~~~~~~~~~~
> > > >       |                       pwm_apply_args
> > > >=20
> > > > [...]
> > >=20
> > > Applied, thanks!
> > >=20
> > > [1/1] linux-next: build failure after merge of the pwm tree
> > >       commit: f7baa9ccef93ba1c36a8ecf58c2f4e86fb3181b9
> >=20
> > Actually it's:
> >=20
> >   f7baa9ccef93b ("backlight: mp3309c: Rename  pwm_apply_state() to pwm_=
apply_might_sleep()")
> >=20
> > But don't bank on the commit ID staying the same.
>=20
> This is likely going to break the build on your branch because
> pwm_apply_might_sleep() is only available in the PWM tree right now. In
> any case, I've now pushed a commit that adds pwm_apply_state() back as a
> compatibility stub, so it should be okay for you to drop this if you
> run into problems. It's always possible that somebody else wants to add
> a new caller of pwm_apply_state() and in retrospect we should've
> probably done this from the start, at least as a transitional measure
> for one or two cycles.
>=20

Hi Lee and Thierry,

I know that we're still on New Year vibes, so some things are not up to full
steam for now; but since we're close to v6.7 release and v6.8 merge window,
hence allow me to ask:

Stephen Rothwell is still complaining about backlight tree build failure
due to f7baa9ccef93b, yet it has not been fixed so far. Has the culprit
been dropped/reverted as he requested? The worst case is the culprit slips
through and become part of backlight PR and Linus will likely not happy
with the build regression (maybe he had to fix by himself).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--QNFbmQpVZ93cppeG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZZaCPQAKCRD2uYlJVVFO
o30uAQCpOUQNLZSsWEF7o4VwnEeONRRU8z0ZDQlzK20JAUQHPwEA2mqQa3jDEv5p
vSerVltHJ5q3FS1SCjRw9gKeiD+FjQo=
=wZkt
-----END PGP SIGNATURE-----

--QNFbmQpVZ93cppeG--

