Return-Path: <linux-kernel+bounces-8556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6207081B958
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027941F221B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1FC6D6D7;
	Thu, 21 Dec 2023 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPIK2gWd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65EA36084
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d94308279dso563701b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703168017; x=1703772817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/54ktMLGsC/HbIUHpgdYFftx5wBmSSsuqjyv83RFiYA=;
        b=BPIK2gWd458Mdi2ATW5BJcztaTXNGtHtYPvPwXrHU1WmEQ+IGiaYi2oyFDaGS9z39I
         qf/NKmXvtaF2SXs4UAY5M/75Jiit5SdBjcwS7+owhe7mo8Mq1A+YXVfvPuC+O7zC9WSp
         Eao5UKBCARYeLjxuVpeNUGu8lvyy+OSlPWw30jSiu1BunoFdZxsueDHX7lYH2BE2QjKM
         9rkm7t5zBnFHo4QJ5GwO9pSadczT9lMOrlcbP0GlbLoR2JyuQKRNZf1iAjOlSHciD5+S
         B2k68TyFObW+sAm7PkvVC4MdWBhODHGRRkflv/u8oxIzgsWMqqmkKccqGg9I45qLBiPM
         lpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703168017; x=1703772817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/54ktMLGsC/HbIUHpgdYFftx5wBmSSsuqjyv83RFiYA=;
        b=JPno66t4K/EOL6m9nLj9PQHc89MHdZ5656aX4/SgQmOuc2VkSxh5rChaDoset98/q7
         jjs52qwNFE3x5n26hJgNDRscnjVZt8t26NhqpIFs6tS72NU/xg/ZzQr4yno/pzntLGPW
         wwespAgp/SjrWi5B8yX3YZgPe1wquXkM7uVcqLo08M0KOUPQuhJHqp+ea2ESR0ciwu2V
         w+lFyBD2f5T77kcG/IejRxTG3ialwD13t0bJHKIN36cu4Av7GACkNcRgzJPq844qoy6V
         e5cabCFtM5irwU/3z7WaOMj72NVMP9DMax1MfnLAcHjaV7Km7VPuU1V/umfHd3437Uyf
         zFyg==
X-Gm-Message-State: AOJu0YxVQFHaIgvJ3oojlktXEEEvsn2y0Wwrzx9C0w42eXr8UJW4UoT9
	CK4ypUG3CvTvG75zrAGmM7nWH/iKiTfX/A==
X-Google-Smtp-Source: AGHT+IEtaQfZsfB6upC3isHiwaxPkyOGymhFNYfry883ZoVaD4IQmGEfSnrGICbQDUWzb4eyA5kBFA==
X-Received: by 2002:a05:6a00:1996:b0:6d9:3981:5903 with SMTP id d22-20020a056a00199600b006d939815903mr3268088pfl.0.1703168017089;
        Thu, 21 Dec 2023 06:13:37 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u36-20020a056a0009a400b006d62cbf10b4sm1626440pfg.194.2023.12.21.06.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 06:13:36 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 3189010206DCF; Thu, 21 Dec 2023 21:13:32 +0700 (WIB)
Date: Thu, 21 Dec 2023 21:13:32 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Staging Drivers <linux-staging@lists.linux.dev>
Subject: Re: "Link in bio" instead of Link:/Closes: trailer
Message-ID: <ZYRIDDD_XR5HdVJu@archie.me>
References: <ZYQeZjN_3bPOdKKf@archie.me>
 <2023122112-rigging-january-7618@gregkh>
 <cc276c0e-99bb-4422-9771-d864db4287cb@gmail.com>
 <2023122129-twisty-mumble-c667@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ki5XL8WJal0E6W8j"
Content-Disposition: inline
In-Reply-To: <2023122129-twisty-mumble-c667@gregkh>


--Ki5XL8WJal0E6W8j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 02:10:03PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 21, 2023 at 07:57:21PM +0700, Bagas Sanjaya wrote:
> > On 12/21/23 18:51, Greg Kroah-Hartman wrote:
> > > On Thu, Dec 21, 2023 at 06:15:50PM +0700, Bagas Sanjaya wrote:
> > >> Hi all,
> > >>
> > >> Let's say that there is a content creator who submits her first kern=
el
> > >> patch (touching drivers/staging/ of course to get her feet wet).
> > >> The patch supposes to fix a reported bug, with appropriate Fixes: ta=
g.
> > >> But instead of using Link: or Closes: tag to the actual bug report in
> > >> the patch, she instead writes "Link to the bug report in my bio", as
> > >> it is the norm in social media world. Here in the context, her bio is
> > >> LinkedIn profile (IDK if there is a way to add arbitrary link there).
> > >> The link in LinkedIn profile, when clicked, will list many links
> > >> (including her usual social media campaigns and of course the bug re=
port),
> > >> which makes reviewers confused about which link to the bug report she
> > >> means. In some cases, she may disambiguate by saying in the patch,
> > >> "Link to the bug report no. 99", to refer to the specific link numbe=
r.
> > >>
> > >> Is such practice a good idea?
> > >=20
> > > No.
> >=20
> > why?
>=20
> Exactly, why?  What problem are you trying to solve here that has
> actually come up in any sort of frequency?

I was scratching my itch whether common social media practices (such as tha=
t's
being discussed here) can be applied to kernel development.

>=20
> "Link: " is something that should be used to point to a well-known and
> stable reference for any future things, like red hat's bugzilla, or
> lore.kernel.org.  It's not for random social-media link reputation
> spamming, sorry.

Understand.

>=20
> The "proper" way to handle this is to have in your Linked-in, or
> whatever social media site you like, a list of your committed patches in
> the git.kernel.org tree, don't polute the kernel log please.
>=20

That's the elegant way.

Thanks for explanation!

--=20
An old man doll... just what I always wanted! - Clara

--Ki5XL8WJal0E6W8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYRICwAKCRD2uYlJVVFO
o2NQAP44SSFDD9rldUnNHUdaTP0OtROrwm9CyrQ4dUweSQqGQgEAl54b7oc1Uxbv
bfcLEe4kCoXXRrRH2wtyTHHG8jCUxwc=
=mAw/
-----END PGP SIGNATURE-----

--Ki5XL8WJal0E6W8j--

