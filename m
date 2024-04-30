Return-Path: <linux-kernel+bounces-164760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87BD8B8228
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7E41F23212
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE551BED8F;
	Tue, 30 Apr 2024 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pk+q67Fg"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2BB1A0AEA;
	Tue, 30 Apr 2024 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714514055; cv=none; b=YmccnQMN2KCEmxge0MBas//GBJqa2pI5SdwP1/7gYl7YfOtybIqtKaYxbFX5ovdPYEa1+e5saytFIFZ+aOHVFbCfQpJcXnw/kV8BToLiIxg65GMfgb6q0V3OCfbkKnMH+cB8vBPHpfEh/t3OMKJ5V4PwebOdMyfCY8a1zPtkIPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714514055; c=relaxed/simple;
	bh=OQ1JSmilEmvGUCxHXGS/yn347uNNeHq7mAnJq9hNctg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gEI+dJVtXzb1hm0XFfUsVQMhDKg1SeK5Vrs8XmHIvFg/snxnZ/9g+gR98MecAIKB6KaiMaeS7/016LViGvDnFdPdBOXZ7omhDC67X8PQ0M4rj5XrMfNpghnccyXcFHH1vgu8zf0ShOxrKmt68Gmg7blnESfpsoPU865g0DEl+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pk+q67Fg; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714514051;
	bh=hwsEDzIbH5eEclr1EyoxVKbwSpGvnsnBFunPBWyr70o=;
	h=Date:From:To:Cc:Subject:From;
	b=pk+q67FgyybW42Kx3uySR56RgkX3rhVYXT7qwwdUqw6muJuKukFnauCWWmhyXhH6J
	 KHrYZQNPaCX2zRQ5FTZ2KxJhevDcFI7C+ZyQZkgpcTr5Isaia27NLZ1n/PI75gG8sP
	 PYhEdk27l7gn0wLS3aK20ONMN1f4bjsBLu0MmYvc6gTyGfHOY6iuNoQ4ThaPzJgRpH
	 8dTt0NkFe7lBtgHhN5BM22CkDNIyjpuRRxgBq57sHF3aITCqGQ0AaOG/cXF9ZfG8DN
	 GsSS7x06zK43YAHlnnM0h+rBZqL7/j/HeoIFJ35BRDnCIh6bBR5CS7jXac0nJxDBrn
	 YrS2/fhH+qBTw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTYr26q0bz4wxt;
	Wed,  1 May 2024 07:54:10 +1000 (AEST)
Date: Wed, 1 May 2024 07:54:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bluetooth tree
Message-ID: <20240501075410.082d328d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_9ORxXdEv72GJLAID17LJzd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_9ORxXdEv72GJLAID17LJzd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  0172c2365299 ("Revert "Bluetooth: HCI: fix slab-use-after-free in cmd_syn=
c_work"")

is missing a Signed-off-by from its author and committer.

Reverts are commits as well and so need Signed-off-bys and reasonable
commit messages i.e. it is useful to know why the commit was reverted.

--=20
Cheers,
Stephen Rothwell

--Sig_/_9ORxXdEv72GJLAID17LJzd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYxaIIACgkQAVBC80lX
0GyGjgf8COLQXHk6UKl/CxZEreYWB99j7MTQKVFqc5nXMUhb3hTcBWMPbk6PcS4y
Px3uX5ESt579E+lUcO/2GyAohM29SUIRxRAXMOMeZdc67IIVALSEW0j4uvgSWDbg
MriHAeXK7SSpw4RQbI3CDC0ODOl+0CvxiTxLYYbNOqjuyw+G7O39BVQurn0Sj1Rp
a2NJEywpn+86vkQrZHt10Nuf6Nv0JVvGmf8yP3NJE/OJpI6zbCpG2hf21CPlI02Y
aQuKU8hYy6rtF/NzJ4W19ULWNXr0EWT6cWOwXGmg9QiS0JNWQt9QVv0GqH1SsmL6
o9/GnkWcvEYKiecWRtgQ9IfWGk+M9Q==
=jJpa
-----END PGP SIGNATURE-----

--Sig_/_9ORxXdEv72GJLAID17LJzd--

