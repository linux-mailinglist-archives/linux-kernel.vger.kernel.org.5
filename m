Return-Path: <linux-kernel+bounces-70206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 380128594C6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C931C2137E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B5D4C9D;
	Sun, 18 Feb 2024 05:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzWuiSA1"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0DD4C61;
	Sun, 18 Feb 2024 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708234334; cv=none; b=c3/o1cd7NVLCBY4NbIVyBoxx1bsZ+n17cAs+cUTf79/KZAEteaNTOC+DFALP8TC56vv2CrdpfARpIjRdhuWzi1IBW7WoiG7bBD7Yr6y+DyvpJHN8FIg1DiBlrvEG8MQF2nn9opOv5zUb3XEGGMi9VZA6hTQgRjjWrlRxG2I0dII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708234334; c=relaxed/simple;
	bh=U3IsuMFCY2SLEhgmSDpSae5NUyuIOOh6Nqk3N9U+d/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM93ZQgdPftrRplhK822fcfjt1LTZDJ1Tii8U8XbVMvkp8dFWEPOPqEG83ECWInON8EmlUgh21SQyXED5VkFWoTPzM2ozK0PI8F066BPRWoQ4qmN05tPEAIFKzgEBD2of9vFjYRWJpbp8uXNSsD1GhOVlzPoG/744pxLuHvpjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzWuiSA1; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e2f12059f4so1676140a34.0;
        Sat, 17 Feb 2024 21:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708234331; x=1708839131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+mYOP74oT/fmnKuLJNRG+jgvNKGCnpPTuzdRRiDPHU=;
        b=hzWuiSA1rF9zQsYa2J+ODX6CVRpG26xj3H2/uOjo0mWLAFxVotF+ugQc7/EFVWAaLm
         qd2L3zmtPHQfVZZ7f5+vwuAnAHTBwsbyz3xjko9lkAntHH8SSbk7OZ8j/lvMgWJUvoAY
         lpsVUqSWuJsqND4pmFx4/gr6yUWCyH1+0WOn6wcNvJu7H20RtFrq6DMVaSmYqEbQj7V0
         PWkWPmy9YeGZNoDpWrr9zYHUvUeO9xmzhpE2i+JIMPXV7DyzmsCQBAMloLJEsT3U8UyJ
         HPlVgXcbfHgAzI3H8ZaNXDcfoZJ96Zrb/KifiJV8ffTDtmewXRuCTTNcQkhKSG9OsTZ9
         uxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708234331; x=1708839131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+mYOP74oT/fmnKuLJNRG+jgvNKGCnpPTuzdRRiDPHU=;
        b=UkbRX6E3P16tIXeg3BDzjZFZWvMYiClyIIH0NtPEZ4MlX0B3l3s+yIYPp1/I+go9t2
         dE6ACk5QJopnJpGaNW82eXKsb9XT1l0KYvbHCSVrnu+BvdoOrBKKcLsspD67A74uJChq
         QpYxbBVTe8z7WJWf6S2zLBkjYh6JP0sXDpXVqJVXX8nxUCZIOoSahj5bEugiGiUPufQU
         ylH0MuHtxQMCjqa2pxSQKFgcAE+bBNKvZam8XY0bursj7C7D9JgGDUp66n4rvVszwhzz
         UgHwoqW7ZILpavAmuXutQjGnkpty2T60ikAPSlfmPnFPfwzIVjQZPUeCn45qATqPsTpT
         begQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaNpWR532GZu1QLKGJIVLBxwleBxmn71okkbR5rTDPA1FYtxtOhnWtLjkT6Ouic6bUEo3vnyYYAgjFsUntYHGiQ0hk4FpL/xrkWswNgKm/BtfrtRdSR2Pu0C+p9F+ST2HK9EzXQnx43f5j
X-Gm-Message-State: AOJu0YxbBFWUtO27+LpoiGMNqLcDQRgXMnUHfkI6o4XEvKMOkwEwl15K
	PVM+xhCHGdSpcAlTNUWl7nJFMbJvKv5GVQ8hJ+DQ3w2AVkqixWl1
X-Google-Smtp-Source: AGHT+IF6zRDmg8LbXEK4+VgIoMIeLzccP/PeHDdh6rX2SeYbpbyn6mdCeMY3wck1Z02klSwCAoFEAA==
X-Received: by 2002:a05:6808:170f:b0:3c0:3389:3b33 with SMTP id bc15-20020a056808170f00b003c033893b33mr10927802oib.27.1708234331172;
        Sat, 17 Feb 2024 21:32:11 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y4-20020a056a00190400b006e1463c18f8sm2438589pfi.37.2024.02.17.21.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 21:32:10 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 237C01846B483; Sun, 18 Feb 2024 12:32:05 +0700 (WIB)
Date: Sun, 18 Feb 2024 12:32:05 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto <linux-crypto@vger.kernel.org>
Cc: Robert Elliott <elliott@hpe.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>
Subject: Re: CONFIG_JITTERENTROPY needs more explanation?
Message-ID: <ZdGWVVIZx8uIu83K@archie.me>
References: <ZcJBk_NQvLzwzprn@archie.me>
 <8992c7f0-b0b1-4bbb-b5a3-2906159e2e24@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lUtBZG1DyXRBGt0O"
Content-Disposition: inline
In-Reply-To: <8992c7f0-b0b1-4bbb-b5a3-2906159e2e24@infradead.org>


--lUtBZG1DyXRBGt0O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 08:56:48AM -0800, Randy Dunlap wrote:
>=20
>=20
> On 2/6/24 06:26, Bagas Sanjaya wrote:
> > Hi,
> >=20
> > On Bugzilla,  Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>
> > wrote a question on CRYPTO_JITTERENTROPY description [1]:
> >=20
> >> The desciption of the CRYPTO_JITTERENTROPY kernel option in crypto/Kco=
nfig has an incomplete sentence:
> >>
> >> | This RNG does not perform any cryptographic whitening of the generat=
ed
> >> |
> >> | See https://www.chronox.de/jent.html
> >>
> >> This was introduced in a9a98d49da52 ("crypto: Kconfig - simplify compr=
ession/RNG entries") - please fix when convenient.
> >=20
> > Can you explain why the Kconfig description says so?
> >=20
> > Thanks.
> >=20
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218458
> >=20
>=20
> Hi,
> Fixup patch has been posted.
> Thanks for the report.
>=20
> Subject: should be CRYPTO_JITTERENTRY.
>=20

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--lUtBZG1DyXRBGt0O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZdGWUQAKCRD2uYlJVVFO
o3aqAQDiy2tA4OaINnPNORdABB1smTA2ILL6uHwCq2cl4csC9gEAlJ9HqGAkl4C1
WXDmN8GK/2cvUgu5+nCdqokqrZt3sgA=
=OYxZ
-----END PGP SIGNATURE-----

--lUtBZG1DyXRBGt0O--

