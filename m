Return-Path: <linux-kernel+bounces-112964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CC988801A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38A01F213BA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B226C128801;
	Sun, 24 Mar 2024 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJHKYjqp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7BE128383;
	Sun, 24 Mar 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319776; cv=none; b=o30QrhyC4Oh2U4rRvwcCEiUmM3PNWs9ksV5kFWbg75oNBtS+fYawA4Z7AcDRliVB+qRaQV9LwXkWImeGL6R1SlAxsnKBiYLk9P2z2/dSr3LL/2sb/fygGYkWeoIyl1Y8vjR/IjQzYPrSbUC0my2P+Xwu0ZR+PEuA3lvkTw+ncX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319776; c=relaxed/simple;
	bh=vJGujO832JFLqHOAnflcavIqgqW+KvXTlKq+tz7Z5VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFOCfWKDCpxmRr6VTZRVqRHNUP5UFGoBK80tMbzrFOBJCRZp7ezD2TYaxpZ2S5rImgN3xGX9mtEhm2KklIgpCji3lqq08UZvMM26ipWa0QF0v6OnMidLrXnP9FOG8AtXGf61DbTRaBvgEHRyfLJmih64QfVMlwgvHrjLmG4c62o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJHKYjqp reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30123C433C7;
	Sun, 24 Mar 2024 22:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319775;
	bh=vJGujO832JFLqHOAnflcavIqgqW+KvXTlKq+tz7Z5VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJHKYjqpdxMhJ1tFv58iXZo2Hsx1KcRhgur/m2GrSrHq/GDxMwB6elkD8JtNWMeUw
	 lHGdJbpFP37NjPcwq0Nw7cbV9omMJjEykGSd2Jbn5+1Ixj/jwuorzEtKX7G7PBTQFg
	 K8xL13D1Dx+fNSp0AmN5Zb/EI04nvIKxD/7n2l97/8zePr7O2i6+oeSyYisAv36Q+Y
	 33wW5O5F7HU0jLtNXoZqCq45uLjoJvv4HmsTZulnsCJpBFm905uLg+HsgOWTwwth4T
	 u3hsNmHBldEM9btN5/k9nO26u9EtKL2cecrv7aNzWQjHuPPOkdLM4e1RandCjiT/yw
	 n76Dj6yr27TzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 077/715] arm64: dts: qcom: sc8180x: Add missing CPU<->MDP_CFG path
Date: Sun, 24 Mar 2024 18:24:16 -0400
Message-ID: <20240324223455.1342824-78-sashal@kernel.org>
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

[ Upstream commit f0cd5a0ebd419bd151ed79baf5f044da797521ac ]

To guarantee the required resources are enabled, describe the
interconnect path between the MDSS and the CPU.

Fixes: 494dec9b6f54 ("arm64: dts: qcom: sc8180x: Add display and gpu nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231230-topic-8180_more_fixes-v1-8-93b5c107ed43@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 97c139d0399d4..960058624a2f5 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2701,9 +2701,15 @@ mdss: mdss@ae00000 {
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
-			interconnects = <&mmss_noc MASTER_MDP_PORT0 0 &mc_virt SLAVE_EBI_CH0 0>,
-					<&mmss_noc MASTER_MDP_PORT1 0 &mc_virt SLAVE_EBI_CH0 0>;
-			interconnect-names = "mdp0-mem", "mdp1-mem";
+			interconnects = <&mmss_noc MASTER_MDP_PORT0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>,
+					<&mmss_noc MASTER_MDP_PORT1 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "mdp0-mem",
+					     "mdp1-mem",
+					     "cpu-cfg";
 
 			iommus = <&apps_smmu 0x800 0x420>;
 
-- 
2.43.0


