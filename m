Return-Path: <linux-kernel+bounces-101744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4198F87AB37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0107BB22638
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B2253E0E;
	Wed, 13 Mar 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKEV1r1G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60D053399;
	Wed, 13 Mar 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347565; cv=none; b=tLD6ErLtUnJuIgS4QD0gUU+8fDqdsEEAH93a5JfrCTbfHYiYkX5FA21DDFxFbnsLdBSd3sO3FoJ3fUD5cZWwc3kKU1f3jMlFL1gcAcqkJI4g8CbVgVKD6EH13P7Kfm1dwHQnO65JQX2hFqQPuWODZAf0v/AGh1VgeXRRahDULLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347565; c=relaxed/simple;
	bh=X5evWfXM8GEHuGV4oJwMVCIjy8InSOaQVoAvsiB2kBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXLwczi4ov8OPR4zjdjYFWHIP3uM9EQaPR8qEQ/WmDSaguyQwOfklDrK8A6fzglAooJLKgVtktyZNwEZixUnOnKQPuenhQT1x7d3Ey33D/6niOhSZQTiLaNPVZjeied18mOO3pDdE6hUXTcb/25lsg36KlrRcXMDJ+1eIjkd2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKEV1r1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D351C433C7;
	Wed, 13 Mar 2024 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347565;
	bh=X5evWfXM8GEHuGV4oJwMVCIjy8InSOaQVoAvsiB2kBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKEV1r1Go4X59ogJTxQF1uJdKbDhGTD0dRo3NcNxXN//bemuKfIet7Vn3BzjrOB9M
	 8Ht1/qcUehr2Oe+RvLhVlR3EHaTZPhP8U9zOZSIW28M6ZmsG9cw0TcJuAQ+pjgO0lj
	 gIV4261xcxhf3fWcBqkM3uZezMGm1Uq/ilbmyWzfd8EcXPrTKvGUu1XOdNGRklOGGU
	 4I051tSf1ZWM54eiw09HQJpIZ8OPHLHWRUl1MObmG9mNFN8oevdHuCGdAWPHqrrUx/
	 jQXjm6w9a6RW22CTZhx1SuPkLgWFx5z2ES0mFC41VLz9V0gBNi7yhP4tV6ltpN6n4W
	 rHgO3B5qsWN9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 05/61] dt-bindings: dma: fsl-edma: Add fsl-edma.h to prevent hardcoding in dts
Date: Wed, 13 Mar 2024 12:31:40 -0400
Message-ID: <20240313163236.613880-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 1e9b05258271b76ccc04a4b535009d2cb596506a ]

Introduce a common dt-bindings header file, fsl-edma.h, shared between
the driver and dts files. This addition aims to eliminate hardcoded values
in dts files, promoting maintainability and consistency.

DTS header file not support BIT() macro yet. Directly use 2^n number.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20231114154824.3617255-3-Frank.Li@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: a79f949a5ce1 ("dmaengine: fsl-edma: correct max_segment_size setting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/dt-bindings/dma/fsl-edma.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 include/dt-bindings/dma/fsl-edma.h

diff --git a/include/dt-bindings/dma/fsl-edma.h b/include/dt-bindings/dma/fsl-edma.h
new file mode 100644
index 0000000000000..fd11478cfe9cc
--- /dev/null
+++ b/include/dt-bindings/dma/fsl-edma.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+#ifndef _FSL_EDMA_DT_BINDING_H_
+#define _FSL_EDMA_DT_BINDING_H_
+
+/* Receive Channel */
+#define FSL_EDMA_RX		0x1
+
+/* iMX8 audio remote DMA */
+#define FSL_EDMA_REMOTE		0x2
+
+/* FIFO is continue memory region */
+#define FSL_EDMA_MULTI_FIFO	0x4
+
+/* Channel need stick to even channel */
+#define FSL_EDMA_EVEN_CH	0x8
+
+/* Channel need stick to odd channel */
+#define FSL_EDMA_ODD_CH		0x10
+
+#endif
-- 
2.43.0


