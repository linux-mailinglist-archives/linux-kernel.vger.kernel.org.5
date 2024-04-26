Return-Path: <linux-kernel+bounces-160013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B378B37B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83C41C2279A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A95148318;
	Fri, 26 Apr 2024 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7HNKUfYi"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF35146A90;
	Fri, 26 Apr 2024 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136393; cv=none; b=OxZt/sjXzXVnGjXZTVtqzcCJ5G5FZ7aE3s9TBDf89Op7uipDzJSmS4CF5hCUSNLNQzvDcS32nFJCJwXMJmSCZ6k7bQLIxZiSy8lUuSBqz8JhVsHS+Z2Iv/qeMwaXOVkancC0p77HtkgT8TJhBlTc1lujpuz3JqNhcqA8CtLhWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136393; c=relaxed/simple;
	bh=EiHRYeZtWEfpRFKUuc6ZAyGPYjJTopn84mY5KLOI40M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AD23KErQwShoAO89qTwvNfl4FMqVICR0K3j4Iz44ckhRd8DZ27elIvHdjbpj96NXtb6HGUGXqg1kSoUbduwlJPRg4Cl0/ygfKFja6fpPbtmXNvS7xk5RetsMEe84UKhgriFlsVxO0fHDYphPKwp5wVxSPHEDxfWu4vA5ov4KxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7HNKUfYi; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q8OOp2018290;
	Fri, 26 Apr 2024 14:59:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=YuhTDF53k8WGnfWTlzSXnbFYLVQGieXoGIp8bpBnuE0=; b=7H
	NKUfYiWfPjUvt7AZe6gxIgUI2tKV+1kF7pjEI/8zP7iuVYiapUFOdHEzhvKUiBkI
	2nAqtF0kX3bqnXRHmnfDXKy5lvRag23HJgUs5IaexxntzzAZJfJUYJsZBoneSMm7
	1Spmjsi4AifFhRnL2+uxYiceeK6zDQxuMQfDoTNvPIi2UtmeLjIdLBBYSMZZ8dfW
	F9jrGrzuNjWTa7JXjnKZkJr0fjLFq6bfWO+6dAYotL/1ugRxG5c4mjx7If5tB9Et
	FtuSeTYiAd0cMSQHQ6lVOza9wX5W2rXFiCPhSvAWMFc1qRKDEs2NYLQkm/p4dWpk
	r0CBdie84o5yUJ2neHWA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4cntnpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:59:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D8E264002D;
	Fri, 26 Apr 2024 14:59:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 66065222CAB;
	Fri, 26 Apr 2024 14:58:08 +0200 (CEST)
Received: from localhost (10.252.17.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 14:58:05 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/11] net: stmmac: dwmac-stm32: add management of stm32mp13
Date: Fri, 26 Apr 2024 14:57:00 +0200
Message-ID: <20240426125707.585269-5-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426125707.585269-1-christophe.roullier@foss.st.com>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

Add Ethernet support for STM32MP13.
STM32MP13 is STM32 SOC with 2 GMACs instances.
GMAC IP version is SNPS 4.20.
GMAC IP configure with 1 RX and 1 TX queue.
DMA HW capability register supported
RX Checksum Offload Engine supported
TX Checksum insertion supported
Wake-Up On Lan supported
TSO supported

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 68a02de25ac7..7529a8d15492 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -517,9 +517,30 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	}
 };
 
+static struct stm32_ops stm32mp13_dwmac_data = {
+	.set_mode = stm32mp1_set_mode,
+	.suspend = stm32mp1_suspend,
+	.resume = stm32mp1_resume,
+	.parse_data = stm32mp1_parse_data,
+	.clk_rx_enable_in_suspend = true,
+	.syscfg_clr_off = 0x08,
+	.pmcsetr = {
+		.eth1_clk_sel		= BIT(16),
+		.eth1_ref_clk_sel	= BIT(17),
+		.eth1_selmii		= 0,
+		.eth1_sel_rgmii		= BIT(21),
+		.eth1_sel_rmii		= BIT(23),
+		.eth2_clk_sel		= BIT(24),
+		.eth2_ref_clk_sel	= BIT(25),
+		.eth2_sel_rgmii		= BIT(29),
+		.eth2_sel_rmii		= BIT(31)
+	}
+};
+
 static const struct of_device_id stm32_dwmac_match[] = {
 	{ .compatible = "st,stm32-dwmac", .data = &stm32mcu_dwmac_data},
 	{ .compatible = "st,stm32mp1-dwmac", .data = &stm32mp1_dwmac_data},
+	{ .compatible = "st,stm32mp13-dwmac", .data = &stm32mp13_dwmac_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_dwmac_match);
-- 
2.25.1


