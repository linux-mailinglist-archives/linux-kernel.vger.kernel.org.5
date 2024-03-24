Return-Path: <linux-kernel+bounces-115108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E7F889341
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E23EB2EF7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB231C5E02;
	Mon, 25 Mar 2024 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfK5t66P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF26A181824;
	Sun, 24 Mar 2024 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324094; cv=none; b=ljLJ87pWENiuihH6ZczNpVqY1TGVCtNaK92qsgjCeF08ooSEzKy5vF483koON4p8HQ6BiERPpaNbY3MgWKn8cd5dmVfuc5L0Ms2kZntV943MHZxzsh+EjNN0CPR3YWl8ZMPW70OTGy+j2bbTuQ+Wpb526g3rQxes+oU4a7Oul0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324094; c=relaxed/simple;
	bh=Q6KOVtDs6oNFjJoLfnzxl1u3QloDpMzBIFFk15tx8As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyE0bIJO++6bhV9tluD8mSE2rMJdgDzwUYSeYgcFWMVa4DEVw2tqrpvnehTHmdneBCOR8IYVEylq8EHRphiSfPX123X0RcRG34SrYE2xHd+3rz5wfaQMJEhL40EHRT++xZ86gM1H8uFyRsWBDtGwfWPx35Zo78iyeclpOME5lGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfK5t66P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FBAC43394;
	Sun, 24 Mar 2024 23:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324094;
	bh=Q6KOVtDs6oNFjJoLfnzxl1u3QloDpMzBIFFk15tx8As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfK5t66PmXiiHoN0Ee6uvDxQfxFACJ/IdqJK+jwr9XCVC931Z7FjRxDEpiL7bxbDY
	 iP4pSGeeF1JFzF0ouwDqzHwg34OnFpQ6r1yvMrD0M7l47c49aBQpC3p0TWI+bb87a+
	 2yjm1/blYlpRVSO5sFZDGrzDD7Fi748h2wHia618CqaajpcewWVHcqzy+/PksGoKIV
	 F09n2S4s4RlY5Bs8lawiD7jvF01X+NFlBjuA7hmwCMgHyjh7U6GGs0BIUIkYSw+0Us
	 /RqMJ2XWbP1y8TA5EMwpOWHA9yxWTT2mD8yolgEiaXAnLZ8CvZMCXAyUp3IrjEigZ8
	 UJTcfxU+9CTzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sameer Pujar <spujar@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 094/183] dmaengine: tegra210-adma: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 19:45:07 -0400
Message-ID: <20240324234638.1355609-95-sashal@kernel.org>
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

From: Peter Robinson <pbrobinson@gmail.com>

[ Upstream commit 33b7db45533af240fe44e809f9dc4d604cf82d07 ]

Update the architecture dependency to be the generic Tegra
because the driver works on the four latest Tegra generations
not just T210, if you build a kernel with a specific
ARCH_TEGRA_xxx_SOC option that excludes 210 you don't get
this driver.

Fixes: 433de642a76c9 ("dmaengine: tegra210-adma: add support for Tegra186/Tegra194")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Sameer Pujar <spujar@nvidia.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20240112093310.329642-2-pbrobinson@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 66aad9dbd58c5..a7c156ce2c298 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -582,16 +582,16 @@ config TEGRA20_APB_DMA
 
 config TEGRA210_ADMA
 	tristate "NVIDIA Tegra210 ADMA support"
-	depends on (ARCH_TEGRA_210_SOC || COMPILE_TEST)
+	depends on (ARCH_TEGRA || COMPILE_TEST)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-	  Support for the NVIDIA Tegra210 ADMA controller driver. The
-	  DMA controller has multiple DMA channels and is used to service
-	  various audio clients in the Tegra210 audio processing engine
-	  (APE). This DMA controller transfers data from memory to
-	  peripheral and vice versa. It does not support memory to
-	  memory data transfer.
+	  Support for the NVIDIA Tegra210/Tegra186/Tegra194/Tegra234 ADMA
+	  controller driver. The DMA controller has multiple DMA channels
+	  and is used to service various audio clients in the Tegra210
+	  audio processing engine (APE). This DMA controller transfers
+	  data from memory to peripheral and vice versa. It does not
+	  support memory to memory data transfer.
 
 config TIMB_DMA
 	tristate "Timberdale FPGA DMA support"
-- 
2.43.0


