Return-Path: <linux-kernel+bounces-36307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C515839F28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD09C284DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33933441B;
	Wed, 24 Jan 2024 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bb4OotxD"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294C915B3;
	Wed, 24 Jan 2024 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063527; cv=none; b=RBocLOJqVupQ/jE81iFyZO55pyxnvoakzH8+Yzqk8mqEyiobHHxDxJRnpQQucE+olOm4etlbplAx1Iq07KzQzcwQdunBB7udXUw6GF7Jog5psFKvgysPuOAzdLPtyeDt7eCNzLwOgPqoBBPsSPadLt5aqczPzsfcwzGsKfApddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063527; c=relaxed/simple;
	bh=cjaowOtRpgb3R3EW6yPICdOQUmN+2o0lK2AU0/UIFk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAG4gE2iMwNCx6MWVjT+yq/FxvOUqjAbiXdpZUSAw2p2QhjHhHE0gly3Nlpx3w083F6GAxbL6pw8Hqu61u8QaVVDQ38Xs0UaExvr3zh6XPSD508IE/twmyePUQEt9xghPyqi8eAiw7Q5hdmQkj06G5WHYGuLbtMZdRfG/6UPypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=bb4OotxD; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706063523;
	bh=cjaowOtRpgb3R3EW6yPICdOQUmN+2o0lK2AU0/UIFk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bb4OotxDwqdzsq1RHQRTgBYqdOvi9fOweRzp83XTGkBvr6eCa1uFAsblIod66MfqG
	 obAmTzxemWIqPvTbAyNTm9OESfjfLMeUrnuJLbF/04C7gGM2K7J3E86vD2ygXjC2C8
	 3t5qtZCMepBSNbvw5SwFiOnTzn4NReVW4YWypPNBz96MWHYoWfTgAz+nvPvcvJO+2h
	 3L5RlrWUOIgi0SQnNH49xTYvu5bPggBK1+NiztA40Kozr4MBp7DSBj53cGairlZQch
	 Pgi1LwYnyB4gs4llSzS8Q6aMdc3b2BinKrv2QPVSTMnmnKQHUcyqfXQKe9IKjSvPgv
	 7kVRscFTXfdog==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKSds6517z4wyl;
	Wed, 24 Jan 2024 13:32:01 +1100 (AEDT)
Date: Wed, 24 Jan 2024 13:32:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, David Miller
 <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Hector Martin <marcan@marcan.st>, Jean
 Delvare <jdelvare@suse.de>, Lee Jones <lee@kernel.org>, Micah Morton
 <mortonm@chromium.org>, Mike Marshall <hubcap@omnibond.com>, Pavel Machek
 <pavel@ucw.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: linux-next: trees being removed
Message-ID: <20240124133201.39c40616@canb.auug.org.au>
In-Reply-To: <CAHmME9o-DpMb7bCg=WJy5pfMpCQh4ZGHOYu4-s-nU=925Y4mwA@mail.gmail.com>
References: <20240124130101.428c09a3@canb.auug.org.au>
	<CAHmME9o-DpMb7bCg=WJy5pfMpCQh4ZGHOYu4-s-nU=925Y4mwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ohE+DwHZKwQWwdDQHpXNcxX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ohE+DwHZKwQWwdDQHpXNcxX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Wed, 24 Jan 2024 03:10:09 +0100 "Jason A. Donenfeld" <Jason@zx2c4.com> w=
rote:
>
> Branch updated on random. Please do not remove.

OK, no worries.

--=20
Cheers,
Stephen Rothwell

--Sig_/ohE+DwHZKwQWwdDQHpXNcxX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWwdqEACgkQAVBC80lX
0GxtOQf6AxqmqxlxZxzmx/pjVKbKtZmIBASwgafLsVznomq4V4iQul0dgIRumq69
jmaXYmxVgHNAWIB0sbugGDiaiGFfibw9eobKkPsPQ+AIBSWp8rFFuBPlR9AOrI39
jmli2n7btUVmCWpgVsjL/jz8t/+4c/2pj9KxfAlcoqDcYcfOCdxXTRZxj42N+mTt
T69XZERVvxXTdPXS3tBkBK/YumLo2HCYmBsSYdjYe0R4f48nuZxixb0d6BlfvR+H
qecw6pD6rvQ3ZiXy2amjCK2znCiLMI4zS9dAMtz0ZdIdT8QeuCG0s2O1lbw/rD3I
v4Uali16JOg9JnPHb5Te9YiHeOfdiQ==
=Qpou
-----END PGP SIGNATURE-----

--Sig_/ohE+DwHZKwQWwdDQHpXNcxX--

