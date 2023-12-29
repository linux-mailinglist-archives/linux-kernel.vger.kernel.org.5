Return-Path: <linux-kernel+bounces-12905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 337B981FC6D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D621F245D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6908015A2;
	Fri, 29 Dec 2023 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gt7HwHFM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9A8813;
	Fri, 29 Dec 2023 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BT1icx3102916;
	Thu, 28 Dec 2023 19:44:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703814278;
	bh=FaxA5fwOZb/Z4U7VCoF0drUnbXm1Lqn0KQRa4A85p10=;
	h=From:To:CC:Subject:Date;
	b=Gt7HwHFM8wDLzcqYsIo1M4vSvjh3lSCgvCpYoZkqFNlbHkoI55HFnHJFsgh8hH2TG
	 zapscOBQhJHaReTqv+ysIG+3wAkILYYg19R1ZWZETs610cjM0OiA6Fn8UUrSoxvelG
	 q+C2WZ2bYSDSQN4UhiLW5+xYvjWR6PG4kQ1UmeLY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BT1icSc113716
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Dec 2023 19:44:38 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Dec 2023 19:44:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Dec 2023 19:44:38 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.188])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BT1iYPs103805;
	Thu, 28 Dec 2023 19:44:35 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-firmware@kernel.org>
CC: <kevin-lu@ti.com>, <baojun.xu@ti.com>, <13916275206@139.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <soyer@irl.hu>, <peeyush@ti.com>, <navada@ti.com>,
        Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v1] ASoC: tas2563: Add dsp firmware for laptops or other mobile devices
Date: Fri, 29 Dec 2023 09:44:30 +0800
Message-ID: <20231229014430.1367-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add tas2563 dsp firmware for laptops or other mobile devices.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 WHENCE                     |  13 +++++++++++++
 ti/tas2563/INT8866RCA2.bin | Bin 0 -> 1076 bytes
 ti/tas2563/TAS2XXX3870.bin | Bin 0 -> 20128 bytes
 3 files changed, 13 insertions(+)
 create mode 100644 ti/tas2563/INT8866RCA2.bin
 create mode 100644 ti/tas2563/TAS2XXX3870.bin

diff --git a/WHENCE b/WHENCE
index 6da8969..e48bd1c 100644
--- a/WHENCE
+++ b/WHENCE
@@ -7087,6 +7087,19 @@ Link: TAS2XXX38E0.bin -> ti/tas2781/TAS2XXX38E0.bin
 Link: TIAS2781RCA2.bin -> ti/tas2781/TIAS2781RCA2.bin
 Link: TIAS2781RCA4.bin -> ti/tas2781/TIAS2781RCA4.bin
 
+Licence: Allegedly GPLv2+, but no source visible. Marked:
+	 Copyright (C) 2023 Texas Instruments
+
+Found in hex form in kernel source.
+
+--------------------------------------------------------------------------
+
+Driver: ti-tas2563 - tas2563 firmware
+File: ti/tas2563/TAS2XXX3870.bin
+File: ti/tas2563/INT8866RCA2.bin
+Link: TAS2XXX3870.bin -> ti/tas2563/TAS2XXX3870.bin
+Link: INT8866RCA2.bin -> ti/tas2563/INT8866RCA2.bin
+
 Licence: Allegedly GPLv2+, but no source visible. Marked:
 	 Copyright (C) 2023 Texas Instruments
 
diff --git a/ti/tas2563/INT8866RCA2.bin b/ti/tas2563/INT8866RCA2.bin
new file mode 100644
index 0000000000000000000000000000000000000000..0dc1ee2267f39abdbefa5dcb3f8051c7944c188b
GIT binary patch
literal 1076
zcmd^-ze>YU6vn@MbH&g~A3-8?QqkfcaByfvy19#kkj9Hdiw%hiE`pn@IJw&waPS!%
zJ2?6h;?hCH@1zD1lYm*h;UhP>IbY82oCBD(@$$_Bpr$Bgqn8f_Xvaae3^!xy=}Xty
z!GF2$oF!r49oWOzTCY`!+JU3y8R=3gy`US)s0BW6QyK=dP+HC!z_jM4dqC|CsBZx?
zZJ>1rtUd$l_rS&+u(=DgAAwE>=(0x|+Ne>9-x2+8>DQ$n|5@tCS<ndle%Oos({OM?
z+e)j5n_O6=GH$5~Ya=Y~{v<!iQ*x}mPU?~JU6sT!N#Xh(cRmOM>yf5ki9v#jIEMN8
z<S_`F^fl#pFNn)w_>QxF9EFxBNp!s8^)4bmNhG;HEUk0qkaM#{k0vGa=W-5Z{w`Th
KzN&Novk#vS5<}4d

literal 0
HcmV?d00001

diff --git a/ti/tas2563/TAS2XXX3870.bin b/ti/tas2563/TAS2XXX3870.bin
new file mode 100644
index 0000000000000000000000000000000000000000..47ad51020615a15ef0335ad03d8e86010521e87f
GIT binary patch
literal 20128
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

literal 0
HcmV?d00001

-- 
2.34.1


