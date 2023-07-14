Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3450C753636
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjGNJOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbjGNJOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:14:00 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F331E65;
        Fri, 14 Jul 2023 02:13:58 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36E9Da89084096;
        Fri, 14 Jul 2023 04:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689326016;
        bh=j4EkMF4Pjjv7iuXkk/zZUvSKBOA0j30IjXIINbCappE=;
        h=From:Subject:Date:To:CC;
        b=ALy4N+XRi//xsNClgF7/bPGUvPT/wRW0f9Ie+pdr/pJOm+BZZO6h/4DtRkmHyMsqb
         CbeUNQvWf98W7UQFWAELdclNru5gzSwK0xU2yedwlSZudwniyWoZbJqTYl47a287kW
         JfAM9V9kp3PfK4miFdRbKoufLGtgjCTOa2wBSQ6w=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36E9Dap1016125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jul 2023 04:13:36 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jul 2023 04:13:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jul 2023 04:13:36 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36E9DZD8015096;
        Fri, 14 Jul 2023 04:13:35 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Subject: [PATCH v5 0/2] Remove power-domains property for devices with
 compatible ti,am62-sa3ul
Date:   Fri, 14 Jul 2023 14:42:40 +0530
Message-ID: <20230614-sa3ul-v5-0-29dd2366fba3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIgRsWQC/22NQQ6CMBBFr2K6tqadqQVceQ/joi2DNBEwLTYaw
 t0tLEw0LN+f/+ZPLFLwFNlpN7FAyUc/9BmO+x1zrelvxH2dmYEAFFoqHg0+79xZZWtprapFyXL
 XmkjcBtO7dml3Jo4UlsMjUONf68Dlmrn1cRzCe91LsKT/rxNwydGUCLYExMqdR39wQ8cWPeGmg
 lxwILKlFAiFkT+K2lRUVgpX6arRoItKf5V5nj+R0wNFFgEAAA==
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        "Tero Kristo" <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Tero Kristo" <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-crypto@vger.kernel.org>,
        Kamlesh Gurudasani <kamlesh@ti.com>,
        "Conor Dooley" <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326014; l=1452;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=cMEtn7syDJk05mLKWZYBMYri9aARdatmDTdlRFB1Je4=;
 b=5keEHyBcGyt4U7UDBo+ojS99vbW0xZyvS64B+oUXWuTlxPRC9dJJqTp6Pusw0mnlVseVei42H
 iVjUr6FdG9KD3QC1fh+6oBEFhhx0SjM1E1OEZolbwO/bpejSQb9g3TI
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SYSFW don't allow access to power of devices with compatible ti,am62-sa3ul
from main domain.

Power-domains property, if present will try to access the power of the
device, which will result into failure in probing of driver for that
device.

Make power-domains property as false for devices with compatible
ti,am62-sa3ul.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
Changes in v5:
- Update recipient list
- Link to v4: https://lore.kernel.org/r/20230614-sa3ul-v4-0-7c969f626796@ti.com

Changes in v4:
- s/items/contains/ for dt-binding patch
- Added "fixes commit" for dt-binding patch
- Link to v3: https://lore.kernel.org/r/20230614-sa3ul-v3-0-2eeb810327a1@ti.com

Changes in v3:
- Add patch dt-bindings: crypto: ti,sa2ul: make power-domains conditional
- Link to v2: https://lore.kernel.org/r/20230614-sa3ul-v2-1-3a832b82339c@ti.com

Changes in v2:
- Make commit message clearer

---
Kamlesh Gurudasani (2):
      dt-bindings: crypto: ti,sa2ul: make power-domains conditional
      arm64: dts: ti: k3-am62-main: Remove power-domains from crypto node

 Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 14 +++++++++++++-
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi               |  1 -
 2 files changed, 13 insertions(+), 2 deletions(-)
---
base-commit: 53ab6975c12d1ad86c599a8927e8c698b144d669
change-id: 20230614-sa3ul-cb4bd1bb4d08

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>

