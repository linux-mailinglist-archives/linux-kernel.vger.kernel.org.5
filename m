Return-Path: <linux-kernel+bounces-12463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4411881F51E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766611C21CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE03D62;
	Thu, 28 Dec 2023 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rbv5RNY+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83863A8;
	Thu, 28 Dec 2023 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BS6dsld085183;
	Thu, 28 Dec 2023 00:39:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703745594;
	bh=EJCG44e6LiY2ozmpMigA/5JiJCeZqYoyVZe30RPWG6Y=;
	h=From:Date:Subject:To:CC;
	b=rbv5RNY+MADYwh6Tw4OL4irSGRbsUlEttVko4ZRxetPTgdxDjtOC+ui95SygAT6YL
	 Uv+A02W5fcKT7ctmO0U8ahfK/xspN8iOTj1cE0T0lS2gqYcE+NUDHWu0rEBOmVBlbJ
	 inPkc+I3Ei/alHPY7fUsKtZEiYk1K+gtuQsJq5+8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BS6dson016974
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Dec 2023 00:39:54 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Dec 2023 00:39:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Dec 2023 00:39:53 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.69.44])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BS6dm9n054066;
	Thu, 28 Dec 2023 00:39:49 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 28 Dec 2023 12:09:48 +0530
Subject: [PATCH] dt-bindings: thermal: k3-j72xx: Update bindings for J721S2
 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231228-b4-upstream-j721s2-vtm-dt-binding-v1-1-e866277f9c64@ti.com>
X-B4-Tracking: v=1; b=H4sIADMYjWUC/x3NQQqDMBBA0avIrB1oxlirV5EuNJnaEUwlk4og3
 t3g8m3+P0A5Cit0xQGRN1H5hQxTFuC+Q5gYxWcDPagyRC8cLf5XTZGHBeeGjBJuaUGfcJTgJUz
 Y1vw0rrXkKgu5s0b+yH4/+vd5XqClTF9zAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, J
 Keerthy <j-keerthy@ti.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Manorit Chawdhry
	<m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703745589; l=1535;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=k6TeF/GvBob+g5G7fXguWw0kINtreXNy1kGKFr4s9Zs=;
 b=pKGrfs6sZX1F1lLx9Zst4Cbhmel8xkyFu4dC5qTPSkszqYdOSATTakhIdZAktCnG/3Zh8oJvs
 yzCHlIxj7YWBSKhfZCJ7KGeJKNPtpElTKWfDGf2iz6H9kv4YHT3O04G
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The clock and processor ID for J721S2 differs from the existing
compatibles, add a new compatible to represent this change for adding
support for Adaptive voltage scaling.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 .../devicetree/bindings/thermal/ti,j72xx-thermal.yaml        | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
index 171b3622ed84..5792ccc058aa 100644
--- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -24,9 +24,13 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - ti,j721e-vtm
-      - ti,j7200-vtm
+    anyOf:
+      - items:
+          - enum:
+              - ti,j721e-vtm
+              - ti,j7200-vtm
+              - ti,j721s2-vtm
+      - maxItems: 2
 
   reg:
     items:
@@ -72,7 +76,7 @@ examples:
   - |
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
     wkup_vtm0: thermal-sensor@42040000 {
-        compatible = "ti,j721e-vtm";
+        compatible = "ti,j721e-vtm", "ti,j7200-vtm";
         reg = <0x42040000 0x350>,
               <0x42050000 0x350>,
               <0x43000300 0x10>;

---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20231228-b4-upstream-j721s2-vtm-dt-binding-95e61c942c34

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


