Return-Path: <linux-kernel+bounces-25269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239BA82CC6C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19491F22D96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CCB20DE9;
	Sat, 13 Jan 2024 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3TiBYmn"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856020DC6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2041c292da8so4116366fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 02:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705143571; x=1705748371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u13T7RhOAhH6dog8l7JDUAnbOerR+MJDTwUVG6LqbC0=;
        b=b3TiBYmnBuqT+rkSHkGbE3HsS29qpbC+LHkra1QAppSwGskwdsetJIc+C0xTyqwj1U
         xv8J08fklB8YUjwcOlWJEjWSLXrOhg0y+CGe9kGRnwjIjY6Q046YY6Crx70p+UXGYOxg
         1+g1bXKPI+pJ3/7DoYywE3/nPYgrYLzzRTRZLandCb1cJpM+GzsHFZR/ULnfZ5nCZehs
         RjDhqdzOaNAQLkbq5O80KoMQnUGizCXoFptMTyCKPfxHIGa62joj86WiPgGUk9k+ap75
         t3A9x9Vg/7x3YChnK8qwr2fYnB8i8l3BogTKDOXnxG/JDoy0Y2l3u81UAIqQ+KsLU5RX
         lMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705143571; x=1705748371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u13T7RhOAhH6dog8l7JDUAnbOerR+MJDTwUVG6LqbC0=;
        b=b6MZKLHPNWRiB4dYmTm8pjJhVeYUd3IBrBBwlhDGVHkRs/Urm8ifNHF7JDEM162bX0
         uFIsMkp8HUVJTJQ4lFLfEXkVAtpWxIPRYsV+paS+RIHbXzcwBb3vcehdRo4sDHwAGrSz
         jHzZBYNiaPdd9EGzwy/3ypOj39PJgI0jpCV6xUCMRAObhuHiqduYrpzuFNnWv21JUt4g
         OU84vMl30vbeX61h+B7pA6iAPiQCWQDeGcRHKE8J+jkM/qGBImcOnoUFdN7hwX24W936
         HZPBIPhvm2ZfXO42j/qg/AX8jDkzkzs3izOdWbhYE6y7O4n/4QgbRzX94gxCxQ3SoWSQ
         nPkA==
X-Gm-Message-State: AOJu0Yw6mQyDatU05f2aWO8PcPSX1nEE93yX6qV+dPxkK/nYfGqHwrRF
	J/YBiQZlqhDTQRB8QNpj30K7VQWMZtyWSA==
X-Google-Smtp-Source: AGHT+IFGiUMJSqzWngkokLw5wmr4wlU32u45XMqTnru0is3haBEI76tr82lzZOTg+ShE6AfPukE06g==
X-Received: by 2002:a05:6870:8315:b0:204:4877:974b with SMTP id p21-20020a056870831500b002044877974bmr3237112oae.97.1705143570850;
        Sat, 13 Jan 2024 02:59:30 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y2-20020a656c02000000b005ca0ae17983sm4155376pgu.8.2024.01.13.02.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 02:59:30 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 014941850DF82; Sat, 13 Jan 2024 17:59:26 +0700 (WIB)
Date: Sat, 13 Jan 2024 17:59:26 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: Deliberately sending partial patch sets?
Message-ID: <ZaJtDozZOgARzVRh@archie.me>
References: <ZaFKvZg-MtZgbCKA@archie.me>
 <2024011247-caregiver-compacted-2e6b@gregkh>
 <ZaI04-HDHbBxKYbS@archie.me>
 <2024011338-flammable-zoology-4686@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PY6NfrOfUq4uRhtf"
Content-Disposition: inline
In-Reply-To: <2024011338-flammable-zoology-4686@gregkh>


--PY6NfrOfUq4uRhtf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 09:44:00AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Jan 13, 2024 at 01:59:47PM +0700, Bagas Sanjaya wrote:
> > That is, the submitter must send the full series, right? Why not partial
> > like above?
>=20
> What can anyone do with a partial patch series?  Why would anyone who
> sent that think it would be material that anyone else should do work for
> them and review it when they aren't even sending the whole series?

IMO people will question why there is partial series submitted (and where t=
he
missing patches are) and then ignore it if it becomes a pattern on submitter
side.

>=20
> I'm confused as to why you would think that would be acceptable?  What
> are you really asking here?  Hypotheticals only go so far, please point
> at a real instance and we can talk about it there.

Honestly just to scratch my itch.

Thanks for the reply.

--=20
An old man doll... just what I always wanted! - Clara

--PY6NfrOfUq4uRhtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZaJtCgAKCRD2uYlJVVFO
o7UjAP9uVVxJwKrgCIjLtXAlYWGiD8C0whbfhDTx/Gska+HjIwD/fSpy7R6H50y4
EDDzRXQxL+P3tH53Ez8/x78UbBdloQM=
=rv77
-----END PGP SIGNATURE-----

--PY6NfrOfUq4uRhtf--

