Return-Path: <linux-kernel+bounces-99054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F98F8782E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF072281120
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9136482C2;
	Mon, 11 Mar 2024 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLhRVD1E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18D347F7D;
	Mon, 11 Mar 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169956; cv=none; b=DzT2C76a2778ZZAZWZTd+8pLfeVaH48AELy6zP5vF9Nob8M+Gq5KV16oK4ofGhUwvn0p65mdcyTxPzNiV7DPQPF8XJvmFP/JsMRPmdrDMkVCVtrzqA/XsCVrw8/b93VRf9orRGRtF2c3tMbQGkKWdeg/6XF5GeJE0MjzopzXtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169956; c=relaxed/simple;
	bh=kifoJ9eFImu0n8wwJjHxP546xn+Rp7wiVvjJnpRAhdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0Xa+oRDpfZmECR7SC58s317yUGBDtrLqs0RMWmuNVQP5+DDuYwHXtzRRG3wLAaQ2Re0T4JGqekqAMcv4rbNuJZS1pIjr7cIBS4Zwp1K/zGTyPWULnoQnhD7TFECeWWF1ARJw0ANtHcGQo8B4sZBGzbqtwLh+xTYWLPHHFKlYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLhRVD1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94341C433F1;
	Mon, 11 Mar 2024 15:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169955;
	bh=kifoJ9eFImu0n8wwJjHxP546xn+Rp7wiVvjJnpRAhdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pLhRVD1EpePwYVWhXjgL5RIPN22f0zvZ/Ah1e3+wfbpB3iFrXjB4LHyZDVQFhL0Es
	 HlhTzpu2SOTfSRJFdfL8gc6Hc+iw2KhpJSx122DSwZ9Zqn/Yk1IDNda1we/ePpF0Di
	 Y6X4Q8JvUzosfPEgM1uJmSsDuVbDou8VdQIGHyK9yaNoknBFjaByQ3U0m/IMf9kteL
	 vcM0IaqPiddRwDA2RM6MkuMo7stQLnJdWweW21AHP5Bqr0FotX01/8eQjeoG1VLsM9
	 AnpAGFGNzMr4nLmIQZgi8Sikz1du4eudXX1zQmOpHkv9OF9hj7Xs6N4lCHPMhQgUt1
	 ysVlJygBIOItA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Dhruva Gole <d-gole@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 07/23] spi: cadence-qspi: put runtime in runtime PM hooks names
Date: Mon, 11 Mar 2024 11:11:47 -0400
Message-ID: <20240311151217.317068-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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


