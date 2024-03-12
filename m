Return-Path: <linux-kernel+bounces-100787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63400879D37
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6C8B21B13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E02C143725;
	Tue, 12 Mar 2024 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TCXqA4Ra"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C1142909;
	Tue, 12 Mar 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277508; cv=none; b=dk1j/NfluwI6jCZk09mamPJ8nV9Hxjfq6+ADBzTVDUBTMIWr4qnWSNX5ZTokiHnSxOX57UuLD3D64Q8auuF6ZEb9DKRw7EMCrXMVoSYwndP0UdC6KZYpn7hNS14khQY+RVvVozGNtU9BDeKGFf6F0axbHazc+eQeo8MOcJi/SP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277508; c=relaxed/simple;
	bh=f0emYnUdkdhYIBc/3Se3W5Np8er3w8EHma7zepyAWfA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=C+CS9qekRWY+lafWVqZrNwuHQ3am7+ovGTVIdpChN3s8qBYb+7xXGlQCWoJZuWdTlBiJO94i2G2/XKp9cdauoLYy1z7yiZRV0kabE9a7C1xwDjBwN9y3quNa8zVvY4ZZ/fr3tM22tyWC4FLeYYEw1GY190jVMRd7K9dB+uEA3vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TCXqA4Ra; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710277502;
	bh=nvWpdmmhjbKdZzXxVwDU/rmHSg/xKycRvzHEUdJCVC0=;
	h=Date:From:To:Cc:Subject:From;
	b=TCXqA4RaQt91XjGumiEcDi8000mw2QdSRqcCe2JgDcUKta3T9x0hthAJnykgoYu0h
	 DQrc43+L4t57IXyeNUpbd9Z/FW0Dsw4hLrrJOguIjsEs8D7vzPVDIlAfnEqHI57ziF
	 LfSy6o+omLbFymjTr1E9EIsj7hFZTTcn1IbbJnKGtPfFetrLEt5upecRTbmDZpVZE7
	 OctwxJyjj9v7//rU8r8JsO73iUlWfioRyxXXPTMUBbnoN48uUQeqqJe+xfMyun66q4
	 DfSvoqAEAqpzcpprsUZU7fQsAHQRL8RoldHMwfgoMZwYcxNux+plGS1zQmmscWx8qB
	 OBqvv0RQwVoIg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvR3y140tz4wcb;
	Wed, 13 Mar 2024 08:05:01 +1100 (AEDT)
Date: Wed, 13 Mar 2024 08:05:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the device-mapper
 tree
Message-ID: <20240313080500.2dd1040e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LIHz_9Kx=RI5MDyxTArtv.h";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/LIHz_9Kx=RI5MDyxTArtv.h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  771d940f4a86 ("Revert "dm: set the correct discard_sectors limit"")

is missing a Signed-off-by from its author and commiter.

Reverts are commits as well and so should have SOBs and explanatory
commit messages.

--=20
Cheers,
Stephen Rothwell

--Sig_/LIHz_9Kx=RI5MDyxTArtv.h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXww3wACgkQAVBC80lX
0Gwz5wgAhgYS+U7fqO2Pz/rei/Rv6hOJQdCItaphRkxoiOYGLPr30pg9FM4ykLoG
qMU+KlL8EjwH+p5LBTusNFU9e+ybGNAJeb5cWvTdJ0KpeXyqF35TM3g8S0oiH6fa
kRMEsDPlrrC7YFYaEr2tOVlLmtlObEv8W5jPWfn/LH3GwyDJuU006BQHY7C7iPb6
9wauky1BKIpvZ4sFSgmWW9ysUfKJLeok9Tro/+Xc60n9G94+fWYWRjRBa+1MYv9g
ZncoFulvmPWjEd8aczL6aBLokbqdHr/TeQapL9OF467zATSy6oZZc6tz2bwUEB0i
ibJdAvI+YQzpRqPEt9hFgC4ASmQP/Q==
=W87S
-----END PGP SIGNATURE-----

--Sig_/LIHz_9Kx=RI5MDyxTArtv.h--

