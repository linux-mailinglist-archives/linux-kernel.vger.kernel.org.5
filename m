Return-Path: <linux-kernel+bounces-80296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3148862D0A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5E1281901
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729DE1B951;
	Sun, 25 Feb 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lIv6pxQT"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4751B947;
	Sun, 25 Feb 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708895098; cv=none; b=cSoPMndXjvElmFo7wST8w1gx+RU+I+fgTF452LKaIKExYEaIwLPgJAgutR6gtw3E9t3YeygzNrDeVR5SUsJSLH+kjxqICB8x7H5yW/VFRRKwZOhsev3ojlIcqEWgF9L3LNubXEJ2nCeDkJnGdr0HpjYgL3PwpoHNoNcBqBQocZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708895098; c=relaxed/simple;
	bh=RSL/67H/EUpZBqOvi6K64lC2jK3bG/Bi0ireGuh7mb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q6OIP4FMFh/z0fr9r7//IhNGBViV2ki+Q25wjjvpLBaO2bM7q5z/tXhLkZQvxlx+PR9y6M6ED3AYRPJ+/m4w4xLrR3mVnGAmhU21Feq+XwhZmgw4B+MNV4zkVFdVW/HqZDFowPEC8a8fDaW/eBT1qZKzJlvhj2+GBGNNXAaSyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lIv6pxQT; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708895093;
	bh=EPfK7CX31nVxVvjvEPnbD1pNwyzPfPgddrAQgDc0GD4=;
	h=Date:From:To:Cc:Subject:From;
	b=lIv6pxQT8cOtFsWALK5mnAVHKo74bNqi8MpFRKvc+QEnmupamZdgS6U3Dspeb06Jk
	 IBwWdRFpGK/KRfklTkzGf1rlcpJIltLoqwpwRXUfUk+KPxRUD/irWJ0ly1+F9cV/gq
	 EiRnAIzXBI6AAvVJn9rTN12OSStr6GmY/2m0Z2tIIjqexgqSN4Nv3fdJDH7EeSIZGi
	 exn20BpSNxaViYWz/uo62YEdXntRvzCDAcLj4h7hre4b3brSu5MabbN3ka3GGwjngY
	 5IVLGdk/DkVqYV9qxB0dC/FkB7YpG4QF4MZn4ijcpJLgak/7WdtZeyRXgS42sTowlD
	 j4HxXx1IDltBQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tjbq92Wm2z4wby;
	Mon, 26 Feb 2024 08:04:53 +1100 (AEDT)
Date: Mon, 26 Feb 2024 08:04:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the cxl-fixes tree
Message-ID: <20240226080451.40829f1d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d+9UNO=VtfD/QoM9nq6+10s";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/d+9UNO=VtfD/QoM9nq6+10s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  d08431235df0 ("acpi/ghes: Remove CXL CPER notifications")

This is commit

  f3e6b3ae9cfc ("acpi/ghes: Remove CXL CPER notifications")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/d+9UNO=VtfD/QoM9nq6+10s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXbq3MACgkQAVBC80lX
0GxBNgf/c5Oythiza2Hs479MoZymFrkXS8x+d+KHrFCu0fZxh/oCDtJFI9MdhOkH
DAw3XyJ/DTDChBRF5OhuBtuKLp0tqLC/uJs4lbrU6xOFULkJ0VocWF/MkdfImkvx
Nh/D2o42O+yWYLuXhomaTecP9CvExfJij+PfuOBFVamzgOIeLaMjTqd9Y3tRIC/B
EeZEbo3QXZjhJSotVaxRWhBuZjupkKdfIU64lVOQUZTsKixB84ttXofCGUPvABkT
YdCNYAs8kZBp9oz+XN146as8UiSLIXOze5LZw/ZK+DtByEeSWMoHZ/sFmydeSNsy
8XFqfeya4uIpSQQqeOWQhq5ehlcLQw==
=tYQO
-----END PGP SIGNATURE-----

--Sig_/d+9UNO=VtfD/QoM9nq6+10s--

