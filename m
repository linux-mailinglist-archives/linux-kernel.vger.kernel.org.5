Return-Path: <linux-kernel+bounces-3930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C71781753B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4F01C234A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417293D57D;
	Mon, 18 Dec 2023 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ITlzFuuL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2EE3D576
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BIFUd77126252;
	Mon, 18 Dec 2023 09:30:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702913439;
	bh=xAs4EhyOhWeylnCWSyUBeu/JKufN7phFIzjaz4yET0U=;
	h=Date:From:To:CC:Subject;
	b=ITlzFuuL5Po6nuGOKxcImazOOCo4CaHOSUBsH8IeMnGDMx1OrEScGJA2OEYT2U5K2
	 ezGDS3XFkiD8W8MFfNkvnPZgMHMpnSTrLZEbUHlYQkT5fxeMlkeo21osincgbdi6g4
	 1vo3KxQ5pqiGHMy2EVIMDatGXGJtmB0AE/GuW96M=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BIFUd4U126529
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Dec 2023 09:30:39 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Dec 2023 09:30:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Dec 2023 09:30:39 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BIFUdNJ022454;
	Mon, 18 Dec 2023 09:30:39 -0600
Date: Mon, 18 Dec 2023 09:30:39 -0600
From: Nishanth Menon <nm@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] ARM: dts: ti: keystone: Updates for v6.8
Message-ID: <20231218153039.dok52xazqshbr6ie@playroom>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="doilzwmdfk4qzhlv"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--doilzwmdfk4qzhlv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-keys=
tone-dt-for-v6.8

for you to fetch changes up to c1170c1d04d5bfbd9b38cb968d45b77e6bda2098:

  ARM: dts: ti: keystone: minor whitespace cleanup around '=3D' (2023-11-24=
 12:53:00 -0600)

----------------------------------------------------------------
Keystone2 device tree updates for v6.8

Cosmetic cleanups:
* white space cleanup around '=3D'

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: ti: keystone: minor whitespace cleanup around '=3D'

 arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi  | 6 +++---
 arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts     | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi  | 6 +++---
 arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts    | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi | 6 +++---
 arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi  | 6 +++---
 6 files changed, 14 insertions(+), 14 deletions(-)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--doilzwmdfk4qzhlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmWAZZoACgkQ3bWEnRc2
JJ0JJQ//VQcObzcDIJZDklf8LEuzFOg0mI+6T48fkHy+Q7ZBQTkxwN/zPTps+bwg
X/yL6DaidcOncPGrHDHRj/dbDIwpl/BzJLc4FCRPcpygVjFEzEoVU42h2TuSwSf3
czVtT+C8x2zCb6vMkYSLFeXvIBqC29oHWvQ+G8NGkzAs5XyudspB1mU9vkh/sXnR
WgsS+PcaJK5RXI3zjr3PEEtvTQV0ADQP5id9vUv1hkQYbKISuVB0sjpCvpCWVbu+
vDOyFd/VNu9/Sprt3FE1G7b6pwS+xaWOMG6xDoeoyMvb/oof5F6S48i1qKC6L970
XpWqLD8AevluVxwEWkKw4v6sTaFQY3jIBIihqoO/wSLaxlKPq8JkYSbNuHucKKzD
s6ryuI1yDose9Nxg0TT0sN/P+eX4RvKZfmjtiSINVsZ7J386wQi/gN8fuRU+zRur
kaQGsJVlN58Pc72yXEaiWvQHN1XWk9fIHTYLC7fP9wSB05MH9NcV8tyLdTqmJtYQ
Lx801W6xE5X4Hc3jeYZBxSjRrnZ/rYDhONH3trbkXZ905C9gbOv8ozkZa3Gad3n5
e3AFS4O931Ru5aCcNhwyK3B+46DiAvAv2oARFqHExrSF1ExtJOG1HZqTKGDCLbDp
/wLs1PkMAw4IpUwZ+elRqgdz7x+7UFluAvbiuUYsDtXFjgHVH7U=
=nYP9
-----END PGP SIGNATURE-----

--doilzwmdfk4qzhlv--

