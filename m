Return-Path: <linux-kernel+bounces-114177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F18888E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8231C27823
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24621249F4C;
	Sun, 24 Mar 2024 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqAEEx7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C002062FE;
	Sun, 24 Mar 2024 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321500; cv=none; b=nIkgcd7+FsUhrEyt4XbxdB7nGFyxtOhac7fbi4wynTHNlZ4OoJjovxAuZ2/O1ax7noShgXJlvBnZPoV29cfaYvdoTuiCqg0oTXz7fKas8A8C2K8Szoe2L7Hvgh+Sz7H5lcyX2soLAjBovGsJspyZvgDVGQlOTSzbsgE83plEK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321500; c=relaxed/simple;
	bh=eOFSIzfqtIpRZNnVVtzJpHLcTC4yIAg2d1c5jY0FyDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1YJsLGnzb7yLorWB+k+CEp+q6e7JnuVUwWJWYzvH+rkR7UE5OeAeYIvRz6XTuxLbXbbFgeLwiYp/DgLVnnLlFmnyG1nDFYYMtsWPPEjwv2woFVbPOff4e4cDpUAqhjm4W+zTZ+YDNG8RtjHHLmMXLb6iTKHtHnTS2MVbr+5Enk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqAEEx7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52843C43394;
	Sun, 24 Mar 2024 23:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321498;
	bh=eOFSIzfqtIpRZNnVVtzJpHLcTC4yIAg2d1c5jY0FyDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqAEEx7NXinHMU0NOVStOBxjPJrblBG3b8CbtxhBrt/5r+/O55+LLWAIT/UrRB6Ej
	 +tsNwSEz6HVpYDc6sStha5QbKKL1Yf/fBDUjWh+EC6K56CrvH3VAfDcucxoCCLDqyJ
	 h0JPWcU9kHLZfLxMES5wtxNI8iTqXbqodmjZo9M7pQSrg12GcyTb5o+zhBookvdUm0
	 56MOrzsWEvxfPGnvIXen14snyLggzZCBaH+yTWs+49keZAPrnWllxyIhS3a0KX/Xiy
	 fZCw0dTlPPL+aHgMFDNDYuVmPnae+bW9VL+FhwsSTJMOPU8uVY1ja3zOhvKKsPwuhf
	 wIZ2Ho32J/bEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 224/638] cpufreq: qcom-hw: add CONFIG_COMMON_CLK dependency
Date: Sun, 24 Mar 2024 18:54:21 -0400
Message-ID: <20240324230116.1348576-225-sashal@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 3093fa33539b54db77171d2919352ad4f044a1c5 ]

It is still possible to compile-test a kernel without CONFIG_COMMON_CLK
for some ancient ARM boards or other architectures, but this causes a
link failure in the qcom-cpufreq-hw driver:

ERROR: modpost: "devm_clk_hw_register" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
ERROR: modpost: "devm_of_clk_add_hw_provider" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
ERROR: modpost: "of_clk_hw_onecell_get" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!

Add a Kconfig dependency here to make sure this always work. Apparently
this bug has been in the kernel for a while without me running into it
on randconfig builds as COMMON_CLK is almost always enabled.

I have cross-checked by building an allmodconfig kernel with COMMON_CLK
disabled, which showed no other driver having this problem.

Fixes: 4370232c727b ("cpufreq: qcom-hw: Add CPU clock provider support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 123b4bbfcfee1..c5cecbd89ba9c 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -173,6 +173,7 @@ config ARM_QCOM_CPUFREQ_NVMEM
 config ARM_QCOM_CPUFREQ_HW
 	tristate "QCOM CPUFreq HW driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on COMMON_CLK
 	help
 	  Support for the CPUFreq HW driver.
 	  Some QCOM chipsets have a HW engine to offload the steps
-- 
2.43.0


