Return-Path: <linux-kernel+bounces-17512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECD6824EA4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931E8282E91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ABE1DFD9;
	Fri,  5 Jan 2024 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NKv2N6VG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A821DDD9;
	Fri,  5 Jan 2024 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704436181;
	bh=0KTXj9eriEvGD7WssZFoeIm+vhVPJwH+2vZ744sORAc=;
	h=Date:From:To:Cc:Subject:From;
	b=NKv2N6VGdfmgJL7vnCHCJSApUXcGxaPV9p81WUJMQH5CoqQVA0OM/AZDGui8B172R
	 BQ7BLVjEDsLZrnBg3L3XC8SAz+oIbpNLyWTESYUDCL1PRKdR0l3xtLzGjluf58QB+N
	 cjugTizb8tPq7zordyDsktMKSyrcc5KXYzGIRIxGWZSQE97hguuHshs3Q54WErQaBf
	 TGPYSjycG9CCAZUIXsGGxJXmWfofPc1/7RUbLp8Wcyjq/6ie983ElX61rIgpcHAymX
	 JO1LrLfep6GKtU07YZKMu0iw9J32JxMTzcW7uKhWsMKkg3PleYsnhuuXGx37NEYo5m
	 R1M4uHKg95I8w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5tps3LC7z4x1p;
	Fri,  5 Jan 2024 17:29:41 +1100 (AEDT)
Date: Fri, 5 Jan 2024 17:29:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: Henry Shi <henryshi2018@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drivers-x86 tree
Message-ID: <20240105172940.018d4bc9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V3xBY8brWa4wkBNHxH_ho7n";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/V3xBY8brWa4wkBNHxH_ho7n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drivers-x86 tree, today's linux-next build
(htmldocs) produced this warning:

Warning: file /home/sfr/next/next/Documentation/ABI/testing/sysfs-platform-=
silicom#20:
        What '/sys/devices/platform/silicom-platform/power_cycle' doesn't h=
ave a description

Introduced by commit

  d9cd21d441c8 ("platform/x86: Add Silicom Platform Driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/V3xBY8brWa4wkBNHxH_ho7n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXodQACgkQAVBC80lX
0GwINwf+N4fffopCPJJXDGxL7Lg337Tz6DFb9aWzexAgZtfKQdjnFkz8phBzTOth
0sM1aigMyJhiHeUT6oGB+ex1rSLrfFYO6bXEzb67lMoZ2r/tQfuFcF0doXQlHNY8
3VLOnzUeiSNofXMkMMUYiExLSCvQibilGO0DUQaf+nOkn6sTWPARWiyrA9zW7K37
NyU8uzVdaEW/2Dbt0LH+fTzYIG0aH3Q9vrleE3ry3X026YxnJP2T0ZD82E6xwgM3
wXtXTKcS8bNMeYh+hBaHiuXFEFqF2yq+qmeUCGfqfVcdgZy2h5ufJaCVMtLoEyTl
z9ZpnM32EGoUpkA3ynLp4Q1wj/eGRQ==
=RfQp
-----END PGP SIGNATURE-----

--Sig_/V3xBY8brWa4wkBNHxH_ho7n--

