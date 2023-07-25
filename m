Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB75761A14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjGYNga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGYNg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:36:28 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4CD19BD;
        Tue, 25 Jul 2023 06:36:26 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36PDaI8M128365;
        Tue, 25 Jul 2023 08:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690292178;
        bh=lVI+xNMajBrI7oZzDmG8d2cicHC0vMA3s2bL6iku5eA=;
        h=From:To:CC:Subject:Date;
        b=TdiGLuCXlk1pHSInCcDRVBm4EDrDKNZcMPvakMERuRN2UlmsJ4PkfbTJ4gvU1mk2N
         RMpbm/OfGAg/ndpuSHBZi5n9J5CvBX1AYqs+8OqeSETA3XCcNNCHL/Y1IgEtsYA6l3
         jlya4wnov7M9aM1P34ycHKM729cZGaVw7OqrdzKM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36PDaI1V080123
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 08:36:18 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 08:36:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 08:36:18 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36PDaFwg017340;
        Tue, 25 Jul 2023 08:36:15 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2 0/2] arm64: dts: ti: k3-j784s4: Add UFS support
Date:   Tue, 25 Jul 2023 19:06:05 +0530
Message-ID: <20230725133607.2021379-1-u-kumar1@ti.com>
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

Change log:

Changes in v2
v1: https://lore.kernel.org/all/20230725053843.1721028-1-u-kumar1@ti.com/
Add DT node for UFS:
  Corrected typo
  Added 0x00 instead of 0x0 to align with test of file
  Added Tested by

Add Support for UFS peripheral
  Added Tested by

Test logs of v1 patch
https://gist.github.com/uditkumarti/ab188e4b433058ae86734cd46eff7d94


Udit Kumar (2):
  arm64: dts: ti: k3-j784s4-main: Add DT node for UFS
  arm64: dts: ti: k3-j784s4-evm: Add Support for UFS peripheral

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   |  4 ++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 24 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

-- 
2.34.1

