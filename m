Return-Path: <linux-kernel+bounces-80298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58806862D0D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C35F1F21161
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EB71BC22;
	Sun, 25 Feb 2024 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="E30CKMgY"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50111AADB;
	Sun, 25 Feb 2024 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708895247; cv=none; b=gvPJnbFhmSVNA7InsNjLbvU2x89/drLYo30pHspUC6YCKyFXie3qtkdTFpTM4USjPNBicA/5F6raKgAiL3EvcZ9f2IEvpVG0lANbZgb6usCE9dBF++MK001ICOTA1irXVOTXmo6cw5gS1Ybhpi2Hm0cmdJLBuidZhuITNUnm9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708895247; c=relaxed/simple;
	bh=o097sEqDrILFUoNzBMUb+NKy/zg4ACjzY86LefdBNmU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RCEAsPQCdibfhglXOuotH1h6Zz5QlxWNCtIqWeSPO/2BhZWTuMVpX0erMRcCLyGdHN7z/x5gFJNBwuVhr+MXPGjQfrxnOTpbMbBcbgvrtJdh7OBMjtf9l/PiIhcVeaWbU8wH16UWI/snJDT0M+nfpda9fjVMlnDNz2THXrOHqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=E30CKMgY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708895242;
	bh=AQlCg+WzHurCweCYi5CbqdgBbgMPPb2CKw6i89pUfpw=;
	h=Date:From:To:Cc:Subject:From;
	b=E30CKMgYOflFWLTOE5mDEJQn36lbdAVmhpO6IJoeeyuOVfuPVSm37NK1pfbucTb/S
	 w3Z1A60loa8+DkP02079EEXnnBSsGioi4Oy5rMFryCyqpnfyrE+bRw3s4WJLoj8eRf
	 EbDl9WdklLvcemD0L1mLv1uSel4fm9LZcERZwbU7nGAQyiQuaRDDv6y43+QZ5U17hu
	 CrbuKfZhRp++yu13zNaiBaHiKLC4IK/iZPDpUvA77TWsmTBTS56zJoCdoQLmQNkTI2
	 tGXsyoum95B9EDJ90M5z+fRooBUAGp/n6JSz4hfC8C7Q+d2gNuzLb6CpSkYJPCT1KA
	 SO7IEox7W3RVA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tjbt24Fk1z4wbQ;
	Mon, 26 Feb 2024 08:07:22 +1100 (AEDT)
Date: Mon, 26 Feb 2024 08:07:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Conor Dooley <Conor.Dooley@microchip.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the riscv-soc-fixes tree
Message-ID: <20240226080721.48140d3f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IGSJQc0XOkmixo9y42NL=uG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/IGSJQc0XOkmixo9y42NL=uG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  8bbccdd8c264 ("cache: ax45mp_cache: Align end size to cache boundary in a=
x45mp_dma_cache_wback()")

This is commit

  9bd405c48b0a ("cache: ax45mp_cache: Align end size to cache boundary in a=
x45mp_dma_cache_wback()")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/IGSJQc0XOkmixo9y42NL=uG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXbrAkACgkQAVBC80lX
0GzWNggAgEVQvR/mqhM4nbfAzkRTQteP8cBQe3z1mj1Z3mJZ5/9L4lvsqYtkyewB
GkSJUCkS7RNRv07+0UhpTyavxvgq/JnI4d/MErzhZQMOXU1bOlgSonhmIKkkw245
+9GEoMnE/+pRLprZnqiZGQG6NNDtSOzDQJVhS9wUs9+HJ2501mrHEBiNWie72DNz
3u+KG3F4D8ieB+VZBBawipJGjvAItBTveG/LEmq5PMWV85uoQLgT5O6ownbRtjW0
bMV6dTSYQDowsLr9H2+67dI94UFdEHY693gREOvhFcpwU2RrNCs7XmpJlBHNdn05
0oQ2EmrLvNG6mQ7+AMrZ3onAW2lflg==
=S1/K
-----END PGP SIGNATURE-----

--Sig_/IGSJQc0XOkmixo9y42NL=uG--

