Return-Path: <linux-kernel+bounces-101804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D309E87ABC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D59D283660
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500AF5810A;
	Wed, 13 Mar 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZnRdzSA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B09F56B96;
	Wed, 13 Mar 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347832; cv=none; b=RA3OXuQPmLKY0jCDyPN2zbFK76jeInGUFtzvTKy3/m+xYP6lAhxrTFmOrpppyhTcPdTcB3SkJL0K2ybVkH0sFz+t6I0QstWAyrBp3HxFILN5M1GaRu8zmqj9HvPsZCMUGnEHP49zKhJBcFVxH6T4ZNzI5+KhFJ6+iJOfNi01dXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347832; c=relaxed/simple;
	bh=X5evWfXM8GEHuGV4oJwMVCIjy8InSOaQVoAvsiB2kBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJxXRxr/BnECQSnYjVCmBYFk+wbd6U4ITrReXPFroDZCGHIC171PRNS4nniQU6Nl/UVkWQXkbBaaGAFcdKbtZpEwre77ABx8Obb1g8I0wD67s2YfJ2pFHyYA8GocmYtiewv7rtbLgDr2hHZiMm41dAIgxkf758wnCRvOO4cTau8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZnRdzSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60535C433F1;
	Wed, 13 Mar 2024 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347831;
	bh=X5evWfXM8GEHuGV4oJwMVCIjy8InSOaQVoAvsiB2kBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZnRdzSAmDWxW6bO06d6xMj6sZTXWYTps+H2mYnDLf7HLX0uew5T2iEMQnVXRUpW+
	 6TNd+6iBSlFwR0PWAe/LOY8xYHDNBV5wbowrv/RHFwsoZBmIheD9H3H69Qtw1926o9
	 uFEnN2D6se1o0NJVAxBOsmGxyjDp76QeyWN73oPsXFA9htdjBK1rcVqj3V4GhCBngB
	 9GB4joORSCFltg/m189asEAOr2gs39juhw2RxzD2UYtw+RAHIfTK9zhPbHIasNPQF8
	 ecJGRRFxmEliyJuw1pn2FxbjwLZR7uu7w+5uWY32H7Al9lDRoLjlLdp1hD1bqLnUTd
	 S9Z0XVYNH3huQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 01/60] dt-bindings: dma: fsl-edma: Add fsl-edma.h to prevent hardcoding in dts
Date: Wed, 13 Mar 2024 12:36:08 -0400
Message-ID: <20240313163707.615000-2-sashal@kernel.org>
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


