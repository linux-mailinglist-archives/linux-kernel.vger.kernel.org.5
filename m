Return-Path: <linux-kernel+bounces-22816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9125D82A34C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EB91C22E10
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7844F5F8;
	Wed, 10 Jan 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RAAXTCPL"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F04F5E8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704922364;
	bh=tgziCic+NT5BA2vVRmJ/AxzBuhtBizO4+06TNabdICI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RAAXTCPLjCTNDrlnh70AUQacIaXdTj3mQMcc4h4KRNW7D8xI9Oa8sXlsV8BRuo+Qt
	 qgIWxWDMEtq3BZOPnqvOhhHV2qkOf7yKOh++ABCr2usM7TDaZsvHNeq+55CpSMdDSj
	 enRLZKmstvJpLVWmTIfrBj+xJaXe2hDQIcefYwFMcOWc7n65Ar46osKSPQ56Pi332K
	 hoPY57YevgcTIUAT4hQ6hxYd+eS78W3hNhz+XyesySEdTxmLadKjpA9FMvccjwZ6vh
	 G8nJUpodvi0rXb5y4RQWpqQUJzPEFq0tBk57vB+WVr3efNKKBfiW5LXIxHK5GImrdY
	 xcRI4JPcH2WNA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T9LcV636wz4wcc;
	Thu, 11 Jan 2024 08:32:42 +1100 (AEDT)
Date: Thu, 11 Jan 2024 08:32:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Boqun
 Feng <boqun.feng@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Paul McKenney
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, WANG
 Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, Will Drewry
 <wad@chromium.org>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [GIT PULL] header cleanups for 6.8
Message-ID: <20240111083215.1e5298f4@oak>
In-Reply-To: <ualbkbj75ulsbwbjuphntw7ztb45r2q7iysvxvklmyv5ndnvh7@zxr56mv33vyv>
References: <ualbkbj75ulsbwbjuphntw7ztb45r2q7iysvxvklmyv5ndnvh7@zxr56mv33vyv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tmnL2H+ZIxa/u./tNlrenwK";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/tmnL2H+ZIxa/u./tNlrenwK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Wed, 10 Jan 2024 16:19:17 -0500 Kent Overstreet <kent.overstreet@linux.d=
ev> wrote:
>
> There were two merge conflicts in arch headers in next; they looked
> pretty trivial. But now I'm wondering - do we have standard
> tools/process for recording what the merge conflict and resolution were?
> I'm sure we must.

For simple conflicts (like these) the easiest thing to do is just provide
lore URLs to my notifications:

https://lore.kernel.org/all/20231218170015.6018162e@canb.auug.org.au/
https://lore.kernel.org/all/20231218170547.5714468f@canb.auug.org.au/

for more complex cases, you might want to do the merge with Linus' tree in a
temporary branch of your tree and add a note pointing that out in case Linus
wants to check his own resolutions against yours.

--=20
Cheers,
Stephen Rothwell

--Sig_/tmnL2H+ZIxa/u./tNlrenwK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWfDPoACgkQAVBC80lX
0Gy9PQf+P4yruHSDMzYIO5JA6UGhjunRM7cUcAyAIAitj+iSdy96KvWkNLmq5I0E
7ax4ahojE063Xs+n01v4iHsjE3TWRJtnyjOTPGMppA8SroZZKFrigp0YcSKM2vn1
y6DAvn2vbtX7Og0rmC2i9vfNEfuTFPuWbyAQoGRgmHrvFsm2kT5qYJZyQYunZL7J
ZH31TnyOoX2Naisop+g4E5S0x6lhr7SUrSoNv9993aLEBQVKDrUH5IjxTjRqtudE
3fz5JC7U/KnlMP3pg/HYmN/YlkcJt1M7pe4bjWuefxW8ZsiFpEMTpePLTvlPJ7rP
4jSLo6U7ULrKYehjDlO/9Qg0J3qlnA==
=zANN
-----END PGP SIGNATURE-----

--Sig_/tmnL2H+ZIxa/u./tNlrenwK--

