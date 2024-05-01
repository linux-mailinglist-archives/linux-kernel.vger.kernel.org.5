Return-Path: <linux-kernel+bounces-164847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74658B83F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2801F241D8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D24C97;
	Wed,  1 May 2024 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hJavO/0c"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF982F2D;
	Wed,  1 May 2024 01:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714526365; cv=none; b=GJ+TBVyPE5BUUHQDyDg2e+xpvGURnYSftB/7JTPIpcPmYmrDGuhX+IPMMdRtLY2gXV72m7089DvpPHSY8vz3knieYOpSkXk/iuG2amlMmWGMWDDjvoOcl5apazwRpZmQYl+R8tKKhApg6zt6vNivnDP1pdF9X4ilUnv0bmLjCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714526365; c=relaxed/simple;
	bh=IhXmNZJJdH367PAssW8LFakW0qsPQ61s1Qx0ncC9DuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UaML6JX/AZX+4m+vpFg1ZsrAa0pOI3Wr4lwb8SQePIh/MucxmpT9IbXghwwixAI6renlmjHzLcwNwt5uQHwuS546XRwabtOAsYUz89ZKaDvvWc85rkirucgwCwgpE/wOjWpY4owEnNN0Jh0ZsSY16aehRxs1Bfd459nkgwYAvHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=hJavO/0c; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714526358;
	bh=d+aPeYIf2KHFxdj0UU+VmTIVu6fugcBFXrv/V7KQIII=;
	h=Date:From:To:Cc:Subject:From;
	b=hJavO/0cvIe6proFVMK2ouM9YNPc06uQsMycbv/2w/P1x2CJlXjQRTTJhl45Qou/h
	 JnA6RYOGmE8RAZgOrO7ce12DJJQ1/EzKlGyzdA1GWMrD46Y4o/YdxTODveww3xRTWC
	 ssgjZQDrtFzDDwDfXHWRyrZ24bD2JM6P8Ajy6x+OOPaJbfqb7cN+4MHtRoYhOKLaqF
	 qpHALuJ9xWvav8lDLLFBnDKDtGVUetzU/BkgS+wDNpjjzDbfuHUldFqNk1/FDuqPL/
	 3V5UuW2p3Pf//T/zgbFJsiobhju8/N7bur6zUBi9OJTXdC8yWHLM5zHwoASiMFG9N2
	 D0IyBGk+C9T5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTfNk47Ksz4x0t;
	Wed,  1 May 2024 11:19:18 +1000 (AEST)
Date: Wed, 1 May 2024 11:19:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Sungwoo Kim
 <iam@sung-woo.kim>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20240501111917.23e2b0f2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FTr+TF281UwiWCOq85mXmJM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/FTr+TF281UwiWCOq85mXmJM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bluetooth tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

net/bluetooth/hci_core.c: In function 'hci_release_dev':
net/bluetooth/hci_core.c:2831:9: error: implicit declaration of function 'm=
sft_release'; did you mean 'dst_release'? [-Werror=3Dimplicit-function-decl=
aration]
 2831 |         msft_release(hdev);
      |         ^~~~~~~~~~~~
      |         dst_release
cc1: some warnings being treated as errors

Caused by commit

  d85d07aefca7 ("Bluetooth: msft: fix slab-use-after-free in msft_do_close(=
)")

(though I don't see why)

I have used the bluetooth tree from next-20240430 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/FTr+TF281UwiWCOq85mXmJM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYxmJUACgkQAVBC80lX
0Gzk+wgAlpBP/bo5ZVyL1uMJxtq8Z/DOfbKAT3YRqCf4dA25zcW85H4XFT+yVtlE
Mk42e1aXtDJmAskFN+5WN+3OTqrOU8l4wpNep2aOxca29H5QfhwT9P3vKXMYvM2V
KeXL0XQk9mkRD5Jiw7tn1zbo4mAQM9QiZ+MC9Tpw23XSSb4aS5+2c0TtQtrV7N4f
mlUtSkwYhdkX1PT33EbsYvHQDgG1b+QxnVMMfqxaCYfna4AXY0S9k5jxDTY7nHR2
e1FH8cyayQg87jNYKVNYbjba7rtkAWvzI0qEPUZohHcTHzKDDnItwBKwXkvU1H8B
6XiXre4av1iElp+ijD39yLKYtBBraQ==
=xEAS
-----END PGP SIGNATURE-----

--Sig_/FTr+TF281UwiWCOq85mXmJM--

