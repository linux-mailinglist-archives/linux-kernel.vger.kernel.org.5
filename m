Return-Path: <linux-kernel+bounces-28398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98A282FE11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7CC3B24EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8162138E;
	Wed, 17 Jan 2024 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GzkwTOHC"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F3910E9;
	Wed, 17 Jan 2024 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705452366; cv=none; b=YFm9V6py98Q+hAXg0UD5W0RHoBo5/hRR4ob7tXS1HRepy1vo1SF/nXb29vg2lfrDg+pysPCbcmHUzSH96ZSAcDuiQUHvEO5PnnvM+q2srp7hBS3vfmWNXnPhgcFuvS3SNjCTLjgYBvHbq8K203uPNU2PsqDrPs1SBn92RMoFw3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705452366; c=relaxed/simple;
	bh=sPPRMtzitfA1rzjzKYhYQH1roHXakfuZRbwwYXenG9U=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type; b=jebXGTAtgKH/1LVjDoW0i/6RmmT1VBCAhckm3GtchX4nrkqkrxNUxeJs0JytvKQl+9AAsV2B/QBLllddzF79swrZfa0cxZEP3tMhJM0hzLMIRYYC+Yx4mY1clmgBNGg2ftUMOZXGnULC4fkxlDNFXshcHt8MOySimV4PLwhJToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GzkwTOHC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705452357;
	bh=9Ygua69Jodct9U/NXrL9McrdGQOHloyD8Glis1dIoTI=;
	h=Date:From:To:Cc:Subject:From;
	b=GzkwTOHCggK5kSbWP0EMTbSbgukF6MSfk4Yhd3nGhOiK+IPbpn3XBkmXnZfFJy/dj
	 T7E5kR7HCd/S68ij2RtAK7Ti5JrsLscbXWXxHw5XWhKTcGNcFHFzLPRSsiuWh7qYQT
	 gOpEIg/rb69jtFfLLPBMgfx2z5CRrI0NMLJ4PGupN78PtA+5xgFT+s99LV65kwQOnF
	 H4XN0f9v4yhujaT47CdUV/uJQQb4amNbf0amxidcxQexgiw9huJmlM/eF1dKXzBAZR
	 rXYys9kSdxVomOTkvmLyN1UoekzOluykbwcm/C220NF2q5aUT5Rv5HUBZIUoJZnHfo
	 COnayWR39iNbg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TF6cj5656z4wxZ;
	Wed, 17 Jan 2024 11:45:55 +1100 (AEDT)
Date: Wed, 17 Jan 2024 11:45:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20240117114553.62798913@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vf4B7AVV628jMlIiYUJtMvU";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Vf4B7AVV628jMlIiYUJtMvU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the btrfs-fixes tree as different
commits (but the same patches):

  4b60f3880d23 ("btrfs: zoned: factor out prepare_allocation_zoned()")
  62ec22633c6a ("btrfs: zoned: optimize hint byte for zoned allocator")
  690381ca057e ("btrfs: fix unbalanced unlock of mapping_tree_lock")
  92dd093f23d2 ("btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapsh=
ot of subvolume being deleted")
  a5592dcde6c6 ("btrfs: fix kvcalloc() arguments order in btrfs_ioctl_send(=
)")
  aa434e486204 ("btrfs: ref-verify: free ref cache before clearing mount op=
t")
  c31b9639579d ("btrfs: zoned: fix lock ordering in btrfs_zone_activate()")
  de4b77527d36 ("btrfs: don't abort filesystem when attempting to snapshot =
deleted subvolume")

--=20
Cheers,
Stephen Rothwell

--Sig_/Vf4B7AVV628jMlIiYUJtMvU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWnI0EACgkQAVBC80lX
0Gzu+Af/cCGM8JwobPJfq5KT6L3+uo63PfOC92qrzqfBaYm98MNhWSDSzBEivUKR
i6uo9ytXSLs+cBdpyVGQUIwhYiiX54OqgyE1/IYH18NlCRsRfpcBNB9EAKuvIwjs
6Myj1apV/8ebp7oz/8CtLr6etKH85qoFWg3riPkjvF3kLx72lbGd3eA/8C5JZsRA
en9hmT7KgfvoywmB6iiqJDV2/KPkRkbQ6Y0pz1IVYfynCbp+7p1GywNVAPWXm5xm
+GYx+5puJnynrHewjLU6ECHPPBSJVyGCC9q76uZTLU675i29LbIsT2YwUVpgFeEo
dzLcJCj9Hj3SeLWRQThO2oj88MPI+w==
=dQcS
-----END PGP SIGNATURE-----

--Sig_/Vf4B7AVV628jMlIiYUJtMvU--

