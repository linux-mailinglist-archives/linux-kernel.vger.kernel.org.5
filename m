Return-Path: <linux-kernel+bounces-113710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5245B888623
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5AC41F24B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333E11292FB;
	Sun, 24 Mar 2024 22:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPqIlV6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32C21DB433;
	Sun, 24 Mar 2024 22:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320695; cv=none; b=QcQz2NXO1cjodRvZUABTA7D6fCLQIug39xbvCucjf7edCHacc/CF6PBx6D6xFXEbkfq5Xjyz4qGNYumpFWGhPzf+AEcds8cHtChQ+90CE3p+ZCzccWj9mydouUeYDZ7Xdz2m9LnCQhIlTU+dLFTO+C3VxpRtXuTmPAoUDroGmLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320695; c=relaxed/simple;
	bh=qkyyFxehdzwxsIPB2u6hGwdn4DIIGZjJoaAfpK7eZzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOI3dg072nNhJeEbanpChJq64E5bt7Vray8HNLanoqMdZD7ZfJ1tOy0nM7vHN5XQ8UU88ZjHkItU79I69i7DQ32GQTmFO5wfN0RUbDFsmMrzPqHfeKFrIxzoED8AG3d+CAsT4nt64kDCQTHhtXe3qNG6v/VsTfZkQJJ7JyxPKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPqIlV6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F376DC433C7;
	Sun, 24 Mar 2024 22:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320694;
	bh=qkyyFxehdzwxsIPB2u6hGwdn4DIIGZjJoaAfpK7eZzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jPqIlV6nghXaUugnqln/psEauIr6Q0NUoPfJsw7dVIv7/HM3YLDSseFWscUltV3Bp
	 uvlL0ujkLThFhs7iQ7sOnJQA7Oj8COhHt1VDfh0JNsY3DAo7T2G62tPILg+citkDET
	 o3DnRlsYXo0KEq4aaVuTt5LpjyZ/ekpKEGjGCeCsFDDznB/QiwP4Upeg3MXo7oDNLv
	 yIgHRqbioqLhzPiQcLeoEm6yHWcCwNJs/yEr/AvWfskwG1nLVZZL882xbxlZ58Vzv7
	 JB2qM6GecSjeZV4ggrbb3hSHEmGuLmcs7BKvaRNtOUTwYps2XwLVeMgM8F7r2LB6ko
	 5W8Pe3LOFf4MQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 257/713] cpufreq: qcom-hw: add CONFIG_COMMON_CLK dependency
Date: Sun, 24 Mar 2024 18:39:43 -0400
Message-ID: <20240324224720.1345309-258-sashal@kernel.org>
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
index f911606897b8d..a0ebad77666e3 100644
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


