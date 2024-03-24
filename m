Return-Path: <linux-kernel+bounces-116061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A33889540
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5C91C2F792
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAC927DDF9;
	Mon, 25 Mar 2024 03:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE5YiP8v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F855A4D3;
	Sun, 24 Mar 2024 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323469; cv=none; b=lL1kwwwFYcYSDlZHaSe8O4R5cviP2OLCFUPHF6ul4ykTo/IKhO/6UbBKmFIRWEbH+sB50xjti4znoxNKGeoggars1JXbKEEQzQt/QMegDYB/AgkFiayQRJkrbSFVm6ABsqE+dikT1c9mFYzp6YEV6YcrTYMOUXu6hqriVsmjPDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323469; c=relaxed/simple;
	bh=goEe/dMrrTfl1yemeoIUdBMMh4E8OH1Z3vR5aSMaV9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3oXYQh3Z0aizuEnCEqc95LKsRCw0APK+TeqMA1mkBzBXu1jjf5HV0ICIN6nfFsi+nmVhbqgLs2TxfadN/rWUw8wCdXixuES1ncKWqLUoc9PFrNIZ2k8/MvMrZ4CMLPYjdO6SEfg38KZ1Fyp9e0nJo9Aq8UpI8/tM37Cql0ZUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE5YiP8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64B4C433C7;
	Sun, 24 Mar 2024 23:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323468;
	bh=goEe/dMrrTfl1yemeoIUdBMMh4E8OH1Z3vR5aSMaV9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uE5YiP8vgP8iltto3kLnb3Wp2BzOskvX+Z4p08g1KliNINI0kYj3Gr1AejcpdT+FB
	 FA5INLUv38Y9HmUXE8lr+kImfPh/crWs4lowyltDpx3GGYqpHNuJFY8MC+xdaWDkQX
	 B+iOfSUTE+662mgF3Nq3lwPX90N8uL5QuBYNN3GZCTbCbMz1ErQtENzU8UBGNfa+Jd
	 c/UFB0jpwjUMogYvJsJJKEp8Znb8JpYvvkMCSmWdeui7G6VASZogx1eNUVDP0pijQI
	 QIcqn1ku6TggCzCgTYN7/o/WduAttF5fEeFS/9nH375KwBu0qENUoQ+DvIYPdOHx+z
	 uGbCX8p5fkvIw==
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
Subject: [PATCH 5.15 173/317] dmaengine: tegra210-adma: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 19:32:33 -0400
Message-ID: <20240324233458.1352854-174-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index e1beddcc8c84a..143fb0f8c07fa 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -645,16 +645,16 @@ config TEGRA20_APB_DMA
 
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


