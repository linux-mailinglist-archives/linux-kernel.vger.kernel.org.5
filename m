Return-Path: <linux-kernel+bounces-71120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F8085A0E6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52839282422
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8A32869B;
	Mon, 19 Feb 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3dkl5Rl"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB5B2C842;
	Mon, 19 Feb 2024 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338268; cv=none; b=tRXelmjFboBpWFmkzkUWglX4ORHA2u1T1rVk7ZpricuYzvf2t4sVLt6d7CkFb5gJX/sEjPxsJdmkuLpD08pKw4yEPy4deWwBMLIR5w7Fi56D86WLTl8ldL73E4HNhna5hh36kPhkL4AQguNMBiv+Ys62Ss57slP7RUsm8dz6VTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338268; c=relaxed/simple;
	bh=k1ZR/2E9zgonOGEnTcqjd8PimJKIdi71ZsQPKAiK/pI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zcrh9Pyc3e0qk4xibUe71iYukgJaPX3kYoXCylLOwg5pNA7h7VFlXvVJmPDbbfjQlzx8awDBUdNu/VOr2D+hf8Pf90ACSwDjfMrvUTHj2NnOnz97/zEh4gamxIsoac2WNZo+7YrGAEZNXwkd2YgTmcoNwST/3GHj3bJdk5UAFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3dkl5Rl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33adec41b55so1988430f8f.0;
        Mon, 19 Feb 2024 02:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708338265; x=1708943065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUKAB7sb5czIBMBlNuCagdfu4VWTGp2m4SsAnQpFoNI=;
        b=b3dkl5RlDoZTZsIBYGkFf+oQLT1YkojTyompktRPUJEOSggCvUpcF4H06z9SMEgav4
         lea9GPuAK/CXVEaeUpvOtIUt216mBw30jT0acLoaiI6Ce8PvCMUOkFSnM9etxJZlB+R/
         6mbGm5XkvFOULCz2T8V0YBDCoTaI1dyIkMQZQqAHMH/kRreI2bEQQS8wFl+QxrfhBLrE
         TA6tEGyDDxDjwcg/Oz305XRNR+gWKW66U2c1DVKgG16QmYfqzdQasmayxoqPUnJdEoyw
         67tadi/DLGeR4acXOdvn1W5fz2a2egIUIieoBePHRy50jYFUz6jJrO0cmrlDJpa99lZr
         M4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708338265; x=1708943065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUKAB7sb5czIBMBlNuCagdfu4VWTGp2m4SsAnQpFoNI=;
        b=fyyVTJHJdiLJga4DNw9yNh1WzrMFpYQFT2Yi3StORlVqyJ9L9wvvv+sALYXvzQ1tux
         Vdq/P7q0w1y2luxw383E95MmDfH/mkZYBsn9bHLbhwg+T0lzoxIZ5h6sGNOUDZZGG0fX
         Zg//3EvDq7brvy/jZJMtv4WKuPEix/89PcxVwF+N8QWWcl8gf456ovuZvnOnwSNnl3kX
         LaFrkBnOm3daPA6BGRabQpTCnBU6yDHECequBBQcngM24HeUclhzzRJ/IjrBlMYI7erZ
         irECcT6IF8i6L8H0bWWweFD0ls4G1xxgvWcMpQxbK5OSzALWe/saTixY2p3vagfcWfRU
         4klQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5/cI4e99Of2LcgXgPWJ5sJfH3e5QvcbeMpCzNNF0VHzSUUl7PPAFd+Uoun+iXjdkL5ph+IXzjG9k6HRuxEyjcou4dBNfw83lhVkRQFMfyTBzrNSj61llGy9tONYU0VghmUcxK
X-Gm-Message-State: AOJu0YxpcuG3ArrMH1oeB0AAQUwpWpJ24+bn4zpxQ/cgM9C/2gk1nF/n
	ob7pCK+LK74FETbPd/vFX8vK9NhFlx0MPOIuEvYoIMLj4PEUNKL7
X-Google-Smtp-Source: AGHT+IF2g+ewN6RzWmlzDcSLZzfEMtoVfx31tsuHwChkjg0cogBD03go0OpotKFKhvIk+IC5hhds6A==
X-Received: by 2002:adf:ea47:0:b0:33d:32fe:cb49 with SMTP id j7-20020adfea47000000b0033d32fecb49mr3310387wrn.3.1708338265299;
        Mon, 19 Feb 2024 02:24:25 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:a92:c660:d7e1:869b:1148:64e8])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d6daa000000b0033d170a5d6dsm9986328wrs.98.2024.02.19.02.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 02:24:24 -0800 (PST)
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
Subject: [PATCH] net: stmmac: fix rx queue priority assignment
Date: Mon, 19 Feb 2024 11:24:05 +0100
Message-Id: <20240219102405.32015-1-piotrwejman90@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver should ensure that same priority is not mapped to multiple
rx queues. Currently dwmac4_rx_queue_priority function is adding
priorities for a queue without clearing them from others.

From DesignWare Cores Ethernet Quality-of-Service
Databook, section 17.1.29 MAC_RxQ_Ctrl2:
"[...]The software must ensure that the content of this field is
mutually exclusive to the PSRQ fields for other queues, that is,
the same priority is not mapped to multiple Rx queues[...]"

After this patch, dwmac4_rx_queue_priority function will:
- assign desired priorities to a queue
- remove those priorities from all other queues
The write sequence of CTRL2 and CTRL3 registers is done in the way to
ensure this order.

Also, the PSRQn field contains the mask of priorities and not only one
priority. Rename "prio" argument to "prio_mask".

Signed-off-by: Piotr Wejman <piotrwejman90@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 36 +++++++++++++------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 6b6d0de09619..6acc8bad794e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -89,22 +89,38 @@ static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
 }
 
 static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
-				     u32 prio, u32 queue)
+				     u32 prio_mask, u32 queue)
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
+	for (i = 0; i < 4; i++)
+		clear_mask |= ((prio_mask << GMAC_RXQCTRL_PSRQX_SHIFT(i)) &
+						GMAC_RXQCTRL_PSRQX_MASK(i));
 
-	value &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);
-	value |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
+	ctrl2 &= ~clear_mask;
+	ctrl3 &= ~clear_mask;
+
+	if (queue < 4) {
+		ctrl2 |= (prio_mask << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
 						GMAC_RXQCTRL_PSRQX_MASK(queue);
-	writel(value, ioaddr + base_register);
+
+		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
+		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
+	} else {
+		queue -= 4;
+
+		ctrl3 |= (prio_mask << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
+						GMAC_RXQCTRL_PSRQX_MASK(queue);
+
+		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
+		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
+	}
 }
 
 static void dwmac4_tx_queue_priority(struct mac_device_info *hw,
-- 
2.25.1


