Return-Path: <linux-kernel+bounces-52035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDF5849320
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E167E281059
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1D8C126;
	Mon,  5 Feb 2024 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SuiX3Tz/"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E845BE62;
	Mon,  5 Feb 2024 05:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707109248; cv=none; b=O3ImWz3eX0Y+34D41rRflUOYiNWR7c2kB8qWwvvLOfEcUmZ18yIAiDK4pFPTDnNScZivsarM2FG3v4pNVXEea0YrFne28MsSmcNvRkh5PWgg1gch7GoDEY8Yt7Up4SzLhtMRtBr+h5CY2lcZHGYV08KHGKCHXHMaKvGCrdFc9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707109248; c=relaxed/simple;
	bh=l9w/yA8U4vmZadw1HoePjP3jfyoZVoTbiYmxwvyIlzs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=X0BG2o7kgrlnRiPXWTVlaHHG1tEUtKYuJ3AFpqu32Un5i81YSscYJB1lQZWjbcGMv8rCytN/swno2RNu+RYQ/ME2Ca3emtwQMy6FydR9+M5Mhk1liD0gJ5RMc2LFeWsoUylsMxjijVH+RSTn0/AIzFr46K5UUCoHnYKed1D+RWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=SuiX3Tz/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707109244;
	bh=/ccN937hD6XYNaNyOJszgCTqpZ42hgDndlG8P/4T2Zo=;
	h=Date:From:To:Cc:Subject:From;
	b=SuiX3Tz/OmIFzfnd1OpbDM4+lMk2YArd6+tb4lJsWRvGnTjtw2Jy4X3kVOfUBOP7s
	 JarcuSVKXLEpmZYLWvllxiDX9I+ajcfhv+diD3H8ou4hz+5VXFV6W/C8+qfO99RTZJ
	 VHQYaIG+NgGdMlJFrppy2s6qNC3b25HOHCkK29nDI68iaKaVG570XD0NmCFTRINfyL
	 QtKedy55H3PbILe+dxmHvXjDIqJdIGYm7nCgJOkR56HQAbZ2fvQHPDkCaaiPv6VTRA
	 Ligej/tx6EZOQZ0aVimT8dz54wPu9wC6kbqeI4NmfdyUZ8R6azZ0o9GcEbPUZ+mx4H
	 4mN7EzOOLOsjw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TSvMv5d0pz4wxZ;
	Mon,  5 Feb 2024 16:00:43 +1100 (AEDT)
Date: Mon, 5 Feb 2024 16:00:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Meng Li <li.meng@amd.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the pm tree
Message-ID: <20240205160042.2e1cffb5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FTAiijfYv=UT2h.K8j+sLlG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/FTAiijfYv=UT2h.K8j+sLlG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/admin-guide/pm/amd-pstate.rst:384: WARNING: Title underline t=
oo short.

``amd-pstate`` Preferred Core Switch
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  3a004e1fee4b ("Documentation: amd-pstate: introduce amd-pstate preferred =
core")

--=20
Cheers,
Stephen Rothwell

--Sig_/FTAiijfYv=UT2h.K8j+sLlG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXAa3oACgkQAVBC80lX
0GzOmQf/ZopHn7aeW37mCHA81xMojTBJXQH254J8w9JwyTyQtJPEd5RfCpRYGoeB
kOYsgEokmFdmRMeErand4aMjcKGy/fY5dt8JcAnjjSvWHxl/IEHAHfCCk7u6tfio
HOsd2z7HZKDUBGdY3aNqTua0tyL+VjhTqk9JNUsEceOGgR4QxzY7TJSly1fgr/Kn
RBBzudkke5ArS9Gukzk04OUiRWIHgHeyaD0dGexLv9VvE6SWoh3+xfOuC5G9R1d6
gAz0o7Hkp3HnShXfyL83FZVd4qTTbaA+EBSxcqtsPFXetFACpLGT7ZTCMlr5DAOj
NEdRpEFBTv6TpflVpQjsqO5pIahDRQ==
=golh
-----END PGP SIGNATURE-----

--Sig_/FTAiijfYv=UT2h.K8j+sLlG--

