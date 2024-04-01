Return-Path: <linux-kernel+bounces-126987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C904894576
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632A2B21807
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0DC53372;
	Mon,  1 Apr 2024 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGnFGP4j"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4596C47A76;
	Mon,  1 Apr 2024 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711999524; cv=none; b=sO54G1wPXJIJPdv6yK+OFupa5Vhq+rMpQx2uo0YdBi1AWOEVhImI+L7gDKPdJpwr9vTaybguvxlSrVjWdrCPw0NMpD2kKTStf2VwfDjEOejClv97ACfaoXyGj+i3sHyaLx2+sA8JFZjK8ccUM63RHfP34RBNENyiEiytclhUS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711999524; c=relaxed/simple;
	bh=o6eDuCSXAK7lFo/qKkEQQj36soVQbPoLui5kgXGipeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B5Tvv81fP0C0QoUr9ewB/oXb2Y35mNX2xNblRqvLRiCaz8SHmGOryHKoVU0/1wy9O2yatNh4kunQCHXz0sOeT/VfwVMe2Ud8CnofFHvCrbB0/rv0ZKrCKmfw6j7O2VTZnyZi7SVF+rn5gaZXfPvgZFyC59RKnahoJuvrEE+6Uo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGnFGP4j; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ed4dd8659so3251414f8f.0;
        Mon, 01 Apr 2024 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711999521; x=1712604321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbATZVSwtVFCc38UdteT0WxrSxfowo8TkRKmuWEvy1c=;
        b=CGnFGP4jDlOuHf26HFmLsbqRcSrb82Wocpj7qmXN7xZZ6SpHu0Bg0rVBlDDqK8p7gU
         Vke8vfsQlNNoMQ0Jn4eSDkkOktjS3HUMevizgH9lHeJFG2PZoShKpha8zl3SfMpogowD
         m1gPDRtpDAGImKiuXllUYULHwwTtw53C3BaZ6njOokkns2EpkjEdKyzxeD2J78G/eCJq
         NECmbLeOzQl8whf5O2XD3lvNHXmjhjAUOPwllbCjwuX65x1WdefqIcf0+Cs2n4uLQyA7
         +U7Oe1mkkDKsGAxG3omzwP2tClH0VeNOTOtrcVSlAzgAZURGhdccRahXgyEv3ZfzfsIZ
         F6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711999521; x=1712604321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbATZVSwtVFCc38UdteT0WxrSxfowo8TkRKmuWEvy1c=;
        b=o7hU+3wbXA9m/UA0QsQTOEdCSOZswaite3yBu6PTZRHKHXJCY2w+DLPBihcMpxToRF
         OBflGN/yRQaYvTE2v6osMpvPAsSAQaMuXlhVzPy20T6aiGGNOLUV9+fP2Ao4sTrMKHAC
         DT2lFCYcSE6H1BkXr3u+8GVcTOydrvl3F1UK5dCz7XNTpW4dEZTlI0n1FHfRXn4GFBNU
         f9MedaH2r39xQZ3sWHcJ6yd1uepWrKFN38GnQPsOMSbah0MWCci2sTFa6XpAyRHbL5aE
         76YhADyCmnLSfaiCUTyOZQtT/mWHDYfgIxQBtLzmSbb0eDWmWUqSViO4W8Cq9LME/VaT
         9J+g==
X-Forwarded-Encrypted: i=1; AJvYcCUhhGgVuglJWjKliQL6/dImvOLggUfwBQuVFcwugyL9ud3qzO1ZlzuO8IDI8tLjbih+/6Dub9U8LM5Ra7tVyZJtHlPFC87N4wREcrKRzYkki4F0TFrXFksh5ktsIC2JgBH2KOMg
X-Gm-Message-State: AOJu0YxMk9fVMX8j75VDlCT9V8zl9DZdeS5PnAZZ1Wqu6qLlzjxIHY0A
	F1xMZ0LAVf/qOSxhFxGAjqgMzfRoMoDK9ZeVO0EySeAkbc23dpUf
X-Google-Smtp-Source: AGHT+IFKo0GgVDkY7Zy7nJekIuEkhWVnxNxEK6NrznEjLdMqIaCn/ECvU1iVX2nGEqSYcSNB4vTQvA==
X-Received: by 2002:a5d:47c4:0:b0:343:44cd:7d1e with SMTP id o4-20020a5d47c4000000b0034344cd7d1emr5650181wrc.17.1711999520491;
        Mon, 01 Apr 2024 12:25:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:a92:c660:38e3:78b9:48eb:4246])
        by smtp.gmail.com with ESMTPSA id n2-20020a056000170200b0034335e47102sm10319848wrc.113.2024.04.01.12.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:25:19 -0700 (PDT)
From: Piotr Wejman <piotrwejman90@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Piotr Wejman <piotrwejman90@gmail.com>
Subject: [PATCH v4] net: stmmac: fix rx queue priority assignment
Date: Mon,  1 Apr 2024 21:22:39 +0200
Message-Id: <20240401192239.33942-1-piotrwejman90@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver should ensure that same priority is not mapped to multiple
rx queues. From DesignWare Cores Ethernet Quality-of-Service
Databook, section 17.1.29 MAC_RxQ_Ctrl2:
"[...]The software must ensure that the content of this field is
mutually exclusive to the PSRQ fields for other queues, that is,
the same priority is not mapped to multiple Rx queues[...]"

Previously rx_queue_priority() function was:
- clearing all priorities from a queue
- adding new priorities to that queue
After this patch it will:
- first assign new priorities to a queue
- then remove those priorities from all other queues
- keep other priorities previously assigned to that queue

Fixes: a8f5102af2a7 ("net: stmmac: TX and RX queue priority configuration")
Fixes: 2142754f8b9c ("net: stmmac: Add MAC related callbacks for XGMAC2")
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

Changes in v4:
  - amend comment and commit message
  - Link to v3: https://lore.kernel.org/netdev/20240303190339.52496-1-piotrwejman90@gmail.com/

 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 40 ++++++++++++++-----
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 38 ++++++++++++++----
 2 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 6b6d0de09619..eb2d0976d010 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -92,19 +92,41 @@ static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
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
+	 * is not mapped to multiple Rx queues
+	 */
+	for (i = 0; i < 4; i++)
+		clear_mask |= ((prio << GMAC_RXQCTRL_PSRQX_SHIFT(i)) &
+						GMAC_RXQCTRL_PSRQX_MASK(i));
+
+	ctrl2 &= ~clear_mask;
+	ctrl3 &= ~clear_mask;
+
+	/* First assign new priorities to a queue, then
+	 * clear them from others queues
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
index 1af2f89a0504..2bc05173884e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -105,17 +105,41 @@ static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
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
+	 * is not mapped to multiple Rx queues
+	 */
+	for (i = 0; i < 4; i++)
+		clear_mask |= ((prio << XGMAC_PSRQ_SHIFT(i)) &
+						XGMAC_PSRQ(i));
+
+	ctrl2 &= ~clear_mask;
+	ctrl3 &= ~clear_mask;
+
+	/* First assign new priorities to a queue, then
+	 * clear them from others queues
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


