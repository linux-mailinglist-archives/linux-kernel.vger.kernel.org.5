Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E103C752696
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjGMPSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjGMPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:17:56 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB52736;
        Thu, 13 Jul 2023 08:17:32 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DFHFAC049319;
        Thu, 13 Jul 2023 10:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689261435;
        bh=FLFw9Mu2Zx4IZrKWachypLONgs6nYIa6QVFe1GPvIHM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eUfHgq2af9CZPEDOjzoZB4Vz9hT+N7ZCniYSMcgLY7DYlJblrCRnaVr9TMqHPmswY
         +TwW3a0pzCL+ubgoxOx+ZogEExWv6CsVbnmys60KwvuSnoRMZQOngSY2Qnvem3bNkZ
         V7hYABwfN0i/MX8MhH9+IzxwEQ4YQR9pqaOUXDSI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DFHEEg028241
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 10:17:15 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 10:17:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 10:17:13 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DFHCEB021441;
        Thu, 13 Jul 2023 10:17:13 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <peda@axentia.se>, <rogerq@kernel.org>
CC:     <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH 2/2] dt-bindings: ti-serdes-mux: Deprecate header with constants
Date:   Thu, 13 Jul 2023 20:47:07 +0530
Message-ID: <20230713151707.8109-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713151707.8109-1-j-choudhary@ti.com>
References: <20230713151707.8109-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constants to define the idle state of SERDES MUX were defined in
bindings header. They are used only in DTS and driver uses the dt property
to set the idle state making it unsuitable for bindings.
The constants are moved to header next to DTS ("arch/arm64/boot/dts/ti/")
and all the references to bindings header are removed.
So add a warning to mark this bindings header as deprecated.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 include/dt-bindings/mux/ti-serdes.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
index 669ca2d6abce..b0b1091aad6d 100644
--- a/include/dt-bindings/mux/ti-serdes.h
+++ b/include/dt-bindings/mux/ti-serdes.h
@@ -6,6 +6,14 @@
 #ifndef _DT_BINDINGS_MUX_TI_SERDES
 #define _DT_BINDINGS_MUX_TI_SERDES
 
+/*
+ * These bindings are deprecated, because they do not match the actual
+ * concept of bindings but rather contain pure constants values used only
+ * in DTS board files.
+ * Instead include the header in the DTS source directory.
+ */
+#warning "These bindings are deprecated. Instead, use the header in the DTS source directory."
+
 /* J721E */
 
 #define J721E_SERDES0_LANE0_QSGMII_LANE1	0x0
-- 
2.25.1

