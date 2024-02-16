Return-Path: <linux-kernel+bounces-67986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71198573F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA421F22969
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75590FBF7;
	Fri, 16 Feb 2024 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aoq1wuo3"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778F1DF58;
	Fri, 16 Feb 2024 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708053075; cv=none; b=BWiaYfA//yVeM1YR3byBh4uGPkd/H0sU3lgzISfdeF3ADEBKLbtaQ9qPeoEyEvnbZB4vRWjcsx2Tsk0YyC66EUoYvIWCjKip8TgyvusSsRLqpzESmeYh4kzqFIu2lFcqF8g2izhF7r+o1lDbzQZ3VAGWRgi3i2wLMAwDhhKtUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708053075; c=relaxed/simple;
	bh=255anHpEUFk/gSI9Ws2TxhyYTTQN5rCLXpeTmNKYgYc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mA0DfBTEASjopatkNCawFJlrYHWenUo2Qs1NdSZWlMA3aiPMfIfUT2lok4IwKTuLuxe3yIM+Qmj1QZCcmlXMZKd46ytgu8GOwWq/rSyqL6Z5WfD67AwObQvsVSc0KJN/jMAzZL5ytcqMtlrqH06zR/XSPwcui+vhoM5X4zl7cUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=aoq1wuo3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708053071;
	bh=h6O0PTL8V1E7B5aSsOjIKqVjqP8hh0cL2eatGAHCFm0=;
	h=Date:From:To:Cc:Subject:From;
	b=aoq1wuo35NJmsiEbk0oTETv4y0pj+ZI3DF6r7eRPCS1M9W/sPV49aH2pySAdKBVI2
	 eFSL193SLWat+qrgv8Uvrj7grma0knW7+JbNeJhVGX0Opy/oyIEIZQWIdlH/zBODiM
	 wk1xY5cN3QSieTG9urY3y9SOfLplLGBidlNbMXJ4mJ1/FH5ELMVhigezqAV+dML2va
	 bAt180bTwB0owFeE3mb2r3Q5RUuPcXLSeeNMqRU2j8Opd8EyoJLQft1hL8/g3JEpxw
	 if7JB4mFNk4oOOvjMD7ocgYvV4U+Oi2cUp6Xco6geYjwKqZZ0cZl9rWq1BJtWbpmeA
	 5jKJN4fEQbznQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TbcQR0m8lz4wnp;
	Fri, 16 Feb 2024 14:11:11 +1100 (AEDT)
Date: Fri, 16 Feb 2024 14:11:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>
Cc: Dhruva Gole <d-gole@ti.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the spi tree
Message-ID: <20240216141110.7819d939@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5hvRLO_JClsApL6+A0cFJfL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/5hvRLO_JClsApL6+A0cFJfL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the spi tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/spi/spi-summary.rst:274: WARNING: Title underline too short.

Declare target Devices
^^^^^^^^^^^^^^^^^^^^^

Introduced by commit

  99769a52464d ("spi: Update the "master/slave" terminology in documentatio=
n")

--=20
Cheers,
Stephen Rothwell

--Sig_/5hvRLO_JClsApL6+A0cFJfL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXO0k4ACgkQAVBC80lX
0Gx/DAf/SaOBycm+MnyWAvUc/Xi34bSkq6N317I8FRQRzUdc3PIsyWR/XdONLb5E
xJihEoZ+PAcasFOGhXOlhDdFovHvH/5fnIrAEusEbNE5rxBHIXOoN4bTVwKm+1vG
eIko7zyuAOSflH79C2+JRfYNektrvscC4L3ohF/oPomVgWFerz6/MGnj0+05Jdpt
jeUeerQCHqyF+C7NldEbcC04Wub/IZAdPLU5TnzE/R3sMkFARMThA9sa7vMgOIKh
YOBDou//7QWCmDKbNC2zJs2nxKt1/0N8+oBFLrWixYnR2WZJifeRXmjCvZ/vzwAH
RSIUen6l1n+OCNyRhwEl+NBB5I64Dw==
=rN5t
-----END PGP SIGNATURE-----

--Sig_/5hvRLO_JClsApL6+A0cFJfL--

