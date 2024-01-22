Return-Path: <linux-kernel+bounces-34113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D90B8373BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101B528F3D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC59347A43;
	Mon, 22 Jan 2024 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gDvX4Fqw"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2B47773;
	Mon, 22 Jan 2024 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955351; cv=none; b=ZLdBRitfBOG4cpjFK60d6Btd8aQtzf/eYSyBmPuGiQWyu6/Z0+9jCanPriUXDfNS2/ZabgRWq5QDuZjSf6WBlJk/jWnRWWh87vk70w4QWabI29OdpxxbMF+Mw92QaEuovBDxyzsiVfA01EvoJrg3Kx3mTp0PZgwWZcDTatal7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955351; c=relaxed/simple;
	bh=N69qqHx189pcGABW06/61WpJRzGakx9exdg3TB8H3Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ijazb4+E5WLduKyNW0CB7nuTvt3CLpjgeU6ZhP1XNJXiEEsCng/qSfQKQzS8rsXDk2tJg0JH7zSMndyPMBL12SlOZipgTuCTRWS+hWo7K+auwqAqbpGBwUhAjWbtpfclS6InCqmKa2eSvgtGErSVMJ/oqIyBdsPQqTqAjWhOn+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=gDvX4Fqw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705955342;
	bh=rch3ecI6HonxMbreI6aKN5lMTeXyt8QMDLNNeQsywFQ=;
	h=Date:From:To:Cc:Subject:From;
	b=gDvX4Fqwf63Sp8/SCGmovKdk0u/BEcVFJc9JjSeUzK+UtSVGFpykgNgyqOU9hm1X9
	 3EJlVTXiw5QPUhkLNGYB0eFCd1y2TYirMM+P2CaftM15KRMzS1Jhv6UE0febNn8xJD
	 UboJ6hLop6N+L58kbuONZly1K6zhcIyG8du2L6PnXiUPi8DdQuRxtbwy0Y/69DDYtx
	 JK/AJmJhY6FbuCNlTGuHzdoSTNuJj3YNoxFi6HqaMwy8n+V3vKT5eNaLZ7n5Lz4HIl
	 ft5FFrKHXruQV5jcOewhs/CMLPiJ9vI13E3zWPlQfWK+QMgcOmPePQS7gZ4eRB+NmJ
	 iORLbuXPtBIGA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TJhdV2Wgvz4wbv;
	Tue, 23 Jan 2024 07:29:02 +1100 (AEDT)
Date: Tue, 23 Jan 2024 07:28:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the nvmem tree
Message-ID: <20240123072835.7b1ba50e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_bJQNL2UtwEI.0rhN9TGBLQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_bJQNL2UtwEI.0rhN9TGBLQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b40fed138700 ("nvmem: include bit index in cell sysfs file name")

Fixes tag

  Fixes: 0088cbc19276 ("nvmem: core: Expose cells through sysfs")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 0331c611949f ("nvmem: core: Expose cells through sysfs")

--=20
Cheers,
Stephen Rothwell

--Sig_/_bJQNL2UtwEI.0rhN9TGBLQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWuz/MACgkQAVBC80lX
0GxVgAf/Z0+bz6Co9/LSZ/QmiFWFCoWjavP83wl2EbfIo5cNwXuz0zq83gfuwRlK
zKKq8JPA+0PwsdaPeqQ+Ev3yb2/9//n0usThtCzDUTQZhbpQdO6rzSulX5q5l+/G
YXjs9ctR/u1vFPucy+Ws4rS5e6Q6coxoI4v2IgWuXrOQSNFdbF9T8XJg+C2iahFw
VP+b44JEoAJXTUb+2+5pLsvS/mFyWLRUV+O8Bccn/fKTv3PT0kDQDVrinDIYwIxg
RZi1MgxWg0Nadajzu6Rc+VASPd4eL2RvUGzBw7n97e+8wt8kaiz6n/3+kD/r5ylG
gJbgw1fTa7lLoDtJSwWvanE4xkxCRQ==
=KVV0
-----END PGP SIGNATURE-----

--Sig_/_bJQNL2UtwEI.0rhN9TGBLQ--

