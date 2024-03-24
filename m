Return-Path: <linux-kernel+bounces-113262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E491C8882E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07FD2884B8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1888618929A;
	Sun, 24 Mar 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sikFVSCR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF76189281;
	Sun, 24 Mar 2024 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320062; cv=none; b=hKIBx6z/rk8w1cRypTmw9nquqPzB+PVeJCZPZA4H11DHmw94AWe7zW5Z68oZ9fbYMC6piTHE5iyvV3Wy66jFTE2iwguYTFoBanUvgIzCSOMdx2IkS6bLFxb33w/HjVnEJDseqYXZ4ylhgp2i81JNO886IErhIvnR8E4ouQcwa1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320062; c=relaxed/simple;
	bh=NpmGYaOjFvZCqNyv/G/NLbLTYcYtn8vcWIXCfc14T6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmaIiwb39TzMNsKT3KwvEZymhnFOsbW3YIEp2Fqw55hUq0IbzZwVZkMA1hffnJKHstwPauE/vmQEX9rYl5uSFNjWrnHU6+tEBWXsSzAH2fo98ToRhBrhpXppxlZxqUA5beR95hHo2/P4jQ3EiwZV0IjWPRsHE7JRkVfJqYSd9ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sikFVSCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73FDC433C7;
	Sun, 24 Mar 2024 22:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320061;
	bh=NpmGYaOjFvZCqNyv/G/NLbLTYcYtn8vcWIXCfc14T6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sikFVSCRqSox3XGpXgO9+VpqH+s3MsPrTswBXqfzeCJPifQ7e1Ir6NN1TQ/CnjZP/
	 AOOjL4i28t9ieUFcfnndm+39dHE3yKvmBA5R0MnL+KkCTowP16zigd9X7YpL1N3u43
	 0IqQPAtHaA779tXpHtFbD5TXHKNfk75pdtY4+84y930gLmdy/heyKpvGeb9dzDwD4l
	 LcKQhq2cKNKrors7cpbXN4y7BlR2XjMwOagRP3vRLOHilBdJNBMAC3h5raR4ERUFe7
	 qKca7+RE1R39WQ71mvGxXP/lSu/+KcBfCrSYGNr5nptxzY5jbjUJYnWXpnzbQY8ePY
	 z/S1dOq2pKmEg==
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
Subject: [PATCH 6.8 371/715] dmaengine: tegra210-adma: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 18:29:10 -0400
Message-ID: <20240324223455.1342824-372-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index e928f2ca0f1e9..002a5ec806207 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -643,16 +643,16 @@ config TEGRA20_APB_DMA
 
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


