Return-Path: <linux-kernel+bounces-13982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0120F821677
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F855281C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE7AECD;
	Tue,  2 Jan 2024 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WOqzuztt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2336F;
	Tue,  2 Jan 2024 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704162613;
	bh=a76C6RoEWABPXTGtBLjJTneSwT7P5KUbRkpixwmdCLM=;
	h=Date:From:To:Cc:Subject:From;
	b=WOqzuzttrN68CM+Gykw9fgYwEkHrZZ6Dnx2UmYpvUvSwEhEC1y2SM/E4bCVWb0ukG
	 GMNEvMhzEThOf/M6K8RuMOhQa+Tjag5/dsDjWPQp8OhgQ9YkCAAz0rsjI+Z61jtdjO
	 SjVTK9WbZ7tGQPU5tQbqsZt1q64FuZwJsUGrNLTCwRKoM173XjMwHrz9XYFWyyHcHH
	 kkwyG9qf0c8a7oK/HPlqqWncaMwb5PgcpXvn8mrO+qrG+ZTJuXaEALhlaU/a+O4KOR
	 /GkBXaNvgvuULhqynBmBMCSYJHm81e/vgQgyhzHozo+7xT9WBRDhO7ROaQVcFHANIa
	 pKBwlumz/9Lkg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3xdw2WFGz4wbR;
	Tue,  2 Jan 2024 13:30:12 +1100 (AEDT)
Date: Tue, 2 Jan 2024 13:30:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: "David E. Box" <david.e.box@linux.intel.com>, Ilpo =?UTF-8?B?SsOkcnZp?=
 =?UTF-8?B?bmVu?= <ilpo.jarvinen@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Rajvi Jingar <rajvi.jingar@linux.intel.com>,
 Xi Pardee <xi.pardee@intel.com>
Subject: linux-next: manual merge of the drivers-x86 tree with Linus' tree
Message-ID: <20240102133011.75a12634@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6eVXb0ON+oyQXliDjq_zT2I";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/6eVXb0ON+oyQXliDjq_zT2I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the drivers-x86 tree got conflicts in:

  drivers/platform/x86/intel/pmc/adl.c
  drivers/platform/x86/intel/pmc/cnp.c
  drivers/platform/x86/intel/pmc/core.h
  drivers/platform/x86/intel/pmc/mtl.c
  drivers/platform/x86/intel/pmc/tgl.c

between commits:

  6f9cc5c1f94d ("platform/x86/intel/pmc: Allow reenabling LTRs")
  70681aa0746a ("platform/x86/intel/pmc: Move GBE LTR ignore to suspend cal=
lback")

from Linus' tree and commits:

  2e35e3aa9f10 ("platform/x86:intel/pmc: Call pmc_get_low_power_modes from =
platform init")
  4d621c3f02ba ("platform/x86/intel/pmc: Retrieve LPM information using Int=
el PMT")
  d79c3c82ee82 ("platform/x86/intel/pmc: Move common code to core.c")
  935b8211a31a ("platform/x86/intel/pmc: Read low power mode requirements f=
or MTL-M and MTL-P")
  1d62ada48d41 ("platform/x86/intel/pmc: Add ssram_init flag in PMC discove=
ry in Meteor Lake")
  544f7b7f651c ("platform/x86/intel/pmc: Add regmap for Tiger Lake H PCH")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/platform/x86/intel/pmc/adl.c
index 606f7678bcb0,882f2d5d8937..000000000000
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@@ -322,5 -321,13 +324,7 @@@ int adl_core_init(struct pmc_dev *pmcde
  	if (ret)
  		return ret;
 =20
+ 	pmc_core_get_low_power_modes(pmcdev);
+=20
 -	/* Due to a hardware limitation, the GBE LTR blocks PC10
 -	 * when a cable is attached. Tell the PMC to ignore it.
 -	 */
 -	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
 -	pmc_core_send_ltr_ignore(pmcdev, 3);
 -
  	return 0;
  }
diff --cc drivers/platform/x86/intel/pmc/cnp.c
index 98b36651201a,59298f184d0e..000000000000
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@@ -234,5 -214,13 +234,7 @@@ int cnp_core_init(struct pmc_dev *pmcde
  	if (ret)
  		return ret;
 =20
+ 	pmc_core_get_low_power_modes(pmcdev);
+=20
 -	/* Due to a hardware limitation, the GBE LTR blocks PC10
 -	 * when a cable is attached. Tell the PMC to ignore it.
 -	 */
 -	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
 -	pmc_core_send_ltr_ignore(pmcdev, 3);
 -
  	return 0;
  }
diff --cc drivers/platform/x86/intel/pmc/core.h
index b66dacbfb94b,2891d8d04fad..000000000000
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@@ -486,9 -511,61 +513,61 @@@ extern const struct pmc_bit_map mtl_ioe
  extern const struct pmc_bit_map mtl_ioem_vnn_req_status_1_map[];
  extern const struct pmc_bit_map *mtl_ioem_lpm_maps[];
  extern const struct pmc_reg_map mtl_ioem_reg_map;
+ extern const struct pmc_reg_map lnl_socm_reg_map;
+=20
+ /* LNL */
+ extern const struct pmc_bit_map lnl_ltr_show_map[];
+ extern const struct pmc_bit_map lnl_clocksource_status_map[];
+ extern const struct pmc_bit_map lnl_power_gating_status_0_map[];
+ extern const struct pmc_bit_map lnl_power_gating_status_1_map[];
+ extern const struct pmc_bit_map lnl_power_gating_status_2_map[];
+ extern const struct pmc_bit_map lnl_d3_status_0_map[];
+ extern const struct pmc_bit_map lnl_d3_status_1_map[];
+ extern const struct pmc_bit_map lnl_d3_status_2_map[];
+ extern const struct pmc_bit_map lnl_d3_status_3_map[];
+ extern const struct pmc_bit_map lnl_vnn_req_status_0_map[];
+ extern const struct pmc_bit_map lnl_vnn_req_status_1_map[];
+ extern const struct pmc_bit_map lnl_vnn_req_status_2_map[];
+ extern const struct pmc_bit_map lnl_vnn_req_status_3_map[];
+ extern const struct pmc_bit_map lnl_vnn_misc_status_map[];
+ extern const struct pmc_bit_map *lnl_lpm_maps[];
+ extern const struct pmc_bit_map lnl_pfear_map[];
+ extern const struct pmc_bit_map *ext_lnl_pfear_map[];
+=20
+ /* ARL */
+ extern const struct pmc_bit_map arl_socs_ltr_show_map[];
+ extern const struct pmc_bit_map arl_socs_clocksource_status_map[];
+ extern const struct pmc_bit_map arl_socs_power_gating_status_0_map[];
+ extern const struct pmc_bit_map arl_socs_power_gating_status_1_map[];
+ extern const struct pmc_bit_map arl_socs_power_gating_status_2_map[];
+ extern const struct pmc_bit_map arl_socs_d3_status_2_map[];
+ extern const struct pmc_bit_map arl_socs_d3_status_3_map[];
+ extern const struct pmc_bit_map arl_socs_vnn_req_status_3_map[];
+ extern const struct pmc_bit_map *arl_socs_lpm_maps[];
+ extern const struct pmc_bit_map arl_socs_pfear_map[];
+ extern const struct pmc_bit_map *ext_arl_socs_pfear_map[];
+ extern const struct pmc_reg_map arl_socs_reg_map;
+ extern const struct pmc_bit_map arl_pchs_ltr_show_map[];
+ extern const struct pmc_bit_map arl_pchs_clocksource_status_map[];
+ extern const struct pmc_bit_map arl_pchs_power_gating_status_0_map[];
+ extern const struct pmc_bit_map arl_pchs_power_gating_status_1_map[];
+ extern const struct pmc_bit_map arl_pchs_power_gating_status_2_map[];
+ extern const struct pmc_bit_map arl_pchs_d3_status_0_map[];
+ extern const struct pmc_bit_map arl_pchs_d3_status_1_map[];
+ extern const struct pmc_bit_map arl_pchs_d3_status_2_map[];
+ extern const struct pmc_bit_map arl_pchs_d3_status_3_map[];
+ extern const struct pmc_bit_map arl_pchs_vnn_req_status_0_map[];
+ extern const struct pmc_bit_map arl_pchs_vnn_req_status_1_map[];
+ extern const struct pmc_bit_map arl_pchs_vnn_req_status_2_map[];
+ extern const struct pmc_bit_map arl_pchs_vnn_req_status_3_map[];
+ extern const struct pmc_bit_map arl_pchs_vnn_misc_status_map[];
+ extern const struct pmc_bit_map arl_pchs_signal_status_map[];
+ extern const struct pmc_bit_map *arl_pchs_lpm_maps[];
+ extern const struct pmc_reg_map arl_pchs_reg_map;
 =20
  extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
+ extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
 -extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
 +int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignor=
e);
 =20
  int pmc_core_resume_common(struct pmc_dev *pmcdev);
  int get_primary_reg_base(struct pmc *pmc);
@@@ -499,12 -579,13 +581,16 @@@ int spt_core_init(struct pmc_dev *pmcde
  int cnp_core_init(struct pmc_dev *pmcdev);
  int icl_core_init(struct pmc_dev *pmcdev);
  int tgl_core_init(struct pmc_dev *pmcdev);
+ int tgl_l_core_init(struct pmc_dev *pmcdev);
+ int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp);
  int adl_core_init(struct pmc_dev *pmcdev);
  int mtl_core_init(struct pmc_dev *pmcdev);
+ int arl_core_init(struct pmc_dev *pmcdev);
+ int lnl_core_init(struct pmc_dev *pmcdev);
 =20
 +void cnl_suspend(struct pmc_dev *pmcdev);
 +int cnl_resume(struct pmc_dev *pmcdev);
 +
  #define pmc_for_each_mode(i, mode, pmcdev)		\
  	for (i =3D 0, mode =3D pmcdev->lpm_en_modes[i];	\
  	     i < pmcdev->num_lpm_modes;			\
diff --cc drivers/platform/x86/intel/pmc/mtl.c
index 504e3e273c32,e75431325dda..000000000000
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@@ -991,19 -998,35 +1000,30 @@@ int mtl_core_init(struct pmc_dev *pmcde
 =20
  	mtl_d3_fixup();
 =20
 +	pmcdev->suspend =3D cnl_suspend;
  	pmcdev->resume =3D mtl_resume;
-=20
  	pmcdev->regmap_list =3D mtl_pmc_info_list;
- 	pmc_core_ssram_init(pmcdev);
 =20
- 	/* If regbase not assigned, set map and discover using legacy method */
- 	if (!pmc->regbase) {
+ 	/*
+ 	 * If ssram init fails use legacy method to at least get the
+ 	 * primary PMC
+ 	 */
+ 	ret =3D pmc_core_ssram_init(pmcdev, func);
+ 	if (ret) {
+ 		ssram_init =3D false;
+ 		dev_warn(&pmcdev->pdev->dev,
+ 			 "ssram init failed, %d, using legacy init\n", ret);
  		pmc->map =3D &mtl_socm_reg_map;
  		ret =3D get_primary_reg_base(pmc);
  		if (ret)
  			return ret;
  	}
 =20
+ 	pmc_core_get_low_power_modes(pmcdev);
+ 	pmc_core_punit_pmt_init(pmcdev, MTL_PMT_DMU_GUID);
+=20
 -	/* Due to a hardware limitation, the GBE LTR blocks PC10
 -	 * when a cable is attached. Tell the PMC to ignore it.
 -	 */
 -	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
 -	pmc_core_send_ltr_ignore(pmcdev, 3);
 -
+ 	if (ssram_init)
+ 		return pmc_core_ssram_get_lpm_reqs(pmcdev);
+=20
  	return 0;
  }
diff --cc drivers/platform/x86/intel/pmc/tgl.c
index e88d3d00c853,91fd725951e5..000000000000
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@@ -258,16 -300,22 +300,20 @@@ int tgl_core_generic_init(struct pmc_de
  	struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
  	int ret;
 =20
- 	pmc->map =3D &tgl_reg_map;
+ 	if (pch_tp =3D=3D PCH_H)
+ 		pmc->map =3D &tgl_h_reg_map;
+ 	else
+ 		pmc->map =3D &tgl_reg_map;
 =20
 +	pmcdev->suspend =3D cnl_suspend;
 +	pmcdev->resume =3D cnl_resume;
 +
  	ret =3D get_primary_reg_base(pmc);
  	if (ret)
  		return ret;
 =20
+ 	pmc_core_get_low_power_modes(pmcdev);
  	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
 -	/* Due to a hardware limitation, the GBE LTR blocks PC10
 -	 * when a cable is attached. Tell the PMC to ignore it.
 -	 */
 -	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
 -	pmc_core_send_ltr_ignore(pmcdev, 3);
 =20
  	return 0;
  }

--Sig_/6eVXb0ON+oyQXliDjq_zT2I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTdTMACgkQAVBC80lX
0Gxnywf9G78zwBR1NR419p3bGLEF+eAyH8HmZH0b1FXkZsE2Q+rxZ1cI+66faTtB
lfn2U3Q64oUxswoQcDqoxegY2GBh648wXz3QVjjPfiiiszOhmngJU9pQ81OxTVxr
L0VxbrvytpDQ+x/ikhsqDadBOtlk1JJePlJDGIB6gGMh8o+vTzFRV1sKBIBS6y+p
KJynHpQimFaDhVj0KPJbk9qmeIISaUCDgsVGksXIOVJQvT6yIMzVxvm3y2VSW/du
73xE/LQLknL7J8uQPqVRGXeAnDaSrcEKoD+eZvtUtM1Qjr6XhhSrreSu46ODgnh2
s1mo5+yi3mUlruex0FkCcA2TNKPwRA==
=sKTR
-----END PGP SIGNATURE-----

--Sig_/6eVXb0ON+oyQXliDjq_zT2I--

