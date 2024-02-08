Return-Path: <linux-kernel+bounces-57449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF7484D92D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAC21F22C89
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0A92E3E5;
	Thu,  8 Feb 2024 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="adXLJY5y"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C12C69E;
	Thu,  8 Feb 2024 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364325; cv=none; b=Es3S9htVx4C6f9WD3VZoTegbfpG5z2trTpo+18e6KhS4xUt6QpE0NeriSooSzfVI3+TiKZGqnYaUTnrLPuvVK/mf5+yCtNtp0EcrTPm/sGDLzgZ0wfCYv8y3BgEnaQO5rY92RXUEfo6TV0HPtD5Y3W5fhThU77cHgoLjF8NbVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364325; c=relaxed/simple;
	bh=dVPRNQQc7P+QfNkHGmDO1CbsleULgLvehZgSq7OzC3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dxN/RfQxBeNwq29CWV7oV96RboFSYNCysolGKtx5UJhNwsaLMnEP3t+r/3gEbU+IzF91InN1IUxlgiySI14aegvC+tAcMgKqOD/rYrG9e6VA0jLqQ7W1zodL+dJLywkycJbu/+8OoMJzfsK1YqnNQ1Xx16pXrMEOBG3u0HlqHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=adXLJY5y; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707364322;
	bh=xQ5Oqi0gQfWoo4eke9JU9R6Zv+h+OBnn7RaqDZCJ5/w=;
	h=Date:From:To:Cc:Subject:From;
	b=adXLJY5yBoNtIsGpXvx171wnDEh5SdT77dVMFQ0AYYR4nsRu72F5ZFA0WUfw+s1ag
	 kTTbsclfzZRAibjcb6LMB3ZR+2ixhkReBX2NF8mpMHgBmeP7/xN3QaIKrIou4vBsDQ
	 9SGEI0uSCPCA68WOrFrOuCmZVKZnWY7c0sJ24EQoSH3enZP7gWpQRcG7BseJgcu/BM
	 317rxZMT3ZerX3f7EpsXpeG00c0AJt8A6qL+bpP681eC4agVQSPkZj0fYk7ZKMrsEw
	 wXKp6i/CxRP57uRPwqGowz+X79PY2uRqpSekold4Ptd1RjII2Fd0LtIxJYpYx1lT1O
	 5Zs89Fg+XldtA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVjjF3RNSz4wcr;
	Thu,  8 Feb 2024 14:52:01 +1100 (AEDT)
Date: Thu, 8 Feb 2024 14:52:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>
Cc: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>, Cezary Rojewski
 <cezary.rojewski@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the spi tree
Message-ID: <20240208145200.7590dc62@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FYfqp2pashq0gs71qMn_jg.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/FYfqp2pashq0gs71qMn_jg.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the spi tree, today's linux-next build (htmldocs) produced
this warning:

Warning: /sys/devices/pci0000:00/<dev>/fw_version is defined 2 times:  Docu=
mentation/ABI/testing/sysfs-bus-pci-devices-avs:0  Documentation/ABI/testin=
g/sysfs-bus-pci-devices-catpt:0

Introduced by commit

  148b93a5062d ("ASoC: Intel: avs: Expose FW version with sysfs")

You need to make the "<dev>" part unique.

--=20
Cheers,
Stephen Rothwell

--Sig_/FYfqp2pashq0gs71qMn_jg.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXET+AACgkQAVBC80lX
0GwtFgf/bVFTvLo15PII4p+GlmjU53hZuvXZST8hkXa/pKueiwOiHiifTyP4PW5B
TUydc1KB2Z5s3mYSdNk9vwHmWCs2jKT6jaoIBBUYjpTujNeOPkdLiHLfoTrKFEw/
kd3IUtOONhpovGbinKbUvsq9Arl+FsKmNAZuz2yTmmbOH2UuWj5uf2otsN5aygMq
iR7dgLH3LIf0y+bZ5BT4T/Nmsqs45vG4lJ5BfddTaPlvyvakW3XFZrcJPHCVt7Ga
DfofaP2ExVbyQvQNuTos+RFWpRjieP5NhCJSNkfHvbAG9obZ6dFsaKJbjH/II7xV
D1SW59OwZjlXtont7N0fpFNUW6gUDA==
=664k
-----END PGP SIGNATURE-----

--Sig_/FYfqp2pashq0gs71qMn_jg.--

