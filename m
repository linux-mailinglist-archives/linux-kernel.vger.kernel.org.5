Return-Path: <linux-kernel+bounces-10663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F181D863
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D661F21A47
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF6E17E3;
	Sun, 24 Dec 2023 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cilsRacD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720DA15C5
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9af1f12d5so402730b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 00:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703407384; x=1704012184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPhLRPpbOyWFDlrNcxVxiAcHR3uYgN0cD7WJgGLlSus=;
        b=cilsRacDwwjDomXGlx3oOn6G3RUyFgyqbn1iF4ut7wP6kemnnsqIVtV2nZYRRz6Ycz
         C/RumO1US9b3QDEnw5V5RzBwoeGlPzgRMLGrKQQvlENrMYwx1bOckV4OO6d7XOXYGmNI
         yibLfcttX3SghbLxtxFiuhc43LOEiCuc541XjREjkEM+QGIf33a8UxYqlH9xhN/sw1vY
         LJadcuiecavjBLlDYgzg8lE2B1KfPlhOGuJDqjGy0satyuCd3SVu70vD2bBbW4SqjKk0
         TIizSktnNBBGpfBWw/Hnyfhp/jhY7l6CfyA0PrIX4hMoCW6K3KhIL1AoVPmrVWvpLd+j
         o01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703407384; x=1704012184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPhLRPpbOyWFDlrNcxVxiAcHR3uYgN0cD7WJgGLlSus=;
        b=J8SroXrLF83dpREkVyAIA8JcRRlpg/YzpD6c97Em521wxXj2idRnEhRc+4Whf+2EmS
         UvnGw4a7y/xxTPmW3C4A9VSX2mmnst+6N53kqM8pmdO/jduh6FMlJJFxknmE5xw7jHel
         1DyCB5T+uyr9629PaiHGeLgicGxgOz2809lb0YEySWG3Mq/rPXKf/QGCy6ltBYEY3EtT
         Aaxl9M84TJIwTY1qj9SD/UBDYUt1Te5gDFHIUnvynm0US1yLikCRuqY9wgSpK40oXJof
         UmPO4MCg5M1paOS/kUlU+pJjLzwIt+q+df3zom8JZ94mKLJPT3umLT8Q4uS0y9qxn3Lg
         CYrw==
X-Gm-Message-State: AOJu0YyyHPGonnWbv/cchBrXNPVaGjZwaOVNhCZ0GlTMPxqZQ5AEa4se
	BWyg90aqCMIAfFgWTirXYrU=
X-Google-Smtp-Source: AGHT+IHVR49ySaT0zH46wy0p06MxK4qHJB+3hfhi6Upfwc+Z093j69p9XgQMuRaYX9IZuxBsm2Emxw==
X-Received: by 2002:a05:6a00:1d9e:b0:6d9:6cc7:ed7c with SMTP id z30-20020a056a001d9e00b006d96cc7ed7cmr4713897pfw.60.1703407383704;
        Sun, 24 Dec 2023 00:43:03 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id n22-20020a056a000d5600b006d999f4a3c0sm2518537pfv.152.2023.12.24.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 00:43:03 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 96CE711D910F5; Sun, 24 Dec 2023 15:43:00 +0700 (WIB)
Date: Sun, 24 Dec 2023 15:43:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Staging Drivers <linux-staging@lists.linux.dev>
Subject: Re: "Link in bio" instead of Link:/Closes: trailer
Message-ID: <ZYfvFAwXOiKBOgw2@archie.me>
References: <ZYQeZjN_3bPOdKKf@archie.me>
 <2023122112-rigging-january-7618@gregkh>
 <cc276c0e-99bb-4422-9771-d864db4287cb@gmail.com>
 <2023122129-twisty-mumble-c667@gregkh>
 <ZYRIDDD_XR5HdVJu@archie.me>
 <20231223004235.GC325499@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RZ+4EG3MQ7SlQlbY"
Content-Disposition: inline
In-Reply-To: <20231223004235.GC325499@mit.edu>


--RZ+4EG3MQ7SlQlbY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 07:42:35PM -0500, Theodore Ts'o wrote:
> On Thu, Dec 21, 2023 at 09:13:32PM +0700, Bagas Sanjaya wrote:
> > I was scratching my itch whether common social media practices (such as=
 that's
> > being discussed here) can be applied to kernel development.
>=20
> The real problem is that someone's soecial media profile (whether it's
> Linkedin, or Facebook, or Threads, or Twitter) is not a stable, fixed
> resource.  So at any time in the future, the bug report in the Social
> media profile could get modified, or disappear when Elon Musk decides
> to take a user's Twitter username[1] away so he can resell the highly
> desireable account name to someone he likes better.  The git log is
> forever.  So pointing to a transient resource from a permanent log is
> a really, Really, REALLY bad idea.
>=20
> [1] https://slate.com/technology/2023/08/x-twitter-usernames-music-take-a=
way-interview.html
>=20
> Common social media practices are often quite terrible, and this is a
> great example about why they shouldn't be used for this purpose.  The
> bug report should be sent to a linux kernel mailing list, so everyone
> can see it, and then they can use a lore.kernel.org URL as the stable
> resource.
>=20
> If the bug report is in some other source where the people who run it
> understand the importance of stable information at stable URL's ---
> for example, bugzilla.kernel.org, bugzilla.redhat.com,
> bugs.debian.org, etc. that's also fine.  But a social media profile,
> which can be modified at the owner's whim (either of the social media
> account, or the social media comapny, or someone who has $44 billion
> dollars to carelessly throw around)?  That way lies madness.
>=20
> Just because something might "common social media pracitce", doesn't
> mean that it's a good idea.  In fact, some might argue that much of
> what happens on social media has a negative value to society, but
> that's a different debate....

Ted, thanks for the explanation!

--=20
An old man doll... just what I always wanted! - Clara

--RZ+4EG3MQ7SlQlbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYfvEAAKCRD2uYlJVVFO
o9j+AQCkIk2elNtkHfVdCpgwB2p128IMcO2VCewPfMsPrCfpngEA+l258liTNVUz
b1WUWAMbZk3AxrqfuEtoA4G1lZZGbQY=
=vnbm
-----END PGP SIGNATURE-----

--RZ+4EG3MQ7SlQlbY--

