Return-Path: <linux-kernel+bounces-89861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 167C186F6A5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9882D1F21432
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD97179B6C;
	Sun,  3 Mar 2024 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh41KAoW"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC5D1DFD8;
	Sun,  3 Mar 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709492627; cv=none; b=JPSVned//soGLeXQtPXnN7T2KhVEoqh/40iSEbpE/08h4Dwcks4K5I8MrhvKE3SqJIDNrhCQQN9Z2j8TvCT+70XP70StgPXO3fCSLsjTsr8ORPVeVvpT2rphTxZQV0c1eQB3sQnJNvn1QQJHSwQ33wU892t6P9JkhFZWSkDV95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709492627; c=relaxed/simple;
	bh=iTOfN+tgqF6RXUgkv5aPdbWw0doQRHF+0VQ+rOX/H74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5a+L6r3Eas4Nh6t522dvwx2b3glx69JAi2voVwYL3RtHXt3wyHegMoYdproOag4aNWq3uAicgG8b0xUNAjtyg11Q513KpevcBsQpSzFdeGODyKD47+QJcYJ/SE2KftrArvRGERmINUPYjHasV8Wkl2V8ziEH2a7whem3JUYki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kh41KAoW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412e22315d8so2547175e9.1;
        Sun, 03 Mar 2024 11:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709492623; x=1710097423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Q6tqq+YHMrtRDD0QwVDNeMhXDLukwoqe/1azYB8u5U=;
        b=Kh41KAoW9MeIsawH3KrleaRw4MBuce0SVIH6iXmpAvkUfmhtKkjKBiDgjzBEFj9YAD
         eL+k26UjyTQWnpkmw6DPRLkbXEd5JuFgnuuaqiiLOweyWXjRll6ZqqSwCYMde6tjKM4M
         NNDMOK557dzie9EuTigVDgQD2b+vrhOymvXJxOFL3iJshQlrERF+0ubIaHl4JIrF0cvx
         zzEhbQi+12BVFOP+1kBOMDluoHBBIGbbHguni/ae6jasOybr8ps8HyTwqBiVRvd2h652
         qdgHoy7zqdM9z2oeQ0M0s5rpVesxFmEDXaCO0WOS2IlAEF+L0Nja7KyXnrocSkaLSCv5
         QG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709492623; x=1710097423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Q6tqq+YHMrtRDD0QwVDNeMhXDLukwoqe/1azYB8u5U=;
        b=fDSsXsTS786W/qAsYjeXIuaoc7yRG7F0oWG91BgCYIgzdGfqhD3KbTrM1km7WuxoCc
         JTNiYhAFOgZwCZ8DqsiwtCUbKGsJJV6AcpZLuXrDkVxsylzRbCS765F0PmTnIhdnnEbq
         VTDB8XMyqLbcOj1y0GXAE7s4VAMvqtwoOMjVh37+Jg4nR6B4PNdXP1OsFu6intKqcZsu
         VauFO/rimpUtQZbzvH2hW/NCggcwmjo2Mu5Evc1vlZwt/qaqUamwU/nXdoJl+5lRyk7d
         RKOWVMzpNBGdXXi4u5m6lpzOaU893n7FyUEp5T2X5zKRCwontyqAy2RM/9K9HjxUPl1m
         QQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXX3I9ZknNkrxbDxhXNrHzT8ElTtVgzbaDpgnrJGmLi3R5jMdiJVIX8NNCHLm7IGN9lcK2B33gkkgbbPLDw5NZCbRd0ceZGDqtkfSpJYsachf1MqWiEstCPSMVRx/IyFyVBPWEL
X-Gm-Message-State: AOJu0Ywc/whg3edjpLOODBjqHjAEndr2MjsQNt1yG2OBxhX/I9R5w9v6
	tznvUVGghgTGjAvjE/IBawmSWhJCDihPupdijZk4rUGiG3m9rvnvmy9xryW3FfE=
X-Google-Smtp-Source: AGHT+IGg4+GTgKpcocRSHWqddDrc+rrpm/34o839Hkj+OJRCyujj5Z/0OpTcDzfW6PMDiFO0ZbZYoA==
X-Received: by 2002:a05:600c:354b:b0:412:bca2:1680 with SMTP id i11-20020a05600c354b00b00412bca21680mr5891715wmq.35.1709492623332;
        Sun, 03 Mar 2024 11:03:43 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:a92:c660:e318:3b1a:c27a:9905])
        by smtp.gmail.com with ESMTPSA id fk6-20020a05600c0cc600b00412e2ccdc97sm1265674wmb.17.2024.03.03.11.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 11:03:42 -0800 (PST)
From: Piotr Wejman <piotrwejman90@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Piotr Wejman <piotrwejman90@gmail.com>
Subject: [PATCH v3] net: stmmac: fix rx queue priority assignment
Date: Sun,  3 Mar 2024 20:03:38 +0100
Message-Id: <20240303190339.52496-1-piotrwejman90@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver should ensure that same priority is not mapped to multiple
rx queues. Currently rx_queue_priority() function is adding
priorities for a queue without clearing them from others.

From DesignWare Cores Ethernet Quality-of-Service
Databook, section 17.1.29 MAC_RxQ_Ctrl2:
"[...]The software must ensure that the content of this field is
mutually exclusive to the PSRQ fields for other queues, that is,
the same priority is not mapped to multiple Rx queues[...]"

After this patch, rx_queue_priority() function will:
- assign desired priorities to a queue
- remove those priorities from all other queues
The write sequence of CTRL2 and CTRL3 registers is done in the way to
ensure this order.

Signed-off-by: Piotr Wejman <piotrwejman90@gmail.com>
---
Changes in v2:
  - Add some comments
  - Apply same changes to dwxgmac2_rx_queue_prio()
  - Revert "Rename prio argument to prio_mask"
  - Link to v1: https://lore.kernel.org/netdev/20240219102405.32015-1-piotrwejman90@gmail.com/T/#u

Changes in v3:
  - Fix trailing whitespace
  - Link to v2: https://lore.kernel.org/netdev/20240226093144.31965-1-piotrwejman90@gmail.com/

 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 42 +++++++++++++++----
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 40 ++++++++++++++----
 2 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 6b6d0de09619..a0e6d33ca87e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -92,19 +92,43 @@ static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
 				     u32 prio, u32 queue)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 base_register;
-	u32 value;
+	u32 clear_mask = 0;
+	u32 ctrl2, ctrl3;
+	int i;
 
-	base_register = (queue < 4) ? GMAC_RXQ_CTRL2 : GMAC_RXQ_CTRL3;
-	if (queue >= 4)
-		queue -= 4;
+	ctrl2 = readl(ioaddr + GMAC_RXQ_CTRL2);
+	ctrl3 = readl(ioaddr + GMAC_RXQ_CTRL3);
 
-	value = readl(ioaddr + base_register);
+	/* The software must ensure that the same priority
+	 * is not mapped to multiple Rx queues.
+	 */
+	for (i = 0; i < 4; i++)
+		clear_mask |= ((prio << GMAC_RXQCTRL_PSRQX_SHIFT(i)) &
+						GMAC_RXQCTRL_PSRQX_MASK(i));
+
+	ctrl2 &= ~clear_mask;
+	ctrl3 &= ~clear_mask;
+
+	/* Assign new priorities to a queue and
+	 * clear them from others queues.
+	 * The CTRL2 and CTRL3 registers write sequence is done
+	 * in the way to ensure this order.
+	 */
+	if (queue < 4) {
+		ctrl2 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
+						GMAC_RXQCTRL_PSRQX_MASK(queue);
 
-	value &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);
-	value |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
+		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
+		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
+	} else {
+		queue -= 4;
+
+		ctrl3 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
 						GMAC_RXQCTRL_PSRQX_MASK(queue);
-	writel(value, ioaddr + base_register);
+
+		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
+		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
+	}
 }
 
 static void dwmac4_tx_queue_priority(struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1af2f89a0504..d15752823d93 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -105,17 +105,43 @@ static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
 				   u32 queue)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value, reg;
+	u32 clear_mask = 0;
+	u32 ctrl2, ctrl3;
+	int i;
 
-	reg = (queue < 4) ? XGMAC_RXQ_CTRL2 : XGMAC_RXQ_CTRL3;
-	if (queue >= 4)
+	ctrl2 = readl(ioaddr + XGMAC_RXQ_CTRL2);
+	ctrl3 = readl(ioaddr + XGMAC_RXQ_CTRL3);
+
+	/* The software must ensure that the same priority
+	 * is not mapped to multiple Rx queues.
+	 */
+	for (i = 0; i < 4; i++)
+		clear_mask |= ((prio << XGMAC_PSRQ_SHIFT(i)) &
+						XGMAC_PSRQ(i));
+
+	ctrl2 &= ~clear_mask;
+	ctrl3 &= ~clear_mask;
+
+	/* Assign new priorities to a queue and
+	 * clear them from others queues.
+	 * The CTRL2 and CTRL3 registers write sequence is done
+	 * in the way to ensure this order.
+	 */
+	if (queue < 4) {
+		ctrl2 |= (prio << XGMAC_PSRQ_SHIFT(queue)) &
+						XGMAC_PSRQ(queue);
+
+		writel(ctrl2, ioaddr + XGMAC_RXQ_CTRL2);
+		writel(ctrl3, ioaddr + XGMAC_RXQ_CTRL3);
+	} else {
 		queue -= 4;
 
-	value = readl(ioaddr + reg);
-	value &= ~XGMAC_PSRQ(queue);
-	value |= (prio << XGMAC_PSRQ_SHIFT(queue)) & XGMAC_PSRQ(queue);
+		ctrl3 |= (prio << XGMAC_PSRQ_SHIFT(queue)) &
+						XGMAC_PSRQ(queue);
 
-	writel(value, ioaddr + reg);
+		writel(ctrl3, ioaddr + XGMAC_RXQ_CTRL3);
+		writel(ctrl2, ioaddr + XGMAC_RXQ_CTRL2);
+	}
 }
 
 static void dwxgmac2_tx_queue_prio(struct mac_device_info *hw, u32 prio,
-- 
2.25.1


