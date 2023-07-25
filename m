Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD7476096B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjGYFjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGYFjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:39:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EAD19AA;
        Mon, 24 Jul 2023 22:39:07 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36P5d0EP049687;
        Tue, 25 Jul 2023 00:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690263540;
        bh=jZlQiYTPLncZVPCLbXblHrnam61fWbVQFvJtNlBgO2g=;
        h=From:To:CC:Subject:Date;
        b=ocFhN0tn90Euur7VXTGpC3nCRZuRlPxmaRTy937kFrYcxJ2211idX+TZwWaAorlch
         cqdmnky5kO/OpNaoUX9dGwGzGP24nPj0x5ZLtxgnvPlFSpd25d5JACHUgh0AL9qZdg
         3L19+M7Muw7c+7FJJeDItSSLNGdA99OTzOlfD73o=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36P5d0jf017584
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 00:39:00 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 00:38:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 00:38:59 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36P5cu75064880;
        Tue, 25 Jul 2023 00:38:57 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: k3-j784s4: Add UFS support
Date:   Tue, 25 Jul 2023 11:08:41 +0530
Message-ID: <20230725053843.1721028-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds UFS support for J784S4 SOC,
UFS is kept disabled at SOC level, and enabled in EVM where
UFS flash is present.

This patch is tested by enabling below configs on top of defconfig
CONFIG_SCSI_UFS_BSG=y
CONFIG_SCSI_UFS_CDNS_PLATFORM=y
CONFIG_SCSI_UFS_TI_J721E=y

Test logs
https://gist.github.com/uditkumarti/ab188e4b433058ae86734cd46eff7d94

Udit Kumar (2):
  arm64: dts: ti: k3-j784s4-main: Add DT node for UFS
  arm64: dts: ti: k3-j784s4-evm: Add Support for UFS peripheral

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   |  4 ++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 24 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

-- 
2.34.1

