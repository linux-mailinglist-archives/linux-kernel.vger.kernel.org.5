Return-Path: <linux-kernel+bounces-115307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60536889A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBCB1F33294
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC791D5675;
	Mon, 25 Mar 2024 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn/sk8hu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391637FBD1;
	Sun, 24 Mar 2024 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320495; cv=none; b=tR6oaxXAHje3ysYQKcM2OPp/3E5A84gMj4sB+S8M3IT3/r25IjrvEth1r8B7Ueh6QvGDxkp2OuoBedYgHXTSv4+G/MkqW/pwoy3dMFOWmNktoEOEuNXL0FvAVEHsKUAbeUT5BQ7QhnWaY58SlMIHYdTWyeyu1SvQcjNqT1LLL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320495; c=relaxed/simple;
	bh=kifoJ9eFImu0n8wwJjHxP546xn+Rp7wiVvjJnpRAhdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQKrMVgZcpBXVwVGFlZOw9NXNJyEJTbvHGem8S2LAvZDyznSjBTp5qE7Afwlbiy9Ewk8eiaaj7IpIUkhUZddOUTSzSdSiZaZUxBqv0ilPwthhUJk7c/oIXUO52Lc8946ONTdgq6ygKFJDnytmQEIumlZs4/c0xD7a232hmT05vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn/sk8hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F31DC433F1;
	Sun, 24 Mar 2024 22:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320495;
	bh=kifoJ9eFImu0n8wwJjHxP546xn+Rp7wiVvjJnpRAhdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vn/sk8hukyRbOydgItX4PyBsoEJtvuUsriDJFTTw88Umil0TvFqsg4MtSwuGQwd4z
	 9RrQ9eBY/pvrrNwGFP/khZUFFP9bCmZX7eD8wM9ERYgZJAWj8WEfqDPkwv1jOAyKnd
	 SvS6sRGw0WuBJOVNxB5dSux5c0Hu1zcuz8G62YOJt6gJKr91kby2WNVSW6OFNGGpZy
	 3fbzbKRgb0wSSspo2J1hL49w9PjGBXiEGHiQfkU+Z1DdBCPbykFqVI8G1lYYv8ZMFT
	 7NGCEMDAet3Im3PYZA36kqIDRwxUcbSfBVMaH9iER3952sx/jGKUXgfTfQzwxoRcL2
	 VHikqPwK7QJDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Dhruva Gole <d-gole@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 054/713] spi: cadence-qspi: put runtime in runtime PM hooks names
Date: Sun, 24 Mar 2024 18:36:20 -0400
Message-ID: <20240324224720.1345309-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit 4efa1250b59ebf47ce64a7b6b7c3e2e0a2a9d35a ]

Follow kernel naming convention with regards to power-management
callback function names.

The convention in the kernel is:
 - prefix_suspend means the system-wide suspend callback;
 - prefix_runtime_suspend means the runtime PM suspend callback.
The same applies to resume callbacks.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Link: https://msgid.link/r/20240222-cdns-qspi-pm-fix-v4-3-6b6af8bcbf59@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 731775d34d393..4b2d42e54f568 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1927,7 +1927,7 @@ static void cqspi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-static int cqspi_suspend(struct device *dev)
+static int cqspi_runtime_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
 
@@ -1936,7 +1936,7 @@ static int cqspi_suspend(struct device *dev)
 	return 0;
 }
 
-static int cqspi_resume(struct device *dev)
+static int cqspi_runtime_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
 
@@ -1949,8 +1949,8 @@ static int cqspi_resume(struct device *dev)
 	return 0;
 }
 
-static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend,
-				 cqspi_resume, NULL);
+static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_runtime_suspend,
+				 cqspi_runtime_resume, NULL);
 
 static const struct cqspi_driver_platdata cdns_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
-- 
2.43.0


