Return-Path: <linux-kernel+bounces-29847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A1F831450
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467F3285E69
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99995125B1;
	Thu, 18 Jan 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="O8NtbWIm"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED1C125B0;
	Thu, 18 Jan 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565703; cv=none; b=OeCGsvOqtQFhSGkDsPfxymgkVpRgrpX/tSfomQTn5DwonFW3xMNONa29a4g4H5Otm3vn6MU10NJQJvR385VHTpV45hpI3hLC7w4xwd1LxJSHGNJsVHrOs7WRTcOMFQoQy32TEOwk6J5e9KHdH7aKb85hBHxCRwAgSAgpBWZJ688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565703; c=relaxed/simple;
	bh=9conq0HhCENWalRVCFB268jo1G5xDSIzy+3McHAMtg8=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version; b=GkDWMOssDdxOokD2pU6MbQ+7IHKTZx8IKkKk+eL+r/edswxLck6O6FRDkrTQ1aDIf4vVb2cGXBZ8n2UOuPC/oRALOfNcRNuXX7PgT7+qgGRB9Xk4Y7Qnfb8k3ENbLlNvw0sTPgxbzCod8APMzzLVS9x+tCGo0c0MwMcq4uU3z6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=O8NtbWIm; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I6QGeG019324;
	Thu, 18 Jan 2024 00:14:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=moT+SCZi
	MPWFJb8Gxy5U3PliGPkKnKE/KLLWUv64/Hs=; b=O8NtbWImzE0c6A5A71Ux46Bd
	aspBhc77eX6NGDGJEjkkrouKzX3saH7GYS9+uFkzdQ+HE6OxY4u/fmLckBo7Ec4T
	9hZvptbIRzL7E9xbPGsQyHrlJ+W0lMPS7cO+vdrYh6k2R171nVH9x1RxzrG4niaO
	1zS2D99TMv8CipbD5cyrhh6/QYd0MflVy9/V4kqLYXS9NFlARutwgSwt5KqI6vfY
	RtDFnM3zwiygbuQclQDwnslKvVshvEGMhKp2K2UtyYDCHQe9t59X6LqWAIeyi8Tk
	rEu/r8IB6ZoKDxIdax28+7zAl2O2ib6stVjMHMtPqEOyPMcR/zjTkfXV5rVJGw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vpxqfran6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 00:14:51 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 18 Jan
 2024 00:14:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 18 Jan 2024 00:14:49 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id BED393F7068;
	Thu, 18 Jan 2024 00:14:49 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Subject: [net v3 PATCH 1/1] net: mvpp2: clear BM pool before initialization
Date: Thu, 18 Jan 2024 00:14:47 -0800
Message-ID: <20240118081447.3884278-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: m6F7iHrMTfd_JKdFDZO62vf4j7raDShw
X-Proofpoint-GUID: m6F7iHrMTfd_JKdFDZO62vf4j7raDShw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_04,2024-01-17_01,2023-05-22_02

Register value persist after booting the kernel using
kexec which results in kernel panic. Thus clear the
BM pool registers before initialisation to fix the issue.

Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
v1-v2:
-Move comments outside the loop
-remove unrequired brances.
v2-v3:
-improve readability
-correct register read API

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 820b1fabe297..cab319287522 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -614,12 +614,44 @@ static void mvpp23_bm_set_8pool_mode(struct mvpp2 *priv)
 	mvpp2_write(priv, MVPP22_BM_POOL_BASE_ADDR_HIGH_REG, val);
 }
 
+/* Cleanup pool before actual initialization in the OS */
+static void mvpp2_bm_pool_cleanup(struct mvpp2 *priv, int pool_id)
+{
+	u32 val;
+	int i;
+	unsigned int thread = mvpp2_cpu_to_thread(priv, get_cpu());
+
+	/* Drain the BM from all possible residues left by firmware */
+	for (i = 0; i < MVPP2_BM_POOL_SIZE_MAX; i++)
+		mvpp2_thread_read(priv, thread, MVPP2_BM_PHY_ALLOC_REG(pool_id));
+
+	/* Stop the BM pool */
+	val = mvpp2_read(priv, MVPP2_BM_POOL_CTRL_REG(pool_id));
+	val |= MVPP2_BM_STOP_MASK;
+	mvpp2_write(priv, MVPP2_BM_POOL_CTRL_REG(pool_id), val);
+
+	/* Mask BM all interrupts */
+	mvpp2_write(priv, MVPP2_BM_INTR_MASK_REG(pool_id), 0);
+
+	/* Clear BM cause register */
+	mvpp2_write(priv, MVPP2_BM_INTR_CAUSE_REG(pool_id), 0);
+
+	put_cpu();
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
@@ -629,7 +661,6 @@ static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)
 			}
 		}
 
-		poolnum = mvpp2_get_nrxqs(priv) * 2;
 		for (i = 0; i < poolnum; i++) {
 			/* the pool in use */
 			int pn = i / (poolnum / 2);
-- 
2.25.1


