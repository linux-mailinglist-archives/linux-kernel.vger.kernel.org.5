Return-Path: <linux-kernel+bounces-58985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F275784EF67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DA61C21664
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C887B5C96;
	Fri,  9 Feb 2024 03:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TLZK5XZC"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004005221;
	Fri,  9 Feb 2024 03:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707449397; cv=none; b=A7tdijWRa5f5ZrG/mXfbkb81+QL5NOk7f7lKhAO8luEG78ZCK8bL6h19z3Qlm1k6w372K9a1rwNjpnxo8ex/xjEaj1g6mDK/OO756GmhxwuI0HKQf4yqO9Dz0zMa+zb3LkWPbKCQk7Ka2VKVVXHkb5ALphmf66DCu9eufK63CSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707449397; c=relaxed/simple;
	bh=aEjuYK57JV00RgqKhkXxxSVib+YM+81Zs1wKu6j2OwU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=amilKV+qmUCoGoaw6R8SEodh7Az02Q7/dPkvWzbMrglBGQT+n4tInRm4SOmtiCPx+ifK4VcDA+MzhhVOW8sJw8loTuVsCVGF/irTUbfCINqn14jl5n4f8aP3BKKsDdVfzp/wzKZGUndmNDSa2wP1VeFG3kiRVXkKHuEerZdJBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TLZK5XZC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707449393;
	bh=hVlvcab28mm7oJHV3nyyIC1q5542oDiRfCk+alo0clY=;
	h=Date:From:To:Cc:Subject:From;
	b=TLZK5XZC+qM3gCrvcW5QaZNNqXvR7dRzbiwtnHEi52A1FbvUXqNdr+055IJhb/l5T
	 RKgOiFzWox8CQvXNacNnDr1aJKybd0X71f3gnvICzenH8bAeayGikHJELb/1jk0eTe
	 nBavEZXjTCPrth7yi5Ugwy9IQPglive5ewPK3MFkCLh86ge7dRR72z/DvhzbcV80sL
	 T2jKSJjurl+Gsi326bVaZ5vmsMZ/IHc2Larrmnj5h3LhMCHEBBgo+/uSv/qzo1LSW2
	 waXL2vBU2JfUIxUXWmzPPHIirUeujzLus7j1CKRNevjfnNpG45xOOMrh2TiiWTQ2+z
	 W2hEzzEMIjj5Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TWK9C6w2lz4wcn;
	Fri,  9 Feb 2024 14:29:51 +1100 (AEDT)
Date: Fri, 9 Feb 2024 14:29:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Wireless <linux-wireless@vger.kernel.org>, Johannes Berg
 <johannes.berg@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the wireless-next tree
Message-ID: <20240209142950.703eca9b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hbmDQp./E6WiNTxV7WTGqWS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/hbmDQp./E6WiNTxV7WTGqWS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-next tree, today's linux-next build (htmldocs)
produced this warning:

include/net/cfg80211.h:1067: warning: expecting prototype for cfg80211_chan=
def_primary_freq(). Prototype was for cfg80211_chandef_primary() instead

Introduced by commit

  b82730bf57b5 ("wifi: cfg80211/mac80211: move puncturing into chandef")

--=20
Cheers,
Stephen Rothwell

--Sig_/hbmDQp./E6WiNTxV7WTGqWS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXFnC4ACgkQAVBC80lX
0GxmkAf/aQ96UE4nadoI0OsRscNwIKzvY0qZgr/tFwoS/Io21ubjazcSbBg3TLff
22tzNQGYnUHfL4kaKQgNlYktIPKmShHVO+nxGN4X2bCDU+VqVqRhPlMyK0veqirh
rQ4UMj8FLNXgn6p0VnCFpA0DEpJ2XwsOEAE67JFIuTx1tEpi0EqixJoURMwKRIgh
3h50otzW5uiQGDfOcKSK+iUhGsVnA553XgDoq4IO4xUQfekOQxWQ+egkgkMspENd
rgPU2NfOzxnVphO2pCeRcPhcGMXQnm6sxz6xMINyBNNk/6eYkXAiwd9pyTZlZaS8
UGGMYhndqKsVjH/kl3jtfa3EFjwygg==
=/yHM
-----END PGP SIGNATURE-----

--Sig_/hbmDQp./E6WiNTxV7WTGqWS--

