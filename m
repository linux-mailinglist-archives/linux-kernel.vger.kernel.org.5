Return-Path: <linux-kernel+bounces-154200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 884CB8AD92C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1788CB256F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6733445BF3;
	Mon, 22 Apr 2024 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iX4J9tLh"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16CD446B6;
	Mon, 22 Apr 2024 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828361; cv=none; b=mUjbi3WEDEgggqd4WaEqBEpvxFrT1SaelJm/M6SQpQU6zqOkk2futlOreT1ZGWFvNVtuRCjAmwqpYYpIsCcd2ZmXX7AdJDBLta3Isx+VNcnZM/33mCj0hqoaUNvBZxT+aSw4FFnssFmyJvxRZFQyNg69A7wBcv/1jQjuoMiKo9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828361; c=relaxed/simple;
	bh=2Ifl8nyJdYuDT2s14qHO3wiFYS1nqSzWrrI6fQBDBhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Nh19zKej3CwBJeJDqzY/wnyyRJHZmN4BFzuYnNAa0VZRkjf0U8IdCM6VyHGqdIu0+csrATUfEH0bwWytTQEsa/GgQ4sUeTMDUpreq8V0h1CP/Pq3JQGGJrVUAhwwstgyszUc7IN2s5Cas1HXN8TzTLQEU4DkgNZ73DtLU3NfZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iX4J9tLh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713828358;
	bh=6EL5U7QilStzdXpfeIpTm8KNQRqebKYgCnAnlG3HTV8=;
	h=Date:From:To:Cc:Subject:From;
	b=iX4J9tLhhZ+L5r9aONQSkkQDlejv1+qdUYKZoePKjqx++RBoiEONQJLgfxvev2d0U
	 hhcbVyHPHtQlG98+QA34fQRz9JVI179Zyrasn6H6obfgUTdob6lQjhL/mnroo7dRIQ
	 SsPbwuLMyr5lRm6iqOCdS6pD52oQS/4NZk5nkXMwihDFQeJ462ik3DtLgRBlj+APz4
	 ADlRp3lMzRE4I16F7mSfVXrjRw6CCrqHZtZUHURZUgPBbt+7UZF1LFbq083vtjvHxo
	 oGiQN52HZPEfV+lmE331gs2ftOxW2951cIfp7dhS7oPQt2s9f0XZdGX6IXBI1prRIH
	 T60Wy4KX7JW3w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNhFf181nz4wc1;
	Tue, 23 Apr 2024 09:25:57 +1000 (AEST)
Date: Tue, 23 Apr 2024 09:25:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoffer Dall <cdall@cs.columbia.edu>, Marc Zyngier <maz@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the kvm-arm tree
Message-ID: <20240423092557.73c2ec1b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xEDyXYKmXsDSC/AYrMBqn.T";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xEDyXYKmXsDSC/AYrMBqn.T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  fe4763e18355 ("KVM: arm64: nv: Work around lack of pauth support in old t=
oolchains")

Fixes tag

  Fixes: e09faab353a6 ("KVM: arm64: nv: Add emulation for ERETAx instructio=
ns")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 6ccc971ee2c6 ("KVM: arm64: nv: Add emulation for ERETAx instructions=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/xEDyXYKmXsDSC/AYrMBqn.T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYm8gUACgkQAVBC80lX
0GxH1gf/VRP2axuUJiIJfQdn9IwLIOsqoYTJ/TOxlc9lc6lV7h5eTly6tO0kO1ZW
FT7UHazEywtllEfcQ+SlVeZKaLF+RvsaMJ7lgo5ePJmVAh6YbSlnrExunfMLMTgv
FZ/I1jU0YW6TaeBNvxI11aUUlSbdxKtqBQxVzYOXK4jwpfqAzfDpBTRWIXR8Reah
nvvAl97wNOj9RS9QCITUMK/bwNwANWQ8yKkt8k32oLIawPpfiRx5ZOKVO6cnSL9h
8Eu0juP2CXsT4FsLiQ9HESVqIV+Jsz7qhBbVoi2ZaW9vuyp+nGx6i82UJ2jJzjOJ
kYRY0ApzySaw9CZta4ZbSn/Beh/b5g==
=NiwL
-----END PGP SIGNATURE-----

--Sig_/xEDyXYKmXsDSC/AYrMBqn.T--

