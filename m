Return-Path: <linux-kernel+bounces-77751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D04F8609BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B481B25EED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C28010A0F;
	Fri, 23 Feb 2024 04:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sVBvZQtL"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C83101DE;
	Fri, 23 Feb 2024 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708661462; cv=none; b=Ws5oKd9AZ86oE4LbPfwj2oMJGg4IYMYQKfDlIHWtQhi4nLwH8u55npH0uMU5IOZYG6x9D6Nq4/1tmI4FUNIXzO20AQqmABCgfehaAvK2IvrJ1gnSTWWngH/dtAV/HkfXlao2G599H6pcCdVuqHyfpTBGCUo3QSG2ADBQxLSMjeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708661462; c=relaxed/simple;
	bh=N5HS1ilw5dmldpb8VkdgiX88R/djn7+at4lkdh2bEIE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GslxSwoh8V38xPvN2rR1uiWRhdqTJrMnQEQqrsERHAohTFT0BjUPpnGlRE/NK3Lb0qst6wRpTzi3j/ixNqRnp3Bc7fFb1Nk40EB44cxdO3ba6xIsa8ZclVl+el9XayLqz8MBuKTW7TM1pL82GfCkhl6WQGuXoO4AdDhSac6F5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sVBvZQtL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708661450;
	bh=BWM7K7TMUhIKsGLZ1Fkm/evkV9Y6r+FFZt2ArUTqZmw=;
	h=Date:From:To:Cc:Subject:From;
	b=sVBvZQtL9nfiN3hl+/E881tFFwoxjNZe/nNF6yRI9duHd8OjrEeX9BjOpADZSP12y
	 S4RmhP77r8IjRuWqBprUwaTlNGLff1Ovr6+ZJQ46H8L1bq83Ip7Xml1/RYkV/axpwn
	 ErjIpca0/Z438utr9rE1ftCTKXM2vpRtt/JitklqotkooWrlaq1FoTo4EJh9eBlMXN
	 h2wy6NiGHnKENSuDe3zeffA3NaeB1NfAdGXitX/da8Y9L0/3pQYnPqXFN0WSV+ZNeK
	 tr2cpQ9GH+OSCh1JJqFzHfgPmjEBpnyiFVG1AWpTlCNqVxvpCSHrLxS6tTNv44Zccx
	 sr6p1XcwzqFlg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgxQ16ScYz4wcC;
	Fri, 23 Feb 2024 15:10:49 +1100 (AEDT)
Date: Fri, 23 Feb 2024 15:10:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vhost tree
Message-ID: <20240223151047.4e267929@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AUG0P+H7hqjGR_1gf5IvmHr";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/AUG0P+H7hqjGR_1gf5IvmHr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vhost tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/userspace-api/vduse.rst:236: WARNING: Title underline too sho=
rt.

HOW VDUSE devices reconnectoin works
----------------

Introduced by commit

  2b3fd606c662 ("Documentation: Add reconnect process for VDUSE")

--=20
Cheers,
Stephen Rothwell

--Sig_/AUG0P+H7hqjGR_1gf5IvmHr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXYGscACgkQAVBC80lX
0GylbQf+IrLVrZIvNO1kZqS+MJ9GHNU/uQ/JouLKea7dM9AUSV51ATAbBtLYG5cY
UsxFYhd5EnRFUwhHUZsRmxFDBfCfJBIPjDL8krS46u+HA2EGQA44VCN0es7EuiQW
vFIsHf1gadIadb9gnlK0tB8L2OTYg/DId6tjkZRkf7OWbN3JqC5J9Uwv4Hlu0Vv8
QKH1NobYGFOegHhZ7Z7H6+WHqBc63fME3DkI2wmJk6UGmlnmO2g1/15/7oRCoESt
r1VwaKgFj4w+C0rw+hMdy5RB2DEug1Ru41vKuMYaaNYsIOngDBXxDcUwt12KITJr
h1aVrGEybCk8QEmL1S7wmJ1BFylOGQ==
=h3xV
-----END PGP SIGNATURE-----

--Sig_/AUG0P+H7hqjGR_1gf5IvmHr--

