Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D67380C129
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjLKGJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKGJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:09:57 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA621B8;
        Sun, 10 Dec 2023 22:10:03 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35d57e88c1dso15655185ab.2;
        Sun, 10 Dec 2023 22:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702275003; x=1702879803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ukdXVDA+vod49MZcomrhRI/+9GYiRBBWvuYzD1mwFzY=;
        b=CSkdc9O3YOaN4vdJez4oQ1dF8IiwOpxWUj+IO4VfzHsmU6zQ0zxTc7+7xpnl6ahPVB
         VZRvUpRJLX4ymvnJV+ZGrFGZfDBj3eyEancVqRMkdPiO6Q+RdhB12E5aBttkD1fmKhgx
         7Qw2EeyUSja3z7x+BNz9E8SGGeHTIjE6EKGc9CCxuaNURAprl0isDR3mKrh4pk+WHoal
         gJtgnQDNFSohNhbB4JYc18YyPrvbMOhS57Jwxe9ylh7WvEDhsGX9912DoXY/eWdhHgdP
         3SWgG8BY0nW0fcR/2cXcdQADlUWjp0Pp9ECCGec+VHjLTdgA1NKnjIy9T5Z6ZRx+u6sJ
         4VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702275003; x=1702879803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukdXVDA+vod49MZcomrhRI/+9GYiRBBWvuYzD1mwFzY=;
        b=uxPBnIYesvSC6UIM9xEZHHVFPMqE/QuUgoF20R/Nu8CF2zZehZmdiU/uc3qAQbZCIy
         50mG/tJ4DsATZpANfUF4RsCiBqlET8zctpUw0QoftvbsulDjIh8fjf70oVG0j4ptvNnx
         d3zkxidruCMXAeWHu+tDzpeNMKk3k/fzJ2s1apjZ6cNri8hafNz2CZdtxrWEhc0EGUTC
         Yc2LCIXQ2n90qpQHwi9ReperVIvfWtmdZDlOUvq+VOH/SdYQmkcBVxiucz94Z363ESOt
         2xdB6sITg8TOKU0gDNsiHedFiieiJ5ZdWh/QiJASkb1b1Ae16mK3WLWFgd4hZM57OR6Q
         Ma+A==
X-Gm-Message-State: AOJu0Yyf91OuJ41+E5t4gYE2rP7NVBalCfMEBmNVshlA1HZFh7f21Uun
        tpe52kpve/rRlJNUia6pliWvJ/fcZ04=
X-Google-Smtp-Source: AGHT+IEm0HnFWnMRK1mKtvZuoyPwf9vzqqhfd399V8BiNQP4IIsoV/RcRsQLF/B5ytDhWt+N8WLrxw==
X-Received: by 2002:a05:6e02:1e04:b0:35c:8410:84ee with SMTP id g4-20020a056e021e0400b0035c841084eemr2980478ila.24.1702275003018;
        Sun, 10 Dec 2023 22:10:03 -0800 (PST)
Received: from localhost.localdomain ([74.48.130.204])
        by smtp.googlemail.com with ESMTPSA id v28-20020a63151c000000b005c60cdb08f0sm5635858pgl.0.2023.12.10.22.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 22:10:02 -0800 (PST)
From:   Furong Xu <0x1207@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com, Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] net: stmmac: mmc: Support more counters for XGMAC Core
Date:   Mon, 11 Dec 2023 14:08:28 +0800
Message-Id: <20231211060828.1629247-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complete all counters on XGMAC Core.
These can be useful for debugging.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/mmc.h     |  14 +++
 .../net/ethernet/stmicro/stmmac/mmc_core.c    | 117 +++++++++++++++++-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  10 ++
 3 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc.h b/drivers/net/ethernet/stmicro/stmmac/mmc.h
index a0c05925883e..14c9d2637dfe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc.h
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc.h
@@ -52,6 +52,8 @@ struct stmmac_counters {
 	unsigned int mmc_tx_excessdef;
 	unsigned int mmc_tx_pause_frame;
 	unsigned int mmc_tx_vlan_frame_g;
+	unsigned int mmc_tx_lpi_usec;
+	unsigned int mmc_tx_lpi_tran;
 
 	/* MMC RX counter registers */
 	unsigned int mmc_rx_framecount_gb;
@@ -78,9 +80,16 @@ struct stmmac_counters {
 	unsigned int mmc_rx_fifo_overflow;
 	unsigned int mmc_rx_vlan_frames_gb;
 	unsigned int mmc_rx_watchdog_error;
+	unsigned int mmc_rx_lpi_usec;
+	unsigned int mmc_rx_lpi_tran;
+	unsigned int mmc_rx_discard_frames_gb;
+	unsigned int mmc_rx_discard_octets_gb;
+	unsigned int mmc_rx_align_err_frames;
+
 	/* IPC */
 	unsigned int mmc_rx_ipc_intr_mask;
 	unsigned int mmc_rx_ipc_intr;
+
 	/* IPv4 */
 	unsigned int mmc_rx_ipv4_gd;
 	unsigned int mmc_rx_ipv4_hderr;
@@ -118,9 +127,14 @@ struct stmmac_counters {
 	unsigned int mmc_rx_icmp_gd_octets;
 	unsigned int mmc_rx_icmp_err_octets;
 
+	/* Stream-Gate Filter */
+	unsigned int mmc_sgf_pass_fragment_cntr;
+	unsigned int mmc_sgf_fail_fragment_cntr;
+
 	/* FPE */
 	unsigned int mmc_tx_fpe_fragment_cntr;
 	unsigned int mmc_tx_hold_req_cntr;
+	unsigned int mmc_tx_gate_overrun_cntr;
 	unsigned int mmc_rx_packet_assembly_err_cntr;
 	unsigned int mmc_rx_packet_smd_err_cntr;
 	unsigned int mmc_rx_packet_assembly_ok_cntr;
diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index 6a7c1d325c46..8597c6abae8d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -177,9 +177,12 @@
 #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
 #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
 
+#define MMC_XGMAC_SGF_PASS_PKT		0x1f0
+#define MMC_XGMAC_SGF_FAIL_PKT		0x1f4
 #define MMC_XGMAC_TX_FPE_INTR_MASK	0x204
 #define MMC_XGMAC_TX_FPE_FRAG		0x208
 #define MMC_XGMAC_TX_HOLD_REQ		0x20c
+#define MMC_XGMAC_TX_GATE_OVERRUN	0x210
 #define MMC_XGMAC_RX_FPE_INTR_MASK	0x224
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
 #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
@@ -187,6 +190,40 @@
 #define MMC_XGMAC_RX_FPE_FRAG		0x234
 #define MMC_XGMAC_RX_IPC_INTR_MASK	0x25c
 
+#define MMC_XGMAC_RX_IPV4_GD		0x264
+#define MMC_XGMAC_RX_IPV4_HDERR		0x26c
+#define MMC_XGMAC_RX_IPV4_NOPAY		0x274
+#define MMC_XGMAC_RX_IPV4_FRAG		0x27c
+#define MMC_XGMAC_RX_IPV4_UDSBL		0x284
+
+#define MMC_XGMAC_RX_IPV6_GD		0x28c
+#define MMC_XGMAC_RX_IPV6_HDERR		0x294
+#define MMC_XGMAC_RX_IPV6_NOPAY		0x29c
+
+#define MMC_XGMAC_RX_UDP_GD		0x2a4
+#define MMC_XGMAC_RX_UDP_ERR		0x2ac
+#define MMC_XGMAC_RX_TCP_GD		0x2b4
+#define MMC_XGMAC_RX_TCP_ERR		0x2bc
+#define MMC_XGMAC_RX_ICMP_GD		0x2c4
+#define MMC_XGMAC_RX_ICMP_ERR		0x2cc
+
+#define MMC_XGMAC_RX_IPV4_GD_OCTETS	0x2d4
+#define MMC_XGMAC_RX_IPV4_HDERR_OCTETS	0x2dc
+#define MMC_XGMAC_RX_IPV4_NOPAY_OCTETS	0x2e4
+#define MMC_XGMAC_RX_IPV4_FRAG_OCTETS	0x2ec
+#define MMC_XGMAC_RX_IPV4_UDSBL_OCTETS	0x2f4
+
+#define MMC_XGMAC_RX_IPV6_GD_OCTETS	0x2fc
+#define MMC_XGMAC_RX_IPV6_HDERR_OCTETS	0x304
+#define MMC_XGMAC_RX_IPV6_NOPAY_OCTETS	0x30c
+
+#define MMC_XGMAC_RX_UDP_GD_OCTETS	0x314
+#define MMC_XGMAC_RX_UDP_ERR_OCTETS	0x31c
+#define MMC_XGMAC_RX_TCP_GD_OCTETS	0x324
+#define MMC_XGMAC_RX_TCP_ERR_OCTETS	0x32c
+#define MMC_XGMAC_RX_ICMP_GD_OCTETS	0x334
+#define MMC_XGMAC_RX_ICMP_ERR_OCTETS	0x33c
+
 static void dwmac_mmc_ctrl(void __iomem *mmcaddr, unsigned int mode)
 {
 	u32 value = readl(mmcaddr + MMC_CNTRL);
@@ -414,6 +451,8 @@ static void dwxgmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 			     &mmc->mmc_tx_pause_frame);
 	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_TX_VLAN_PKT_G,
 			     &mmc->mmc_tx_vlan_frame_g);
+	mmc->mmc_tx_lpi_usec += readl(mmcaddr + MMC_XGMAC_TX_LPI_USEC);
+	mmc->mmc_tx_lpi_tran += readl(mmcaddr + MMC_XGMAC_TX_LPI_TRAN);
 
 	/* MMC RX counter registers */
 	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_PKT_GB,
@@ -459,9 +498,23 @@ static void dwxgmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_VLAN_PKT_GB,
 			     &mmc->mmc_rx_vlan_frames_gb);
 	mmc->mmc_rx_watchdog_error += readl(mmcaddr + MMC_XGMAC_RX_WATCHDOG_ERR);
-
+	mmc->mmc_rx_lpi_usec += readl(mmcaddr + MMC_XGMAC_RX_LPI_USEC);
+	mmc->mmc_rx_lpi_tran += readl(mmcaddr + MMC_XGMAC_RX_LPI_TRAN);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_DISCARD_PKT_GB,
+			     &mmc->mmc_rx_discard_frames_gb);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_DISCARD_OCT_GB,
+			     &mmc->mmc_rx_discard_octets_gb);
+	mmc->mmc_rx_align_err_frames +=
+		readl(mmcaddr + MMC_XGMAC_RX_ALIGN_ERR_PKT);
+
+	mmc->mmc_sgf_pass_fragment_cntr +=
+		readl(mmcaddr + MMC_XGMAC_SGF_PASS_PKT);
+	mmc->mmc_sgf_fail_fragment_cntr +=
+		readl(mmcaddr + MMC_XGMAC_SGF_FAIL_PKT);
 	mmc->mmc_tx_fpe_fragment_cntr += readl(mmcaddr + MMC_XGMAC_TX_FPE_FRAG);
 	mmc->mmc_tx_hold_req_cntr += readl(mmcaddr + MMC_XGMAC_TX_HOLD_REQ);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_TX_GATE_OVERRUN,
+			     &mmc->mmc_tx_gate_overrun_cntr);
 	mmc->mmc_rx_packet_assembly_err_cntr +=
 		readl(mmcaddr + MMC_XGMAC_RX_PKT_ASSEMBLY_ERR);
 	mmc->mmc_rx_packet_smd_err_cntr +=
@@ -470,6 +523,68 @@ static void dwxgmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 		readl(mmcaddr + MMC_XGMAC_RX_PKT_ASSEMBLY_OK);
 	mmc->mmc_rx_fpe_fragment_cntr +=
 		readl(mmcaddr + MMC_XGMAC_RX_FPE_FRAG);
+
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV4_GD,
+			     &mmc->mmc_rx_ipv4_gd);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV4_HDERR,
+			     &mmc->mmc_rx_ipv4_hderr);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV4_NOPAY,
+			     &mmc->mmc_rx_ipv4_nopay);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV4_FRAG,
+			     &mmc->mmc_rx_ipv4_frag);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV4_UDSBL,
+			     &mmc->mmc_rx_ipv4_udsbl);
+
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV6_GD,
+			     &mmc->mmc_rx_ipv6_gd);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV6_HDERR,
+			     &mmc->mmc_rx_ipv6_hderr);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV6_NOPAY,
+			     &mmc->mmc_rx_ipv6_nopay);
+
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_UDP_GD,
+			     &mmc->mmc_rx_udp_gd);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_UDP_ERR,
+			     &mmc->mmc_rx_udp_err);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_TCP_GD,
+			     &mmc->mmc_rx_tcp_gd);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_TCP_ERR,
+			     &mmc->mmc_rx_tcp_err);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_ICMP_GD,
+			     &mmc->mmc_rx_icmp_gd);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_ICMP_ERR,
+			     &mmc->mmc_rx_icmp_err);
+
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV4_GD_OCTETS,
+			     &mmc->mmc_rx_ipv4_gd_octets);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV4_HDERR_OCTETS,
+			     &mmc->mmc_rx_ipv4_hderr_octets);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV4_NOPAY_OCTETS,
+			     &mmc->mmc_rx_ipv4_nopay_octets);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV4_FRAG_OCTETS,
+			     &mmc->mmc_rx_ipv4_frag_octets);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV4_UDSBL_OCTETS,
+			     &mmc->mmc_rx_ipv4_udsbl_octets);
+
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV6_GD_OCTETS,
+			     &mmc->mmc_rx_ipv6_gd_octets);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV6_HDERR_OCTETS,
+			     &mmc->mmc_rx_ipv6_hderr_octets);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_IPV6_NOPAY_OCTETS,
+			     &mmc->mmc_rx_ipv6_nopay_octets);
+
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_UDP_GD_OCTETS,
+			     &mmc->mmc_rx_udp_gd_octets);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_UDP_ERR_OCTETS,
+			     &mmc->mmc_rx_udp_err_octets);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_TCP_GD_OCTETS,
+			     &mmc->mmc_rx_tcp_gd_octets);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_TCP_ERR_OCTETS,
+			     &mmc->mmc_rx_tcp_err_octets);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_ICMP_GD_OCTETS,
+			     &mmc->mmc_rx_icmp_gd_octets);
+	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_ICMP_ERR_OCTETS,
+			     &mmc->mmc_rx_icmp_err_octets);
 }
 
 const struct stmmac_mmc_ops dwxgmac_mmc_ops = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index f628411ae4ae..b9b80e0fceeb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -212,6 +212,8 @@ static const struct stmmac_stats stmmac_mmc[] = {
 	STMMAC_MMC_STAT(mmc_tx_excessdef),
 	STMMAC_MMC_STAT(mmc_tx_pause_frame),
 	STMMAC_MMC_STAT(mmc_tx_vlan_frame_g),
+	STMMAC_MMC_STAT(mmc_tx_lpi_usec),
+	STMMAC_MMC_STAT(mmc_tx_lpi_tran),
 	STMMAC_MMC_STAT(mmc_rx_framecount_gb),
 	STMMAC_MMC_STAT(mmc_rx_octetcount_gb),
 	STMMAC_MMC_STAT(mmc_rx_octetcount_g),
@@ -236,6 +238,11 @@ static const struct stmmac_stats stmmac_mmc[] = {
 	STMMAC_MMC_STAT(mmc_rx_fifo_overflow),
 	STMMAC_MMC_STAT(mmc_rx_vlan_frames_gb),
 	STMMAC_MMC_STAT(mmc_rx_watchdog_error),
+	STMMAC_MMC_STAT(mmc_rx_lpi_usec),
+	STMMAC_MMC_STAT(mmc_rx_lpi_tran),
+	STMMAC_MMC_STAT(mmc_rx_discard_frames_gb),
+	STMMAC_MMC_STAT(mmc_rx_discard_octets_gb),
+	STMMAC_MMC_STAT(mmc_rx_align_err_frames),
 	STMMAC_MMC_STAT(mmc_rx_ipc_intr_mask),
 	STMMAC_MMC_STAT(mmc_rx_ipc_intr),
 	STMMAC_MMC_STAT(mmc_rx_ipv4_gd),
@@ -266,8 +273,11 @@ static const struct stmmac_stats stmmac_mmc[] = {
 	STMMAC_MMC_STAT(mmc_rx_tcp_err_octets),
 	STMMAC_MMC_STAT(mmc_rx_icmp_gd_octets),
 	STMMAC_MMC_STAT(mmc_rx_icmp_err_octets),
+	STMMAC_MMC_STAT(mmc_sgf_pass_fragment_cntr),
+	STMMAC_MMC_STAT(mmc_sgf_fail_fragment_cntr),
 	STMMAC_MMC_STAT(mmc_tx_fpe_fragment_cntr),
 	STMMAC_MMC_STAT(mmc_tx_hold_req_cntr),
+	STMMAC_MMC_STAT(mmc_tx_gate_overrun_cntr),
 	STMMAC_MMC_STAT(mmc_rx_packet_assembly_err_cntr),
 	STMMAC_MMC_STAT(mmc_rx_packet_smd_err_cntr),
 	STMMAC_MMC_STAT(mmc_rx_packet_assembly_ok_cntr),
-- 
2.34.1

