Return-Path: <linux-kernel+bounces-28557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBCD830014
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489721F2503C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B588F44;
	Wed, 17 Jan 2024 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BCbHnMm1"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445D28FC;
	Wed, 17 Jan 2024 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472608; cv=none; b=FoLkzFl0gQxNShaGL+Gyzc1uAS/zkMoJoSfpbtPTq7KpJh1JV4ZTtS3lxE8gW0anD1kO4Ww3wv7LivvssaW1FFtLI08kjhfUlDlT+CtiAF+kxmtrebUUn1jQk6ctoIOuYP1JPdby/DiPDGtilktXilpYixUsWKChWeRsl8VMAgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472608; c=relaxed/simple;
	bh=YmgAmQESRGyO7hObIG4VdMuhpU1Rmm5n8BlSEhK+Ci0=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version; b=fGh6V9v0qtafcOhVWZAjiJPLUQTcquJgXazybkmgo+eUSs28u/bhljSaG/BX9Kej+yA+tHJO9VGlK87q3BdFZlvA4BhZaj1HqMVQjnKrNf39tkhB5E67KUeS1l7kixeNUTIScqtbqawzjEVTVuMkJk1XqsolLkJ4NTguKsW62WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BCbHnMm1; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GI9O2R002942;
	Tue, 16 Jan 2024 22:23:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=VjLXAwL3
	3gDx/5/BzSqYEdBdLVkV4tNSMniS7zSywuI=; b=BCbHnMm1caokDrn29icWtAcD
	ZvqvHUzs5RUy+dUbOGFvXd6zTEgBl5pCXinu0R7yE6qO9cOBjQo3ZWM9rRZDzOq8
	KHMaGF+TyZFO1Ru8wvU3HKD7SjIypd8s7ysSTX9oFU88aklCM5x3b0i9r/o8kofJ
	0xpNl4M0oDsnHL3tt8pP6efYVpSw8STLkNgVimkMOCJaM1Qp9dNmWtmt97V6ePb/
	mqoOrvugzdfa8aK8zZxWIfvq95K72rj0F1iF1l2EyyjT4CVRLknsjA6vZ/23yx3y
	D1praCRRcIpv8FEarZmWPJYEmhhYMhK5Ro61xtcambSwFQjoxRlwSmrrXG7oYA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vnxu1jd6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 22:23:14 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 16 Jan
 2024 22:23:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 16 Jan 2024 22:23:13 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id A6A803F7044;
	Tue, 16 Jan 2024 22:23:12 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Subject: [net v2 PATCH 1/1] net: mvpp2: clear BM pool before initialization
Date: Tue, 16 Jan 2024 22:23:10 -0800
Message-ID: <20240117062310.2030408-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: j9pVR1av0e7_aP6TpQx_f3QT-tsmk5w3
X-Proofpoint-ORIG-GUID: j9pVR1av0e7_aP6TpQx_f3QT-tsmk5w3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_02,2024-01-16_01,2023-05-22_02

Register value persist after booting the kernel using
kexec which results in kernel panic. Thus clear the
BM pool registers before initialisation to fix the issue.

Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
v1-v2:
-Move comments outside the loop
-remove unrequired brances.

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 820b1fabe297..49d9960f9ce8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -614,12 +614,37 @@ static void mvpp23_bm_set_8pool_mode(struct mvpp2 *priv)
 	mvpp2_write(priv, MVPP22_BM_POOL_BASE_ADDR_HIGH_REG, val);
 }
 
+/* Cleanup pool before actual initialization in the OS */
+static void mvpp2_bm_pool_cleanup(struct mvpp2 *priv, int pool_id)
+{
+	u32 val;
+	int i;
+	/* Drain the BM from all possible residues left by firmware */
+	for (i = 0; i < MVPP2_BM_POOL_SIZE_MAX; i++)
+		mvpp2_read(priv, MVPP2_BM_PHY_ALLOC_REG(pool_id));
+	/* Stop the BM pool */
+	val = mvpp2_read(priv, MVPP2_BM_POOL_CTRL_REG(pool_id));
+	val |= MVPP2_BM_STOP_MASK;
+	mvpp2_write(priv, MVPP2_BM_POOL_CTRL_REG(pool_id), val);
+	/* Mask BM all interrupts */
+	mvpp2_write(priv, MVPP2_BM_INTR_MASK_REG(pool_id), 0);
+	/* Clear BM cause register */
+	mvpp2_write(priv, MVPP2_BM_INTR_CAUSE_REG(pool_id), 0);
+}
+
 static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)
 {
 	enum dma_data_direction dma_dir = DMA_FROM_DEVICE;
 	int i, err, poolnum = MVPP2_BM_POOLS_NUM;
 	struct mvpp2_port *port;
 
+	if (priv->percpu_pools)
+		poolnum = mvpp2_get_nrxqs(priv) * 2;
+
+	/* Clean up the pool state in case it contains stale state */
+	for (i = 0; i < poolnum; i++)
+		mvpp2_bm_pool_cleanup(priv, i);
+
 	if (priv->percpu_pools) {
 		for (i = 0; i < priv->port_count; i++) {
 			port = priv->port_list[i];
-- 
2.25.1


