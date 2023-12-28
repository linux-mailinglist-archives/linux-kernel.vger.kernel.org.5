Return-Path: <linux-kernel+bounces-12644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4368981F840
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1161285A30
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E2B79C1;
	Thu, 28 Dec 2023 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwSsT6Rj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436E748F;
	Thu, 28 Dec 2023 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35fff22678eso9288905ab.3;
        Thu, 28 Dec 2023 04:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703767915; x=1704372715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8g5ynfSY07qPeX049rGLQx5z1LWGJLy6ofOSXI+4anE=;
        b=XwSsT6RjAXs4LI6xpKNdAzF6rV3ZSQkV8yWOfL83sjkNgtPJuVTfWGlxR5DtxXmWjg
         aULUL7Hr6k5dmGVTnVBF+bwche5y5do4l/zFAPttsleelsBXr3MdTlEop0Kv23QJUZGY
         43pO2cf210yqFW889WfouDDva+ScW7JnvnBAdogHo9w6MTBj7Ncsy9adkJy1bYCS9QZy
         GviK1f8qEiwTqvS/Pphtb9Ci99AHD7cNEbpR1SxDcGP3JntMk8WPIzkzd5Tpzm1gj5OS
         jZTI2pY9GyDvlvinZkiY2FGvywLD16HwKLOBzptRHdBVc3qW9keebM4jIFnrHgVbIdwJ
         cAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703767915; x=1704372715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g5ynfSY07qPeX049rGLQx5z1LWGJLy6ofOSXI+4anE=;
        b=Lr4s7+ReivhrqSkZUN4YLXLVSaKbRZ/ncZkhor4jtfPUZZN7l+yyW6u61CQnFp2TX7
         rAfJ5sxS5wB7uT6iSi6QZMA0gYEJ6Di64Q6ABMGnCUeaKMQ2ijn5BF7IQ9z4lxYwR0XW
         ArlodNJhobS7ToQ8NHGAglG8kKlaLFgWUAgp36RRrmKLyWyeXIcM9q3uAE6NUrAeJLSV
         karLwXXhEB2bxJqzp1zVx5zTby0fV90FNjxF+6c9dl1qPaX/Fc2E+gTHRPKlWPPC17gW
         CVNpRVXHRZ11HAsrUDI4PL74gg/DbvZjrdR79zDIad3UdHQ/ewH+Zscv4ZzOc+/6Xbgc
         qJxQ==
X-Gm-Message-State: AOJu0Yz6qPg/ZdHrIDWvL4vBgYlNufzO1CWkscmDr8Lm5iVQn6z6lAyT
	p9beokwd8UDwsAYlDACHl1c=
X-Google-Smtp-Source: AGHT+IF2eGUtVz5MaqqOWVP4xH+Rvq1xgqfuJGwwoqse5DMWmSb+FqfgobHEtftloxz+hNAv3e78PA==
X-Received: by 2002:a05:6e02:1845:b0:35f:f01e:bb26 with SMTP id b5-20020a056e02184500b0035ff01ebb26mr9617052ilv.51.1703767914854;
        Thu, 28 Dec 2023 04:51:54 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b001d3ccdeeaecsm13834658plb.264.2023.12.28.04.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 04:51:54 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 417DB10788B6A; Thu, 28 Dec 2023 19:51:49 +0700 (WIB)
Date: Thu, 28 Dec 2023 19:51:48 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: David Binderman <dcb314@hotmail.com>,
	"sfrench@samba.org" <sfrench@samba.org>,
	"pc@manguebit.com" <pc@manguebit.com>,
	"lsahlber@redhat.com" <lsahlber@redhat.com>,
	"sprasad@microsoft.com" <sprasad@microsoft.com>,
	"tom@talpey.com" <tom@talpey.com>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?ZnMvc21iL2NsaWVudC9zZXNzLmM6?=
 =?utf-8?B?NDYyOjIwOiB3YXJuaW5nOiBkdXBsaWNhdGVkIOKAmGlm4oCZ?= condition
Message-ID: <ZY1vZLLKX8RIinFa@archie.me>
References: <AS8PR02MB1021708E77D868F8AE5EFD8859C9EA@AS8PR02MB10217.eurprd02.prod.outlook.com>
 <ZY1hcE5E3Mizv2il@archie.me>
 <AS8PR02MB102175EE04EAB5CAB6E459BEF9C9EA@AS8PR02MB10217.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gFTAUEjMnkShEXtR"
Content-Disposition: inline
In-Reply-To: <AS8PR02MB102175EE04EAB5CAB6E459BEF9C9EA@AS8PR02MB10217.eurprd02.prod.outlook.com>


--gFTAUEjMnkShEXtR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 12:03:21PM +0000, David Binderman wrote:
> Hello there,
>=20
> >What warnings?=20
>=20
> The warning mentioned in the title.
>=20
> >And what gcc version?=20
>=20
> Probably most versions.

So gcc 13 doesn't have the warning but gcc 14 (still in development) do,
right?

>=20
> You will probably have to switch on gcc compiler flag -Wduplicated-cond
> in any random released version of gcc to see what I see.

Full gcc output please?

Still confused...

--=20
An old man doll... just what I always wanted! - Clara

--gFTAUEjMnkShEXtR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZY1vYAAKCRD2uYlJVVFO
o+kKAQCHWf5YzeTvwh+erEiv1QyPQeVrOCjkWMHoumn0EPZFfQD/cKAwPgqjOkus
Elnd+mrWpFNltQbYNoQWUggB9vEesAE=
=/xiG
-----END PGP SIGNATURE-----

--gFTAUEjMnkShEXtR--

