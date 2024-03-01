Return-Path: <linux-kernel+bounces-87853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C197E86D9F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7721F237CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E53340BF9;
	Fri,  1 Mar 2024 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JtYtPMVk"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFE3FE48;
	Fri,  1 Mar 2024 03:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709262884; cv=none; b=P28qn7GT816iWInjn7/884rNT+VLxwsK2XEPPp1vnubLYh5mCuAua3SIbisayiBTqfXuGrLlrEeRV3x0ljHZDv36eTPenPWVJUT7b0BAhtPHh2EAg1EZVwLPoOdIr+0lOszVFyIO0/xigC82hLcE9VPp2B7abXGKPuLm4rEa9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709262884; c=relaxed/simple;
	bh=8KooHiSHfy499QBK0B7dlOLyfz/tp/A8aRIHFP+v5Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WByFGoFpqpVvP/RNpMuK0Zt7qCozbYsp7zA1YCVTUZmjO7uw4WCgL2fwrTsDtPRv3/eBizkbxmnKyGagHM1yUVyauddqYo45craLUm21KlmFlnQjr7KJjdHwys4w89ONf4atM4eSx7Gu0ZdJTZbpyE5F0in+TVK2reGH2M+Xldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=JtYtPMVk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709262879;
	bh=EdyRsvU5kqbbF53QnWVyOMFIv55duUWubcGQP4fqOFk=;
	h=Date:From:To:Cc:Subject:From;
	b=JtYtPMVklLt/7lVjCrghwQ3bUlKfpCoxM328WGbXRQiVDDJVm3LnFOxiu0XjXAnjm
	 H3bkO0m79/oo4JLBUggqcew+9Mc/EH2hsvCINq26W/vZ3sPqGCV0jz1hd/bB8N8zBW
	 J5gJJDYg1+mpWuaPVf+DdDlLc54fVjDViteH8Vtw0MaAdsU2raX6XVVC9b44StifyL
	 6sjpQUVL5aoVPsrWu/7i/8PtY3fFZFK3Jtz4n4crI8c1h4m80QIf9eELVe16y3MJwO
	 Rs/gESyhnwX7neP3IksZZ3LmnrQpKlM4VoN6PK6VQqGQ3NFWHK285KmVLQTV/2un5z
	 Nis2a9AGRQFMA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TmCqy0D7Wz4wc1;
	Fri,  1 Mar 2024 14:14:37 +1100 (AEDT)
Date: Fri, 1 Mar 2024 14:14:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: linux-next: manual merge of the drivers-x86 tree with Linus' tree
Message-ID: <20240301141436.77c192f9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ekZLYXc/fcODtbuyW6DmN.P";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ekZLYXc/fcODtbuyW6DmN.P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  drivers/platform/x86/amd/pmf/tee-if.c

between commit:

  e70961505808 ("platform/x86/amd/pmf: Fixup error handling for amd_pmf_ini=
t_smart_pc()")

from Linus' tree and commit:

  6ed210504a18 ("platform/x86/amd/pmf: Add missing __iomem attribute to pol=
icy_base")

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

diff --cc drivers/platform/x86/amd/pmf/tee-if.c
index 8527dca9cf56,16973bebf55f..000000000000
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@@ -436,44 -453,13 +436,44 @@@ int amd_pmf_init_smart_pc(struct amd_pm
  		return ret;
 =20
  	INIT_DELAYED_WORK(&dev->pb_work, amd_pmf_invoke_cmd);
 -	amd_pmf_set_dram_addr(dev, true);
 -	amd_pmf_get_bios_buffer(dev);
 +
 +	ret =3D amd_pmf_set_dram_addr(dev, true);
 +	if (ret)
 +		goto error;
 +
 +	dev->policy_base =3D devm_ioremap(dev->dev, dev->policy_addr, dev->polic=
y_sz);
 +	if (!dev->policy_base) {
 +		ret =3D -ENOMEM;
 +		goto error;
 +	}
 +
 +	dev->policy_buf =3D kzalloc(dev->policy_sz, GFP_KERNEL);
 +	if (!dev->policy_buf) {
 +		ret =3D -ENOMEM;
 +		goto error;
 +	}
 +
- 	memcpy(dev->policy_buf, dev->policy_base, dev->policy_sz);
++	memcpy_fromio(dev->policy_buf, dev->policy_base, dev->policy_sz);
 +
 +	amd_pmf_hex_dump_pb(dev);
 +
  	dev->prev_data =3D kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
  	if (!dev->prev_data)
 -		return -ENOMEM;
 +		goto error;
 =20
 -	return dev->smart_pc_enabled;
 +	ret =3D amd_pmf_start_policy_engine(dev);
 +	if (ret)
 +		goto error;
 +
 +	if (pb_side_load)
 +		amd_pmf_open_pb(dev, dev->dbgfs_dir);
 +
 +	return 0;
 +
 +error:
 +	amd_pmf_deinit_smart_pc(dev);
 +
 +	return ret;
  }
 =20
  void amd_pmf_deinit_smart_pc(struct amd_pmf_dev *dev)

--Sig_/ekZLYXc/fcODtbuyW6DmN.P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXhSBwACgkQAVBC80lX
0GwnAAf/ShVAMTuKjlZ7/acLikE4WY9U6YOi8peS8Zl+2q59dhUcsYVyOpHm9sef
oKb5TK8qXHI9xiuzwIQ5dBcih4qX+78UiGpw5P2hmgaZVeyUc1TOqh8NgqJKF3m9
FdnTCauvhAxmM7H6Ar7SdAcKFrOQz2dlwjwLQAE3dk111yrmcp0ucRcBh12OyG4d
rL2+aOVui5i2RwZqZzPb02DW6PIylz63WYNPsAG4eCENCSfiM9urA6A5n/y5UHSD
uMNLALEC838eh2bKHQqjGEKn7koVVMDg0CXy6OWZ/g8AqkEXhqS9/okv871BdIbX
Yo5AOt/3zC580hnrdwrnG/MzaADnyQ==
=49RC
-----END PGP SIGNATURE-----

--Sig_/ekZLYXc/fcODtbuyW6DmN.P--

