Return-Path: <linux-kernel+bounces-109524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 956E9881A83
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A56DB21923
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F97817D2;
	Thu, 21 Mar 2024 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sMke6qfR"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF0C622;
	Thu, 21 Mar 2024 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710981950; cv=none; b=JTqsY5Yqd0hUDC9AllsqSrZ7B4PxqRhiUdEfhoKj4ZRclhzPnfJFQHwtUgsEa7bJMfYTtkob50zbXwgAaB5TkE7PvgdFGcckHu5i3XrvJhfd5PfM7L/iY37urOY8PoD2ZfVcVnnjNy90o7z/dcJ68MB8h77fRRJANxnFYiNY5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710981950; c=relaxed/simple;
	bh=oQh7iEWJxke65nOX3RTuMmAXLKd9lRuWK2XoyXqOdhk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ldaZGvMY/iSEAtrXts9RSzzh8IaebGK914CjOcWxDVNqzMSc9ZUzVAWbtz0gyytXFXdH5w4CwWU3gbb3w+u4UNMNZA55pSmzUDmz1e5+5frOTb8Y2pUJUFlNlLZKrHWpORC2HxD7nDBxFKkN5ObAePaR7llorWgm1spkiE5ho60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sMke6qfR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710981937;
	bh=zJekwCEN8bUaFdpiF0rZBacWTc4yR7kNiS5DLXzcyvQ=;
	h=Date:From:To:Cc:Subject:From;
	b=sMke6qfRYnrwRUCWmK5CXjPiqzPMgNGpUfUj4ITPf51Q4zm3pqqW7m6IOHTH2wdoE
	 aTPFidf/hbXDFQD45EVzyCuAmBCxtnOQWEJQ4SqNkFhwhZDCqRojsoUTapa7SbMspE
	 QB4ibVg/RGwxo1JTOO/Yont/kz/hrDrEuli2/G1Ife77Y04uJ3BNnW/xcEZbp4uWrX
	 XMC9GTHeGo4MC/sGdlB8UrH9JNEI2BPgcWnuK5mqIAeWiAIQ8JksDso2Ze5hiEhnzs
	 KT7UiV1sB6AFfdy0gwQDYXnQUXfcDw5HMwd0FUpt7xdiP/UNleFNnQ6mwcenVCxWo+
	 W4RAipVUnfTmg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V0RZm49dnz4wc1;
	Thu, 21 Mar 2024 11:45:36 +1100 (AEDT)
Date: Thu, 21 Mar 2024 11:45:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>
Cc: Andrew Davis <afd@ti.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: linux-next: manual merge of the rpmsg tree with Linus' tree
Message-ID: <20240321114535.1aa208bc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dsIAHX_t4DSI885GW9zS5pZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dsIAHX_t4DSI885GW9zS5pZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rpmsg tree got a conflict in:

  drivers/remoteproc/qcom_q6v5_adsp.c

between commit:

  db34c47d56d5 ("remoteproc: qcom_q6v5_adsp: Convert to dev_pm_domain_attac=
h|detach_list()")

from Linus' tree and commit:

  5789e877b93b ("remoteproc: qcom_q6v5_adsp: Use devm_rproc_alloc() helper")

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

diff --cc drivers/remoteproc/qcom_q6v5_adsp.c
index 93f9a1537ec6,34ac996a93b2..000000000000
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@@ -704,13 -713,15 +704,13 @@@ static int adsp_probe(struct platform_d
 =20
  	ret =3D adsp_init_clock(adsp, desc->clk_ids);
  	if (ret)
- 		goto free_rproc;
+ 		return ret;
 =20
 -	ret =3D qcom_rproc_pds_attach(adsp->dev, adsp,
 -				    desc->proxy_pd_names);
 +	ret =3D qcom_rproc_pds_attach(adsp, desc->pd_names, desc->num_pds);
  	if (ret < 0) {
  		dev_err(&pdev->dev, "Failed to attach proxy power domains\n");
- 		goto free_rproc;
+ 		return ret;
  	}
 -	adsp->proxy_pd_count =3D ret;
 =20
  	ret =3D adsp_init_reset(adsp);
  	if (ret)
@@@ -742,11 -753,8 +742,8 @@@
  	return 0;
 =20
  disable_pm:
 -	qcom_rproc_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
 +	qcom_rproc_pds_detach(adsp);
 =20
- free_rproc:
- 	rproc_free(rproc);
-=20
  	return ret;
  }
 =20
@@@ -760,8 -768,7 +757,7 @@@ static void adsp_remove(struct platform
  	qcom_remove_glink_subdev(adsp->rproc, &adsp->glink_subdev);
  	qcom_remove_sysmon_subdev(adsp->sysmon);
  	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
 -	qcom_rproc_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
 +	qcom_rproc_pds_detach(adsp);
- 	rproc_free(adsp->rproc);
  }
 =20
  static const struct adsp_pil_data adsp_resource_init =3D {

--Sig_/dsIAHX_t4DSI885GW9zS5pZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX7gy8ACgkQAVBC80lX
0GzT2Af8CJUuuarfXO1M5NAAd0F/Mv8XiaGmHzEWK9eT/xfGXXFYP1HVSD31Yvb6
/24wtiCutC8GZBjj3ZWtqU5bVF2tb3ksijQLD+2+WQGID3Vm0KpURDSihSxFDMH8
3YAxJFcFVYyEYa7VLhC+xcFCHgmRPvYcgOSPdUMP+nUuGCOVoQAvuNmo/Fn2rj7U
toU+E7qHtga9x25UvvN86Tx0cPdlcMN3vX9YJPC2xVJzbQ67mEUSt2Fvg0MssKFr
DPN9vBPE7fJTQkHpxhX+PQi4pQKKBs2A104M5tL63HInu8Gas3BM8QY7GTZFBmj2
LadIDzynkHFPmNqVTGWQywdiRwf4tQ==
=5aFe
-----END PGP SIGNATURE-----

--Sig_/dsIAHX_t4DSI885GW9zS5pZ--

