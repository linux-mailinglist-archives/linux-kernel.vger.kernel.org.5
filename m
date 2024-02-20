Return-Path: <linux-kernel+bounces-72272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C171185B17B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 620B0B227CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C4551C2C;
	Tue, 20 Feb 2024 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GMJB2Ur/"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66DF4597A;
	Tue, 20 Feb 2024 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399912; cv=none; b=HX40tM0rh49MfVGBPhG7iNH1laQApvatOveTFL3dhJCkA1KovH8xwXM7F7JMDJ9hzGY8MdYwC6kijBHWcN/v2ZcStgvWrEBK8WYWSI3X1yAfOMlb17P9Ikr+VVrr16XBHkTUQ6tMqWhcH2ubkQSQDxu3W9ERMlvgeik39PPb7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399912; c=relaxed/simple;
	bh=cIDbGSIveSzcFeROhmIIsKDFhOQPG4wJw615tBNccO4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HD0Rwf+LTS/sxh1nOMI/MpBKFyjMwcbVRxkDB4aUgcpM4Ryz8deXDz5zM/vjt12qjuWJtTdI13UrqiGarT14znj6OUwYSpOrtsbJZYteK40Rr4uvwHrnZcgVL73xboBf9OZ/8x3XQIyY4mkbXwep8Hg1wgDOBZZ2XhGqCvessEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GMJB2Ur/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708399906;
	bh=MVwR52auKQDDtwN5f0V07528Ab2MGJqFJAwOewE/2EQ=;
	h=Date:From:To:Cc:Subject:From;
	b=GMJB2Ur/HUlYTEf7FmcrCtgXgnq05UtokVw4dxyKDvtsLtL83ahHT4AVq0MqMHmjL
	 q/+lhKQpTe1+Pl8W9FeTlqGdrOP1tvg/enGv8hRWkxBt/lVb/ZM2+EncAestOOg0JP
	 8j3N8bfadoQDlcUnK3jnSJo6pABy+Jbzw6a6AV3Z+l7hlmEVb+qwmy8+FaZhFE1pSJ
	 4v3tbwFEpHPu2ABYl2fIY6/kscwzUB+nl2kRfjJ8jxpJkl7NFvqtSN07e4JzuPS0SA
	 wJbKsXnmxAZCIDZ7Az+gzGnYcPtMLcK10ZMsXTnWfx2Pqad0zou0CAP2x+T136bvO/
	 SZye1uNitHb/g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tf4hJ6q7wz4wcL;
	Tue, 20 Feb 2024 14:31:44 +1100 (AEDT)
Date: Tue, 20 Feb 2024 14:31:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>
Cc: Danila Tikhonov <danila@jiaxyga.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the usb tree with the regulator tree
Message-ID: <20240220143142.540fe132@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ETKXXR08IR_gx9/thtEQ_mE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ETKXXR08IR_gx9/thtEQ_mE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml

between commit:

  ec29a4d9b7c7 ("dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM615=
0 compatible")

from the regulator tree and commit:

  ef6035d2f1f4 ("dt-bindings: regulator: qcom,usb-vbus-regulator: add suppo=
rt for PMI632")

from the usb tree.

I fixed it up (I have no idea if this is correct - see below) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulat=
or.yaml
index bf6336850be6,66dcd5ce03e6..000000000000
--- a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.y=
aml
+++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.y=
aml
@@@ -24,7 -24,7 +24,8 @@@ properties
            - qcom,pm8150b-vbus-reg
        - items:
            - enum:
 +              - qcom,pm6150-vbus-reg
+               - qcom,pmi632-vbus-reg
            - const: qcom,pm8150b-vbus-reg
 =20
    reg:

--Sig_/ETKXXR08IR_gx9/thtEQ_mE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXUHR4ACgkQAVBC80lX
0Gy5JAf/WM3e5honpOpti+zmKIMCKE+Or/GLaOc2n4ioEV67p/dg5dhB9zK3vhD2
EJ1UuieRhkE9RgYwTbBMnXEjBpnyBcRBvwShSl4D1tiWAtEmTzg2atUlfFILMr/M
8VZeTmPitaDR23VtJiYpeXfr0mxwt7HURK0HlpYViZhblx/WnBhvzjncw3/hRjDn
FilIXs+xN6g8UoLwLF6hDCJEblS+zu/gtt2AyhIJ0ZZqa5lh8/QYbWdEwQ73g8wM
DSwHrVo7hln7AxtJBR81yxiDrlc1Q9hIn5KkEg4OH7HEZAB7oe/0URf4Hu2NHvcX
s1aUzU09DvbdZR+5vPxzPFmi43j9ew==
=t0aV
-----END PGP SIGNATURE-----

--Sig_/ETKXXR08IR_gx9/thtEQ_mE--

