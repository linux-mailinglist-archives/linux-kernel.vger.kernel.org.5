Return-Path: <linux-kernel+bounces-56883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB46684D0CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199901C25E65
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79885942;
	Wed,  7 Feb 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="RZxTyRA6"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5EA82D96;
	Wed,  7 Feb 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328954; cv=none; b=qt9ZGABWJdo+IOX9yB8v4f6Rhhrwz50E6XpMXDICWYHt2Joy5Kb8OURI2x6KsCgQBUsb64+ur6DEeEHdHkdDaN0VULahnlFJ+dwFbmiCul1wpeSn4vxllDmggYQte7tVHka5RCjAM2hGhwtjqWo5AU7C8Y11SoZ/EHogJUVrfsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328954; c=relaxed/simple;
	bh=77uzNKLxV1R6k1YJfFpxFNDKxAoJvkjdZ28kaV1uqXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/W4E7kNLR64PXf6ls1cPvxiFN6AK9V7MoGJ6E+IQImKCJj5hwflOjVcNFouZe1G4LgnoMerZSVFMJHlcdX6svY/kVII/ulGyJeshZmU9WimHUCpml1SJRSDCiPT4skaDU2TLZ+hpwvqxx5+V4/diXjHeW5whmdVjclT7FOfgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=RZxTyRA6; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5F69D9C46C5;
	Wed,  7 Feb 2024 13:02:31 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id swXEbVmF0ocO; Wed,  7 Feb 2024 13:02:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DF2B49C48BD;
	Wed,  7 Feb 2024 13:02:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com DF2B49C48BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1707328950; bh=wV6mjwfrwD5VGN0XS4xudNMb5yOVG7KLDPWvun2sA0c=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=RZxTyRA6g8UC73Rf6FIZdvzMThfOk/DX7bGAkBzR8SrsxApXOAvjs5OkoJr+hPpkH
	 yH2stvhnQYMXAADYXdJf7mPXp9yf1Rcm0pAjleVMHwgLmTwuA6WZEYruYWtcL215MT
	 eMOvoTueTLtOSPWorm5CnWpNxtlrodPO2TzKiSlXG6294K+aFMjqW3lFm4BKeejS0g
	 zZnaypPbKaFmxd1w+UmlHi1XycMJz06MFojyB4UvsNP1cFldu58xZyJ2kE6bcbTdNR
	 03amLILuS366/Jr0vMt5+4wZZIBT/l22giiJVoPonJyx+AJxWOsE3dN2AFHbibHKTH
	 xtW4qTrquHtYQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id lwfgIO3Vw8bY; Wed,  7 Feb 2024 13:02:30 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B8A2A9C46C5;
	Wed,  7 Feb 2024 13:02:30 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: mdf@kernel.org
Cc: avandiver@markem-imaje.com,
	bcody@markem-imaje.com,
	Charles Perry <charles.perry@savoirfairelinux.com>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	kishore Manne <nava.kishore.manne@amd.com>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/5] fpga: xilinx-core: rename "prog_b" and "init-b" gpios
Date: Wed,  7 Feb 2024 13:01:26 -0500
Message-ID: <20240207180142.79625-4-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207180142.79625-1-charles.perry@savoirfairelinux.com>
References: <20240207180142.79625-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

New bindings use "prog" and "init". The legacy name is used as a
fallback.

Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
---
 drivers/fpga/xilinx-core.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/xilinx-core.c b/drivers/fpga/xilinx-core.c
index 597e8b7a530b7..4d2416e71d59c 100644
--- a/drivers/fpga/xilinx-core.c
+++ b/drivers/fpga/xilinx-core.c
@@ -171,6 +171,28 @@ static int xilinx_core_write_complete(struct fpga_ma=
nager *mgr,
 	return -ETIMEDOUT;
 }
=20
+/**
+ * xilinx_core_devm_gpiod_get - Obtain a resource-managed GPIO using a
+ *                              legacy consumer name fallback.
+ *
+ * @dev:           Device managing the GPIO
+ * @con_id:        Consumer id
+ * @legacy_con_id: Legacy consumer id
+ * @flags:         optional GPIO initialization flags
+ */
+static inline struct gpio_desc *
+xilinx_core_devm_gpiod_get(struct device *dev, const char *con_id,
+			   const char *legacy_con_id, enum gpiod_flags flags)
+{
+	struct gpio_desc *desc;
+
+	desc =3D devm_gpiod_get(dev, con_id, flags);
+	if (IS_ERR(desc) && PTR_ERR(desc) =3D=3D -ENOENT)
+		desc =3D devm_gpiod_get(dev, legacy_con_id, flags);
+
+	return desc;
+}
+
 static const struct fpga_manager_ops xilinx_core_ops =3D {
 	.state =3D xilinx_core_state,
 	.write_init =3D xilinx_core_write_init,
@@ -186,12 +208,14 @@ int xilinx_core_probe(struct xilinx_fpga_core *core=
)
 		return -EINVAL;
=20
 	/* PROGRAM_B is active low */
-	core->prog_b =3D devm_gpiod_get(core->dev, "prog_b", GPIOD_OUT_LOW);
+	core->prog_b =3D xilinx_core_devm_gpiod_get(core->dev, "prog", "prog_b"=
,
+						  GPIOD_OUT_LOW);
 	if (IS_ERR(core->prog_b))
 		return dev_err_probe(core->dev, PTR_ERR(core->prog_b),
 				     "Failed to get PROGRAM_B gpio\n");
=20
-	core->init_b =3D devm_gpiod_get_optional(core->dev, "init-b", GPIOD_IN)=
;
+	core->init_b =3D xilinx_core_devm_gpiod_get(core->dev, "init", "init-b"=
,
+						  GPIOD_IN);
 	if (IS_ERR(core->init_b))
 		return dev_err_probe(core->dev, PTR_ERR(core->init_b),
 				     "Failed to get INIT_B gpio\n");
--=20
2.43.0


