Return-Path: <linux-kernel+bounces-25983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F4682D94B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31857284843
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A7C1756D;
	Mon, 15 Jan 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wtUjWDCL"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461117555;
	Mon, 15 Jan 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40FCvJZb110754;
	Mon, 15 Jan 2024 06:57:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705323439;
	bh=nVIik13VEQb/k+Y/rs8n0/H7l0pIsFj55OzrRKWZwcU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wtUjWDCLxK+FclaPXHB4PPXzzGbZD0gR0OqEYRi2Xrocsl+M7TNvfa7K3kstFKuBb
	 QVH9YEK2FcGlWOSe8V4bCZBnxHRRucnDdz5k1jy3KhwVOfy+HeMZ6/l0w5eqpfzjWr
	 kml8Q+i2hvxSZE7tSRdO/mr0G2qM7knaR6KEspPY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40FCvJB0019839
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jan 2024 06:57:19 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jan 2024 06:57:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jan 2024 06:57:18 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40FCvIIQ128467;
	Mon, 15 Jan 2024 06:57:18 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>, <kristo@kernel.org>, <devarsht@ti.com>
Subject: [PATCH 1/2] dt-bindings: display: ti,am65x-dss: Add support for common1 region
Date: Mon, 15 Jan 2024 18:27:15 +0530
Message-ID: <20240115125716.560363-2-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115125716.560363-1-devarsht@ti.com>
References: <20240115125716.560363-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI keystone display subsystem present in AM65 and other SoCs such as AM62
support two separate register spaces namely "common" and "common1" which
can be used by two separate hosts to program the display controller as
described in respective Technical Reference Manuals [1].

The common1 register space has similar set of configuration registers as
supported in common register space except the global configuration
registers which are exclusive to common region.

This adds binding for "common1" register region too as supported by the
hardware.

[1]:
AM62x TRM:
https://www.ti.com/lit/pdf/spruiv7 (Section 14.8.9.1 DSS Registers)

AM65x TRM:
https://www.ti.com/lit/pdf/spruid7 (Section 12.6.5 DSS Registers)

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 .../devicetree/bindings/display/ti/ti,am65x-dss.yaml       | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index b6767ef0d24d..55e3e490d0e6 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -37,6 +37,7 @@ properties:
       - description: OVR2 overlay manager for vp2
       - description: VP1 video port 1
       - description: VP2 video port 2
+      - description: common1 DSS register area
 
   reg-names:
     items:
@@ -47,6 +48,7 @@ properties:
       - const: ovr2
       - const: vp1
       - const: vp2
+      - const: common1
 
   clocks:
     items:
@@ -147,9 +149,10 @@ examples:
                     <0x04a07000 0x1000>, /* ovr1 */
                     <0x04a08000 0x1000>, /* ovr2 */
                     <0x04a0a000 0x1000>, /* vp1 */
-                    <0x04a0b000 0x1000>; /* vp2 */
+                    <0x04a0b000 0x1000>, /* vp2 */
+                    <0x04a01000 0x1000>; /* common1 */
             reg-names = "common", "vidl1", "vid",
-                    "ovr1", "ovr2", "vp1", "vp2";
+                    "ovr1", "ovr2", "vp1", "vp2", "common1";
             ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
             power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
             clocks =        <&k3_clks 67 1>,
-- 
2.34.1


