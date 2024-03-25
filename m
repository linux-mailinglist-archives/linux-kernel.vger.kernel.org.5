Return-Path: <linux-kernel+bounces-118151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC6F88B505
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB817300BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D3982D6C;
	Mon, 25 Mar 2024 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lqS5u1LO"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9238E6EB6A;
	Mon, 25 Mar 2024 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408194; cv=none; b=sFV+hFM8dhWP/NEBjHuh+sUGKttvRM/9IthB2Cvxo2DLAwTsMGFv+ZlghNJf39vylQIoWbGulYZEkDEZXrGzzXOq6ItmxEvjgEiihODxXZtTkKAfqdTjodY+5DLL7w7DLXdiEKkEgNpKCHeEC/PK/cgpKNTyNihrGB4Aw9uiaQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408194; c=relaxed/simple;
	bh=7xv+wZzim3UMSlEAoMORiNX9a+kf2pcq6IJYmwmtohQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VJdaMBPZDqiOkrvWvJr66tgr3zRTkda8LejNc5h/ZyWFl4CAr5xXsjkNoFoNf5dsCeF+1c3HY4snIrBXsoYWmdjY1LriHTV+9+Jlqw3BJAi7EaP4JUkfYSXaoX6oGuA+ZzfeEKcso3R2CNK6gUpkgfHtE/I6p6P5Y35O1NYnbFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lqS5u1LO; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711408188;
	bh=YMn++1J95wpfV0yh3r7Ro2bHnY9QUCijB0bnckCw62M=;
	h=Date:From:To:Cc:Subject:From;
	b=lqS5u1LO1vEmtIXEU9mpChuSZc8D+qJGPkJqPl/9hD7qFvfCiLefnXU0G1ZWbZy5C
	 +NgFIbFwHdAq4WAb3996y4R4yQlOC4RYDs0vMpgLEcY/hZ4jaUnLz294bNYw/JvjCV
	 qFT86yezT4M3v42nwHmck9QfKgbGHIh3KT0cQGOvQ4VF41XDV9H80Bfjv7BJeOomL6
	 B2aTBf0OpL68fzH7EBCJK0T0djXRzpQE70OuojylhjBBJdm9PPxcjnCRTYPqnmWe44
	 s6DCYRq1VQ4wvUKk7HtiiblCOYtRZBASm9kEiJ3DGd9LkcOdzExsBneE+jwErXbDHT
	 VD98KiEzf4oKw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3TCt6nWjz4wc1;
	Tue, 26 Mar 2024 10:09:45 +1100 (AEDT)
Date: Tue, 26 Mar 2024 10:09:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Wireless <linux-wireless@vger.kernel.org>, Johannes Berg
 <johannes.berg@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Subject: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20240326100945.765b8caf@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8AGzgBNmxth=6OF0Gt7NqCT";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8AGzgBNmxth=6OF0Gt7NqCT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c

between commit:

  5f4040050553 ("wifi: iwlwifi: mvm: disable MLO for the time being")

from the wireless tree and commit:

  bbd6d0f8bc51 ("wifi: iwlwifi: mvm: advertise IEEE80211_HW_HANDLES_QUIET_C=
SA")

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

diff --cc drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 8f4b063d6243,6b8f18b3e280..000000000000
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@@ -359,8 -359,11 +359,11 @@@ int iwl_mvm_mac_setup_register(struct i
  	/* Set this early since we need to have it for the check below */
  	if (mvm->mld_api_is_used && mvm->nvm_data->sku_cap_11be_enable &&
  	    !iwlwifi_mod_params.disable_11ax &&
- 	    !iwlwifi_mod_params.disable_11be)
+ 	    !iwlwifi_mod_params.disable_11be) {
 -		hw->wiphy->flags |=3D WIPHY_FLAG_SUPPORTS_MLO;
 +		hw->wiphy->flags |=3D WIPHY_FLAG_DISABLE_WEXT;
+ 		/* we handle this already earlier, but need it for MLO */
+ 		ieee80211_hw_set(hw, HANDLES_QUIET_CSA);
+ 	}
 =20
  	/* With MLD FW API, it tracks timing by itself,
  	 * no need for any timing from the host

--Sig_/8AGzgBNmxth=6OF0Gt7NqCT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYCBDkACgkQAVBC80lX
0GwPhggAh70oz9Z9zchPSUVqf6GKtUcpXQtk2/MO21QPAriY6t/pdhIn5XAqDW09
+onmxtwsW+DXvUmIaj4AmsrTliwtpLTqPoxxk9+ry23eEkjF4ukaNkDmL67TDxlN
iggW8pZfMxZzPSxG3Tr9axz0NPCToMT4g80KW8Qq1GzkrLszg4jicGVocRDgX0Sr
mW+hJDTlCqw8hqqvvy+nG1B7VmHWOx9owIOrFNLC0JyaTQiI/9XOnq/1wKg3m3Dz
pBKjHnIawJ28FQrMU8LnuX0dRrdgO30jZPwTF8SajvmwKhIECKJIp4h/YeuSIGS5
QZA8YrXJWGS9CeRl2LhTjwD7v4O4bQ==
=h+Aq
-----END PGP SIGNATURE-----

--Sig_/8AGzgBNmxth=6OF0Gt7NqCT--

