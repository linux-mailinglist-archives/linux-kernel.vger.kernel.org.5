Return-Path: <linux-kernel+bounces-62559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E27208522E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E941F22F58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D607E1;
	Tue, 13 Feb 2024 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rKD1zx+U"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6EC621;
	Tue, 13 Feb 2024 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707782944; cv=none; b=M6C/89E4EzoAiUppw28JyH1Ng8q/OGXZG2eWgW+YVPsN53y5aeciCfDYzMcXUG2gZZUCfNvbVgWYMbkyGmWc69VnFP/qHeYouyosdZWDuppyspzuC9dfCRyrpOiwhAHidd9r4ElOqmY9L2eNFUkSw8k4rR1SepeNnOJjgymvhcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707782944; c=relaxed/simple;
	bh=RvflJdzl0Jc9vk19OoqP+WEbH4d8Gr0XXL8NXNFQ/K8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=D6GiuSarat+MOoQcbyLtrJPOa2C/r+9vZIWCU3YgJROaqVMcupwcc4FfMZbo1+CABra7lLohFqJzsXFfnBW6rT7/vJgLxAypOl/nHQ6GhD/duuNcoM75UIiS2mJBDdczbBukaGvI6K8z94Q+vxKVRtuKll6HaH2tLmL5noOtyao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rKD1zx+U; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707782937;
	bh=2nfZYxxE+1dxFM4SEfJqpgzynVkamsIwAnSU0lPVsxA=;
	h=Date:From:To:Cc:Subject:From;
	b=rKD1zx+UkYmZLwgLYJzKgJX8nSyoUSWu8e1drAjJeEOUNgi11aawinhW6EqKhFT4m
	 xrpmEFOtQnhn0uR5m4NG/oBFTHKrX0HZzce2KU4oIDMgoIRV1SvvyggASWABf2NZDc
	 3gAKsGyPTRbixP4ZL0BTJ1j3x0+Bw8tZuwM3Pw9jlu12MM533RGlx4uG+8a32WeqT6
	 WB3TuMj+ZIP4zahJPaX1iBBcFEa2U9sTz+uASPlD2vPv4JjUS6ey0+SW9zSPTiE9HU
	 jq+RNsGzZhhn4X26uPXS6CywO+k+wcby20VAzwGAV00sLYeAsxAbbqFjTNP1kYFZ7J
	 7r6B9UkJ/SZpw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TYhWW3hXWz4wcp;
	Tue, 13 Feb 2024 11:08:54 +1100 (AEDT)
Date: Tue, 13 Feb 2024 11:08:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, Wireless <linux-wireless@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Johannes Berg <johannes.berg@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the wireless-next tree with the pm tree
Message-ID: <20240213110852.51524899@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xWx+rnaTt=Lmy3hfd=gt658";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xWx+rnaTt=Lmy3hfd=gt658
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h

between commit:

  2e171a57c312 ("iwlwifi: mvm: Drop unused fw_trips_index[] from iwl_mvm_th=
ermal_device")

from the pm tree and commit:

  8cb3a308ceb1 ("wifi: iwlwifi: mvm: fix thermal kernel-doc")

from the wireless-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a618824f0b65,83263d510a45..000000000000
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@@ -537,8 -540,9 +540,8 @@@ struct iwl_mvm_tt_mgmt=20
 =20
  #ifdef CONFIG_THERMAL
  /**
-  *struct iwl_mvm_thermal_device - thermal zone related data
-  * @temp_trips: temperature thresholds for report
+  * struct iwl_mvm_thermal_device - thermal zone related data
+  * @trips: temperature thresholds for report
 - * @fw_trips_index: keep indexes to original array - temp_trips
   * @tzone: thermal zone device data
  */
  struct iwl_mvm_thermal_device {

--Sig_/xWx+rnaTt=Lmy3hfd=gt658
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXKsxQACgkQAVBC80lX
0GyuTwf/a8D7+UV9abG8o84U+eYLjKJH0aImG46vrcPW3w1LYfVMNtJ+b7GbnNgC
fJCcFmFcdMHNZ9wxy06qQsbtp78fEsZB+WTwNXQwiZj1btxG6cZggm8w6NC8FnXP
evkAT5DLzOvQPE0jWkURTX7zQWBeGMFeak9zScx2YJy8qTtV+8fbWoDagOt7GZbR
IiIEQiXcyEBTe7cpEJ1iGecR3+ekZ4h+luiRigfm3zBc7NrUmO404/kBw2M1JpZ2
tw7A7Yg1jzSFYQKkgLbb7rAeo9MY8Jz3gQvwiXcsRB4XNMxNLqoK7g5CDZk/SqDJ
wC96Zsr/5E4OQ+ss8e30k3PtmdJWlg==
=mK8G
-----END PGP SIGNATURE-----

--Sig_/xWx+rnaTt=Lmy3hfd=gt658--

