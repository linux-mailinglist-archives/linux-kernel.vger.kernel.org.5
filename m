Return-Path: <linux-kernel+bounces-62933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F27AD85280F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3163E1C23154
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5962911723;
	Tue, 13 Feb 2024 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pK0tkVky"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6C111A8;
	Tue, 13 Feb 2024 04:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707799765; cv=none; b=lSwaq1+8KOXyGMNrxObaFXIyxo5UQqfnJ3gA7xLKF8vzehTodNHS1t9aglEsU+5d/dzVF2G0QNJZJjoDAUIGJGhLgHuNMXgva4NPBGT4DdRmM1Q+QA8ighL5KgR+cAVOF/5E3C6bGOjkPF88eWmoA1s6Erfu4sQuMiEpQLPV9ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707799765; c=relaxed/simple;
	bh=TALgT7aSoIQP78sl0GtaQ1oWhVItTFTc+ox6sTQD41o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Mm0zTmDOozWdXFFlGUmioiQdbS2NlJHwGxYcZC/Tsev3hDaHZ7fWeXka3/X9t+sOdO1r3JdkQ4g+MKLdaB9fd3TJaMQbsqWGdQsendfX+tfTJzSXuEUKYh6PhJgXxsFNYaBmu7INZtcYwrWt+wzDxBha3cPHJlfnxfG1RDqMWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pK0tkVky; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707799758;
	bh=IHYwzgJ2UeK0c9Ln15n91swWkHRee7UO8KszCl6sh+k=;
	h=Date:From:To:Cc:Subject:From;
	b=pK0tkVkyY4SwmF6xgxwzW1Ay0dYLB/B6uavUkqAAN2O0GC1r1A6UR8/OJDfyk56OQ
	 G32wM0+K20BAx3xlIYRV6+WzT2AsLl0KQ9Tricjidmc83Y04Fg+6zYqo7BIpxaqRgR
	 EA529SxCo8Mxoa/GQI+G1ScyiVbDM1MDVQP6zpp2d65rGIISp0koShKz84im6b8+jb
	 YVMIXr61ETM3denAdal/kwVrq0D811bZN3uC92iVf3iuNhMb40wQc5Vx/Z1TrfscpO
	 /QcXK+Q3seoopNPJnfo8DDFrltPjWQyvhI9OwXM6CIABVXdyanv/eNnNfcsaowsN7T
	 CI4m7Yt1zWWfw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TYpl20Xh5z4wcH;
	Tue, 13 Feb 2024 15:49:17 +1100 (AEDT)
Date: Tue, 13 Feb 2024 15:49:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the jc_docs tree
Message-ID: <20240213154916.39f70814@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T1_U8_AvpOqvZU35jbTwUGx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/T1_U8_AvpOqvZU35jbTwUGx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  b37c416b28ed ("docs: kernel_feat.py: fix build error for missing files")

This is commit

  c23de7ceae59 ("docs: kernel_feat.py: fix build error for missing files")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/T1_U8_AvpOqvZU35jbTwUGx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXK9MwACgkQAVBC80lX
0GyiKgf/UwrXZl0tjD22C6dJQhzBvNdR5RgkecVFmN8rlOwTjiVn/22/0L06H4lL
0hsMVJYgbUEyhaYpOMtBgur0vanXA+QWsx/UJAsgaWchJr7uijpFJnUzHVrb9tvL
PFv8qt0dhby9bVROO6/rq2qZvKwrLORNKjl5hMar0HGMgfjs/OasTIACVnHoAFkM
QuZKvKCP7MZCpxAImhCQL2p5TIpOhHNUWdxCxCCX/rZsrfCrHXq2U7UcyhQ5yzgI
sKrIRBPccIrISbFRNAP73cEEdDDAx9XcvYce/o7ZMQEyAmYld1J7AR6E7VVZByHK
urVxXR+B0bxnW1CFIos73SACMJ7TkQ==
=4nOx
-----END PGP SIGNATURE-----

--Sig_/T1_U8_AvpOqvZU35jbTwUGx--

