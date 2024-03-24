Return-Path: <linux-kernel+bounces-115075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C438892FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EB51C28E71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95112F528A;
	Mon, 25 Mar 2024 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6+o224s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D2180A81;
	Sun, 24 Mar 2024 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324054; cv=none; b=qI0oNJaPc6BNb/QO9bmIZVg049F+Ki1cl2KO2TrX4YdLXZuibEwMW29wmvMaffsg2CIZSgVzhIRe7PUAsn7Nh3fr1Rl/LL9GbBBLjWJxLVYKwHL5LGktB7RI3jvDJr5awaPmMsd21P5672zIf8MZ68dVmJNf33F94VJuWdd384c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324054; c=relaxed/simple;
	bh=6aeM9EccW5V1l59G/zhCMMLoAu+pGwX9rkHHx76rL18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oG77ghHGL07aSHBxEOH4ttomhlD2UW6/eK3t6GYMpSDnPU64RF+kOMWcalzMU3EUnG8Tb/5XfUK7PvN9rSPpUbJAmjqxxaKtD9sBOG9OpVK1/zlUCn6Mto/fucnF+hCWxSNlzAArfkPm3coi2JNrzSu2hHrbCaLGrhGd75SyufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6+o224s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D327DC43390;
	Sun, 24 Mar 2024 23:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324053;
	bh=6aeM9EccW5V1l59G/zhCMMLoAu+pGwX9rkHHx76rL18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6+o224sZSuV/ImooYpWTFN34tKF4GDKkV9AYv3dXNq/PQPpgY1Y+s5JHzCBaZSAb
	 f60tdToaxkaXjCvKgTaGsEt1bXrHS+BIl36wOny20Wo901KqgHjH7cVi00OueZNsoD
	 8Q0HVuCkH/M7RjI2ryJHHk0o9fkG8w/HeXlleexmsGHSoWSbYJZI6B2ttTa4UGGQq+
	 TC+9luKUZ/qplsSEDt0JMT3c03VA8VE25pk91uN7N5Zi3cSsmhllPxOZWEFGAKR6Ay
	 OgV/w+fO2Iz7xOmrPNlFbwEl+M/xbcUJUCXaXSNdyf7kLJYHEvE6lh5dB32S+osuUB
	 scJZz621QGw9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 054/183] bus: tegra-aconnect: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 19:44:27 -0400
Message-ID: <20240324234638.1355609-55-sashal@kernel.org>
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
index 47c2bb444ab4a..072dc40e29a69 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -136,11 +136,12 @@ config SUNXI_RSB
 
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


