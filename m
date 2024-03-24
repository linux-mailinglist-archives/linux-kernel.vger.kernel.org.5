Return-Path: <linux-kernel+bounces-114150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5BC8888BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F19289E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E775244CF2;
	Sun, 24 Mar 2024 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsFKCLsE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B10D134412;
	Sun, 24 Mar 2024 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321465; cv=none; b=skEmSoJqFD0KSnFOxiYqBblqMUBjoXkTwzpntPBvRjsIjAZZ4XVy8WYM8SmIqCZvQ41BDIjriYBWsYzowFh8vawjsFsIpOPvp98R81gAA2DatoZUgO0M6KLOz5gsng6K0JuhlN/i7RfWdOOlrVIQWnC9XOlf4GeRu5MFh4kpDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321465; c=relaxed/simple;
	bh=t+7Oww8cat4ZZ/+r8pnzUTQJ7RVy2StCPb/afBg1f/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6RWCh8+ieQPrgH4SkvrDiEJMJZ4pRhBJ0s1dze1OUAvromtxteE4UGmx0PN1c82dkuB9j48Gzmp9iVbcodrzwKBpwrPVrfRzanllr1ruSl9OnkQAFeFITeczZfT7GGKrQM2MBDrJFI5GddK5Shq2FJMU7FKlOMDdenpk5dlV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsFKCLsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D846C433F1;
	Sun, 24 Mar 2024 23:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321463;
	bh=t+7Oww8cat4ZZ/+r8pnzUTQJ7RVy2StCPb/afBg1f/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KsFKCLsEsjkUQg3JHoXa1DsB+6OeJCUOYTrdUnuhH9w2KwPv/YTgkX5yAwUor6LgH
	 JicLI39su3v/Dc3gkBFVltvQyeTAEA+1uSSZXhj5rTc42Fl+AI0LxUaL3FYk0viheu
	 EzsMTIeo1HConazC8JWmx+d9uekD1rnng6BIVndHbu+dbU1Tgbs7gWe5KK8M7r+Ajv
	 yRizPSAN1jqm6gzWLBaaf13D/ZYcb4j+y/SjToa1NVQx8DOqXxFh8x5WnpZtNyXcDN
	 Ip72naWOz8utmEF6N7xEWdvd9FrBHf1ofPbpXiwJB4CNtaKdbo4/aCLpr6n4Wu0Cw1
	 +1YpEtZKBb6Xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 188/638] arm64: dts: qcom: qcm2290: declare VLS CLAMP register for USB3 PHY
Date: Sun, 24 Mar 2024 18:53:45 -0400
Message-ID: <20240324230116.1348576-189-sashal@kernel.org>
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


