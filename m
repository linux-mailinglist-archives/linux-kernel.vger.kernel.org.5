Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9427B651A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbjJCJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbjJCJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:12:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD83A9;
        Tue,  3 Oct 2023 02:12:11 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3939C0eU066359;
        Tue, 3 Oct 2023 04:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696324320;
        bh=o0ED1kfJG1RufpI9CAgyV1TxWurfgTv4TIBc7Zp6N1g=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=vmStWs+HGM6w0K3EsMxfA7VdsXP4O6Aq1CPdHrik6dybqVsE284HDd7oWxazPYnq8
         vC0yn2p+8F5X+X71wHnhBAF/zL+JSOVsF7loB+0w+pVTD+5HzQNc0gh2jO7lrUgxAS
         hJoHaAk5UBQoyLGdBkqp6WikXrHvRJ5uQQ6PnMM8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3939C05A034797
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 04:12:00 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 04:12:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 04:12:00 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3939BxV1036852;
        Tue, 3 Oct 2023 04:11:59 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Tue, 3 Oct 2023 14:41:35 +0530
Subject: [PATCH v3 6/6] arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231003-mcasp_am62a-v3-6-2b631ff319ca@ti.com>
References: <20231003-mcasp_am62a-v3-0-2b631ff319ca@ti.com>
In-Reply-To: <20231003-mcasp_am62a-v3-0-2b631ff319ca@ti.com>
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
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlG9rSoc7jBFiH69KKePPfR0TAho2Tyl8+v48gC
 YmXvD5K1CGJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZRva0gAKCRBD3pH5JJpx
 RcVgD/9HqCgJDE8mu1VtzHLYBv0oo6PjkcesEaNZXOC7H/jEUVBLHxyVhaouICVlOXsGGRt386Z
 mJln2Oljvc4iaVOnBzAnWpK3hb3qaVSAYWZLH5VNuUkJjPqbpKLFREa2yu4EibhPQp9sdFJWsrh
 0wlj8GonyFgEdhOp1OWcWRHa2FGoB/wY/N6qKa8IyK4dXb2O5f68AFVP+reQxZ5Od9R8R3LVlbc
 j0yF2FvX8DoZMMbOz00XozNbQMVa70ciMWKcINUuBdw+AewlkpSX7F7k7QIJUQvMU8EmtMMK5mh
 +tnuNVegNPuY0tw/hMv8K78vyF65NimxVCg4ROqLiBgs+MePMZcFujJGdg/R7G7OohIvPx20tB3
 XK01dgLgj1FGIOU9LQW9g7d8y619poedhdAQD3qu5YUH6DFgNHeoC7SF+VIHtB63LiAtZo98Pz4
 T8R2uEWcBdcKFBmvU1TTwnK6NKNYv37HVSb2RkRVWPIAjmqnzzATtmhBsMI7LQJgIs1Yylov6Aa
 EC5wOyS09ZYsU+MIG0KzCc1NOMt7l8JRomEzsNa87z9sbzFwrh1VQ9VozmwuyNS/8Cz0kytoBuE
 h66N+leHWbBoxlStpepxNFzy5bs7h1wGBUg6CpCtPgnxbt01tzIZfofGql4VMAPPO5xO1dr21MB
 5KwZ++XS2UCurbw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

