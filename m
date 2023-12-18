Return-Path: <linux-kernel+bounces-4495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDC6817E31
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE14B23658
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71B760B0;
	Mon, 18 Dec 2023 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cTgFV7HJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851411D14D;
	Mon, 18 Dec 2023 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702942647;
	bh=46/1y0bwzTDSoSxJQVUpZ7e0bPr6XBblpse94JxyJjI=;
	h=Date:From:To:Cc:Subject:From;
	b=cTgFV7HJeFXCp3LQV5+eUEZlJnYNVDHYPSLt7X+a5gwXvxO3ozY1MqKClb7Je5gTv
	 yZLJjUo/HVARQHmd+6WDT43cwxo4UKIpBryO5uFCV7C4g8yMLbE0xpfGcUP6rL1ogx
	 WAuMxd/78lV7vS3U0TCSLmMbvQiXRo86GWkyGb+wad8hHIEQqQxqH8D0U/8VwGmvgl
	 fVCWfMGDaesJg2Q4v54MIJtwRbzzHRAuIg1e3kZRscUppngubRAvM0qvRtgmRyCtpF
	 9p8i4rqOVkDnXjyHRXPjYjlV3YwZzH+rc0vI75Gs703Pc0tGR00TInMJ7vX5FGF5ym
	 +WkU8S/1Zpfeg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvGT32qK1z4wbr;
	Tue, 19 Dec 2023 10:37:27 +1100 (AEDT)
Date: Tue, 19 Dec 2023 10:37:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20231219103726.720e569a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zNRhK8t9mistuNOsyYNsue1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/zNRhK8t9mistuNOsyYNsue1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

ERROR: modpost: "acpi_device_dep" [drivers/platform/surface/surface_acpi_no=
tify.ko] undefined!

Caused by commit

  90d843b96b49 ("ACPI: utils: Introduce helper for _DEP list lookup")

I have used the pm tree from next-20231218 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/zNRhK8t9mistuNOsyYNsue1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWA17YACgkQAVBC80lX
0Gw1Ggf+KBUya7nVI79McFN5WTC6C+B5nlep8a7O+1rb9bHICBUXXhkZhpwc6HTl
GESZFHGvQwnk4Mf4k0wLaVgDoCVhapc/iUT52Bl1IRMA6PVeK+mRyLjO8Q8Wdevb
cZMff2HDymhZG0DrdjeQ5jVMYosDlUwtMT5Ni23rmPN/44X79UgCYCTq77ldJIhX
VYDkYSnvhM127G97ljI2Kq/NPMHcmJsv/ZaDCPUpDr/YWUl6qdoJANuBxNa1Gnc1
EpH/VoBXSEK9edh7SxmqyRPqaRRvgiNLqp+Xy26ERM3PuPP1klz4SaaHY3zUVqYw
Mr1h6I6NWh6oLjhYbLw9xvXNhEh2sQ==
=qFQ3
-----END PGP SIGNATURE-----

--Sig_/zNRhK8t9mistuNOsyYNsue1--

