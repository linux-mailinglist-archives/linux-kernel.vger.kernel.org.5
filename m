Return-Path: <linux-kernel+bounces-12627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0570581F7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1241F214A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD417474;
	Thu, 28 Dec 2023 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZveAfP2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF06FD3;
	Thu, 28 Dec 2023 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-594965fbb3cso1873377eaf.1;
        Thu, 28 Dec 2023 03:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703764342; x=1704369142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsN75v0buLJQ38tkV4cmhuBqPvoeWy9Oxr4haYwM744=;
        b=ZZveAfP2CJymG9fF3UsWVr5uXN6CmrDLPeOdm4oT9/uHA+L03xrfT64Md02UOKRqu+
         l5MeYw54bOF1zDXrQtLEmYSuYA3pR/SPpJXl5ZzXq4Aq9AAd0yncSTyrl7834oXuoHjI
         MIgvKwu4uZAd2647IytTK/oT0fHsd/jAaK9j82q48v12N0Lpfrhc9xWT2QRNYkZVc8dd
         uNPvxVE84e8Xckx2Y32J6Esof516Ga+Cv9tqLJgCqlHxlKIkfj0OrM3WV6+ba2nvM91d
         RGaXhUpcVoCNOcw9FF9KQ+aExB+62Xtc42ZxvTZ4Dg40ycNZznTNqrtdzkV8VTm5pysx
         4tXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703764342; x=1704369142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsN75v0buLJQ38tkV4cmhuBqPvoeWy9Oxr4haYwM744=;
        b=VX/dyKg+6gohZ4f6kLLqNcNap61RubsbFi9sKHzsesCsx34HMaqYBOpTnSTn66VTsj
         ZHEr1gE2QrTL+hKfC9wqKm6yOrm0YdQBzdkSZZ8UR1SG2o47lvm4tJyY2kGLDF6GF5yr
         0n9HmIIjMO5YYZUiAK+S5HK3BcPwtU9LYCdhbdmSgrPL7qYW9Xm7KzBqdBYi3nhFH/9I
         7LrbZO02E24wcan7KCrBnbms0GgjYeQkO+ioSwe5R1edqHoCBif9M3ksrHnec3l90jTq
         NCkOO2qvyUacbnTKoJXB69C2rxMVXFYyew41rWNE607ZDz9h09r4ZgkuLr7KxeSq4IIi
         RMzQ==
X-Gm-Message-State: AOJu0YzJhs26Vs9Pla7MKWBQ3IiYFXsBbx3BOe3CXShvQKKB3BKy7Fpg
	SkzxD67OV0EQFfMwZ8A7VCo=
X-Google-Smtp-Source: AGHT+IFpDIR0rcTSc8BOt2vcCjty10gHsFxPzeP2aD/C4y/+RCqLvvhgnCRMU/hh7nKfHCPN9jSutw==
X-Received: by 2002:a05:6358:948b:b0:16b:c401:e714 with SMTP id i11-20020a056358948b00b0016bc401e714mr13045085rwb.5.1703764342378;
        Thu, 28 Dec 2023 03:52:22 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c21-20020a17090abf1500b0028c95804922sm2613520pjs.51.2023.12.28.03.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:52:21 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D732A10242C47; Thu, 28 Dec 2023 18:52:16 +0700 (WIB)
Date: Thu, 28 Dec 2023 18:52:16 +0700
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
Message-ID: <ZY1hcE5E3Mizv2il@archie.me>
References: <AS8PR02MB1021708E77D868F8AE5EFD8859C9EA@AS8PR02MB10217.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j9Y55VhaNyESaLgn"
Content-Disposition: inline
In-Reply-To: <AS8PR02MB1021708E77D868F8AE5EFD8859C9EA@AS8PR02MB10217.eurprd02.prod.outlook.com>


--j9Y55VhaNyESaLgn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 11:35:29AM +0000, David Binderman wrote:
> Hello there,
>=20
> Recent development versions of gcc compiler produce the above warning
> in linux-6.7-rc7.
>=20
> Source code is
>=20
>    if (old_iface) {
>      ....
>     } else if (old_iface) {

What warnings? And what gcc version? gcc 14?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--j9Y55VhaNyESaLgn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZY1hbAAKCRD2uYlJVVFO
o6w7AQCKtIFbhZJhnYuEYWDY5MrIyDWaON51NhouAHcBok44VwEAuNQOTcKi2+yh
/DS4li4njTBszSZPTRNeyOB5MigPEQk=
=IuY7
-----END PGP SIGNATURE-----

--j9Y55VhaNyESaLgn--

