Return-Path: <linux-kernel+bounces-78841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC39986199A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C802825B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0E8143C6C;
	Fri, 23 Feb 2024 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wZPnVDIE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327AA143C5F;
	Fri, 23 Feb 2024 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709156; cv=none; b=f3Q2lwriYrwYYWgRWgIIYvgLDQ1Nu3yoPWzm4Qtd8N1YYgq0lPvq5N+62lpolFKlPneHyatVTNbFhosjtOF4ouCaphfmwZBvqNB6GggJLmm9XL/poMNFhI/IHz7LRvS+GSUEqboAKO3VRSJoz4xZuMNFU/tDZny/d5hw5JnYj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709156; c=relaxed/simple;
	bh=igHDeF92LiyJV6CYdDteCC2bRTjg8rQRg4+bhnAd1mA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIjqJlVk8cwYlt68oUwFhd5KZmTnOR0Q0qPZXYnz7MiCR4+oW3dPoJHbra++l3tfOBJpcYQcFfL2Gmgc5VqTX8MVav2m3e/MsS+++SBJq6m9p7RSgO1cEwQBCEFp4epBfrAw8kRrpKnXQRl3KfOBxLAgXQYI1hTPA2+wZolC1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wZPnVDIE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709156; x=1740245156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=igHDeF92LiyJV6CYdDteCC2bRTjg8rQRg4+bhnAd1mA=;
  b=wZPnVDIEbrCMeE4jMHHMfaEMJiTtDfzo7uRbchodJR02JmSkgKFAkHmw
   +aVPLItMkFEEkfkEKgm8nY+izgRsY5Xg6uZWOalCVNjV9lsidUrQz6yTc
   6Zf24ivlOo975UiRmuBKb0ZTxx6+3UD55fKl48XeWGzYpnd2dGl0Mf1Dj
   7Z2DFuV9nwj1T9ezI6RxXYxmtgrazz/9/DypgfC0ISVNhNXWV2jbdVC6Y
   yJkmxuJcbTUd47ABc/YmVpoWkgFLuQJ4ittrwNjL7GI+KLEjFVBYxsXhQ
   zqrs2WedvzJ/okFDkLt5kk/I34dZ+jBdBre49l0v9q1uqoGGxKD6bkCtq
   Q==;
X-CSE-ConnectionGUID: yqAR4j5MT/u3WWYb46nLgA==
X-CSE-MsgGUID: BwHaQGmTRgSiNQnK3eo0Rw==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="247481342"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:25:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:25:30 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:25:25 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <tudor.ambarus@linaro.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 08/39] dt-bindings: atmel-nand: add microchip,sam9x7-pmecc
Date: Fri, 23 Feb 2024 22:55:20 +0530
Message-ID: <20240223172520.671940-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223171342.669133-1-varshini.rajendran@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add microchip,sam9x7-pmecc to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/mtd/atmel-nand.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index 50645828ac20..4598930851d9 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -56,6 +56,7 @@ Required properties:
 	"atmel,sama5d4-pmecc"
 	"atmel,sama5d2-pmecc"
 	"microchip,sam9x60-pmecc"
+	"microchip,sam9x7-pmecc", "atmel,at91sam9g45-pmecc"
 - reg: should contain 2 register ranges. The first one is pointing to the PMECC
        block, and the second one to the PMECC_ERRLOC block.
 
-- 
2.25.1


