Return-Path: <linux-kernel+bounces-3013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7027F81661C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3003C1F21798
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51FD63DD;
	Mon, 18 Dec 2023 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AWD1oy6q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7D63AA;
	Mon, 18 Dec 2023 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702878493;
	bh=6EkdkOoPvJi8d4K4K1G/cZM8HRKq5yRNGdpX+aZ6Yjc=;
	h=Date:From:To:Cc:Subject:From;
	b=AWD1oy6qUt+uq+WdrOBJGVSWoBWcE8iN1lRseSLkdXdjT3Dg3RBcRkquxcNNR2ptw
	 Zt1TNoLujVn4cH9w0TxgFERKNiNColD9ZA/9jRILLqgRBICquQAH+j6Cjq2Qc9M6hq
	 WLT8ZHQo7NH+2fN0Pry2G0wS+DjuEwrs9R+K/zA77PnUIHXDsjwK0oxdupHDk+OHwe
	 zuIkPvvk+kgwTSwqA88mxNQhR0OWitMux3EKrMjRhGSpOnwSST5qHBurWXdkJhqQH5
	 65SXfU+sMNw+vl7fCYHE2o/Mw1h3ilsRKFHKaWT0aDrm2Q1CV+m4niwetyib5PAG5T
	 vxAT3EAOu87VQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4StplK15nmz4xCp;
	Mon, 18 Dec 2023 16:48:13 +1100 (AEDT)
Date: Mon, 18 Dec 2023 16:48:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robh@kernel.org>, Greg KH <greg@kroah.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Kyle Tso <kyletso@google.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the devicetree tree with the usb tree
Message-ID: <20231218164812.327db2af@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TpXr3zQnUF_Qfml_0=hY_HS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TpXr3zQnUF_Qfml_0=hY_HS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/connector/usb-connector.yaml

between commits:

  76cd718a9ffd ("dt-bindings: connector: usb: add accessory mode descriptio=
n")
  d1756ac67e7f ("dt-bindings: connector: usb: add altmodes description")

from the usb tree and commit:

  0d3a771610d0 ("dt-bindings: connector: Add child nodes for multiple PD ca=
pabilities")

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

diff --cc Documentation/devicetree/bindings/connector/usb-connector.yaml
index f5966b3a2d9a,5a93cdb9fdbc..000000000000
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@@ -166,49 -141,6 +141,44 @@@ properties
      maxItems: 6
      $ref: /schemas/types.yaml#/definitions/uint32-array
 =20
-   op-sink-microwatt:
-     description: Sink required operating power in microwatt, if source ca=
n't
-       offer the power, Capability Mismatch is set. Required for power sin=
k and
-       power dual role.
-=20
 +  accessory-mode-audio:
 +    type: boolean
 +    description: Whether the device supports Audio Adapter Accessory Mode=
. This
 +      is only necessary if there are no other means to discover supported
 +      alternative modes (e.g. through the UCSI firmware interface).
 +
 +  accessory-mode-debug:
 +    type: boolean
 +    description: Whether the device supports Debug Accessory Mode. This
 +      is only necessary if there are no other means to discover supported
 +      alternative modes (e.g. through the UCSI firmware interface).
 +
 +  altmodes:
 +    type: object
 +    description: List of Alternative Modes supported by the schematics on=
 the
 +      particular device. This is only necessary if there are no other mea=
ns to
 +      discover supported alternative modes (e.g. through the UCSI firmware
 +      interface).
 +
 +    additionalProperties: false
 +
 +    patternProperties:
 +      "^(displayport)$":
 +        type: object
 +        description:
 +          A single USB-C Alternative Mode as supported by the USB-C conne=
ctor logic.
 +
 +        additionalProperties: false
 +
 +        properties:
 +          svid:
 +            $ref: /schemas/types.yaml#/definitions/uint16
 +            description: Unique value assigned by USB-IF to the Vendor / =
AltMode.
 +            enum: [ 0xff01 ]
 +          vdo:
 +            $ref: /schemas/types.yaml#/definitions/uint32
 +            description: VDO returned by Discover Modes USB PD command.
 +
    port:
      $ref: /schemas/graph.yaml#/properties/port
      description: OF graph bindings modeling a data bus to the connector, =
e.g.

--Sig_/TpXr3zQnUF_Qfml_0=hY_HS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/3RwACgkQAVBC80lX
0GzA7Qf+Lo4E+AtV95EJ9wbkn8X8Lqlfa/tf45BG+CiononD0HBknFipzc26RiUa
ap1lzfDg9zzP1CRStffg5XzLxBJMloENVGjT/biAk7JEg+tqBZ2AGwDdKExr7Qdn
chiH7vscqgGi+JO8i3bnz+OLxZWRIYL8WyQ9f1Hjo+0e3non32XRP+rN9Wn/M3v7
emgRqvEQENj2Q5WpAFRdyIMLBS4IXN/0NvQq1WSaA+P9ovqVlXwQeLs4dMXL75Yc
KrO3aHAQ7nICA+1ToeERvJt9abAHUBO+6+PDDn7qAEqQuIGYDm63mDh+l2F61M8b
1Y++4qOl3wY5s0G/9CEULRGDRe2NIQ==
=9+k4
-----END PGP SIGNATURE-----

--Sig_/TpXr3zQnUF_Qfml_0=hY_HS--

