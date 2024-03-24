Return-Path: <linux-kernel+bounces-115888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8175788987A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A751C31D08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199A1264D89;
	Mon, 25 Mar 2024 03:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiCaoj0s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA47146015;
	Sun, 24 Mar 2024 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322081; cv=none; b=FJW2dfrKBVBQ/Q1C6SndvnPWVP2Xq5vcKCTGeAgrgaRMSRCWlznCWw5SLO2HLWUPYDvON0BSDTxNp2ChRMHUR92mC2btMQJBJTnElJ1j3kNYAcsd0XwM6wfoSbc6w/glVh7nLr0yxaLxr5ITfiNfxhGmTJxYmOjnUx5T6cQo6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322081; c=relaxed/simple;
	bh=CI5aKXSZgFc/eeP7euBsbtDOIK02Hte68IcEDoH60/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvwBapy4Fh2Gqe40TkMhxaPWSWk6aovSm+FSTdG1E043q/7cF6oP52rEk5ZoaZ+tl4P3HNjePdSUI+jknUeiDA8St8e7E2Xn0jKlWA+Rak0tMN0GF78CW3oRFz/ahxXySsJqvxydCarMQB0yM2TO+TPOtoaQ2mEhkppkUImdsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiCaoj0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3427EC43394;
	Sun, 24 Mar 2024 23:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322080;
	bh=CI5aKXSZgFc/eeP7euBsbtDOIK02Hte68IcEDoH60/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiCaoj0sTF1JbGCHx8I7jEQXb5alS2TOa523biBwqF2UsFTG7Q+F8GHirUeS1MXLk
	 PFH9jUpmFX35jfSJ+y/8SZfrdhvuKJcE9+kdkOaUIGtAEsK83aX0ZHJFDoYOtM28wS
	 q6p12XARHAEZ/ydOJAlyLd7CC4uvPHpOglLULAT6iAfJ1XlGAXzKowCBbMzmYzsZ6W
	 oPz304Fx+ylIaYDMqs09N8+NGLykZIjfIkfhkowY7ZSWArGxRCdCcB6V4bzGMAEdwv
	 q7y/t+7MkwBwOj9p/qKwVCrTU1sM5I79wMKx5XMc0jRpyEFhm6HZRLsgeSqSeRi1DB
	 5Kd/i1rCHDUOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 154/451] bus: tegra-aconnect: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 19:07:10 -0400
Message-ID: <20240324231207.1351418-155-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 7bfe998f3514a..bdc7633905504 100644
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


