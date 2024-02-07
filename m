Return-Path: <linux-kernel+bounces-55919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCBA84C35F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945901F2472D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764E10A20;
	Wed,  7 Feb 2024 04:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sCZTL6IU"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0C10940;
	Wed,  7 Feb 2024 04:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707278998; cv=none; b=rTVUq2Kh24Q58LLbEIGbmC1TSnqvsYrV9RPjtm4OhnxlxDrgLyxCtyDL2tL/sEpbXSTB/94RYP9cIN2c8wqvQ6NQYjXrjtBPIdhfOU8XlHsUpF198LSvdEPqkKYN7QJsALz6pe+ZlqOA/bYp36suQh5FYRH0ze9IabHgldN8y+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707278998; c=relaxed/simple;
	bh=yqZqsfOuNrFhhOM0WOUw3Bhnj2nSg3Bk5pHQ5SYDzss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ha4KNPWtybY517jrkpvdWVgMIMHzPHXI9YCxnjcfYl3n6QNfXlOAbDj1lyHQNZmakw6YYW/k0md6yb4myYj3w3fmwMKNvqa/6XO6r8+jWsAOZ0tsIpKsPIrtia4a6nxR9T+5NMfE1ZD3bmmSqWcU3XxFPCGoCqMkPy3EDvIWkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sCZTL6IU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707278992;
	bh=C826NNNKt8ZIGL54VMmqCCadJzosFA/ZbZqSB/IKd8o=;
	h=Date:From:To:Cc:Subject:From;
	b=sCZTL6IUkjIp8JRujoLdXBk8pInizAMZ8hFbHe8ZA6jkUnyRqt/OS9IWoa7Wg2NKW
	 /h6wS6goj2LNAOzp66pB8nBb7hvQDxQve8r68FdLKpBrR6+3hkvaxB1y+jxS5bC6UK
	 ovj7o3duc5Ty4gRQGItPWbT6t0qpMT7IL1A5VhtDcR2AYPx/qU9VreXqCMYLmYFufl
	 k3koJB+oiXObtWvRIt8GxjmUHptmctpcbXMTu0WEwswLVbp64U0awnM33wemVX28EI
	 bOUSCr/R0FrHTbTg5jymOvLss0cu1uL/uHNTbvbHLprCciZXwSXi8GG2/J5liBkneX
	 SDCKPJX2uU8sA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TV68H4WyCz4wc3;
	Wed,  7 Feb 2024 15:09:51 +1100 (AEDT)
Date: Wed, 7 Feb 2024 15:09:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robh@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Charles Hsu <ythsu0511@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the devicetree tree with the
 hwmon-staging tree
Message-ID: <20240207150947.1f2bb82c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YfEiLhIy.6LEA4Cd5+Y6/vI";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/YfEiLhIy.6LEA4Cd5+Y6/vI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/trivial-devices.yaml

between commit:

  fd67e0c7b60b ("dt-bindings: Add MPQ8785 voltage regulator device")

from the hwmon-staging tree and commit:

  6284d33d1749 ("dt-bindings: trivial-devices: sort entries alphanumericall=
y")

from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/trivial-devices.yaml
index 842eb65e4c03,41982a41398a..000000000000
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@@ -47,10 -48,10 +48,12 @@@ properties
            - adi,lt7182s
              # AMS iAQ-Core VOC Sensor
            - ams,iaq-core
 +            # Temperature monitoring of Astera Labs PT5161L PCIe retimer
 +          - asteralabs,pt5161l
              # i2c serial eeprom (24cxx)
            - at,24c08
+             # i2c h/w elliptic curve crypto module
+           - atmel,atecc508a
              # ATSHA204 - i2c h/w symmetric crypto module
            - atmel,atsha204
              # ATSHA204A - i2c h/w symmetric crypto module
@@@ -295,6 -280,20 +282,22 @@@
            - miramems,da280
              # MiraMEMS DA311 3-axis 12-bit digital accelerometer
            - miramems,da311
+             # Monolithic Power Systems Inc. multi-phase controller mp2856
+           - mps,mp2856
+             # Monolithic Power Systems Inc. multi-phase controller mp2857
+           - mps,mp2857
+             # Monolithic Power Systems Inc. multi-phase controller mp2888
+           - mps,mp2888
+             # Monolithic Power Systems Inc. multi-phase controller mp2971
+           - mps,mp2971
+             # Monolithic Power Systems Inc. multi-phase controller mp2973
+           - mps,mp2973
+             # Monolithic Power Systems Inc. multi-phase controller mp2975
+           - mps,mp2975
+             # Monolithic Power Systems Inc. multi-phase hot-swap controll=
er mp5990
+           - mps,mp5990
++            # Monolithic Power Systems Inc. synchronous step-down convert=
er mpq8785
++          - mps,mpq8785
              # Temperature sensor with integrated fan control
            - national,lm63
              # Serial Interface ACPI-Compatible Microprocessor System Hard=
ware Monitor

--Sig_/YfEiLhIy.6LEA4Cd5+Y6/vI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXDAosACgkQAVBC80lX
0Gx+Rgf7B3DC+yo3kNIKHgG9RKZi2hpn7LX4vb6U+QPb7YFK4Q3xOA4GMKxvkS3O
+tKn3bYnyK/zz+vE8fyUm/CODcEHu2/UOMUJvTjlaYa0Q1DPraWXyRlkMZPHp5kn
d0CY6Q5N7oY8jwrxDJVoN6tY6pLj53zsDjNfIuupnAhj9wGMgyWmKN6D4Q+hGj1p
G37BnCONvSeDk+qO2o3kWUnoU8YOMm0gN8zGWtQgabp7L8CrZaNu+wunF+i/eq0u
oL0XXDbJjrX/CX7tonvGMy0S9Z2IaMRJZiPNrQ5/tW61MWecEqSq7HxlHjjySfE7
iB3MO7RW0v1u+hRNreAG1iNXvl+ekQ==
=EMdf
-----END PGP SIGNATURE-----

--Sig_/YfEiLhIy.6LEA4Cd5+Y6/vI--

