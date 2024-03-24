Return-Path: <linux-kernel+bounces-114801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CAA889157
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF911F2CFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B715525B232;
	Mon, 25 Mar 2024 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljebkf8q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB4175CAC;
	Sun, 24 Mar 2024 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323405; cv=none; b=pF6KfwQG4l/1aJcYOX25bNXpMn/2gGpozuACsrKgBHgCtj8QflI1WuWh6FZ7qqdz4Sb+SzryVp8XClYpLhXbudbCH42bIbMvRMYx8agZ3kEgoI6z6M0mxZzkc8tMpHropRq4sTlR2qc2rluOQQtkfZr1lr99LpL2WmdnBOazhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323405; c=relaxed/simple;
	bh=qiGAF4i2UqxoN3ZSAp9HOjnO/1BpK6+ooU9v+UKEwgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZlqO/FFkbgYzcBBM8lgWLiCXWWEVVZ2nFbxxiwhkVzpRgCXxGk4GS3DT6bcDNnQJ7tKdMr50/6iIzQX0PwxCmG8P5ueaxoJHzYWJxocu1DQTb8BCjw1Z7F+iqhYKyqrFcWyQE81zuxhg4ElCCZ/JXpBue/63GaSilAjrx77Vlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljebkf8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906F7C43394;
	Sun, 24 Mar 2024 23:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323404;
	bh=qiGAF4i2UqxoN3ZSAp9HOjnO/1BpK6+ooU9v+UKEwgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljebkf8q5Ftw7h183yW6G7E64ripT3hkH4XDLsQMFtKHCASvqNSEBGTkdEgRYNRGb
	 EORI26MJbkitFHlZJS61CapA3YcQBC4eX2BPhKFKqSWeisj9zVYVItlYaOKie1zQCm
	 T62pLlYjurUwiYh+sGUscHF4pooWH1OpnXMxLOH4x70Rkaqb74BnwISEikFG//bkZf
	 xbIQJkMOg4w99LjW41BO1J3kJAAW7tW10sgz+5PPOzAycHAEJCeLEoDwP3XoIWCqz1
	 +JWJGO6xyCDfuD7NTc8jNa0HfWf7hbfkWU6+zaLkKY57+9AmcpC3IJAclwmVWAQrdd
	 662MxP3h5/UJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 105/317] bus: tegra-aconnect: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 19:31:25 -0400
Message-ID: <20240324233458.1352854-106-sashal@kernel.org>
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
index a4cf3d692dc30..d224f5f7a7405 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -175,11 +175,12 @@ config SUNXI_RSB
 
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


