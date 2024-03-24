Return-Path: <linux-kernel+bounces-116172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525AB889AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8183BB2F6F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79073B6925;
	Mon, 25 Mar 2024 03:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFJkM7Dp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C717BB07;
	Sun, 24 Mar 2024 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323748; cv=none; b=toKbaOlGA3C63CCwY7qnx+7HQ/ImDdKI4S/VK/SsO2LtquRvq8JHkXP8zphWxthpUKZ/adGUdexuNjMxAjycvMKR8IbKjOYJwmuqGSWe9ExIx0CIsxJygktdWPBwhHh3l6F6xxyC581oo6SsxPB08bnxL1RM5243CwpjbYvIVCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323748; c=relaxed/simple;
	bh=Vg4vQmwbAvuhv6YI8WBV1X4v7KltOUdKsp8PbCBCV1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9qnH+jz3bvrU4b7ilH4u/DidgXv/8UdJ97H8xbpUV3O6NXNGIVG6BL7gCcwBbE3eblODVQ1kh+JMPs8vg6d3siicY9eHiDpgPcP0sRZp2pvV1+gn0uo87zgwCus0LtmZS95v0H+PWlmCXo7IC2GVAl4FspGl2fdNQkJRvDw6lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFJkM7Dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0269C433F1;
	Sun, 24 Mar 2024 23:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323748;
	bh=Vg4vQmwbAvuhv6YI8WBV1X4v7KltOUdKsp8PbCBCV1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFJkM7Dpt6pYSVRP9Z+sfmfu50EO03Kx/Bj7Sl+OhQil26uLNWV83D+eurBWOUAqZ
	 OYuR44LV50tp8LT/85nKQggL2fj/kiK5Sr41onJOHhjKqfD5Jla1SD5QBwK2X3dqmS
	 nr5aD6fmoB7UlQrUz5yJAyVinBwDhG7isH/oFMP8mBSzzfaBSNchh7tvB/WBWYtAoo
	 ch8Yq8uz4NBo+/7yZpd/6hBCqLSB3VW1FpPN43mO0WHGD1Y66dWitZMZ8zoeYkAJoy
	 Ljmf8uu1ChygiX7j9xrw4A8NXpnnCPkWFMPSOeOQl4JIRbgCv6UfNEio9Z0J9NSctY
	 CcMOt5AL6N3gQ==
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
Subject: [PATCH 5.10 123/238] dmaengine: tegra210-adma: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 19:38:31 -0400
Message-ID: <20240324234027.1354210-124-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 7e1bd79fbee8f..02b98f979479a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -614,16 +614,16 @@ config TEGRA20_APB_DMA
 
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


