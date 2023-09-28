Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B147B1751
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjI1J0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjI1JZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:25:25 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254F6CF6;
        Thu, 28 Sep 2023 02:25:21 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38S9PAwD104297;
        Thu, 28 Sep 2023 04:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695893110;
        bh=o0ED1kfJG1RufpI9CAgyV1TxWurfgTv4TIBc7Zp6N1g=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=s6kvyYv0IrHovbvZq9KKX2JghoGppsy0vNEtq24IJg1qLNZEasa1rg5nDk/kB+8u/
         l0z7yKul1coqQvnm9QF0evvpSs0SdiYu9rFd/It1SjnUIk6PGMGFYGPAxyP5Qkjamk
         4KW9JLeedi/00MWhYoG860BqDdcH0dl7i7v5gqZY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38S9PAc7013142
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Sep 2023 04:25:10 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 04:25:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 04:25:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38S9P9Xx121283;
        Thu, 28 Sep 2023 04:25:10 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Thu, 28 Sep 2023 14:54:31 +0530
Subject: [PATCH v2 6/6] arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230928-mcasp_am62a-v2-6-ce9f0e1ba22b@ti.com>
References: <20230928-mcasp_am62a-v2-0-ce9f0e1ba22b@ti.com>
In-Reply-To: <20230928-mcasp_am62a-v2-0-ce9f0e1ba22b@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <a-bhatia1@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=/Lj5kyUdXlkA9yGStAcfh52IUoBdgRQoHn/afCOf6+c=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlFUZnbUw5nSwPtomUBH4NLaw//CRnbWv9s8MaE
 8Ep8DCTFZWJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZRVGZwAKCRBD3pH5JJpx
 RWIZD/415zV3mz8jK19pj5dxOhPYqM0c67jMJwr5iixRKbcVt3R4kFTonmnPI29S/zTV4s7iymZ
 /tBLBJ7Un4U0F+VJZ+0kiUjnhUKlL555Yxp1VXSSvJTBlKfFbMGPfE6vIaCG2hXeubsor6CTNup
 oh3HFiSiI5+Eb09j+EjEXvB9BGAfunZPLqtSQzOphscNH8asVepBhOeUCyLvgtbXEAYD3AKo3+g
 zX9N6eK9G8XHk5dOr/CWeJWmp4gvB6GkNZpNUXz756WRzCxWHWuADPuzeqVDAGxys6EF2vN3jqQ
 e4DEaSXII37lEJKEbACNNO3QC9anuNTAHGWiXLwpuW3bt4WycyubMszGQYsm+AqE5fUAIKAA8Dc
 zCDOUF338oGZryzEm44mbI3zKDBQnk/HiAZfkmzEd5WJH6X8kkHnRK97ULyEkdSAc5Q3isHZx9n
 9oCRR6igYNf8x/OIm6TocVTUqdpdH9FPGEAEcQ4G4XW9k9a+qqTy+wc15uZTM1p0CYMggUDIDs+
 2iNPCA7cqzTgpihleTGh7XsTJA3JC5fTx9SmyBpPGSYlLcYZ84gauWOQDv9hgapXrlYePHTT2IY
 SpVInTK3+eLtBz6DfXslBHU9ENXWhpoMzLuX34gHrbQJ/Qy0/8WEmKFoykFdGtFG/mWG12s562a
 mOm6IXDmCkH3olg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SK-AM62A-LP uses TPS6593x PMIC (interfaced over I2C) to power the SoC
and various other peripherals on the board [1].

Specifically, the audio codec (TLV320AIC3106) on the board relies on the
PMIC for the DVDD (1.8V) supply.

[1]: https://www.ti.com/lit/zip/sprr459

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 66bfbef73324..38f0ce9cd2a3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -725,6 +725,7 @@ CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_SL28CPLD=y
 CONFIG_RZ_MTU3=y
 CONFIG_MFD_TPS65219=y
+CONFIG_MFD_TPS6594_I2C=m
 CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_MFD_ROHM_BD718XX=y
 CONFIG_MFD_WCD934X=m

-- 
2.42.0

