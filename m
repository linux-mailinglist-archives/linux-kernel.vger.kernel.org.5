Return-Path: <linux-kernel+bounces-114101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DF6888867
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DF81C24F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E865415FA70;
	Sun, 24 Mar 2024 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElrWJWrr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E9F201263;
	Sun, 24 Mar 2024 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321403; cv=none; b=igYOVNAcb9w9hjMz6QwAQ8YTk67p2QECZmIDu4NuDcWBWZl9qhTfg+Av7nnH3f/YLy4/a7UmwBJWtR+yyX9Yq1pwlHnhgKy0sGSA8mvCg/sMGLGScFWCnzTBQhxFst29K5KeZe7D0larcRa1USQZXyiWnpbSLcvfmSldMvoN0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321403; c=relaxed/simple;
	bh=6/JF0p4TGpuVIu9EuMBPKr0jbFJ9JTrCi2bvP6CETf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHo6VoZJu0rek9YAxhH8fjrcKtcf6G3olctLh7rYgU3U6gqLyU1sFtVXbAt8+9OiHttKCCUk9Jv+3wN7pzRq4Ez9xXGYcIzbWiXmsyAnmQMsAL8UytkzSaNFiKEriwDY5+DLygGW+rv9ya9GIIx322Ubc1/MTnU4AVucQqeg+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElrWJWrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF09C43394;
	Sun, 24 Mar 2024 23:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321403;
	bh=6/JF0p4TGpuVIu9EuMBPKr0jbFJ9JTrCi2bvP6CETf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElrWJWrrYe4WDII77INpNlbwnIGsmEnhbv+cf48JOLJaEbMFZnKF8dkLr2o1H6NcN
	 Jxf5W+V9UB/jvYJ46QFdD5urMmR5wcqIqdyob5ek9pjfoTNdgueOeuVcSdLgJfD7/z
	 KZomv100use54IWT3lHbs/PCx52ekn5KUxhV2u8nYR0AGydHoTuhlWrOy2cG8FuCL2
	 K+HHoIe0Q7RJ3CSf5OxPhlmLc3NsSJF9D1bW0+k24aNFAFzAq3KdnKEfNih6MX5tjR
	 LqoQ1Ddd6bjFH0ruL4z0qDZWu3OwTdzysX3M6ZvrWiG4M7ZKrS1scR+R1aoJMYdxJY
	 o0lZ4j4Z51DZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 127/638] arm64: dts: qcom: sc8180x: Add missing CPU off state
Date: Sun, 24 Mar 2024 18:52:44 -0400
Message-ID: <20240324230116.1348576-128-sashal@kernel.org>
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
index c8001ccc2b7b1..e15f4facc0021 100644
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


