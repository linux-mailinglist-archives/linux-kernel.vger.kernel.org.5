Return-Path: <linux-kernel+bounces-78826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EFE861963
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4CA5B23C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0702413A27A;
	Fri, 23 Feb 2024 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tIckocSj"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039112EBFD;
	Fri, 23 Feb 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709126; cv=none; b=np5lM7Idt2OTkg0DQCECD8H7cu0Zzv9t0Gb5zMNB9Oi250LY2vtVczVlkqLyXsbUVEuChsvusvi8KZ6rhw4Zq6gtRdRNrfIS/bzGjTvThMCcEPNaNh7m3vbvsVrOurNbkK1CRht+cEuqR1KQaN6b1f9NVsdGyyHBmdFNMHqNwuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709126; c=relaxed/simple;
	bh=5r33dar4uXTcIxiLo2EE3ZhpnzHXGBgTGDLgfEfSrvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tp4XpqMTa1A1d1oNU1qbvlMgq8OROqkh+kNK3YQu06rpnwqwURIYAM5iLbZpCIoS7cpkiV3CFd4xP9PXUnaZWg+5QfvVCelNap+81pB3XNJ0wEpmbHkjjbDNoZJUB/2Pm+m4HTyEjVUIpWK2yUWUWi43A2kElfLfvATCFeJdYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tIckocSj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709114; x=1740245114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5r33dar4uXTcIxiLo2EE3ZhpnzHXGBgTGDLgfEfSrvg=;
  b=tIckocSjCuk+2aPLKLj7/0i1K/UQ//m+Yc0JUIxjGz0bUfOyiSsROYUq
   ThkaN5t2b4DcV/03JLdMfjj44iwyNGKM09/5BUH0GuFSLGKeNMDGV/7Be
   QxHKXYdEYQ96byGBApbGbNSnKpdJqeWcpocuRsasjctJYCnywFKQAQ6JK
   7bk8Dgb1A9R11TfvgrgWtCaZdfzkc7XOSJ+rdxQtxjoMQwtLYlE+Soa1L
   eRyfGj2ae5qZVWlWDtMtKuuX8U5bMV07MI9f1+PbPh66i4OaEGU4D5sGg
   G1PTG8vSDTFpAVuKroVfrtvpUglFIVPxIFwop+VCLkKIH28C+BikwISoT
   Q==;
X-CSE-ConnectionGUID: dqFe5GJiTEWg/SG7rQOAsA==
X-CSE-MsgGUID: OJqcd/JwSvGUi+SaCzclTA==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="17267159"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:25:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:24:44 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:24:39 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<tudor.ambarus@linaro.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 04/39] dt-bindings: crypto: add sam9x7 in Atmel SHA
Date: Fri, 23 Feb 2024 22:53:58 +0530
Message-ID: <20240223172358.671722-1-varshini.rajendran@microchip.com>
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

Add DT bindings for atmel SHA.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v4:
- Updated Acked-by tag
---
 .../devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml   | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
index ee2ffb034325..d378c53314dd 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -12,7 +12,11 @@ maintainers:
 
 properties:
   compatible:
-    const: atmel,at91sam9g46-sha
+    oneOf:
+      - const: atmel,at91sam9g46-sha
+      - items:
+          - const: microchip,sam9x7-sha
+          - const: atmel,at91sam9g46-sha
 
   reg:
     maxItems: 1
-- 
2.25.1


