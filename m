Return-Path: <linux-kernel+bounces-136022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B885989CF03
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D258E1C23CD8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B37149C7F;
	Mon,  8 Apr 2024 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="CE3xrwCY"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4F171A1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619663; cv=none; b=mF58f9JVga/WEcx7oCpNLUDNOkq2LR5bMaPdYzKcGH669VBxOYBbSpOQZawwXNPF3w0Xe+vGUUcDJDASltJ+xNwseKUi/39XQTAXu+Kvl7eowmUWgwP/UspExanYcfy3w61IeSllHvdAa5fZZX++VKYQd9H3TSAZWoVa6PtZ9fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619663; c=relaxed/simple;
	bh=nGVBkZiKyNJu572sTsUpZ6tZsvjqorg2/fE5SwF8ubY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aM33B0ERvoScPEDRMhq2xkLHLCwAclMWKHwK7kW5Q7LuyX/wgPzHi1E4z8ktzTp9Y9MqH+8pmZaMhF6Li6Z2mpp0fSWt+3L1kLiNgMBCU1zZ6gtJYbPEYzr1bO6kYPuFcX1dPOXCvNZLBI5CklrwcpCq8YmaF3pWPLqo8AwAoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=CE3xrwCY; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 56C3E2C023D;
	Tue,  9 Apr 2024 11:40:52 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1712619652;
	bh=ce2C3mFUjKHfphm5glLdo0kYS8B23G4tb8eLLffI+F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CE3xrwCYAXgCKQ1ghoDmBjulloVo/VtAdpNIbvq4UNzpCPeTP+rt6xqb3qmeFsh2Q
	 r44nTA2dbsbhjGzOJGXhvQ7g6E6LSjI2kua1lGo/Ryw15MpQb4WCxm/e+Ew6JFGb7o
	 x9cMyPtz11JmNrVdRYKK2OHwibl4YwChRL/bfYCIa7Ubq6ZfhCrHqTdGxZPmyw+BRk
	 rrc+sjRCw99MkaTG9NRX3MTR5k5BSCvxru+fL7w7udx1GHJsPXnK421TC0XCn9xaoI
	 kvyu0R3DX+xFqEySBcxSMo1kxKZ0kqJ353AXYTTSWQHDmhRGtrNRYDRb0MIPE0ZdBC
	 bpCZFwHzTmD6w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B661480840001>; Tue, 09 Apr 2024 11:40:52 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 3255113EE52;
	Tue,  9 Apr 2024 11:40:52 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 2EEA828058C; Tue,  9 Apr 2024 11:40:52 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org,
	guanghuifeng@linux.alibaba.com,
	cleech@redhat.com,
	njavali@marvell.com,
	baolin.wang@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] uio_pdrv_genirq: convert to use device_property APIs
Date: Tue,  9 Apr 2024 11:40:48 +1200
Message-ID: <20240408234050.2056374-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240408234050.2056374-1-chris.packham@alliedtelesis.co.nz>
References: <20240408234050.2056374-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=AuZN3/9P c=1 sm=1 tr=0 ts=66148084 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=raytVjVEu-sA:10 a=0-5qEPbCpBJHDBHC09kA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Convert the uio_pdrv_genirq driver to use the device_property_* APIs
instead of the of_property_* ones. This allows UIO interrupts to be
defined via an ACPI overlay using the Device Tree namespace linkage.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Remove extraneous newline

 drivers/uio/uio_pdrv_genirq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.=
c
index 63258b6accc4..796f5be0a086 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -23,8 +23,8 @@
 #include <linux/irq.h>
=20
 #include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/of_address.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
=20
 #define DRIVER_NAME "uio_pdrv_genirq"
=20
@@ -110,7 +110,7 @@ static void uio_pdrv_genirq_cleanup(void *data)
 static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 {
 	struct uio_info *uioinfo =3D dev_get_platdata(&pdev->dev);
-	struct device_node *node =3D pdev->dev.of_node;
+	struct fwnode_handle *node =3D dev_fwnode(&pdev->dev);
 	struct uio_pdrv_genirq_platdata *priv;
 	struct uio_mem *uiomem;
 	int ret =3D -EINVAL;
@@ -127,11 +127,11 @@ static int uio_pdrv_genirq_probe(struct platform_de=
vice *pdev)
 			return -ENOMEM;
 		}
=20
-		if (!of_property_read_string(node, "linux,uio-name", &name))
+		if (!device_property_read_string(&pdev->dev, "linux,uio-name", &name))
 			uioinfo->name =3D devm_kstrdup(&pdev->dev, name, GFP_KERNEL);
 		else
 			uioinfo->name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						       "%pOFn", node);
+						       "%pfwP", node);
=20
 		uioinfo->version =3D "devicetree";
 		/* Multiple IRQs are not supported */
--=20
2.43.2


