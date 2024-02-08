Return-Path: <linux-kernel+bounces-57393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7916284D7E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3AC286F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C501D52B;
	Thu,  8 Feb 2024 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OLqnm4Sc"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E241CD21;
	Thu,  8 Feb 2024 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359943; cv=none; b=p5cXTL8Y0ecfcOBdwMm88Rx6Yw7knn6mrLePluHXmipLYmWiSBuyHiksmswSIZI0RW7aKhnEPuFYojMUGRNgvrJXZDs5eZ0AxH9/A68U0ZfOiIQRRb8SRmSWgazGp1nXGh5sNXR79qvocTt0l6gRf3ckgppP5J83eez4A+4rF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359943; c=relaxed/simple;
	bh=w7w4OKPE4XQdyOY1mTyI4o6ppGWfuRd1PHiDn3TVltI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Jn+k68CvhLSVVehQOPzA0BBGnI5GBW5+JhtyGba/6H3NCzzLSDq0pgXBFwCc2fzdMB8WP43FBpP+NhY8JgrJ4NZ1BwrN50Y+tnTI9ECq+QYA3CKroS9s5uFDL0AuGRO/ETd5n8rdPyaLC82LYchlpl/8r9QX3+KJEzI7LT3c1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=OLqnm4Sc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707359937;
	bh=O/hM/ULATvS+zlv7841P46Mbj8sqxkUxtFHEQxvQfYw=;
	h=Date:From:To:Cc:Subject:From;
	b=OLqnm4ScfzDsyVIWgOHCiJLk/H2TbNEjxcISzXfiuqgBqQ+w4D+/hVMVDUP6/FD7F
	 3iqAT03KmVo+0qCun8j6+yedwLbINN8rY32I3tDefUS7q73O5S2yURxFEH+fM3Uyib
	 3yr9a1oZT3vE+xdP8cXGCRiZdAHqPNXMouCs3BL2hAzLzmxbKPMC3LPFqgW5kDF0ln
	 dfoOyZOM7+yGsfW/dX8oleIa3zmX9AhezvUeIEr4i3rtptCE3t+XPazfPlD3kC/BPN
	 RSDppLstOY36puk+oH+Od9ydGxtPzZVh/RygWNLi0beiCvaYq1dGzGf1TEQodImnby
	 4oCg38sleVzXQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVh4w6HfMz4wbr;
	Thu,  8 Feb 2024 13:38:56 +1100 (AEDT)
Date: Thu, 8 Feb 2024 13:38:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andrew Davis <afd@ti.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the rpmsg tree with the pmdomain tree
Message-ID: <20240208133855.53695262@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ubV/oSdQ66uQ2x.P757eQ2V";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ubV/oSdQ66uQ2x.P757eQ2V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rpmsg tree got a conflict in:

  drivers/remoteproc/imx_dsp_rproc.c

between commit:

  ab2ce14d02c0 ("remoteproc: imx_dsp_rproc: Convert to dev_pm_domain_attach=
|detach_list()")

from the pmdomain tree and commit:

  8f12de7913af ("remoteproc: imx_dsp_rproc: Use devm_rproc_alloc() helper")

from the rpmsg tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/remoteproc/imx_dsp_rproc.c
index d73727a5828a,56a799cb8b36..000000000000
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@@ -1090,9 -1154,7 +1090,7 @@@ static int imx_dsp_rproc_probe(struct p
  	return 0;
 =20
  err_detach_domains:
 -	imx_dsp_detach_pm_domains(priv);
 +	dev_pm_domain_detach_list(priv->pd_list);
- err_put_rproc:
- 	rproc_free(rproc);
 =20
  	return ret;
  }
@@@ -1104,8 -1166,7 +1102,7 @@@ static void imx_dsp_rproc_remove(struc
 =20
  	pm_runtime_disable(&pdev->dev);
  	rproc_del(rproc);
 -	imx_dsp_detach_pm_domains(priv);
 +	dev_pm_domain_detach_list(priv->pd_list);
- 	rproc_free(rproc);
  }
 =20
  /* pm runtime functions */

--Sig_/ubV/oSdQ66uQ2x.P757eQ2V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXEPr8ACgkQAVBC80lX
0GzGVggAljb63DY+kdUeutTRYrvB1UoW5K5Oy2D7AP9PPfw/wKew2/mK2N/45L4H
LYm8ljj/FaAnR9jGQBAut47IYHLTkT2OSVbpbM5rTtCSeroxQ/KElyQiBJHxpJPt
iGB8W9Bg0o0CZpBJ/kJxJVTB3vqMIOFoAYf7qRw9UpYOQDtg0mOlyJpl+wE5u/K5
qdmSaJg3gpTcOSzA7/u3rcStwBkAQz56Mj5+8FPKT+g8lTKphSAmI5XGy+WRzxfi
cX8Uq0XoByxV65AWahjPsuK18qxwXWJY17wrkQB8dydfEyRE0H2zwNbT9Su3Dqcr
B4NR7Z08OYgHLbwNWLkdckoWvQVF2w==
=Rm0Q
-----END PGP SIGNATURE-----

--Sig_/ubV/oSdQ66uQ2x.P757eQ2V--

