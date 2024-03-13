Return-Path: <linux-kernel+bounces-101803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6268787ABBF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB12838A6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5005A4D134;
	Wed, 13 Mar 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmFImyyq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0CF56B9B;
	Wed, 13 Mar 2024 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347832; cv=none; b=m8Y3ZvwA5MU7nWibYyZOzwwE6YWvlngNyD5eBl2b4Ne4D+qRkgpMgDu9AnZT10oS/f2qUGFUZYzbVafdkDcFcLV92spPIlBQ/QXQThjTV8tidbKNtdqNE1eGQN+bin+vuCFYH1IOgcsjfSn/MRSCCTCD/BAuORRiUfNrC7X9ULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347832; c=relaxed/simple;
	bh=K9pnua/Id5hq18UGxClNrowmQIW9BfoGTl1qNbNnRVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5xGhgCj+3ZuZjU7RkwBux9Szulc5eUduL7biEXNwq7zYXg9/DPevN9DdV2y9Loxehf+mKsE34z+edzGuBXqEFS7WIvBREUUi8cs2a4IcrbgUPlCKE9Juc+OTFXZs9FJE4jQN0kjuDG85JbG5+2xTe5db7bq/+hdiDFeGz+l1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmFImyyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79979C43390;
	Wed, 13 Mar 2024 16:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347832;
	bh=K9pnua/Id5hq18UGxClNrowmQIW9BfoGTl1qNbNnRVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HmFImyyqtZs+qASZ2goyruJc+LowtDsHdAH9EyeYM2u+zCHgzMVCPL04hwEaLq6Tp
	 hQnE57vqc16dNy81M85Qj0/gFaTJXkT5tq6XmQZCM58t2UYVLg/kPYeNMZLJPBYsGH
	 GN02EaiUGvL1WhiePw23VzyX9fi2jNaRjP39eo5GHuibTZrTP5e+8ZogL98/KxCBEm
	 Q7FPM5ZFws2GQ8CG0zy7aKvwHWvrg1qf0Xtrag/U3qEfl7ZkR+RI1JkIzDQnJu0ylB
	 xx8D0C1NZq7UEa2t3rkpn660nF1NeqOwhKvbIEV4FTRhEgaw2emjL/S31lceop/0E8
	 GbQP/LuhGyfvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 02/60] dmaengine: fsl-edma: utilize common dt-binding header file
Date: Wed, 13 Mar 2024 12:36:09 -0400
Message-ID: <20240313163707.615000-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit d0e217b72f9f5c5ef35e3423d393ea8093ce98ec ]

Refactor the code to use the common dt-binding header file, fsl-edma.h.
Renaming ARGS* to FSL_EDMA*, ensuring no functional changes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20231114154824.3617255-4-Frank.Li@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: a79f949a5ce1 ("dmaengine: fsl-edma: correct max_segment_size setting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/fsl-edma-main.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 30df55da4dbb9..a56c8a0f2663f 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -9,6 +9,7 @@
  * Vybrid and Layerscape SoCs.
  */
 
+#include <dt-bindings/dma/fsl-edma.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
@@ -23,12 +24,6 @@
 
 #include "fsl-edma-common.h"
 
-#define ARGS_RX                         BIT(0)
-#define ARGS_REMOTE                     BIT(1)
-#define ARGS_MULTI_FIFO                 BIT(2)
-#define ARGS_EVEN_CH                    BIT(3)
-#define ARGS_ODD_CH                     BIT(4)
-
 static void fsl_edma_synchronize(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
@@ -157,14 +152,14 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 		i = fsl_chan - fsl_edma->chans;
 
 		fsl_chan->priority = dma_spec->args[1];
-		fsl_chan->is_rxchan = dma_spec->args[2] & ARGS_RX;
-		fsl_chan->is_remote = dma_spec->args[2] & ARGS_REMOTE;
-		fsl_chan->is_multi_fifo = dma_spec->args[2] & ARGS_MULTI_FIFO;
+		fsl_chan->is_rxchan = dma_spec->args[2] & FSL_EDMA_RX;
+		fsl_chan->is_remote = dma_spec->args[2] & FSL_EDMA_REMOTE;
+		fsl_chan->is_multi_fifo = dma_spec->args[2] & FSL_EDMA_MULTI_FIFO;
 
-		if ((dma_spec->args[2] & ARGS_EVEN_CH) && (i & 0x1))
+		if ((dma_spec->args[2] & FSL_EDMA_EVEN_CH) && (i & 0x1))
 			continue;
 
-		if ((dma_spec->args[2] & ARGS_ODD_CH) && !(i & 0x1))
+		if ((dma_spec->args[2] & FSL_EDMA_ODD_CH) && !(i & 0x1))
 			continue;
 
 		if (!b_chmux && i == dma_spec->args[0]) {
-- 
2.43.0


