Return-Path: <linux-kernel+bounces-113714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2DE888E54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFAB1F3041D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DA31E772F;
	Sun, 24 Mar 2024 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqJup6m5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B11DBF23;
	Sun, 24 Mar 2024 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320699; cv=none; b=gyT0QsSMFxixL/+kwx0k6KlOVZfbeAb1svhRWDozXCOb+lbASQ4Gw7v7Ko1GuNtp/CAtbdwvyA+U1wJWHkM7bbwCI7kVK6n1Rk3eX4QIwHV25SSJQ2wUld+U7h2Y0YNqhpwBwjoGnqjC9W18Yuhts++FdhtN1j8Ep3bu2rZrhto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320699; c=relaxed/simple;
	bh=4FNTlPBsr7Z7V1+dAD2XdYCPyICn4BPhFJMGPZUBfg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enI5jkRLK/OqjP/aPWc6MfuXli9/7Or3CiFFI+uddVKoSIVVxFIS4tmsEw2ea1vSxyjofWddqKfZtzg5pFECqBAtmQQ4zxOdGcVj03pFfhD6tQFcY4SHOkU5Nm1mIYapBwvxUb3H0rG79zNuxhUl3N5VqSohq8MGWE4PGEYWzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqJup6m5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1642DC433C7;
	Sun, 24 Mar 2024 22:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320698;
	bh=4FNTlPBsr7Z7V1+dAD2XdYCPyICn4BPhFJMGPZUBfg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqJup6m58Ixi5CfHBPcumCk7KGD36qnUeIHlHEj/2vT0fxvDZH10s1kYh8M7Cri55
	 /HegPtTOXLp023k0KmI02K+niMkB4BK4tJDZG2zkr+zdzkfEptEMmrq+aG3tjxtOHx
	 L81JHz4ZHZ19wYCRKuHQbmBIXTGQR3uNQ7+ZkIzpvimLVoQYdGvmOnlap1Sj7NwE38
	 yF87l5VJaUFatlx69MVWCvSsnGuEt4jLszj3fj5mLsXO3Mv4AQCH0v/V0vhBX7vRqe
	 QDXUOscxOdSzl1h7iq2Gcjo8G+aO2rh0S4DWb+J4jfu3uem9ErFCDJnL336X5MGCmC
	 9fMnK0QZ+fWuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 261/713] bus: tegra-aconnect: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 18:39:47 -0400
Message-ID: <20240324224720.1345309-262-sashal@kernel.org>
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


