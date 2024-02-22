Return-Path: <linux-kernel+bounces-75905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F418985F07A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32B81F238F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF37D1C14;
	Thu, 22 Feb 2024 04:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b226THhz"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670F10E6;
	Thu, 22 Feb 2024 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576715; cv=none; b=vC38pq7AFgw9ukYPVSQOzTU5BMtwluvv+6pZCY93vCM2wMhrOHEjQSMco+la/u9K7TwJdjcun5Cxk2Vkz+gW4islPzPcpnh8k/HSH9kwq5Z15xtB4gt7+yaGu+zWjuPugiCA5m+6sZdkVSo5utnXW9Uqbqxims+cd1SC5Ev4ghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576715; c=relaxed/simple;
	bh=YyiHPo6lpjIRrcpkojOn+UeZ2kGiQoAWAAYO9zWyQ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XVPbtAB1MJxLkhaxeabdZ+SayztcPYs78XnhBQ1Eqt8nQvmloEhLgg5JIsFeXZ5o297TncDYdj4RZDJSMSKp4+UnxJShC5+/lNvfSyiIuT64yHGxPSBpd4GHQRG7Xft7rzJ/YsCaHrf41cov0/A1I9h1kqvj5f4rGUWN9JUZZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=b226THhz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708576709;
	bh=U2MzncGXbDNzCtp+gQ0mCYGLNdNGYclqHp3bgczOtZw=;
	h=Date:From:To:Cc:Subject:From;
	b=b226THhzDEKCWHO1KuzBnZPQiqyJboqL3m3KC7VLI7ej3a1Hxxc9zVoOrVSHDj3JR
	 ey+/KdHQf50s8kHSiAsSrdAW8oJgJN+x+m6oKxnSDPlbvFQ5inEHJtyuXGvE/cLDzd
	 6dPYXcVWL+dWwoc52cO93HVv0TV3fwZbU59CkIor/7ExXTdW1qNNqQ6qJVEpFPkhZ8
	 752nYisHwNqZEdmrVGuxwq338eKV+iiiSXT76vNnMB0fQEBihsPxrxPYu3YatAicf/
	 tPhPakIxzKk9QbfK1aey5ibTtdEtUQUYBIYOtoRjERmwLhH4508JmJe5sSirqUk+MY
	 VUH4oUYOJqUuQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgL4N1bPmz4wc4;
	Thu, 22 Feb 2024 15:38:27 +1100 (AEDT)
Date: Thu, 22 Feb 2024 15:38:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>
Cc: Danila Tikhonov <danila@jiaxyga.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the usb tree with the regulator tree
Message-ID: <20240222153826.3f7eba10@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z2LrkZarDBZRFQAea+V8Pww";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Z2LrkZarDBZRFQAea+V8Pww
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml

between commits:

  ec29a4d9b7c7 ("dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM615=
0 compatible")
  b9262cc1b988 ("regulator: dt-bindings: qcom,usb-vbus-regulator: add suppo=
rt for PM4125")

from the regulator tree and commit:

  ef6035d2f1f4 ("dt-bindings: regulator: qcom,usb-vbus-regulator: add suppo=
rt for PMI632")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulat=
or.yaml
index 8afb40c67af3,66dcd5ce03e6..000000000000
--- a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.y=
aml
+++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.y=
aml
@@@ -24,8 -24,7 +24,9 @@@ properties
            - qcom,pm8150b-vbus-reg
        - items:
            - enum:
 +              - qcom,pm4125-vbus-reg
 +              - qcom,pm6150-vbus-reg
+               - qcom,pmi632-vbus-reg
            - const: qcom,pm8150b-vbus-reg
 =20
    reg:

--Sig_/Z2LrkZarDBZRFQAea+V8Pww
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXWz8IACgkQAVBC80lX
0GwyJAf+OGHW0sj4omPVHNpX8Jv9mzrKQSNdi7VR8VfVyEB7Vut8/qXdBuHxqH3S
rQTDE9OcWvKsv3QgL78oMMVqKraw8MhdVCdVfevtninI75jpnHjPW0nE7D6+W9Ez
L4gdqWv2DFmQuufHGs9J59glcMxKSTvqy4fQpFKkCB84kckitPm/2pdfwj7Tk8DP
Waw6Hq/c0vMQdszRKrw3JtJoDoXYhXY80f3OuEwAd8HrGbXCuer1tq6UK/8EOyvC
aLcMq5MmX3iJ5Qw/lKmcBmmMmRwVKU2mBubTYB2zhthue4whvKxB3yy8+KojlpCr
FFPNE+/FETXgFEV1rT4/SZM0ErAdJA==
=ktSN
-----END PGP SIGNATURE-----

--Sig_/Z2LrkZarDBZRFQAea+V8Pww--

