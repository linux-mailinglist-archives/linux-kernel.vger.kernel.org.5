Return-Path: <linux-kernel+bounces-97247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9FA876786
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9961A2865FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A15208CE;
	Fri,  8 Mar 2024 15:45:13 +0000 (UTC)
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4E1F934;
	Fri,  8 Mar 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912713; cv=none; b=r7ZgaVFPbmIVOxzL21mz1MuyWN0Drg42Jr+Bi8sqife118/sM3nEllrUMkoBzLahXp3D5YYA3KD6sa4L98asIKVnCS88ZHhwYfhtReoDsnr8JaK5JWk6g+UV4g9BmzR39Eu1RM4bJ2Cp72NKgE+8IroGuivEQh8md/1TUMLKMfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912713; c=relaxed/simple;
	bh=XkJffO4Kahb1zkXZvM3TCnNZLMJJAGLAGtJUiIL1pic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIfUW7f9EXzufV76Evwt5CLB+3HiG66lYy3O7yh4HjZaIHcfdvyZ8Imb7CpmGfoOlhAfcOSGSVxy/jQw0yrMzrjQMCPti35eUV9QS6/lyFDhqp5v1zOqwM60oUYiH5upSupoOuxd4B0DId1hMeOGThcQtleLHmxRQAzgGnBgXn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1ricP9-000nrO-2u;
	Fri, 08 Mar 2024 16:45:03 +0100
Date: Fri, 8 Mar 2024 16:44:29 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: deeb.rand@confident.ru, jonas.gorski@gmail.com, khoroshilov@ispras.ru,
 kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
 voskresenski.stanislav@confident.ru, james.dutton@gmail.com
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in
 ssb_device_uevent
Message-ID: <20240308164429.0a01fc41@barney>
In-Reply-To: <CAN8dotkp7tQ6znKM5=1iM08hLvjLK-VbQm9LuqcGBf0e3ok=kg@mail.gmail.com>
References: <20240307223849.13d5b58b@barney>
 <20240307232927.171197-1-rand.sec96@gmail.com>
 <20240308060943.2410ef2e@barney>
 <CAN8dotkp7tQ6znKM5=1iM08hLvjLK-VbQm9LuqcGBf0e3ok=kg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UBAVpEGvFW.8SZN79fr457G";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/UBAVpEGvFW.8SZN79fr457G
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Mar 2024 14:36:56 +0300
Rand Deeb <rand.sec96@gmail.com> wrote:
> Adding a redundant null
> check goes against code clarity instead of enhancing it.

You keep on moving goal posts.
The check is already there. Therefore, this is about removal of this NULL c=
heck.
Which is not acceptable.

> I respect your opinion, but it seems we are stuck in a while(1) loop
> without a break.

Don't worry. I'll ignore this thread from now on.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/UBAVpEGvFW.8SZN79fr457G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmXrMl0ACgkQ9TK+HZCN
iw6djg//cErRxyXC6LYNIJ79g3Zqn0XiRGBUoxnpKZvv+kUJ+2qe14ne/H9CIEqT
m+KyOI++0XWwWkrMEPvO01psTr3ra6WHeGFwYmVngj+hSmJ3mODWl+w+WCLeL6hU
hhXabKrwaXs+2ZGAYDA8dyE6ihMSLsPpNElsUY1x6Y1id9NkkrSMkPXh/jCpa4lO
Vzy5qXISAyQ4NIZajqH6e4oUjwuixr9oghFOkSe/FW7UI8aZ+Cci9F/YI2sJL9SD
ThWiVfhEK9iiUtGulfW7gsknP0uEO9bj9oZj5KSd5Wvg4zhep59es/TzBJCYFLyF
QShqke8zkRpRX1FaZLqhrSj2m9bnTSi5OmuwENBsuOELjDwbIPOx8+DHU4q6VMgq
F+FZkHdzCNiAWHwWfc9Fi8brFdguVFN84FrvRaHkze76y0zh10uBDAHVeeY5ADDB
rp/Kr0fPQxq/YoWqbbqZggE6CdoxrWQG6JypC+OwFeEGkLL5rFAnMwmC4nAbJAov
+UE1Qd5OcgGsH7p/7BbVDlf6IWBYhqxBsFAMKzjPF/MeqBzhYYi8rwVxP4VOpgjL
kJmgb5n+MtuLD5lCvdY+P+Rbn7M2JeAIaoDnA/QdgGB6Fs52+4SeHuPIDf9WXFDW
q3kjTBJNfmDk7SykJn9jAt6Tv8Bl+IuTIB2XigrFy4PETaX2CNE=
=6clV
-----END PGP SIGNATURE-----

--Sig_/UBAVpEGvFW.8SZN79fr457G--

