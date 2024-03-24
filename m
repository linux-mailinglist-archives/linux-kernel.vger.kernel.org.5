Return-Path: <linux-kernel+bounces-116146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1F688999D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653C91F31627
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24F43B0A3B;
	Mon, 25 Mar 2024 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXRODp/t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3517A916;
	Sun, 24 Mar 2024 23:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323695; cv=none; b=uj8G8fDz55IciFJUUeA6GzMfqpy73onItsnyoMaVYi53RIA/LlW1/b5pIUSCKDLiA0yTvDf1Ul/f+QrJ3QUAe3pcHgx0yRgcJ3/8mPJTuCrlMKwrnJjKJcgwo/Z8Wxqzg4h7L/yyIokgZAaLDQRmYDj6Ry8Fq8EsTPlkCHK5aic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323695; c=relaxed/simple;
	bh=pWG+b7pauP9/zuCIkVzsof4xZ6Nu4d2N8Fb2XZ+QAJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+2H18SOoBVAo1rrl0mmRBX/I33cn7drlmBcV2RYpsQbn3ozZF53P4uRCjbitdpbX+mSQWSkvwPlUhE5ttHGPtOPfNk0gRq34tsuBy04YOfjz3Dblvk1Nfnb8MssIRKiC9ff9Hy201jpVTEQWKxbnqsTYcN4E6TzsKaI7+DAr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXRODp/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CA0C43394;
	Sun, 24 Mar 2024 23:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323695;
	bh=pWG+b7pauP9/zuCIkVzsof4xZ6Nu4d2N8Fb2XZ+QAJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXRODp/tYOHGvlQG5qbGsTDY0cMFxGoa4g06RQv0Aldi1G6ofC/EJ1XB4aEvYqb3A
	 NetqXe5qRKODxBgNWpldGvLpOVAYWhuKxtwhDtyoFF5UbRPuRrR31Vht3+ww0fej5e
	 V20+tr1cwpLJlLE9XEolEW6tYNvychFsbVZ+5jdouqGBAWUNyo3OjgIsPwO6Y5uWWO
	 ZSxztjojtGI+o4tiDIKpGQxslqMTKiNT5Z3Itz5JdNB0IUALMMYabh2EfBV+y9mBL3
	 fPD98aRD5zWhMlDmTAHsssRtsy9bO8UatuFnhcDgzWcGZhqNQx7IOM30gH0obg4vZQ
	 P6n6ZUPADdE+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 068/238] bus: tegra-aconnect: Update dependency to ARCH_TEGRA
Date: Sun, 24 Mar 2024 19:37:36 -0400
Message-ID: <20240324234027.1354210-69-sashal@kernel.org>
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
index 0c262c2aeaf2f..01f2349dbfaed 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -176,11 +176,12 @@ config SUNXI_RSB
 
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


