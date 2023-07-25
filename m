Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90237611F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjGYK6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjGYK5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:57:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75201448B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:54:42 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36PAs3IC120178;
        Tue, 25 Jul 2023 05:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690282443;
        bh=0cJnmSZ3r+njW/GeSxRb/SY6mLGpzQUnl1bvUoS1mp0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sxJD8EKnezpdmH3CaZaLi+sl4aSiGX9JTHxOkWrx5eYhlTl7uv4cUiqlnA6M567Bz
         r81KaY1DPmpaTglmXcplDbccU1xFOd4xLnDX79xARXTcqVXl5HNK5OtbpLdWdwZQb5
         4VG2qotFJ/8EDkS0BxzfRYtXpwpqOmNOr/G5jRys=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36PAs3w3076737
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 05:54:03 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 05:54:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 05:54:02 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36PArnkV091635;
        Tue, 25 Jul 2023 05:53:58 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <onrad.dybcio@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>, <john.garry@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Hari Nagalla <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 2/7] arm64: defconfig: enable TI OMAP2 mailbox and K3 remote proc drivers
Date:   Tue, 25 Jul 2023 16:23:41 +0530
Message-ID: <20230725105346.1981285-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725105346.1981285-1-u-kumar1@ti.com>
References: <20230725105346.1981285-1-u-kumar1@ti.com>
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

From: Hari Nagalla <hnagalla@ti.com>

Enable TI OMAP2 mailbox driver. This driver is used in TI K3 platforms
as well for communications with remote processors.
Also enable Cortex R5 and TI DSP (C66x,C71x) remote proc drivers as modules.

Needed by AM64, J7200,J721E and J784S4 platforms.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 089e71f5bb7a..a2a03b4ae834 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1230,6 +1230,7 @@ CONFIG_TEGRA186_TIMER=y
 CONFIG_RENESAS_OSTM=y
 CONFIG_ARM_MHU=y
 CONFIG_IMX_MBOX=y
+CONFIG_OMAP2PLUS_MBOX=m
 CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_QCOM_APCS_IPC=y
@@ -1242,6 +1243,8 @@ CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
+CONFIG_TI_K3_R5_REMOTEPROC=m
+CONFIG_TI_K3_DSP_REMOTEPROC=m
 CONFIG_MTK_SCP=m
 CONFIG_QCOM_Q6V5_ADSP=m
 CONFIG_QCOM_Q6V5_MSS=m
-- 
2.34.1

