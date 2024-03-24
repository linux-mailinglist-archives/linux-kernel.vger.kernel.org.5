Return-Path: <linux-kernel+bounces-115078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F7888CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E221C2A751
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638C28A662;
	Mon, 25 Mar 2024 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp+nYn3B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE01180A9C;
	Sun, 24 Mar 2024 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324058; cv=none; b=mIZQzsXjW2tWZjXAO1LiZAmf/JBCA3ig5P94qVYkD0UEBARjPqjydejgPIyDFE/3bnyjA4PHjavJ/pTIbVxXvI0Pq210jvTQF9CpjOF1y4eawXZZsihJLGl+BqhNDqEsVs/oWH7j2Iz7oVpv2+Zal6BRzv1mYyW2SdVqha1V8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324058; c=relaxed/simple;
	bh=MRDmClh3Cke92m76M4nPCaQOFMb5bQB4ZRJEkFsfWQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiNtwD9WAAuvN09or6ulBxU2JW8N6A/E7wZfDshJqdEGaQSfdgXBU1sb0L2KU6tiRy/0Nhlp55Ge/ztE1iwSttuJ/Cvkhp7Q5xjBNbQwADiT4Gus5mw3SinCkKz9ecg4MpbUX7vjPgDf+1ed8osgcwmXCSzsw+hekXkTwzIi4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp+nYn3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266D2C433B1;
	Sun, 24 Mar 2024 23:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324056;
	bh=MRDmClh3Cke92m76M4nPCaQOFMb5bQB4ZRJEkFsfWQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qp+nYn3BLwpgPoJCM86Ia1LAcHUb1RamApX/L4miQvwuxYw0iBDj3H5SG3OXqR6dI
	 Q7ctFiAA1HHGw9PjKnWBR+cvHj37l1zVpxT664Km43rOhwPmP+AxQQ9WBD3S3KOfIu
	 MzbY9QZWs2X5p+qU0RaJ7ug48sNI/+24KarsDVL61Ids46+ZOEnBbUpucbknkIznF6
	 1H4JbjzEK6k0Hi04aXTYxBGpgHMToETjQVVmnlDWCI7fkx7U58+Z2tCwY7BnOez/Yz
	 mRyyI/SJzGnJm/QEY49M78KW07GyjSvR++FH0vkpgH3V20MRXn1hvxxj9B+fwQE1/p
	 1W9aJOFENpQ1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arthur Kiyanovski <akiyano@amazon.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 057/183] net: ena: cosmetic: fix line break issues
Date: Sun, 24 Mar 2024 19:44:30 -0400
Message-ID: <20240324234638.1355609-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit 46143e58884025292bd977ca8bc0fdd9dac47c4c ]

1. Join unnecessarily broken short lines in ena_com.c ena_netdev.c
2. Fix Indentations of broken lines

Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 78e886ba2b54 ("net: ena: Remove ena_select_queue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c    | 8 +++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 3 +--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 9225733f4fece..29700fee42e9d 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -375,7 +375,7 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 		io_sq->bounce_buf_ctrl.next_to_use = 0;
 
 		size = io_sq->bounce_buf_ctrl.buffer_size *
-			 io_sq->bounce_buf_ctrl.buffers_num;
+			io_sq->bounce_buf_ctrl.buffers_num;
 
 		dev_node = dev_to_node(ena_dev->dmadev);
 		set_dev_node(ena_dev->dmadev, ctx->numa_node);
@@ -702,8 +702,7 @@ static int ena_com_config_llq_info(struct ena_com_dev *ena_dev,
 		/* The desc list entry size should be whole multiply of 8
 		 * This requirement comes from __iowrite64_copy()
 		 */
-		pr_err("illegal entry size %d\n",
-		       llq_info->desc_list_entry_size);
+		pr_err("illegal entry size %d\n", llq_info->desc_list_entry_size);
 		return -EINVAL;
 	}
 
@@ -2063,8 +2062,7 @@ void ena_com_aenq_intr_handler(struct ena_com_dev *dev, void *data)
 
 	/* write the aenq doorbell after all AENQ descriptors were read */
 	mb();
-	writel_relaxed((u32)aenq->head,
-		       dev->reg_bar + ENA_REGS_AENQ_HEAD_DB_OFF);
+	writel_relaxed((u32)aenq->head, dev->reg_bar + ENA_REGS_AENQ_HEAD_DB_OFF);
 }
 
 int ena_com_dev_reset(struct ena_com_dev *ena_dev,
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 2e5348ec2a2e9..734da4e9ead2f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2401,8 +2401,7 @@ static u16 ena_select_queue(struct net_device *dev, struct sk_buff *skb,
 	return qid;
 }
 
-static void ena_config_host_info(struct ena_com_dev *ena_dev,
-				 struct pci_dev *pdev)
+static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pdev)
 {
 	struct ena_admin_host_info *host_info;
 	int rc;
-- 
2.43.0


