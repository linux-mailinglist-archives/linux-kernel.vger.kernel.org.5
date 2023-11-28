Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC77FB17D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbjK1Fox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343578AbjK1Fog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:44:36 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0746D6D;
        Mon, 27 Nov 2023 21:44:40 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AS5iV6R072818;
        Mon, 27 Nov 2023 23:44:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701150271;
        bh=C7nLneLG/Oh9BPvoztNlayKtN+X4/S2BfHVVmetyqmQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=b/bS/4SMVXWeTaBX54ZcF9ROImJ0vhwI9JTbQ8xm7xwkXS4oEOILfk1VqezSiLijf
         /oaKowtLIVuYskkdNbKt0AHeZHVFAIp027M3zRNEnohSoFg/mqCVGs4eT87fkBO28D
         Rf9dy7X++7ZHn9Q+xNd9fxBqQnOD1xGokOP1IF1Q=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AS5iVpZ055937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Nov 2023 23:44:31 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 23:44:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 23:44:30 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AS5i2uT096776;
        Mon, 27 Nov 2023 23:44:26 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <vigneshr@ti.com>, <tjoseph@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <nm@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v13 5/5] PCI: j721e: add j784s4 PCIe configuration
Date:   Tue, 28 Nov 2023 11:14:02 +0530
Message-ID: <20231128054402.2155183-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128054402.2155183-1-s-vadapalli@ti.com>
References: <20231128054402.2155183-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Ranostay <mranostay@ti.com>

Add PCIe configuration for j784s4 platform which has 4x lane support.

Tested-by: Achal Verma <a-verma1@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Achal Verma <a-verma1@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 645597856a1d..85718246016b 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -330,6 +330,20 @@ static const struct j721e_pcie_data am64_pcie_ep_data = {
 	.max_lanes = 1,
 };
 
+static const struct j721e_pcie_data j784s4_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.quirk_retrain_flag = true,
+	.byte_access_allowed = false,
+	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 4,
+};
+
+static const struct j721e_pcie_data j784s4_pcie_ep_data = {
+	.mode = PCI_MODE_EP,
+	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 4,
+};
+
 static const struct of_device_id of_j721e_pcie_match[] = {
 	{
 		.compatible = "ti,j721e-pcie-host",
@@ -355,6 +369,14 @@ static const struct of_device_id of_j721e_pcie_match[] = {
 		.compatible = "ti,am64-pcie-ep",
 		.data = &am64_pcie_ep_data,
 	},
+	{
+		.compatible = "ti,j784s4-pcie-host",
+		.data = &j784s4_pcie_rc_data,
+	},
+	{
+		.compatible = "ti,j784s4-pcie-ep",
+		.data = &j784s4_pcie_ep_data,
+	},
 	{},
 };
 
-- 
2.34.1

