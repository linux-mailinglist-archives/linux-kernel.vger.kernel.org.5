Return-Path: <linux-kernel+bounces-113090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE959888162
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D771C21813
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCE31534EC;
	Sun, 24 Mar 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKgvWbIJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60577152E14;
	Sun, 24 Mar 2024 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319898; cv=none; b=KF70yuTTP2hCI6RMLYnuT3DZAMV2FWX2vXgFMSCtVyH6959O/n3g/guz4sPDAK7umdsZIHTI/Ei/Jl/ccUxfi0e4pz4wZRlQpMxNUcCyGP07thrzA14oyxJSwX5aF74OwD+59KZf8LaoAGkKYs0eA4jXMT/zv2SxrCrtBIwsdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319898; c=relaxed/simple;
	bh=qkyyFxehdzwxsIPB2u6hGwdn4DIIGZjJoaAfpK7eZzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4/HQ+JG3uZ2UD/O2Q50gXkvBk2h3anSjebb46m2gugls1V215WUCwzpo6ZSw+Q5pe23QIdKWM3ZAKKPVTMtgALuYcVrz6M1dS4t8TbGEyWJ+tfD1Ma3ameOLvV7IyTMxrrY2LmOSGTVKLHh993mJm/DiUx8KLBDcbKIagI25ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKgvWbIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94856C43399;
	Sun, 24 Mar 2024 22:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319898;
	bh=qkyyFxehdzwxsIPB2u6hGwdn4DIIGZjJoaAfpK7eZzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKgvWbIJFpLxfklYqX5XfJi1WtQzt6EAAdzTXCYofEn5rJLnKp+F5x7BB4+rsnkbZ
	 cbEVq2WXwtGkW4Pe37Oq7LNf1j4wwMUX3a8+HobhWTGd9u1ge99SrKb6OlyCBNPnVi
	 dnE/d7wNwYhgfY0fTeYz/gS04DrrsPH9w9eAqsjTdokadL6+ODpnlABqz5PTYa0Rus
	 MSSrvVho0GgOL1q4QYyItkze3Hkjs4mjhpNrOvssalW7kZQue4MKNZyhApFf7pGQAA
	 tA7+zTXiNOY8qFbbAKmOM2k171UklgFyDhhj6OckS4H0V/5hu/fcHfqgFf4hRE7tcs
	 4EOdxtUMrxv4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 203/715] cpufreq: qcom-hw: add CONFIG_COMMON_CLK dependency
Date: Sun, 24 Mar 2024 18:26:22 -0400
Message-ID: <20240324223455.1342824-204-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


