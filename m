Return-Path: <linux-kernel+bounces-2456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC53D815D64
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 05:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4273A1F222F0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321C415B3;
	Sun, 17 Dec 2023 04:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScLsAVgl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F7643;
	Sun, 17 Dec 2023 04:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5c6839373f8so1283006a12.0;
        Sat, 16 Dec 2023 20:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702789005; x=1703393805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GIlO6BSBXPMCEu/D89Xxu5tjbOcoGhj9piMmi9W/enc=;
        b=ScLsAVglt8U+jbCsW0SW4mxV5+qgds0IOTRIDqe49W+kglN7HqODKdhLNgnT29WRyJ
         jQ4ZEL7j97eZ7/2acEw1QpIwxcGNBZmF8sqBJipWYpxqPNxyKiBDDF4zBHRhQO6XihUs
         14hFNd46fFHmpbfb5kDGbHnbvea/oV9ign6Sw2EeK06GiRQa1Pqu0J5kxQME2inDhkFc
         Pz8VteTh1aqXfO3g0pSRr28ephzcn619/+rewe57iLRamZxfIzkguGFlWjxG67MVYr7Z
         tLdqx6xwovqzkOZh0wziR46EZRORx9u33+Bveb/M6Nibm7eSmnpqubuaz5KPnfn4CALe
         MwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702789005; x=1703393805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIlO6BSBXPMCEu/D89Xxu5tjbOcoGhj9piMmi9W/enc=;
        b=FwfY1CKHNCUSxjr+I5uVb7rM0s87fYUdxWQhVRqmi2Z4hjfL3ckbuiWTiaX+lX+W5X
         ulqz04g73XCdTL+8Csi2HYT1NUzW9OQRNl+JZyjL3D07KVNuvXwBWDzKsILOv1hW2JyA
         JofsIGbo4VzlnvkvzgFxrgQfBlw9MEEyDHwJg5FZzSN0UhSIx0aviOrMHopiR/SjBIw1
         qSpDWa7jCHizVJGj32Fjoh7ynFvdxHupM+yZeif6fAT4r4t8KTqIXfvdNq9KZ4XLz0Fh
         1dEc48txv0GMXqmqNzOv0D0LMDhod66ZXf9HaF3AsfQ4jgSkL7m5hUgoTo42qqb1oSGs
         VTdA==
X-Gm-Message-State: AOJu0YytgMYXPLi3Bbfus263ocBfGCtQnTX7ebof/hDXrAJ63KlPqLpf
	+aLnQHreMsz6jrdLhy87xYY=
X-Google-Smtp-Source: AGHT+IEadLchqeaBK4f6Cs9ojVhRzTESzHTfrIXVC+gwCJT6QHFqTaioPcFujG3pUELCaNNUWLuS3A==
X-Received: by 2002:a05:6a20:158b:b0:18f:c3c8:effb with SMTP id h11-20020a056a20158b00b0018fc3c8effbmr18937858pzj.21.1702789005501;
        Sat, 16 Dec 2023 20:56:45 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b006cee656cb35sm14665800pfl.156.2023.12.16.20.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 20:56:44 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 363B2102106F4; Sun, 17 Dec 2023 11:56:40 +0700 (WIB)
Date: Sun, 17 Dec 2023 11:56:39 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Ohad Ben Cohen <ohad@wizery.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux RPC <linux-remoteproc@vger.kernel.org>,
	Linux OMAP <linux-omap@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: Remove Ohad Ben-Cohen from hwspinlock
 subsystem
Message-ID: <ZX5_h_hE7PLedYye@archie.me>
References: <20231216111017.17624-2-bagasdotme@gmail.com>
 <CAK=WgbZcM8qEm6EOT2FFLNLoJC986UYpjEWK2O6-js0P=4No4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RwfsyGJJCk9Gbjoj"
Content-Disposition: inline
In-Reply-To: <CAK=WgbZcM8qEm6EOT2FFLNLoJC986UYpjEWK2O6-js0P=4No4w@mail.gmail.com>


--RwfsyGJJCk9Gbjoj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 08:59:50PM +0200, Ohad Ben Cohen wrote:
> Hi Bagas,
>=20
> On Sat, Dec 16, 2023 at 1:10=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> > --- a/CREDITS
> > +++ b/CREDITS
> > @@ -323,6 +323,7 @@ N: Ohad Ben Cohen
> >  E: ohad@wizery.com
> >  D: Remote Processor (remoteproc) subsystem
> >  D: Remote Processor Messaging (rpmsg) subsystem
> > +D: Hardware spinlock (hwspinlock) subsystem
>=20
> Please also add:
>=20
> D: OMAP hwspinlock driver
> D: OMAP remoteproc driver
>=20

OK, will do in v2.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--RwfsyGJJCk9Gbjoj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZX5/gwAKCRD2uYlJVVFO
oyLpAP9wlT8tloZGb1zyitMjaC7tRYzOvw5dQyDZeVyelxez9QEA5eeeUmBFtLD8
2TywiWXg14qMNWKnBRNbIAFr4hYcYwU=
=evH6
-----END PGP SIGNATURE-----

--RwfsyGJJCk9Gbjoj--

