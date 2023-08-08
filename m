Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F06877366C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjHHCT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHHCTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:19:53 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E8D1705;
        Mon,  7 Aug 2023 19:19:52 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a37909a64eso3595516b6e.1;
        Mon, 07 Aug 2023 19:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691461192; x=1692065992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w2SLqdPoc24r3SU7DATTJAeepTTgjgASEEH+wJbfp+8=;
        b=riVngxdTKsSRf7zXfXSL+qD0Y9DVtBRjJKYvZ/v+RGrtoKt2jqRdWIGY1s1cEYR/qX
         mnMqz8NnTPAca/wgd3qX9s+/2HRmdijpDagu7AOB+NXdafhI/WATpb6oFJjBeU9TI5hd
         jYynNZSw2+jSjtfEA+KpBodE2c5qagBxcR40d4hzGZ6m2FXk2i/9ePzEi+wEHpqNveJA
         wS9m4UybfB/LsIsiFllnIm1fByZs2aGe+6i63UN7+kXgX6JXzLLIPwNhdgAV5u9iGYGU
         XYZq+mXmuobQKRH3+VWUU2BZd7AGZZxu+6LzzE+pe58UPKcIY+vpP2nGPF7MhiSyuW8f
         gtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691461192; x=1692065992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2SLqdPoc24r3SU7DATTJAeepTTgjgASEEH+wJbfp+8=;
        b=VPnhKGRVgL0Z5rQ+wq6OY0YKHYg9FB9y6mRVErZIMYOzrrgf9jpq0+YyqFRIeM9Brx
         3hfi6Ap6V+54b0yXqvNKcSx4/IoVRZug4d0eNvQTDSkiYjtGrUrmyeDph6SxOgzDf2QE
         fdIB3gC6mgk/+wfZDYE2PVvrEHQKBOWRhageft84EdJd3mHvb5u4/QEjqj54Lk9E2pes
         ueZu/gwrHmrKBmHiv4QCo3OkFY6sVq2xfYlaRY8LYFqaKxHP/Pw3eVcH+6ifYMoL9+rS
         y22nxiFRGjkQhgbX5Jb1R0LK9MZN/w7b3M+4I6JkOf58rvhqW60LKQ7wyc4rbx1wC8ps
         t3jQ==
X-Gm-Message-State: AOJu0YzEF0V1UqExXhmD7xmaaSw/JZD1y4hcKDy7blgtrjwj341uQELB
        sTaap8rZjpTnnHCj2jLfyZg=
X-Google-Smtp-Source: AGHT+IGH/g0JdiGrMleuVRrFWy33FO4h64b4qozK/olV66uDrtE31E68FjW4XEcWo7kvtPQnHeG1BQ==
X-Received: by 2002:a05:6808:17aa:b0:3a7:7bd3:7a7d with SMTP id bg42-20020a05680817aa00b003a77bd37a7dmr15663696oib.23.1691461191836;
        Mon, 07 Aug 2023 19:19:51 -0700 (PDT)
Received: from localhost.localdomain ([198.211.45.220])
        by smtp.googlemail.com with ESMTPSA id p18-20020aa78612000000b006871dad3e74sm6849000pfn.65.2023.08.07.19.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 19:19:51 -0700 (PDT)
From:   Furong Xu <0x1207@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com, Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 1/1] net: stmmac: xgmac: RX queue routing configuration
Date:   Tue,  8 Aug 2023 10:19:06 +0800
Message-Id: <20230808021906.1120889-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
introduced RX queue routing to DWMAC4 core.
This patch extend the support to XGMAC2 core.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
Changes in v2:
  - Convert the shift ops to FIELD_PREP
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    | 14 ++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 34 +++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 1913385df685..a2498da7406b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -74,8 +74,22 @@
 #define XGMAC_RXQEN(x)			GENMASK((x) * 2 + 1, (x) * 2)
 #define XGMAC_RXQEN_SHIFT(x)		((x) * 2)
 #define XGMAC_RXQ_CTRL1			0x000000a4
+#define XGMAC_AVCPQ			GENMASK(31, 28)
+#define XGMAC_AVCPQ_SHIFT		28
+#define XGMAC_PTPQ			GENMASK(27, 24)
+#define XGMAC_PTPQ_SHIFT		24
+#define XGMAC_TACPQE			BIT(23)
+#define XGMAC_TACPQE_SHIFT		23
+#define XGMAC_DCBCPQ			GENMASK(19, 16)
+#define XGMAC_DCBCPQ_SHIFT		16
+#define XGMAC_MCBCQEN			BIT(15)
+#define XGMAC_MCBCQEN_SHIFT		15
+#define XGMAC_MCBCQ			GENMASK(11, 8)
+#define XGMAC_MCBCQ_SHIFT		8
 #define XGMAC_RQ			GENMASK(7, 4)
 #define XGMAC_RQ_SHIFT			4
+#define XGMAC_UPQ			GENMASK(3, 0)
+#define XGMAC_UPQ_SHIFT			0
 #define XGMAC_RXQ_CTRL2			0x000000a8
 #define XGMAC_RXQ_CTRL3			0x000000ac
 #define XGMAC_PSRQ(x)			GENMASK((x) * 8 + 7, (x) * 8)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index a0c2ef8bb0ac..38782662ff98 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -127,6 +127,36 @@ static void dwxgmac2_tx_queue_prio(struct mac_device_info *hw, u32 prio,
 	writel(value, ioaddr + reg);
 }
 
+static void dwxgmac2_rx_queue_routing(struct mac_device_info *hw,
+				      u8 packet, u32 queue)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+
+	static const struct stmmac_rx_routing dwxgmac2_route_possibilities[] = {
+		{ XGMAC_AVCPQ, XGMAC_AVCPQ_SHIFT },
+		{ XGMAC_PTPQ, XGMAC_PTPQ_SHIFT },
+		{ XGMAC_DCBCPQ, XGMAC_DCBCPQ_SHIFT },
+		{ XGMAC_UPQ, XGMAC_UPQ_SHIFT },
+		{ XGMAC_MCBCQ, XGMAC_MCBCQ_SHIFT },
+	};
+
+	value = readl(ioaddr + XGMAC_RXQ_CTRL1);
+
+	/* routing configuration */
+	value &= ~dwxgmac2_route_possibilities[packet - 1].reg_mask;
+	value |= (queue << dwxgmac2_route_possibilities[packet - 1].reg_shift) &
+		 dwxgmac2_route_possibilities[packet - 1].reg_mask;
+
+	/* some packets require extra ops */
+	if (packet == PACKET_AVCPQ)
+		value |= FIELD_PREP(XGMAC_TACPQE, 1);
+	else if (packet == PACKET_MCBCQ)
+		value |= FIELD_PREP(XGMAC_MCBCQEN, 1);
+
+	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
+}
+
 static void dwxgmac2_prog_mtl_rx_algorithms(struct mac_device_info *hw,
 					    u32 rx_alg)
 {
@@ -1463,7 +1493,7 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.rx_queue_enable = dwxgmac2_rx_queue_enable,
 	.rx_queue_prio = dwxgmac2_rx_queue_prio,
 	.tx_queue_prio = dwxgmac2_tx_queue_prio,
-	.rx_queue_routing = NULL,
+	.rx_queue_routing = dwxgmac2_rx_queue_routing,
 	.prog_mtl_rx_algorithms = dwxgmac2_prog_mtl_rx_algorithms,
 	.prog_mtl_tx_algorithms = dwxgmac2_prog_mtl_tx_algorithms,
 	.set_mtl_tx_queue_weight = dwxgmac2_set_mtl_tx_queue_weight,
@@ -1524,7 +1554,7 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
 	.rx_queue_prio = dwxgmac2_rx_queue_prio,
 	.tx_queue_prio = dwxgmac2_tx_queue_prio,
-	.rx_queue_routing = NULL,
+	.rx_queue_routing = dwxgmac2_rx_queue_routing,
 	.prog_mtl_rx_algorithms = dwxgmac2_prog_mtl_rx_algorithms,
 	.prog_mtl_tx_algorithms = dwxgmac2_prog_mtl_tx_algorithms,
 	.set_mtl_tx_queue_weight = dwxgmac2_set_mtl_tx_queue_weight,
-- 
2.34.1

