Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB336810F65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378737AbjLMLHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378716AbjLMLHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:07:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC479C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:07:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A18C433C8;
        Wed, 13 Dec 2023 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702465664;
        bh=UGvQIiReFkG1frMVyMqxPjsjO3iZbLcTAW7fpnClpK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQ3TriLkBKtLNyg/oyYevIJ5UsmVvUI/fCLDxt1BeTirg/OsN/XiJJ//xUZ6Hvz22
         7x2qNsaak4xRiMq/O/Zq2VIO3yOK4LHiMPmgzbvsNxUI+wee3v7UjdARqGnz5EVgy5
         opOqBAuVyFYApcHKR4YhDGVfk23jrDaoeX5evYIevX5cuJt43II7acmX1Mh1tQ3XRM
         RcLxLy9BvHnRclURzCwLAKMse3oHyZ0MTXXmItjpAYTJFp+63oPxZGXRnO+/vEZM7D
         geIp74kQrZKsfLF6f9Py+GTjfhjD87yTGP7JYirPymLSyt59ntoaJOKilXcGy1VJgP
         WAYLCETMYXZRQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, vladimir.oltean@nxp.com
Cc:     s-vadapalli@ti.com, r-gunasekaran@ti.com, vigneshr@ti.com,
        srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rogerq@kernel.org
Subject: [PATCH v8 net-next 04/11] net: ethernet: am65-cpsw: Rename TI_AM65_CPSW_TAS to TI_AM65_CPSW_QOS
Date:   Wed, 13 Dec 2023 13:07:14 +0200
Message-Id: <20231213110721.69154-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213110721.69154-1-rogerq@kernel.org>
References: <20231213110721.69154-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will use this Kconfig option to not only enable TAS/EST offload
but also other QoS features like Multiqueue priority descriptors
and MAC-Merge/Frame Preemption. TI_AM65_CPSW_QOS seems a more
appropriate Kconfig option name than TI_AM65_CPSW_TAS.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/Kconfig         | 12 ++++++------
 drivers/net/ethernet/ti/Makefile        |  2 +-
 drivers/net/ethernet/ti/am65-cpsw-qos.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

Changelog:

v8: initial commit

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index e60b557d59b9..49cd96c4f532 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -134,14 +134,14 @@ config TI_K3_AM65_CPTS
 	  protocol, Ethernet Enhanced Scheduled Traffic Operations (CPTS_ESTFn)
 	  and PCIe Subsystem Precision Time Measurement (PTM).
 
-config TI_AM65_CPSW_TAS
-	bool "Enable TAS offload in AM65 CPSW"
+config TI_AM65_CPSW_QOS
+	bool "Enable QoS offload features in AM65 CPSW"
 	depends on TI_K3_AM65_CPSW_NUSS && NET_SCH_TAPRIO && TI_K3_AM65_CPTS
 	help
-	  Say y here to support Time Aware Shaper(TAS) offload in AM65 CPSW.
-	  AM65 CPSW hardware supports Enhanced Scheduled Traffic (EST)
-	  defined in IEEE 802.1Q 2018. The EST scheduler runs on CPTS and the
-	  TAS/EST schedule is updated in the Fetch RAM memory of the CPSW.
+	  This option enables QoS offload features in AM65 CPSW like
+	  Time Aware Shaper (TAS) / Enhanced Scheduled Traffic (EST).
+	  The EST scheduler runs on CPTS and the TAS/EST schedule is
+	  updated in the Fetch RAM memory of the CPSW.
 
 config TI_KEYSTONE_NETCP
 	tristate "TI Keystone NETCP Core Support"
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 9d7cd84d1e2d..d8590304f3df 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_TI_K3_CPPI_DESC_POOL) += k3-cppi-desc-pool.o
 
 obj-$(CONFIG_TI_K3_AM65_CPSW_NUSS) += ti-am65-cpsw-nuss.o
 ti-am65-cpsw-nuss-y := am65-cpsw-nuss.o cpsw_sl.o am65-cpsw-ethtool.o cpsw_ale.o
-ti-am65-cpsw-nuss-$(CONFIG_TI_AM65_CPSW_TAS) += am65-cpsw-qos.o
+ti-am65-cpsw-nuss-$(CONFIG_TI_AM65_CPSW_QOS) += am65-cpsw-qos.o
 ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
 obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index 898f13a4a112..be4987eb8c51 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -31,7 +31,7 @@ struct am65_cpsw_qos {
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
 };
 
-#if IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS)
+#if IS_ENABLED(CONFIG_TI_AM65_CPSW_QOS)
 int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			       void *type_data);
 void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed);
-- 
2.34.1

