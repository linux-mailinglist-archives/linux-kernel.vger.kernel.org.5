Return-Path: <linux-kernel+bounces-152623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BED8AC1A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D3E1F210A0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF4145973;
	Sun, 21 Apr 2024 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZWQiPBEl"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7D1B974;
	Sun, 21 Apr 2024 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713737984; cv=none; b=AkF0zKnvgt+SN/Y8MCicdvm34GDEIzWZkKNM27ENpQOXJPeVaM3uNGwxMI3cGGP41WEwB5PpY+ZWxjki2+ZWFdPTo3oBDp1Cilrfap3wLurtJ0leaVBRhK/8mFFMRatEku0+yOMbMnfx6zzmsQP3c5qOppeC72Xh+Kzo3mCJHR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713737984; c=relaxed/simple;
	bh=gpkXFt4K7gR7pdacgPlzta7Zf5ov3LigCAFVGHtc2aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RrnnXVHvECqBrz+TnxrEDdZlUlAn1QStUoNgqQDFM7+9QUaKHVe0qSMrS8cKTCO6vui+DkvrRAmNJr3qRUM2f1LSVtvzKy0I77qffVkUvDa9BT9ZfEPyMJwaNTWjxsBGfKg5oizzpZCP96NkIw/BAv3nJ+iUlYdw0wfGsBoA1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ZWQiPBEl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713737980;
	bh=KDRWTdY/BdehO8gYSGZjXUGgjh95qAwgwfLuKoyBYbQ=;
	h=Date:From:To:Cc:Subject:From;
	b=ZWQiPBEluaoclAncRL44AJ1ntXmrOWYbttWsW2e/3ysjZqlsAJ6XFM5Bs9Nnz+51o
	 mx3E1gCRBC0DgJTD9EtorvngvhrYIzx+nc7SO79INbd1hBjp9e82hVbs7o6OgdosZC
	 sUHOK/LjNYXjhUhBqfL/1QhL7JuzBs3xyYB9oCpBTtKducuCnjL2aSFYEv3pBzjRfa
	 BIaWaezxeHIpfkkhN+/I18uV8iXNTbQoDs2Zwt0GxCzpYLu1N4gBoLKVgTxxqigpQJ
	 04WWBbiZDuMsNOCfd/LyayDJKp3OaqEwpVGrjlJagVXjZvmyBOC2uViSzowo7tg3VR
	 pA0vLofASCJqQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VN2qc04kMz4wc5;
	Mon, 22 Apr 2024 08:19:39 +1000 (AEST)
Date: Mon, 22 Apr 2024 08:19:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@redhat.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, DRI
 <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: warning while fetching the drm tree
Message-ID: <20240422081939.7d61cfa5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1XdrssMqPnKOZyM8fpylqaQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1XdrssMqPnKOZyM8fpylqaQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Fetching the drm tree produced this warning:

Commit

  326e30e4624c ("drm/i915: Drop dead code for pvc")

added this unexpected file:

  drivers/gpu/drm/i915/gt/intel_workarounds.c.rej

--=20
Cheers,
Stephen Rothwell

--Sig_/1XdrssMqPnKOZyM8fpylqaQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYlkPsACgkQAVBC80lX
0GyRegf8DG88Tc2ajFce9SaiKMtc1R291H0Yx8bJRd1QRT0Nc+bsZPHmaw8SDDYK
e880Nn6u/R6JlO/bfYezdYNIVyQZ+JTRmROPqNYvAlI/D5c5KVLyFvTIMutMQkMF
kn+7ud6Vcbn2atoikFAIKegroDdTco/alpBl2gv6bTuZ9k9T+0MGrXxtU5D31QZJ
B3EMvIiECd5iS5EStJHlM3ikKGM1lfA7lE1SpnzXJNFapop6X06ewKA22a/kGlSg
wcDyjnRDbKW/WYFhYQzGF3yOcJvOCrVfIGEVri4fXHpbuZwbszf4ptFwXEUuJpi0
qwleqOQcnIwnkKon3NNspiiBoqWioA==
=sdp2
-----END PGP SIGNATURE-----

--Sig_/1XdrssMqPnKOZyM8fpylqaQ--

