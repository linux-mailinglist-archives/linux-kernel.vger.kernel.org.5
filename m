Return-Path: <linux-kernel+bounces-115384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C87889B31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749F92A7680
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C94154BED;
	Mon, 25 Mar 2024 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j94uLUFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B11442E2;
	Sun, 24 Mar 2024 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320653; cv=none; b=SY5KLG9StxC+bmC9UjVo8N+BBajyQmawpkq1SkACmwoYRmWJW43cQPFEETAfJ6F7bRCyVRU4/wHxJTnxPiWRxMqXOn2dJo5BDjsWv6nd5iCDIDtmwa8ftfIpGxDESYFhIHpY8KB1MLUcjmB4jr73hdsWiaf/rnuzTdt+qXhxWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320653; c=relaxed/simple;
	bh=ihf/gRh8V3eyFigSVCgEiwUDfiQkJZ0pUrLWekgm6JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHfoWwd75X/lZP9XvYmbACbusKJ/LzNh/B2IFLEwCPF/Pjmz9BcKeJonSFkOkcb4eXXLSoVm7nz1VcFLgi6TDzuj28ttP3KVF6gJ6UAIq9J4DbyRIGKwjF8/8olVTmyX4g2jkn9gnhk8m320hlVhGT5o2Plqi4vNYkq4RnxsIDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j94uLUFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32916C433A6;
	Sun, 24 Mar 2024 22:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320652;
	bh=ihf/gRh8V3eyFigSVCgEiwUDfiQkJZ0pUrLWekgm6JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j94uLUFx7UZ8WM2aGhtqx/RiqBr4g1ZT4fNc7jigbxiqbE+4OJgFN3Yqs0P0BMYkI
	 zeqENmYJ2nz9iKhy2qiBpOfPxxo5EPQmcMWtuaL53L2RisgKNSLJ3L9CmPoYeIZIe2
	 w3bIak2gNBkthbBAyAYMdqXpc+Mm7Z2/RZJMG2DAtWAx0REVQ9BOm+gjLe2VlZr7aI
	 5iBxZoYfo91brAEIW5kaLvTiJQipWlErFJtcrbDhVKU3jKc/9hiyAWac5G3XP8JJDG
	 rOEfgKcMdB3JNWQOeW4Nykl44+MzH5/4gngz5r6TLQeONHidNoadSD6aI+c5vUJF0t
	 /hEJazw0gc0ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 214/713] arm64: dts: qcom: sm6115: declare VLS CLAMP register for USB3 PHY
Date: Sun, 24 Mar 2024 18:39:00 -0400
Message-ID: <20240324224720.1345309-215-sashal@kernel.org>
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


