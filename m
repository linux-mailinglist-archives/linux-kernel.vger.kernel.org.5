Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535A07A9B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjIUS62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIUS6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:58:08 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431153EFF;
        Thu, 21 Sep 2023 11:51:55 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38LA0hSU001920;
        Thu, 21 Sep 2023 05:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695290443;
        bh=7sPeJ3cF82T2KpMA+b/VQuIl+euYK6afaT51C9aZWvI=;
        h=From:To:CC:Subject:Date;
        b=J9aUGrcshukRoWODyEcESdI2RKZVrzJm2dBb6rUUKnuR4RDsfDL2WtEIVCwuYTrf5
         6op8Anb4dRaVKpClRNcK1kvdmtixV9PeeFA5toKz7UKkhqcsP49z3aMcY6+TwCln5L
         +2BmaSUHSAI/0DQV0Dzm82y+Zf0FftkYz4/FHjBg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38LA0hOi003844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Sep 2023 05:00:43 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 05:00:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 05:00:43 -0500
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38LA0dD3060269;
        Thu, 21 Sep 2023 05:00:40 -0500
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sinthu.raja@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH 0/3] AM68 SK: Add support for PCIe and USB
Date:   Thu, 21 Sep 2023 15:30:36 +0530
Message-ID: <20230921100039.19897-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for PCIe and USB interfaces.

Sinthu Raja (3):
  arm64: dts: ti: Add USB Type C swap defines for J721S2 SoC
  arm64: dts: ti: k3-am68-sk: Add DT node for PCIe
  arm64: dts: ti: k3-am68-sk: Add DT node for USB

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 56 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-serdes.h            |  2 +-
 2 files changed, 57 insertions(+), 1 deletion(-)


base-commit: 940fcc189c51032dd0282cbee4497542c982ac59
-- 
2.17.1

