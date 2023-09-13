Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3082E79E71F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbjIMLre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjIMLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:47:30 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC8210E6;
        Wed, 13 Sep 2023 04:47:26 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38DBlDBM048324;
        Wed, 13 Sep 2023 06:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694605633;
        bh=r6URBWHQnbB+NzsH1Xu/dUaTz1ei0DikP3C8THWpk4M=;
        h=From:To:CC:Subject:Date;
        b=tY3EF1l6csZApEQZ81MuowhCmE0TuPddAeuD5bnjh+coKqpwGJxDwZefP/KHGVEZ2
         EHfLUNXAE5UX5E2E+5xEJC7fGjEmnuATaaUGC5TPK31/kdZLRcIA9pjRvgqwTN7RMV
         U9mOYrPHyHxjLIX3rD87kLm03Xn/+N7jmAK3mbdE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38DBlDZM113434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 06:47:13 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 06:47:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 06:47:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38DBlCuI052551;
        Wed, 13 Sep 2023 06:47:12 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <rogerq@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add support for GPMC NAND
Date:   Wed, 13 Sep 2023 17:17:08 +0530
Message-ID: <20230913114711.2937844-1-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for GPMC NAND on AM62x LP SK
board.

Nitin Yadav (3):
  arm64: dts: ti: Add GPMC NAND support
  arm64: dts: ti: Add GPMC NAND overlay
  arm64: defconfig: Enable GPMC NAND support

 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso | 119 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  29 +++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi           |   2 +
 arch/arm64/configs/defconfig                  |   3 +
 5 files changed, 154 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso

-- 
2.25.1

