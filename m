Return-Path: <linux-kernel+bounces-78849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C418619B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A9F1F2342E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BEE13BAC9;
	Fri, 23 Feb 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f2dT9f5T"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E343312FF8D;
	Fri, 23 Feb 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709207; cv=none; b=DEgR4vngauvLFCjuGxHe8x6b0kqCmH56FwcfoaMOVrc4xw+K9YHolwTjEqGbmLa8A5ckuRyCGHI+7eAq63IlFmZ8k5AftwnJshcLSEhR/MeaoU1AlhdvtbCZ7IA6Gfs3YxGJ5wp8tNFnRTl9LKRQzf+hdOVx6jggLdO56/qfPO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709207; c=relaxed/simple;
	bh=b6RY3R0zuqGa4j5oeK47mHYhlfqQm9cq85DEmMV48OQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7icjn4/ucxl539M3DS2WHMbVtUdWheZvD6dYVWnnqlkiRtEtpHoCnGPCKFJ5sJJbmnfkIOJL148iXnt3jUFuWge5vfR0h4kzhZ481wmbDVnyRkEBRIxgTlrea6k0reLH5/1VO2GPneDxcT+rF89WTXdhNffkpHnzMpfL3/MXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f2dT9f5T; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709206; x=1740245206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b6RY3R0zuqGa4j5oeK47mHYhlfqQm9cq85DEmMV48OQ=;
  b=f2dT9f5TMBa8eIxYaeLq1k3vPQlLUCZAijaqp6R6zp5PpjpPmLCHMtN/
   7vIVLmK8uqRptfezv+RtIwWHJLNjmu8EjOY0LX8HkcemGfjw0u0wm3/4U
   b9/jUzh0rMuPBB0H+idG/TrXTduDuLdRcYjav4JESxzpLVt5qf0+urFTy
   2aLHcpApCIwQHVvg+32BjKG8YfwbKcooyd7YE0VR18ILD7xhAanOIP6JW
   syH9rUch/+MgwP4Dv6M2OaKckfKGPf6ytTPPs8JO0IhvNTOOv/C/I7JDL
   gngVSdQQPPtiW5bmSpvBW6CnoReoKRRSWP2KdLavSPIM9C3j+2p1VhBEl
   A==;
X-CSE-ConnectionGUID: wf8h5iB/RBWgwQC4yBIXdA==
X-CSE-MsgGUID: H52Puku3Tpewb437Nrp6SA==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="16734528"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:26:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:26:37 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:26:32 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <wim@linux-watchdog.org>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <eugen.hristev@collabora.com>,
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 15/39] dt-bindings: watchdog: sama5d4-wdt: add compatible for sam9x7-wdt
Date: Fri, 23 Feb 2024 22:56:27 +0530
Message-ID: <20240223172627.672316-1-varshini.rajendran@microchip.com>
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

Add compatible microchip,sam9x7-wdt to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v4:
- Removed unnecessary '-items' from the syntax
- Changed enum as const as per the comment
---
 .../bindings/watchdog/atmel,sama5d4-wdt.yaml         | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
index 816f85ee2c77..cdf87db36183 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
@@ -14,10 +14,14 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - atmel,sama5d4-wdt
-      - microchip,sam9x60-wdt
-      - microchip,sama7g5-wdt
+    oneOf:
+      - enum:
+          - atmel,sama5d4-wdt
+          - microchip,sam9x60-wdt
+          - microchip,sama7g5-wdt
+      - items:
+          - const: microchip,sam9x7-wdt
+          - const: microchip,sam9x60-wdt
 
   reg:
     maxItems: 1
-- 
2.25.1


