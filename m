Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBB179C4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjILEdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjILEdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:33:35 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72B28F;
        Mon, 11 Sep 2023 21:33:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38C4XDwA035445;
        Mon, 11 Sep 2023 23:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694493193;
        bh=3oxQAynjg9hnrGwjEx1hWVlHQ/8WWGFE6ImW4Q/vUHY=;
        h=From:To:CC:Subject:Date;
        b=XMWlELHqEXYj5w4yPqmnq0SEe3pd92ppjsIwVK/wTiAyeUDRPMSskpF2MiylvLTM0
         AfaXQxoupG/zyij/8VLX7cPSMVRusHEo+7hrTHWb/PNDB5oT/dwcyDoFavaTGcnAI8
         Aud8onjjiJaxtqcv7OHQkTqBd9ykqdg2Bd6mhuZs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38C4XDND004542
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 23:33:13 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 23:33:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 23:33:12 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38C4X8Jj098938;
        Mon, 11 Sep 2023 23:33:09 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j721s2-evm-gesi: Specify base dtb for overlay file
Date:   Tue, 12 Sep 2023 10:03:08 +0530
Message-ID: <20230912043308.20629-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the base dtb file k3-j721s2-common-proc-board.dtb on which the
k3-j721s2-evm-gesi-exp-board.dtbo overlay has to be applied. Name the
resulting dtb as k3-j721s2-evm.dtb.

Fixes: cac04e27f093 ("arm64: dts: ti: k3-j721s2: Add overlay to enable main CPSW2G with GESI")
Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

NOTE: This patch is based on linux-next tagged next-20230911.

v1:
https://lore.kernel.org/r/20230911052158.89185-1-s-vadapalli@ti.com/

Changes since v1:
- Addressed Rob's feedback, moving the line "k3-j721s2-evm-dtbs..."
  just above the line "dtb-${CONFIG_ARCH_K3) += k3-j721s2-evm.dtb".
- Restored the following lines which were deleted in v1 patch:
  "dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb"
  "dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-gesi-exp-board.dtbo"
  based on Rob's feedback, to ensure that they are installed as a part
  of make dtbs_install.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index e7b8e2e7f083..51dab9499cd0 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -66,6 +66,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-gesi-exp-board.dtbo
+k3-j721s2-evm-dtbs := k3-j721s2-common-proc-board.dtb k3-j721s2-evm-gesi-exp-board.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb
 
 # Boards with J784s4 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
-- 
2.34.1

