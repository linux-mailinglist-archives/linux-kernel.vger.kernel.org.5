Return-Path: <linux-kernel+bounces-70681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9563E859B15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DC52829C1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876CDEAFC;
	Mon, 19 Feb 2024 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qcvh9G49"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F387C15A;
	Mon, 19 Feb 2024 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313992; cv=none; b=XaK+/OXGPzatee6LumX0xkw2N4cPoZ0yIVplM3Wl8HDDxUx6pgFpmLWpgrOe/x2E5PKKrTDgCAWHdWLMIAQm4NU9EuGyOe82kibfhC5UbUc+R9O/5V83LOLm+WJv2aaSIg7LTneuANNO+fyxnbCV854lodZWns2yG0kDoqToxe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313992; c=relaxed/simple;
	bh=fxhi+GqlErvj/43tcOJamSImC1DKThuSTHYdimhH9l0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aa2darkmF2+uF1gXR1/VdAXAB+l5GKYjSPWOvKxfstS4abH8novAilTgHUS+ITC5BbptWwkRdj2BVEzGhsle0QS3ZpdznWRoyveMMOXIRVt1oSmh5QU11svHIQQeQ29wTZIYSO2LXR/9/Ajmw66BIdwA+mkhj8J0rHwdCoXX5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qcvh9G49; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708313987;
	bh=TBNt9NsUlQ6Z+jk7YwoAOPS6chuqkcUdtoSLrtBERHs=;
	h=Date:From:To:Cc:Subject:From;
	b=qcvh9G49iWJ6vri1aZVNujcfSuhdLYDD4AfCGl0gtLDQal85rPvOgJfiCnpfGFL3d
	 UfdUxZDOKCQ9NWShfUxF501nSpT23hPdNYYP5HT8vuUa6iXpLJ5Km9gj82yWSO69ia
	 JuGgTMDUalJJJMbeH/cvD6XtlMR8UntC9sBUwI+LC47QUK/W//AovHtCbpaHR88ftO
	 Lcff0HV945m/M/WS4SCppNhpEHDa1WzBqn0oZ5BZI5+mYAe+KiVBsb0/tDNg7ZtO3r
	 a4tCj/InbA4WP4Dd24Sf+9y+iBH0BQQJIpCbkpIZFAp6pCeW1tjScbaYm7kh+wubdj
	 bLNQjgbO0PSjQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TdSw30zm5z4wcK;
	Mon, 19 Feb 2024 14:39:46 +1100 (AEDT)
Date: Mon, 19 Feb 2024 14:39:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the iio tree with Linus' tree
Message-ID: <20240219143945.1460f25f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tXUY7csCIFfpbDRm+l9Nm2f";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/tXUY7csCIFfpbDRm+l9Nm2f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iio tree got a conflict in:

  drivers/of/property.c

between commit:

  8f7e91790738 ("of: property: fix typo in io-channels")

from Linus' tree and commit:

  fd4464d218d5 ("of: property: add device link support for io-backends")

from the iio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/of/property.c
index a4f11b2f4ff0,ec914e4516d7..000000000000
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@@ -1222,7 -1244,8 +1222,8 @@@ DEFINE_SIMPLE_PROP(clocks, "clocks", "#
  DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
 -DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
 +DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
+ DEFINE_SIMPLE_PROP(io_backends, "io-backends", "#io-backend-cells")
  DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
  DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
  DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")

--Sig_/tXUY7csCIFfpbDRm+l9Nm2f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXSzYEACgkQAVBC80lX
0Gxrqwf+LFEm+rBw+Cy1ERMoexncey7Vz4sKhU2GMtIO7+QqSJVyz4PN3eoPG3JN
687ngTCQdvbWSGWtvdAiijYF9PK145d8p6s0yFRydJdBl7o74M15WnFah08CMEf9
W8rWAQssHK0cWYtcODKIGQQJZuSXvql4wnFcfGIDTRgqMUuYlp2T5s4bIarF3wtq
30uiKte8N08Wn1ZwIYc/2MId5Msx8wxG/62o8kVaNIHgxCTl7GZdBc80A/sce+f4
qYdOW7InP89hJp0LOZWLUxN8dltsKtQ3ZmSMZG6BREg9ZG5iVS9QinlzFagczXWk
/xj/v5+LsLEJ8aTlu1zx3qNg625pTQ==
=4GOt
-----END PGP SIGNATURE-----

--Sig_/tXUY7csCIFfpbDRm+l9Nm2f--

