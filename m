Return-Path: <linux-kernel+bounces-113815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D5A8886C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F4E2912FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9AC1FDB34;
	Sun, 24 Mar 2024 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcsnJmfG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3271E621F;
	Sun, 24 Mar 2024 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320842; cv=none; b=Mv+8lCip0cmztXOSpsUZe+CJG38glQ2QWnhE0s3jk6rtDh7jdmCwuXqIYA7Ru3epbWVcXDwLXQzVl9JzQPT9ixoS+2z/EN6gLKIZETlCTAICUObVjn4rtL6oOpujiyYzz71tSSXKGFQOFRpYHhi7oTXy8QRg0X3pIFNNossdITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320842; c=relaxed/simple;
	bh=Dk19BKliAWL8ndMZblXchMzHzw54IPJ5e8qxIK3ZQI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFb0Oz4GLvQLzoClGqp/nR5dp0WGtJQqibxXQIkQRv5js85o7RFZu+Qw+jqdbqb8nJaKoMZf4GvZqHXabV+wmZZk4LOi3cn8ZBzIe6LjpV0jLsjis8hfBdalT/Ev5AH43vrfX4gycyZ+zZ6QMu8OoKzXv/3cpTWuQgK0WNHNvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcsnJmfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E18C433F1;
	Sun, 24 Mar 2024 22:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320842;
	bh=Dk19BKliAWL8ndMZblXchMzHzw54IPJ5e8qxIK3ZQI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LcsnJmfGhe3SEhe2UEa2o9VDhoEZ1A2O7INw6Jnz4jch2OwPprw+ztZKauWj54gZR
	 /oEmvVRXMf+k1hJmEzaLgnjngwxNG0PzgwKD65gm8EtUv0q2t8TyYQB1NK+oCg+loS
	 bwB08zLmjVkKpCKIvmFygUBkOk5kYP4JuuFfu1SpPxWlJdVgCv87+26wjaHYTaBIha
	 M2OWILKfRLVJCI9U2JSXHdGNRodd+Ei39THxZtb7eh+tii5Q3k6czq1JNfxyqTc5E6
	 bASJ1UvinzNH6uTe98dqAWSH1wEPWWcRla5y3a4pEG/+xE62BjupX9FjjjP5P1G0fJ
	 AQTt5KERSno9Q==
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
Subject: [PATCH 6.7 407/713] dmaengine: tegra210-adma: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 18:42:13 -0400
Message-ID: <20240324224720.1345309-408-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 70ba506dabab5..de6eb370d485d 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -629,16 +629,16 @@ config TEGRA20_APB_DMA
 
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


