Return-Path: <linux-kernel+bounces-139595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECC98A04ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364AC1C22F40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52DEDDA8;
	Thu, 11 Apr 2024 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JlhwEmw2"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53954946F;
	Thu, 11 Apr 2024 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712796702; cv=none; b=iUzk3zoOHfpzgc/boCdMFtUd7lf06URDMg8NkLD/UrsEiUw35I1b174eby4sB4omTeWMpT+zUM/oxRUzRPdAvjY9ZvYyPe09ZL3cgvoHQPDJTQJtVcVh1GNkqil8O0KffXRsaqiTztfeOERPSTfEueNMb8nmIN1+5mDox7/Uok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712796702; c=relaxed/simple;
	bh=1cQR6TA6bfQm37PZdOpPRldQ3GrG5ztpabo/rDGNjLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=V5Dsk+OkUJEuBfqrAcjN4xhJ/EP1aU3o/3tWI+N/hm0q8MpuNix9Xj3aLBrBRkBEEASSMvsEndyhkKYXvjQazWfEv193Q6jHoDIhY1SF93DSM5Dva2c6eEg8mej3eU3+4undd3Jdwo3Qz0GC4WaX6x8TeLOtlQU4N3PSocyFFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=JlhwEmw2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712796695;
	bh=2z/uSXzX1Q/L0cxXzbJl/PDuYffxts/I4DsYCMach9Y=;
	h=Date:From:To:Cc:Subject:From;
	b=JlhwEmw2hXuZS32/1KI7FGseZCQkTgqejMS5n+MiRhBHlWALF5wi15G+RvfC/a7g8
	 wTnvEB0FRJDwMCwyj6WTcUDCGkDujeEinvgOkTgEYmuGrbIiSdts5YsjCygwT9pvHr
	 fNoA2pskrhLJ7ocVCcrml71P5q1Qoggm2vhX9soT0IU3WdJpLzAzD+jUn3spSqhxRG
	 XbARBElHFgYXa9zJpV3PTGbe8VTw9OgVwv8nhIrmlPl07/iYsyTjlhXeHErQ2P0WAq
	 i2IFj3a3G1fO10jjF6rEhkHab08hg7u9tuD/ahiCnP7keDbETL9CbMcmAXYzcp3K5W
	 IUSwNOvdU/lEA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFLjz66mCz4wnv;
	Thu, 11 Apr 2024 10:51:35 +1000 (AEST)
Date: Thu, 11 Apr 2024 10:51:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hid tree
Message-ID: <20240411105131.7830f966@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Eg_QQDvOpWyst.__NKb1P7G";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Eg_QQDvOpWyst.__NKb1P7G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

x86_64-linux-gnu-ld: vmlinux.o: in function `hid_bpf_input_report':
(.text+0x1c75181): undefined reference to `hid_input_report'

Caused by commit

  9be50ac30a83 ("HID: bpf: allow to inject HID event from BPF")

I have used the hid tree from next-20240410 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Eg_QQDvOpWyst.__NKb1P7G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXNBMACgkQAVBC80lX
0GxdTQgAn43tZ0ln7JXm2yAFEgqXjACcXsCx/tbwpaeptOg7djZ9QJLLJljZrwXc
ryvg2K957AWu29pJ2+Nv4E26GDohYsCq+NUzwr1m0chnl02O90ctWentE/vkrHuy
3aTw4F/ridDgmgX2qb08r/gwbHHA1NjjV51h6xTPYWHFzU0r+C9ZnjcLtxUDSp1k
Osm28UJI99SIGkkPqh3veYLfG6lnmlF7m8uV4de5PQlsGIGSJCXlFngt+m5e6fxs
abDpxsjQmKiM8UUq4Yq+VTgxvACHug+/2M2nUZ80DWiLoforYlqlx3cGfMBitXal
ACrFv+qeNcBi5SDE+l8WMQaH6xWElw==
=hjwm
-----END PGP SIGNATURE-----

--Sig_/Eg_QQDvOpWyst.__NKb1P7G--

