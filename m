Return-Path: <linux-kernel+bounces-113097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67934889399
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22961296410
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E0E154C01;
	Sun, 24 Mar 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsiD3Uub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A4154BE3;
	Sun, 24 Mar 2024 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319905; cv=none; b=TU6QeqcpbrkTlkQki4OYtlBO/VMDJ+vsBw/IC/LSED0fU/PI2fQnUCa0GXqmo5IzRrD3IIZVstjtqLVz6PhvJzXb1ao99sy345VlGEFEWxTLy8zv/tI9j9ePz2wH17PNRC14NNxRiRFVEyk9sZZlC5TT+WEIi5YYBdRYkaO2R9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319905; c=relaxed/simple;
	bh=4FNTlPBsr7Z7V1+dAD2XdYCPyICn4BPhFJMGPZUBfg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOO7fsR7O2fJtHJ8++asycb/LUPh/9lnE4po0Y5vCixvouGvrhCG4XYQfsjw4VGPlV6rsiPlGGr9yBeWeyKIJcPrO33dJXvCc9AAuNyra5IuekWlNHtOP8eHHeyGhPaI5VrwgCNab8GAwcWbMQDP/gSOUVBIVKqykWKOmvXOXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsiD3Uub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519FDC433C7;
	Sun, 24 Mar 2024 22:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319905;
	bh=4FNTlPBsr7Z7V1+dAD2XdYCPyICn4BPhFJMGPZUBfg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BsiD3UubSiSZZsGRfnrhTFjVk8WEzCohkSVrC3rwlzlJywbTnJuyb1qNZrNfn9KxT
	 6rUAswPObOhHwOQuJFEWQOOGpOG5dMRtIgXp0Levj0+RIy1i/P13hkR0dLN+Jk7+ec
	 keULtvVPko89/PGhJgHIJN2QTZ7yVjYPe26MJoKZBaOGD4qRjCfNx/RoQ4wgbI7W5p
	 2q6NT6BeHL1Rz0gfPxrDll/6620aJjgTQiuR9zl2hYGqQ2hTWglLx/e7uNa4U1atuz
	 qrUW8pHNqfcXgZgbw2ySoyZdtAZ20DM6nai/VqdGAmAZ0Xsrl7A7h1dePuaCynvPdS
	 f88JYtQKHxw9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 210/715] bus: tegra-aconnect: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 18:26:29 -0400
Message-ID: <20240324223455.1342824-211-sashal@kernel.org>
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

[ Upstream commit 4acd21a45c1446277e2abaece97d7fa7c2e692a9 ]

Update the architecture dependency to be the generic Tegra
because the driver works on the four latest Tegra generations
not just Tegra210, if you build a kernel with a specific
ARCH_TEGRA_xxx_SOC option that excludes Tegra210 you don't get
this driver.

Fixes: 46a88534afb59 ("bus: Add support for Tegra ACONNECT")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index e6742998f372c..d5e7fa9173a16 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -186,11 +186,12 @@ config SUNXI_RSB
 
 config TEGRA_ACONNECT
 	tristate "Tegra ACONNECT Bus Driver"
-	depends on ARCH_TEGRA_210_SOC
+	depends on ARCH_TEGRA
 	depends on OF && PM
 	help
 	  Driver for the Tegra ACONNECT bus which is used to interface with
-	  the devices inside the Audio Processing Engine (APE) for Tegra210.
+	  the devices inside the Audio Processing Engine (APE) for
+	  Tegra210 and later.
 
 config TEGRA_GMI
 	tristate "Tegra Generic Memory Interface bus driver"
-- 
2.43.0


