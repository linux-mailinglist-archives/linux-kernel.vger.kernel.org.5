Return-Path: <linux-kernel+bounces-116391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072748899F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08592A6B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E384DA1C;
	Mon, 25 Mar 2024 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="lEQLBH0G"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF0213AA47
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331795; cv=none; b=u0BvkkSSuNzgWbS2xr5lot94Vomq++QEyzdCGr+ypubhQ1ug/08hWYf4EUHhNudLoqHRfWng2NLToJdV+DhVPesVWx1hnIW5aVOAETWtQaABc8BrVyy7cKWsVUur/7NQra2S5z1wTL8riFRdXiLB/EhExjaCpLPooivaJPrt73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331795; c=relaxed/simple;
	bh=mx/VdD1hq7cRmoLLUg9zTXrB6nghO0otx5ehOvo8wJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYl03y7WJsnnw2hboaRnwcBqsPbm2STcBT28WjNhaKe+Btp1R/VI5oZqketZKbW5xJmMjzaJmeUDjs5etoY3cQ98b0SwdgocVzcW+2NQ2aCy8a3/wEHGAu/pjP90j8VGOyFf9GxNdkFgRnezX/yt0OYx293Wml2eAmr/ZI92OJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=lEQLBH0G; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 42D7F2C00C6;
	Mon, 25 Mar 2024 14:50:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1711331449;
	bh=UvZ22nbi3oBrveYANpJX+eOm9E/q+JnPTDDNwgaPVZ0=;
	h=From:To:Cc:Subject:Date:From;
	b=lEQLBH0G0p5FfWe/jQ+cXxHsyUp3lqtUIqVcbjwtkWaB9OV5q+2B6GtUFautBhvaF
	 6Hm2H2VJMpUJ6U8VAcITw39qpvXEBWIkJwoi1d/bjj3p6MpptOD2pMLKn4yG8Gbb3Z
	 x37wgkYLfck9N0JSToTqGF2zTA+wO0vW7HhiegChBUxQMkDDJQjeVOcysvMIrlViTX
	 y3iW1457iQlK4O1tWztSthdXAD5Rb3H7ZDqm9n4BQxR3DJ1lwMooPtADa4yiC2osb6
	 tQ23RTRNzZ1yOHk7+VpgYSoumYI/gGNM0904kbe2N18Jz+QRLZtjEBsUQ61Y3+100j
	 vGOunsPO0fjFw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6600d8790000>; Mon, 25 Mar 2024 14:50:49 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 11EED13ED7B;
	Mon, 25 Mar 2024 14:50:49 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 0CC26280A41; Mon, 25 Mar 2024 14:50:49 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] uio_pdrv_genirq: convert to use device_property APIs
Date: Mon, 25 Mar 2024 14:50:45 +1300
Message-ID: <20240325015045.778718-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KIH5D0Fo c=1 sm=1 tr=0 ts=6600d879 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=kuWcMSrzkGJfJYRAjKUA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Convert the uio_pdrv_genirq driver to use the device_property_* APIs
instead of the of_property_* ones. This allows UIO interrupts to be
defined via an ACPI overlay using the Device Tree namespace linkage.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/uio/uio_pdrv_genirq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.=
c
index 63258b6accc4..772ab42a3ba1 100644
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
@@ -127,11 +127,12 @@ static int uio_pdrv_genirq_probe(struct platform_de=
vice *pdev)
 			return -ENOMEM;
 		}
=20
-		if (!of_property_read_string(node, "linux,uio-name", &name))
+
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


