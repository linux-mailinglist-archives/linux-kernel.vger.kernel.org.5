Return-Path: <linux-kernel+bounces-139396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257628A02D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530B41C21DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71A518411E;
	Wed, 10 Apr 2024 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S/cTebfQ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB0181D19;
	Wed, 10 Apr 2024 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712786793; cv=none; b=a4SZ0EbzDK73QRP42v4BL6jpwNuo6hkoFwxOv8/DMUKQgPVOivqZCMMlEeYoCK1uUV/zRNe0FYe6rgFXKb7Fwo6o5SPsEjHQqgK3ccs7IjNiROWIqdkfLt/nA+SvJO0e7cpUTHFDHgN4BXwDdBS0kJTi4txKILJQ3EONQvRcB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712786793; c=relaxed/simple;
	bh=tzLPNab9cDBFOQCIOfRPLvL2TorxTyJquEWfKi5d7vo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NPZIynYJKs4/OKIWBDk+9sI1fEJO9dBzkfdwsS4HP89uzdmwCnndxxtVkX+JuHp404Q+ApqgIJ/TyHSeQ0bVQ5BxId82rdUCdSMchg1QffiFXzhp75IwCjGyQXjyXBcprIs7IAIBRvTZc/5pLiEBZLhj2nRXWTTBRW9UWpd/ZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=S/cTebfQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712786786;
	bh=v3Ontk0G4uRvi7NlVfYwfRYBBad9zzz0t6yR1UdbSDQ=;
	h=Date:From:To:Cc:Subject:From;
	b=S/cTebfQB4U9fGaSOyhAY8N9JD/+Xb/yHrRJKS616jSGXjhkSRAv6N4D9VjCv7ss4
	 WX+vxPWGCu7WCKS5lzfQKvNz0EW6kMGMfXLsug+sY6SQbx+OPcurc3Qlejt+J0e0ST
	 YtVsdfTG6w4BrqJKWIgokjoe0/UmdKEhRCoRS5DURmaAOLzO8Jw3dNCPT7N9Huaf/f
	 Xa5ZUFqxZtk81U/6UXX9U1G7loqf9vKM3vRI9B/FhQR8qyMyZsCES/glzPB1659NgN
	 82xMbBxwTWBtpW+CQKwFjhKo3xsVi3bmmu/dMDitV2kMaXKlNtbCiAVibnut/+eshe
	 YcLuZre0tm6tA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFH3P0MKlz4wby;
	Thu, 11 Apr 2024 08:06:25 +1000 (AEST)
Date: Thu, 11 Apr 2024 08:06:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the risc-v tree
Message-ID: <20240411080622.0cd5502c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W7W8oCSC46HFikN3UWuV3vZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/W7W8oCSC46HFikN3UWuV3vZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  36d37f11f555 ("export.h: remove include/asm-generic/export.h")

This is commit

  0316e4b04e01 ("export.h: remove include/asm-generic/export.h")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/W7W8oCSC46HFikN3UWuV3vZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXDV4ACgkQAVBC80lX
0GzfDwf+LuuUAfFjnC2DXK+RvYe03U8eVboGDb1AwuG4HaKhqSwHzjgql8sGO5OK
FYXQzmHLEplpTJYT1ljdgq1YcPe2HcNNvRo6CrS42MjAjdSDWC55FZ/QfNxIfYr1
YOojGI7eAXjeky3xZO2VI/gWckcQPnfRNvo/43wGdxfIQqKdDXlxWAVaxrbViwfN
Q3bDuk6ZFDxFP8WpR92s/wrSR0vUeWFoULGQtueo/jJQB2lpIHUQw/BkLosobwld
PRbbL1DmxALcIITQnTgQAFkP8YNTas9StKfEFPw70tAqka6kZKrztm8OGDx7Leyp
TyB6kRNxDiUrf4s0gNubLSHhd/oUEw==
=s9EW
-----END PGP SIGNATURE-----

--Sig_/W7W8oCSC46HFikN3UWuV3vZ--

