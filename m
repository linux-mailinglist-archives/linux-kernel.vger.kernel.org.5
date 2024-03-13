Return-Path: <linux-kernel+bounces-101745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A6387AB39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB5B288854
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC48854BFF;
	Wed, 13 Mar 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/fk1gT8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A59253E30;
	Wed, 13 Mar 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347567; cv=none; b=SRd4Oz4yxOxjt5XzzF5bQr3x3uCb+0wGY3uz/HWCOPJgDSPmy7Gjb9XjSKpUEuTnWMto1SY6cIX0/aNHsr4angr7urhnei3XkKqannqISOTiR8I6X3jyNthjzFy8GpRT27/1Ud8eK+HfhC2reN3Ti/3CIBjBLYkNVeQf959CObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347567; c=relaxed/simple;
	bh=s2efhrQBCbHJnbdZjOb5z7wBCsEMxP4MrYOva+cNMf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxBNTexlDdJcIsFIJ6unQMJjfjIJe32jhrDhgaoW+TBLEMJs6BlEJUc1bxW964iULbroGWkU/biJuALFRD038egnKCxaQDcg/l4HHqKAMEbZDc5KNWJegn7z1pqCqIv5OmrQviLgw0cDorxRNPRsBQ+bgNaog9nDv3F8q4C0R0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/fk1gT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0330C43394;
	Wed, 13 Mar 2024 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347566;
	bh=s2efhrQBCbHJnbdZjOb5z7wBCsEMxP4MrYOva+cNMf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/fk1gT8OIZXzKqIZbzoaaeztVkVBPNTEV65N+b8wC12PwOubzrqMYxaQMeRcy+tt
	 p+NQ6u3zdCTd9QcmRGM4GsjDHCIBFlGVtEGFxYqji+146AUciAR9WTOvHf31uFrzU3
	 lJMhDi3ISFPSX/Tkx2/bHBC2HAdRBLgy3cLEETb7xujLDTWjpXdxFm6Ed4Y8mxsYVg
	 OvZ7x6YI8BrchLJJb/OzUvczNXlILalYGnr0S6LR4MhGG2OZWRB2bU9RdWDwDN4SYX
	 YFnBdAetWJ0bn5QT0Kn7FysIFyasvsU6omwVXV+E21VyTe/2tisbFPpjdoQLUOJvNE
	 SqcTQGts4rcyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 06/61] dmaengine: fsl-edma: utilize common dt-binding header file
Date: Wed, 13 Mar 2024 12:31:41 -0400
Message-ID: <20240313163236.613880-7-sashal@kernel.org>
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
index 75cae7ccae270..45cc419b1b4ac 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -9,6 +9,7 @@
  * Vybrid and Layerscape SoCs.
  */
 
+#include <dt-bindings/dma/fsl-edma.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
@@ -21,12 +22,6 @@
 
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
@@ -155,14 +150,14 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
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


