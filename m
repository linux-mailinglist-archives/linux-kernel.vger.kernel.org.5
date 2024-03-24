Return-Path: <linux-kernel+bounces-115383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC631889B42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8622A6737
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FB51FB07E;
	Mon, 25 Mar 2024 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Avumo8Pg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1584FDB;
	Sun, 24 Mar 2024 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320652; cv=none; b=icegSfaoZC/T7O7zgJ+s+4fJemAHVKzvU7hingCDkRYRHS4L6r+QwIHCo568faHd5brvxQq8vEnpiFbklDcW5QkrzwgtJRgG7+U6Kq6HNgLe4klnt/VxClI11LCJnFfSsfifT1y9bJqpWE4mf7XBKosEZ4342jUvEmwO2EQlmO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320652; c=relaxed/simple;
	bh=ME0ojuQ7AJEJ0fypMbut5+DeBUymaln3FXqHO0SHC54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/gPN4cuJrFKTsvDTrCmXlHyUJ12R0nqmy7JbaYv+tt3b6WprU35Qw+z9oEcWrzNj5AhjMYNP/Qg2aXBQrwuQqnl5stYDOH65U0OXFO2Xl6++/4NrxW7B2lMRFGe8kqpRdYiMwdyy0VHt3QPzzdeDdPO1WGbOeSMz5DsqbNymEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Avumo8Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237AFC433C7;
	Sun, 24 Mar 2024 22:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320650;
	bh=ME0ojuQ7AJEJ0fypMbut5+DeBUymaln3FXqHO0SHC54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Avumo8PgaudLUyucO+IfUSk7pr224nv+G/MsJr0JQshmL4K9FJHJZ8+ArcqGEYMXq
	 z0Sbe/BE9cmh1wGK+Ad+GWyuJzJLkYpEx33f3ADYqgOO9DyjNA2pc5ZGfdF/FStdsG
	 N02B7TEo0WnTSexq501w5yB9dVGbTnWbFgjxcEu1nfnhsXzt/NG4eu/wER9TXxvZOz
	 8Va4O7g4bogddA9WeAzMIMZ2jTq2+BdqqRovPnpdotlxflNWW1pnvKguF/FKl20aVJ
	 /LcPK6A5E5huJjnXbt4lvcbm92xZnZtG1GcVIEGQzD3OGVUBbrTpSKUkVYOUwk2NJh
	 8TsOnmY71nFFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 212/713] arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY
Date: Sun, 24 Mar 2024 18:38:58 -0400
Message-ID: <20240324224720.1345309-213-sashal@kernel.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit fc835b2311d4deb85d776c1d73562338462aa7ac ]

The USB3 PHY on the MSM8998 platform doesn't have built-in
PCS_MISC_CLAMP_ENABLE register. Instead clamping is handled separately
via the register in the TCSR space. Declare corresponding register.

Fixes: 026dad8f5873 ("arm64: dts: qcom: msm8998: Add USB-related nodes")
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://lore.kernel.org/r/20240117-usbc-phy-vls-clamp-v2-4-a950c223f10f@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 7dd0d4ce25ef4..610ffd0f9e18e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1082,6 +1082,11 @@ tcsr_regs_1: syscon@1f60000 {
 			reg = <0x01f60000 0x20000>;
 		};
 
+		tcsr_regs_2: syscon@1fc0000 {
+			compatible = "qcom,msm8998-tcsr", "syscon";
+			reg = <0x01fc0000 0x26000>;
+		};
+
 		tlmm: pinctrl@3400000 {
 			compatible = "qcom,msm8998-pinctrl";
 			reg = <0x03400000 0xc00000>;
@@ -2185,6 +2190,8 @@ usb3phy: phy@c010000 {
 			reset-names = "phy",
 				      "phy_phy";
 
+			qcom,tcsr-reg = <&tcsr_regs_2 0xb244>;
+
 			status = "disabled";
 		};
 
-- 
2.43.0


