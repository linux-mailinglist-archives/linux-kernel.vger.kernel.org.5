Return-Path: <linux-kernel+bounces-3931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4513081753C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01BC1F24308
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ACC4238A;
	Mon, 18 Dec 2023 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pwGzBppi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1133A1C1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BIFV2GY126315;
	Mon, 18 Dec 2023 09:31:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702913462;
	bh=QwHBdz9w94lCzbncal8M8zIKxQeR3PIqfF/KaIwPR1o=;
	h=Date:From:To:CC:Subject;
	b=pwGzBppiZZ+KOvoD/vQoF55paXUoc6+tJxaMk7PHqqHAouNAH+/JsCRo3+EN3HPQ4
	 Y6/hhfL22U07S6mf8JvfJ3YsFhpNVlghCMmxgkWZ11lWe0bJ21eSOx4FNQ2A5M5i7c
	 aQS6ZAAdJJvAiS7TUsqlk+LhDefq8zYlCqv/O0mc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BIFV2Pp106208
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Dec 2023 09:31:02 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Dec 2023 09:31:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Dec 2023 09:31:02 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BIFV2je022994;
	Mon, 18 Dec 2023 09:31:02 -0600
Date: Mon, 18 Dec 2023 09:31:02 -0600
From: Nishanth Menon <nm@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [GIT PULL 2/3] arm64: defconfig: Updates for v6.8 for TI K3 platforms
Message-ID: <20231218153102.ptduqsvtsq7sxs5n@tinsel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ccdybajxm2udcssp"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--ccdybajxm2udcssp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-c=
onfig-for-v6.8

for you to fetch changes up to e8779517788fa0f3d04840cb7d4121d3df8dfd54:

  arm64: defconfig: Enable DRM_POWERVR (2023-12-13 08:45:05 -0600)

----------------------------------------------------------------
TI K3 defconfig updates for v6.8

- Enable TI K3 SoC components PRUSS, CSI2RX, POWERVR for various boards.
- Enable TC358767 for Iot2050 board
- Increase 8250_NR_UARTS from 4 to 8 to support AM62x verdin boards (minor =
increase in kernel image)

----------------------------------------------------------------
Aradhya Bhatia (1):
      arm64: defconfig: Enable Toshiba TC358767 bridge

Donald Robson (1):
      arm64: defconfig: Enable DRM_POWERVR

Francesco Dolcini (1):
      arm64: defconfig: Increase SERIAL_8250_NR_UARTS

Jai Luthra (1):
      arm64: defconfig: Enable J721E CSI2RX

MD Danish Anwar (1):
      arm64: defconfig: Enable TI_ICSSG_PRUETH

 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--ccdybajxm2udcssp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmWAZbAACgkQ3bWEnRc2
JJ0XOxAAmfF0O4Er1tm6pvMsEf/WYmTcXORPGETzHk4fh9T6j6VGnpsMkLCvbj8X
Mb8N7LKJlM1YAptzp8Ky1Z3CqAgTpEKiGlm7pho13VFeH3cxDdKHqhEZ/S/GCamx
mX0svBdoEb1zXYm/+cFPOa5V17zsajPN7XGGs6gWn8OW3/XPotPWHrbDGX0nSWZI
fcRtUPBi16la95QxV+XpncXgbBVMiG98NF0MiE2tVRr0QJzWI0DEkhjmsOTkvf+N
XC/lCRUviiiK2SKQa6z+2irmVHYc+ePr7meZ7Wlh7mRfnCShiXB8tr+cr2NjM/P6
PolSj6scIMD7Ga4kqqaQWkQU3DxPS7kXkCHXPgi7ayDnEi3Qz8Mq0ST9Q5JQysF8
JrKqhWm7K2/fq5hL2Pm6NQnwtI8jqSNO/DRDczTW3J1FwKlpIrOJD5+e22ED8o80
cT9CF3Fl3yYq+yXXNPm/Q2pvnx4kWEUlDpIYUJ3xuTENrSf4M/mmN0rB1pXkTjeY
Y8V86QsM6qSlgN3E2qVGXQif/ZeNGfDlVHSWPRdhkZ3b8UWMG0JYxPkHBARiNIh+
qAWx55z56GWg1Atg5h/ey2tSsFce2inQmhMoL0ulo5++1b7vVu3q9R0zcLyzQC2c
xQlcCjZa7MDMDgyA0xOn+OQ0isCjYyglNaeBoRpW3wXCLVWZGFI=
=TQo0
-----END PGP SIGNATURE-----

--ccdybajxm2udcssp--

