Return-Path: <linux-kernel+bounces-99568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AEE878A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF406280FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB4E56B94;
	Mon, 11 Mar 2024 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X+JgIYQR"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60C57302;
	Mon, 11 Mar 2024 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192495; cv=none; b=IMeOtgwnbayNjuRzszSMkHhw0SHy5L3b9HmcyBf7SqY+YoQWRYyIRUJOwIWSdgoae9pE1a6fTSNJOdM2+h8ZGUFmR3YRbNPoxaSXU0tMoNP5LbjjS1Zh5wNRTgsDppIjQ5JvoT5WMETIg6SIgwxSEwvWprPQopG1n7NsfJQewkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192495; c=relaxed/simple;
	bh=AddjCZRuJA/cvjpCaDsD/qJlxubINQComTz1P8PLDT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ifdcp+xbkl4AEOmWbwaZs0mxwp5IKHdJOZDelTRtUQ4FiMn2Lg9daxRFUVRQ1sO0u1TSDJ7D/E1qwD3oNw86Pm1TmgVz1xMul3aohFvH9IQjGePEtbYw6sgbXWvAue2WyHd8POqeiInc8mYzq36L84YEX3XAjp4EopXvAs/Bh/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=X+JgIYQR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710192490;
	bh=7UwE6XKNoVZL+OR1xX/AzhU4bxZHpOWT6dZZmZslD3s=;
	h=Date:From:To:Cc:Subject:From;
	b=X+JgIYQRcyXIBGEen+GQkmBqqeO0xuwOybCyYWYA6jvgkIebcO9/Hyog2KM2TOvKu
	 zqBhbzZUOCmAdx1EH8VCOEhiJqMx8WynpeTcwezWB6C5u9x1UbFJyowxuSkQrGvoDY
	 4x2752RlDiPWN3RUHbQdXTWBQv6ha0vfPZ4XQBm4tpmh2BvzNzXrXvhup3PlzRxuFd
	 7wbHs/+YbYyXD0fF+E/uOTkIekYrmWsuinnlQppaYN2Qgd7h6mtxarMs7HVTm/zAgD
	 CSXQVOvSdnkT6KCDf67VfRRKHJT/zzsT91dnziJndZ3ybcRdE4a9vHUJLKYsNIkCuo
	 t9vqrMrpFr8yw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ttqd471shz4wyx;
	Tue, 12 Mar 2024 08:28:08 +1100 (AEDT)
Date: Tue, 12 Mar 2024 08:28:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the tip tree
Message-ID: <20240312082808.0a9c5726@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//vu4yJVwlgRnXW4S_E8Wl4t";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//vu4yJVwlgRnXW4S_E8Wl4t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  e0a1284b293b ("time/kunit: Use correct format specifier")

This is commit

  133e267ef4a2 ("time: test: Fix incorrect format specifier")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_//vu4yJVwlgRnXW4S_E8Wl4t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXvd2gACgkQAVBC80lX
0Gyx3Af+IkHUa2gu+KEQetYQCppprKkniYqVZ7NWQvqqAckD04h+MN2ggRtrp+l5
y9o7lqzCO0627iovMaTG0Q7lGANWjfuH1NJ9zdOzAPplPVptOsgQ2Zcx5nWW++VZ
ucOGfWmWhSo64QNwsd39np4lvJB7MrAhkyWTlxOHfgX3rQwQTDtA58CkUuCSSX87
ZnFUU/l7XOKN8HoTEBd7RE5Tji7TxUd1oM+91L7h/fsMqPuClxhtuvSUhYgI38D1
sig0ZjC3nrgBGr4QUAZHxQzchXDseC3VjqtFn1AzNmKPrLhD83OCwDRa+qPJfPOg
83DdYE+nA2N5/BY/z+ScA72LTTvBnA==
=Uig7
-----END PGP SIGNATURE-----

--Sig_//vu4yJVwlgRnXW4S_E8Wl4t--

