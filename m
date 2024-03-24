Return-Path: <linux-kernel+bounces-112959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0E7888010
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3573828133E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461481272B7;
	Sun, 24 Mar 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuEhaq7Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD0126F25;
	Sun, 24 Mar 2024 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319771; cv=none; b=ZezWfb0Y5BpaMrF/XjEvB4S+A1hLaXF7/cuphqjkv6LJw140eujuDA9kZiqkpM92KPFL0Ln2g8ojXOMWdX2B5aARLEPNIrGt2lgBWgqIUbkVqPHj6ZJSWd2zRUnet16S+MJw1tskQQwaUhL5q+Xwad+U6UKEpxQbY4NoMgZW6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319771; c=relaxed/simple;
	bh=ejEken6MNn40cWSqDfSx13qHzU93nZ33Dq8SRiNXNHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l15gd5hDBP1oNb99hoZzSY9sOBQ2Jsys07gfn/jjzfTaIDNAx03ABn2FTtPjsG3hTfD6TLh36ZQA9fUdkBsaKEnpq5pCJ3MvEf2by6+PABhUfzwHLOLLPF+6MjqSDN4hojfwiHlFPj9iwF4IBVtkHpp84UuucFk2TQ2LIC+NdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuEhaq7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1469C433A6;
	Sun, 24 Mar 2024 22:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319771;
	bh=ejEken6MNn40cWSqDfSx13qHzU93nZ33Dq8SRiNXNHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuEhaq7QEGNCV3EfWMUeF8FjeTBEzEEV2vou7okcLHK5lWN8b98qEqNmn3lL5SAr4
	 z5swCxigAlYsqFdVYGOSQ8gJ+oCLNuZpxiXbGelg85WrJSTvhYGEUS1G9PqzMfwlfK
	 ihSuHiivyZAzoHszpGkT3ZjXBemTRVZeELE5aZCavki5xAfOcZ8tjr2LUl5bEmeFz0
	 xwrCqLDNE2K6awS32CxBJjTD66jsj9y9c5HJCZCNxtZvAIFJIhTj6nCO/qfT1YeZfw
	 jyvNcLQLKho+o/dHieCS8cLU0mvEcJtFJhbh09eKqdgVcq3tCuQak+2ye8o569E7qf
	 eaIv4T9b+vECQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 072/715] arm64: dts: qcom: sc8180x: Fix up big CPU idle state entry latency
Date: Sun, 24 Mar 2024 18:24:11 -0400
Message-ID: <20240324223455.1342824-73-sashal@kernel.org>
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

[ Upstream commit 266a3a92044b89c392b3e9cfcc328d4167c18294 ]

The entry latency was oddly low.. Turns out somebody forgot about a
second '1'! Fix it.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231230-topic-8180_more_fixes-v1-3-93b5c107ed43@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 91fd805f17a1b..b84fe5f3b41cb 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -290,7 +290,7 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
 			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <241>;
+				entry-latency-us = <2411>;
 				exit-latency-us = <1461>;
 				min-residency-us = <4488>;
 				local-timer-stop;
-- 
2.43.0


