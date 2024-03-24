Return-Path: <linux-kernel+bounces-112960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B98888012
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7522814DB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248F41272DC;
	Sun, 24 Mar 2024 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxYnWzwM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611851272B8;
	Sun, 24 Mar 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319772; cv=none; b=q1o4NdTqzJomGwaFwIWFdeuCuzkoFrPoeYY4/lNGC4gA14xOQ9h06cXXxZjw0Xd0nOmykzI0Zvzw4XFEXVJ9owtrtQF9BTeK3LTG9gkctkp7zpnXZ03rBUhMWuys22rYjrWXDp0vY5CopqRODojpqvC/J+JzbBkw9OWMJWjwd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319772; c=relaxed/simple;
	bh=tV8tPyjDBqcivZy7fQnifxHJaUsNLTeXhPXtDBg9Lzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGFoIeowUGlW9DQ8BgLS+AoHjBZh00FiOT/pjHwoSxncPU03Vr1OVhfxTeMfKxRl6SZOua4uUCfWX4j6VqFXAT0iVjYFFnFgTl/L/cJkustzxz12lJyXJRGCls7eWh48ZGP9RIFmzEvYBv2WcHCEFFziwgGET5Ap2oW7emzWRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxYnWzwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9507DC433C7;
	Sun, 24 Mar 2024 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319772;
	bh=tV8tPyjDBqcivZy7fQnifxHJaUsNLTeXhPXtDBg9Lzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NxYnWzwMvsj8qno1zmcbxUaiuCv23FY97s8fc/4NRDeOZ0hs9xKwUDWJ1Qrw9KZxh
	 73pP/FRGOKlWJU3TFD+VHGnQXX9D4XCWfhiLuTtQ258HGqMRv+etTI+03BnEdiyBVl
	 pQq0USOhyVwXm7AH9aPdcLAxu91JqBRUgp9QSQg+XzRb2K/QGUT9y2wdm13nP2zXBe
	 POatgUno9jQlT9itnjspWz1lvhW5OPcFFRGS0cg3BlpJYwolDyjz2ksxC68PfbQvL5
	 eK0AnBaHj5dN14R+vaKmxwDRNolqg/EZUoL9Rf8c3PRj1VkZzZnMXWa4Elj7vlRDiL
	 iZNd6DrBqa4zg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 073/715] arm64: dts: qcom: sc8180x: Add missing CPU off state
Date: Sun, 24 Mar 2024 18:24:12 -0400
Message-ID: <20240324223455.1342824-74-sashal@kernel.org>
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
index b84fe5f3b41cb..8849469d0aa10 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -298,7 +298,15 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
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
@@ -582,7 +590,7 @@ CPU_PD7: power-domain-cpu7 {
 
 		CLUSTER_PD: power-domain-cpu-cluster0 {
 			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_SLEEP_0>;
+			domain-idle-states = <&CLUSTER_SLEEP_APSS_OFF &CLUSTER_SLEEP_AOSS_SLEEP>;
 		};
 	};
 
-- 
2.43.0


