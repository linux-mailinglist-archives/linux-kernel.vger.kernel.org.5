Return-Path: <linux-kernel+bounces-114151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA6B8888BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07181C279F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B40A244CF7;
	Sun, 24 Mar 2024 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMxkfvMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ACE13443B;
	Sun, 24 Mar 2024 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321466; cv=none; b=GCFCjlSXBoulcywsbVpsuvo7zia7eiSaBpzIBNGw/63Xon7KnkacFVKJJ1pgxCTEtl3Akds1CXewoXMBZPQmC+ra4FUoxjZKKoWnd4QvvnnoAHgTlCIRIPSdR6mAmadgHwgaaIiLVBUOi7fKKNxhaRxNQpXPReOuJvlOv6Eb+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321466; c=relaxed/simple;
	bh=ihf/gRh8V3eyFigSVCgEiwUDfiQkJZ0pUrLWekgm6JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMPAg4E/jYbV+VvtO6p6zAy0bjUGYzN68vDzRWHjgUhosR6obiZJIceFqeLlR+vJXCX80MjRLEv5UEjmlDjjx8do29pANnzMyt5+LPvBGjFwi23OaNu+s4pbksENWw8r6H9CrcCWqc3R8J/jjgr9Nq08MH349Slp9fQH828eeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMxkfvMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F00C43394;
	Sun, 24 Mar 2024 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321464;
	bh=ihf/gRh8V3eyFigSVCgEiwUDfiQkJZ0pUrLWekgm6JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dMxkfvMG95zJPuBKeTV8Jmuc/SIi1dliw78lmhfAQt+l/k2E7W1RYrneaYqM0lTQA
	 2gsWa4jyPg5GqLHK2acT8nO8WEfh7MqprwBpQAHAJ1RF9tQ/BWH6M7K+k0tfD5UuJQ
	 E+C9YjPrI534HdvULd7Jh67V6eHTPd1O4Xyq9wc4a1OkPpQ7sqskrL+RhOt4KlPk5j
	 /EWebOWoSsXNL00AQVDoDLx5rjjO+325QjuvqGj26utjPyowFiGxT9QczvAcJDajJI
	 3JgbRWDjW89mbiN1mtOko5PI941xVECb8EykhBcw1ymBUZU2Q55gkAWMx7f/Q4L6Xv
	 UDdJn9dtX+WCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 189/638] arm64: dts: qcom: sm6115: declare VLS CLAMP register for USB3 PHY
Date: Sun, 24 Mar 2024 18:53:46 -0400
Message-ID: <20240324230116.1348576-190-sashal@kernel.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 95d739ed962c9aaa17d77b739606dbdf31879f6e ]

The USB3 PHY on the SM6115 platform doesn't have built-in
PCS_MISC_CLAMP_ENABLE register. Instead clamping is handled separately
via the register in the TCSR space. Declare corresponding register.

Fixes: 9dd5f6dba729 ("arm64: dts: qcom: sm6115: Add USB SS qmp phy node")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240117-usbc-phy-vls-clamp-v2-6-a950c223f10f@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 839c603512403..87cbc4e8b1ed5 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -591,6 +591,11 @@ tcsr_mutex: hwlock@340000 {
 			#hwlock-cells = <1>;
 		};
 
+		tcsr_regs: syscon@3c0000 {
+			compatible = "qcom,sm6115-tcsr", "syscon";
+			reg = <0x0 0x003c0000 0x0 0x40000>;
+		};
+
 		tlmm: pinctrl@500000 {
 			compatible = "qcom,sm6115-tlmm";
 			reg = <0x0 0x00500000 0x0 0x400000>,
@@ -856,6 +861,8 @@ usb_qmpphy: phy@1615000 {
 
 			#phy-cells = <0>;
 
+			qcom,tcsr-reg = <&tcsr_regs 0xb244>;
+
 			status = "disabled";
 		};
 
-- 
2.43.0


