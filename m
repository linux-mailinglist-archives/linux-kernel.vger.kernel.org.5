Return-Path: <linux-kernel+bounces-115357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4252889B14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209381C341EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F811ED0EC;
	Mon, 25 Mar 2024 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRcDi4It"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD9142E73;
	Sun, 24 Mar 2024 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320585; cv=none; b=rty3C+f8OuouL7qxWkHsucFoS9P9K31Ba8BClh9S6zeUa8ZGAVome765IwVea0pt/QJ7lDM0N94oEZKpMLYWQGDN/jgiCv/36r5d1k7Stq2Xjv+KpS9dt6m/CZUNcZ13hcDzbmE2HknFSFiIXaCupBvWot+3+HuRHUJ8nzO0g9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320585; c=relaxed/simple;
	bh=ZwXuFkqNZmx5JQ14seezatPnEP+6OXGKABZlAYssQow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRgEQILDuEM4WsUi9A2t+/b0v9cj68jaovvR8lWKx+OsFR5p+VmynaaVTh7Xb9T8Qf/bW2UcowHKuHH2cuA0bN4KlzRBoEDPnaWHzXdin9d5OFMD8hu5HRF2BWc1EuRuEsbT6CypnwdsgFn0UqLnAN9rnMRpKkUq2GnfSvw651g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRcDi4It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E318C43394;
	Sun, 24 Mar 2024 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320583;
	bh=ZwXuFkqNZmx5JQ14seezatPnEP+6OXGKABZlAYssQow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRcDi4ItdrJ5q2SCKNDFnfIt+PqhztHol0vSAmCM7I5NsESFP9hNeBmWbb7OeIve5
	 99p7q9cbHxPvn/JzDV0qJZ/OWnsY1GIfTZNiWY6sQR4wzbVZGn5KSy3V9hKENumpAA
	 +iOC/+IPH9bFwyA3yiYMFhCwh+/xXx4tR1Js0/59Us4oXRnjECEefRwzEjd5hNt5oc
	 An6t2xy8hqUF8aNn7bFGbiL5kld6KN6FbFZQB6lnzhncY5jl7WX0k3+N36C/Y4C3am
	 nMXnWPIP1ko8/nWFY1V5VpxeSoLQUN61Omm6cFRdHGu3EmdTlB2oEsr7rKLkWPk7WZ
	 YV7TJpK4uLYkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 145/713] arm64: dts: qcom: sc8180x: Add missing CPU off state
Date: Sun, 24 Mar 2024 18:37:51 -0400
Message-ID: <20240324224720.1345309-146-sashal@kernel.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 07b600dfdfea65d58dd80ea25becd8cff69bfafc ]

The CPUs can be powered off without pulling the plug from the rest of
the system. Describe the idle state responsible for this.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231230-topic-8180_more_fixes-v1-4-93b5c107ed43@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index f2eedbdc025c3..a7acaa8ca6055 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -297,7 +297,15 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 		};
 
 		domain-idle-states {
-			CLUSTER_SLEEP_0: cluster-sleep-0 {
+			CLUSTER_SLEEP_APSS_OFF: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41000044>;
+				entry-latency-us = <3300>;
+				exit-latency-us = <3300>;
+				min-residency-us = <6000>;
+			};
+
+			CLUSTER_SLEEP_AOSS_SLEEP: cluster-sleep-1 {
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x4100a344>;
 				entry-latency-us = <3263>;
@@ -581,7 +589,7 @@ CPU_PD7: power-domain-cpu7 {
 
 		CLUSTER_PD: power-domain-cpu-cluster0 {
 			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_SLEEP_0>;
+			domain-idle-states = <&CLUSTER_SLEEP_APSS_OFF &CLUSTER_SLEEP_AOSS_SLEEP>;
 		};
 	};
 
-- 
2.43.0


