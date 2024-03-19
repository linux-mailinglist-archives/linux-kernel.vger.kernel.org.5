Return-Path: <linux-kernel+bounces-107257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B029187FA09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD47B20B93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A095916D;
	Tue, 19 Mar 2024 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1pY4XLkN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78222339;
	Tue, 19 Mar 2024 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837432; cv=none; b=uP+4RtxwT/83oXxX2nPvG5MNiaABYQlG04u8AeXr2Lg+2DYxFrp7w1fTa0oTnNnA/2b+1g72vCOs0/aAuYmpf/UDLpHrmNpOKE88O5RZrtAzCMToKcEa6I5t/MG1ySPtGf04Ra74Cpj3nFU2hbIQlEuhJIxLEOc9V0O9ZB3/NmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837432; c=relaxed/simple;
	bh=KxEovkRLfcOBJo8sLybFppNre+BC/0BqX5kv7PHyjYY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hOp54i5dYWHJMYXLn9vYPMF4JEjO9rVfoMVohkFuFf5sPf/bS4qr5f+mqdOlPelmXyKcIOts+r+OgMZ6on9/F4bDgqDckp+iRdk1Lsim176I4tpI5p7ucK4iLhHCMzh0ev3abnwpQX7Sbop5JXizKgwIKdQOz78AmT5+4dSiHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1pY4XLkN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710837430; x=1742373430;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KxEovkRLfcOBJo8sLybFppNre+BC/0BqX5kv7PHyjYY=;
  b=1pY4XLkN8M3AeN4xZUrVuppVrHDCABPDf8VEOBB1QhaWWq+GuemsvHHn
   fZoQ6hW/IdSw7LjHn0oJv5MQAa21jrSPfShPC0AMN1ROTQC6Klnjqu2ot
   2vicVEX7NDXmdSpWMpB76UIvwPU18LZCuG34Gnjly5Qo21Kjslw20w9Ly
   pNT75TLcQSvswiSJf2eEiRASu9YFPgG/ptQdPEwe0UTeeAajAX5VMripA
   PQGRALWSUYaKAZvcqCP3M3SWWqKx7LkXeLeiUehgxSL2BHKBQqKUK1XGF
   PUb1giofIZZCWQrfWWwTS2fU0kbdfls4MKYS+qRe25yLu9I04F36a4pwq
   w==;
X-CSE-ConnectionGUID: nAyssGQoRB+MEbN67pDo4w==
X-CSE-MsgGUID: 66fYV4QuQzi8PbUn7UuNOQ==
X-IronPort-AV: E=Sophos;i="6.07,136,1708412400"; 
   d="scan'208";a="19571076"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2024 01:37:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 01:36:37 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 01:36:34 -0700
From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
To: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<linux-crypto@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <balamanikandan.gunasundar@microchip.com>, <Hari.PrasathGE@microchip.com>
Subject: [PATCH] MAINTAINERS: update maintainer for microchip nand and pmecc drivers
Date: Tue, 19 Mar 2024 14:06:20 +0530
Message-ID: <20240319083620.88181-1-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update myself as maintainer for microchip nand and pmecc drivers.

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82896c3e0559..46c177aa2b60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14394,8 +14394,9 @@ F:	Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
 F:	drivers/media/platform/microchip/microchip-csi2dc.c
 
 MICROCHIP ECC DRIVER
+M:	Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
 L:	linux-crypto@vger.kernel.org
-S:	Orphan
+S:	Supported
 F:	drivers/crypto/atmel-ecc.*
 
 MICROCHIP EIC DRIVER
@@ -14500,8 +14501,9 @@ S:	Maintained
 F:	drivers/mmc/host/atmel-mci.c
 
 MICROCHIP NAND DRIVER
+M:	Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
 L:	linux-mtd@lists.infradead.org
-S:	Orphan
+S:	Supported
 F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 F:	drivers/mtd/nand/raw/atmel/*
 
-- 
2.25.1


