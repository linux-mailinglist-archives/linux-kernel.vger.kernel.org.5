Return-Path: <linux-kernel+bounces-113686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD6888605
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A4728E5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E1B127B70;
	Sun, 24 Mar 2024 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/gbohhz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D1A1442E3;
	Sun, 24 Mar 2024 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320653; cv=none; b=lhlEOqcu5BoyyWgoUIFzeTzDLGy724cDlhetBbMq+UTkdXQvdbAX3DKIKOAO/1VOfG314KLyDUfukMImwSF7pfrNT22kPOkTWQwnhixH5/ZeqXisJSglJBl72McbyDpD7HHqNRQG6ZuZYu6MJUcz11wfyW1075sSpZVHMDPEu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320653; c=relaxed/simple;
	bh=t+7Oww8cat4ZZ/+r8pnzUTQJ7RVy2StCPb/afBg1f/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq5XnCYwPGL4UHR1hQFSOtK0DpwHdKmI8w9XUeGcbH3YQXv5ZjC203TESsZSH7PfNTd0nOYL35Na8pc9pTxi/FWr5Bta61j/iHjPkCJ4KraZpeK5xwLYMRGbcVak210JsbEF3u+dKyCJkJTJRUJEkZnbDG0Qs9i3tz4k7OAD/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/gbohhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DC2C433F1;
	Sun, 24 Mar 2024 22:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320651;
	bh=t+7Oww8cat4ZZ/+r8pnzUTQJ7RVy2StCPb/afBg1f/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/gbohhzQt5RC4hF/WTsm8xWMwv6oZoONX/QBhVBaYF7+1fYdFlTGOL4Bs/hen5Cv
	 cdp4PkNBdsUo5K1MW1sV6dpTxwdY85w6bxp7IVtGLsimXSqxHXqLex6LWh0hraZmqW
	 QruO3juU4MEfj/diReSFFwGRX7z+atoHbKCFfUbz1imVtT+iJxuE117+AepsMAcFUR
	 JmC3T0EflU/le1JKob0bLkYhde5Xw7mngPyEjsaaEx8UVwA4kXzeyvb/E2jyQgyASK
	 69ZlSR4XpdXX2xB+U7ZqRHainGgN+PAx4cIJPdqP8J0ATnQ1n2deQyhFPb4lyGILXX
	 yCB1A7LiSw3TQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 213/713] arm64: dts: qcom: qcm2290: declare VLS CLAMP register for USB3 PHY
Date: Sun, 24 Mar 2024 18:38:59 -0400
Message-ID: <20240324224720.1345309-214-sashal@kernel.org>
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

[ Upstream commit acb94d67f5a23dbb2e0021b6c30609ed05d7d6a5 ]

The USB3 PHY on the QCM2290 platform doesn't have built-in
PCS_MISC_CLAMP_ENABLE register. Instead clamping is handled separately
via the register in the TCSR space. Declare corresponding register.

Fixes: 0c55f6229bc3 ("arm64: dts: qcom: qcm2290: Add USB3 PHY")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240117-usbc-phy-vls-clamp-v2-5-a950c223f10f@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index d46e591e72b5c..40a8506553ef5 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -418,6 +418,11 @@ tcsr_mutex: hwlock@340000 {
 			#hwlock-cells = <1>;
 		};
 
+		tcsr_regs: syscon@3c0000 {
+			compatible = "qcom,qcm2290-tcsr", "syscon";
+			reg = <0x0 0x003c0000 0x0 0x40000>;
+		};
+
 		tlmm: pinctrl@500000 {
 			compatible = "qcom,qcm2290-tlmm";
 			reg = <0x0 0x00500000 0x0 0x300000>;
@@ -665,6 +670,8 @@ usb_qmpphy: phy@1615000 {
 
 			#phy-cells = <0>;
 
+			qcom,tcsr-reg = <&tcsr_regs 0xb244>;
+
 			status = "disabled";
 		};
 
-- 
2.43.0


