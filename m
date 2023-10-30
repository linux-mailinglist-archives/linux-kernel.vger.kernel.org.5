Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F81B7DB358
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjJ3Gb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjJ3Gbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:31:50 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0DA12C;
        Sun, 29 Oct 2023 23:31:24 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39U6VAok097247;
        Mon, 30 Oct 2023 01:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698647470;
        bh=6K8TV7A8S/Z7dYJQycx/75juIBVr0dpkeJIct+ticDk=;
        h=From:To:CC:Subject:Date;
        b=xxZzfx0AGBtGOBx2uzlZEhMmEKBYYx7HuqE6qbCCb/9xZtS4HlxKq2qpRB8+3stL6
         yUBDbKtI/b7YCBQPaKbGUizGqaZVp8WeubjEmdTqgIh6qg2WSrluyOtD1cq5tlABCm
         cHqgsOvusKkTmqlYwISY1j2tcPo78nmwYtvRlH6M=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39U6VAXB009140
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Oct 2023 01:31:10 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Oct 2023 01:31:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Oct 2023 01:31:09 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39U6V8Yu022280;
        Mon, 30 Oct 2023 01:31:09 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add eMMC support for AM62a SK
Date:   Mon, 30 Oct 2023 12:01:06 +0530
Message-ID: <20231030063108.1242981-1-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables eMMC support on AM62a SK.

Change Log:

V1 -> V2:
 - Updated commit message in 2nd patch of series.
 - Moved alias changes to 2nd patch of series.

v1: https://lore.kernel.org/all/20231027093950.1202549-1-n-yadav@ti.com/

Nitin Yadav (2):
  arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
  arm64: dts: ti: k3-am62a7-sk: Enable eMMC support

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 19 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts   | 25 +++++++++++++++++++++++
 2 files changed, 44 insertions(+)

-- 
2.25.1

