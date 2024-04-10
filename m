Return-Path: <linux-kernel+bounces-138146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB2089ED48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099F81C20D92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508BE13DB88;
	Wed, 10 Apr 2024 08:11:16 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175013D63B;
	Wed, 10 Apr 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736675; cv=none; b=V/+NVY3A4hD8eYLW0vm5vKXCJCO2hDaLth0D4eAW8lvAxKZooAc1ASup1XZayWFXzE3C4+ddSzFASZGxF4d9FPm1rp0ovVWsmqoJQ6ndCiATlJbimOm0KKwFxvolWggQn14dGQvxzVyx+6MUXNi7BQ4IPSmS5Zl+iUMmHu11ROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736675; c=relaxed/simple;
	bh=UEdhYL3cMgFIuThNHCfuqEPNpl7OpPotitWx/s83DB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TrZnTohDE2Q/Qhgq+ebd/hE+FoJ6eSfPH2XgjymWSGkwwfL9BOwfbW6Qh11rNcEXqf/NEUSbvYYZ1kGnKW1xQlzULb1yk6B5SmeUVSAJYNWeKN0kxYyFw6UXpfHr7meLBqkUO2zR5JWsYddKo5Ud5WKp+f8aBVr98+zK5Fi5hIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 515C1200273;
	Wed, 10 Apr 2024 10:11:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1699D20027B;
	Wed, 10 Apr 2024 10:11:12 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1CA70183AD24;
	Wed, 10 Apr 2024 16:11:10 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v3 1/2] dt-bindings: net: bluetooth: nxp: Add firmware-name property
Date: Wed, 10 Apr 2024 13:40:47 +0530
Message-Id: <20240410081049.775382-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410081049.775382-1-neeraj.sanjaykale@nxp.com>
References: <20240410081049.775382-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This adds a new optional device tree property called firware-name.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2: Add maxItems, simplify description, remove "nxp/". (Krzysztof)
v3: Corrected subject. Dropped description. (Krzysztof)
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index f01a3988538c..37a65badb448 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -31,6 +31,9 @@ properties:
       This property depends on the module vendor's
       configuration.
 
+  firmware-name:
+    maxItems: 1
+
 required:
   - compatible
 
@@ -42,5 +45,6 @@ examples:
         bluetooth {
             compatible = "nxp,88w8987-bt";
             fw-init-baudrate = <3000000>;
+            firmware-name = "uartuart8987_bt_v0.bin";
         };
     };
-- 
2.34.1


