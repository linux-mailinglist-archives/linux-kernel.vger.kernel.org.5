Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F21075C73A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjGUM5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGUM5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:57:50 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D0C186;
        Fri, 21 Jul 2023 05:57:49 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36LCvbfC069934;
        Fri, 21 Jul 2023 07:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689944257;
        bh=rnorjwn43wORV+uRkEwgozu1v6r3MwEdYJRYgPBSdIg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LxK1C0WmjQ/0TriiE/aX88j2NyysNQyIRdHvI3LmfxhDQZmU5M1Imb14Nip8PRYYc
         9HriYhlYx60nWkE8FLxbYUIDNpzXL9zcNeQ51/+4xcUODLWtfDy6lRPnCO21pz73hq
         x3xK8LeLVBVSDR/FMaTDgYypnmYw5sQulwR/fgZA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36LCvbht029723
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jul 2023 07:57:37 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jul 2023 07:57:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jul 2023 07:57:37 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36LCvaXI010992;
        Fri, 21 Jul 2023 07:57:36 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <peda@axentia.se>, <rogerq@kernel.org>
CC:     <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH v2 2/2] dt-bindings: ti-serdes-mux: Deprecate header with constants
Date:   Fri, 21 Jul 2023 18:27:32 +0530
Message-ID: <20230721125732.122421-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721125732.122421-1-j-choudhary@ti.com>
References: <20230721125732.122421-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Roger Quadros <rogerq@kernel.org>
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

