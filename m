Return-Path: <linux-kernel+bounces-108398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82DE8809FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF28B1C22399
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5B8101C6;
	Wed, 20 Mar 2024 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TF5n0Npj"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68828F4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710903204; cv=none; b=BIijc2lDhc4oLAI8pEyv6aa+QyJKD5z+1E6ntJDsSgQVC9NhZWcJivrmYiagv5zliCnr0cWzi5xkyZzxr3gc+XHJpuYhjh5d819WgdIgU28Hrt+os6RUYsvvikYRqe/39+z2ZXPA8x1PwzylyQm937mo9HxSvcUkN74xHouAHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710903204; c=relaxed/simple;
	bh=3wOx2qDEKjHgiu3tYCtv/UuUYuX2mzOT+NakgfgxUpA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AzuATWqlQnST4eZoF/XVHlUlj3HikIOWFEJC3GPBxHkE/tJx/YzThlk7VySpkMxWn5CwKtkRGutMoUndgP3sHY7aBp7sODAmmy7NUEGqSlpSHOPtkaT1XymABl6MD4DrJ/52K+HiriEo6l9Kj3Jhu+sTnqrBINx5uHUaN71LKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TF5n0Npj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710903201; x=1742439201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3wOx2qDEKjHgiu3tYCtv/UuUYuX2mzOT+NakgfgxUpA=;
  b=TF5n0NpjBF/9oHmPqL1wNDSez2eDUEHo4Lv/7T8cI2pbCzWmQfsXDGN1
   4HCbBHui7YmrtVURKA2cFj28tm+8g02klLG6DbgBp+QcWB5xBzkEFzM0N
   PLgbMY3rtP5HI+AuhjQKHiYpZ8doHFq9TecNz4ivWjAF9hIzkVrABAZJf
   aGyihwrIlJ76fHxqi0ndq05TuirP5uNhvdI7DHklLmvNF6Lw4kRdjB94s
   x79KQfwUTs7vkdS+gUqW3bX7NieL9pMbswCoqGGgXz7tmW2KT8VBtAyOu
   Es0pSlKwjnBIXJ6dnUhBSg+TZYzIpJjOghsypKkUALysyM21bww/y/Qei
   A==;
X-CSE-ConnectionGUID: C7KcuK3eRZm2UzlPs6x+Yg==
X-CSE-MsgGUID: 00oSvkqLR/K8e4v0SunErw==
X-IronPort-AV: E=Sophos;i="6.07,138,1708412400"; 
   d="scan'208";a="185147938"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2024 19:53:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 19:53:05 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 19:53:03 -0700
From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
To: <linux-kernel@vger.kernel.org>
CC: <balamanikandan.gunasundar@microchip.com>, <hari.prasathge@microchip.com>
Subject: [PATCH v2] MAINTAINERS: update maintainer for microchip nand drivers
Date: Wed, 20 Mar 2024 08:22:58 +0530
Message-ID: <20240320025258.6854-1-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update myself as maintainer for Microchip nand and pmecc drivers.

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---
v2: Removed the incorrect entry in microchip ecc driver

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82896c3e0559..b6582bd3eb2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14500,8 +14500,9 @@ S:	Maintained
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


