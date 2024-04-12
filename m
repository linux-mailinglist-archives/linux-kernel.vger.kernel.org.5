Return-Path: <linux-kernel+bounces-141944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1006C8A2564
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6C01F23872
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66C199B4;
	Fri, 12 Apr 2024 04:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xux96C8h"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC0C14F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897755; cv=none; b=hQ3Lu9cJBw5KKmMpJY0mU9CreNlhxUvypOabNajkFue4HZ1LUSXdDL69h8vwrZMzqHmTv8mfp970msEnxQlq3LM4VGz+ed1/V9iP9R054ozybUyIAuIZ8KXRfb8yMeje0CGu3SnuvhTc4Y/lEw3PYyAAlIq4DHY3cFhJYV25eUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897755; c=relaxed/simple;
	bh=M2jzVZ8+KjNuU8n6rv/zCWuWp+BU8vA8ZeVWzeYBJH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khehFRo+jQmsNSA/VRjgNdWIKhDcLQMg7zJfyQ3/5PYGF+VVOuosaJZ6yQdiTif8dbKI3T8XRrBci+kfyoVS+X2Usd+RtpI8MQ/BJBdjWNT35xHuAos/vEP4R9aVp+bryDmviNRVUw7DShvWmGWHmkZ+Dna6zUWRev4/qgHvH90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=xux96C8h; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 924082C0320;
	Fri, 12 Apr 2024 16:55:44 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1712897744;
	bh=WjkOv3uKagUxfCycJ62ZDravSNC8MLdiB6ELd2mC+TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xux96C8hTDnLNcyzULjxa+cKUW9nu4ULz/3TBUPcvAhcMbjdAOYhPuMRo+DWvL1GD
	 YMRNEfpJLuARXfLQt8k5wWKFdzsxtNv/VHbgUhAg5RP5C3uk7fDYLzn3ptJtkDXor0
	 0V8IXiDHdhdLc5SIPKwbgk07HDJ5M7KV+uiUMxjRwusa2/f+12gbVdrxV1pKKQga6u
	 KO1Xr4M9MeeALfD0cLIZll6wfQywgpBwgrk1mnv5ADSoYArzFrkqTsqoP8BXaOneV6
	 v+4r9kf2iXIJ4kgGkENUtSIDOsv/vkxuqsofbBwYOOfJQNIILKdFraqhRln/cfDlyX
	 BCQyKW/65imZQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6618bed00001>; Fri, 12 Apr 2024 16:55:44 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 3BC9713EE52;
	Fri, 12 Apr 2024 16:55:44 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 392D7280566; Fri, 12 Apr 2024 16:55:44 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org,
	guanghuifeng@linux.alibaba.com,
	cleech@redhat.com,
	njavali@marvell.com
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/2] uio_pdrv_genirq: convert to use device_property APIs
Date: Fri, 12 Apr 2024 16:55:35 +1200
Message-ID: <20240412045536.1909897-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240412045536.1909897-1-chris.packham@alliedtelesis.co.nz>
References: <20240412045536.1909897-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=6618bed0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=raytVjVEu-sA:10 a=0-5qEPbCpBJHDBHC09kA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Convert the uio_pdrv_genirq driver to use the device_property_* APIs
instead of the of_property_* ones. This allows UIO interrupts to be
defined via an ACPI overlay using the Device Tree namespace linkage.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - None
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


