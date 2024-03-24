Return-Path: <linux-kernel+bounces-114183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79A0888F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869C71F21EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDC724AE8F;
	Sun, 24 Mar 2024 23:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+6+Jyff"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0FC13342A;
	Sun, 24 Mar 2024 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321504; cv=none; b=FoC+ruqiKfgtH5P8L5OKuibqhOtaZYbEeDgIlKgKx4hNLX4h7EJhG4LYttYl/JvdPZDO9EOpNdp6qco6rKE4+YmXHR7G1HkXli1utvDhpSs6tLvDfdm62E0hhPRa6hAgGEmHF8WNO4eIDQ22lUyIdjf1Bl4stMawtvfkcEfVwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321504; c=relaxed/simple;
	bh=+Hxhegior8++nnyBQf5i5t5oXEIt5a5o7CvmOj5jmnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxxOf/w4jJFGoN3YS04iH/+9MDqk9oJpeAhp/H12IvX4K53ij4CzDxGCFHi4FFEPd+m6qOh5KTcrRgg9pUhzLQPR0vd9fJIkh1in2fQVyDjhg74YMRt0mfXhifYj8MRMth4Jl+hgCR1r3Q9puLN1ZUYg+zx6HonqeH1i4ZWbDhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+6+Jyff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207FBC433C7;
	Sun, 24 Mar 2024 23:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321502;
	bh=+Hxhegior8++nnyBQf5i5t5oXEIt5a5o7CvmOj5jmnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+6+JyffQRA/BTuE2GCHaOHCtLKpyv5VER9sTV5+J+S0GfQBlxHb/j7CnFBKrMjOt
	 2OMQpAt5PwQp8T/2lSb+EbnaeWXes81xjrLiWREs7f1a+M4NRtmItqQ5kaoNVISimj
	 wl4CWt6T8Wpv3qIIvTloehuQfAlcRNKUa7GC4xMvvGEUBZ9+yPNR2JG/SeoN0twpPh
	 pkWrIvc5IJWLf+1yh8P/FKc5kAfVaHG2fxOGzzpg0hrwHKU775oz4ynbUA7mS38TS9
	 5KFkaVU2vzpWljuAEZEVi3iHMXsOyekb36WJQUVZPPgNLkgPwTadopzmfrt2AdbnJM
	 GvlJIK1SJzxRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 228/638] bus: tegra-aconnect: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 18:54:25 -0400
Message-ID: <20240324230116.1348576-229-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index c98dd6ca26297..fab27506d945e 100644
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


