Return-Path: <linux-kernel+bounces-113038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28A98880FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0ED31C2137B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1851413F003;
	Sun, 24 Mar 2024 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6/7bs03"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399E13DBBB;
	Sun, 24 Mar 2024 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319848; cv=none; b=irvXcVaTS27KAtZ4isAIVcyOvMIi1S1Z96AimipyzpHk83xBvrljr4s8vyZosEXHpSOgs6DyDmatPWvN3uVx23/J6lhxg5vjtL/uEBYN1tEIiQOULskE+erSzS+eafkbq3r3ODD0JgtjonG2J9fHokUjvJhK1DMpq2GUxWsn0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319848; c=relaxed/simple;
	bh=gx4eZVC9G/0GVO15fm/mEKgXDVa2hcqjveI2hkLEjSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfhEwMrISllbv333O3nUGkB7qK2UqwKB8HIlEzhiusFr//oND9lY16NUkE3otm0UvYwO2FP+Xog7+1g17Mk5FdieQMWjnotPfa1lFH+kUxSt/eoeUVslEyxeGuXHpIwly05cXIg+5lqKll+a6kItYMcbBtv5K2u2tuEeU3fCkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6/7bs03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810CFC433C7;
	Sun, 24 Mar 2024 22:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319848;
	bh=gx4eZVC9G/0GVO15fm/mEKgXDVa2hcqjveI2hkLEjSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6/7bs03bOpU7GUo3FTxMtvTRLs6B0rHM9xtB3Fr7YSDe0tRfkz3qgCBDH576RA4A
	 X06CtXGJrMwLkBAoGR46jUucYoMPVZ1IbLsL1kmQfISDF3csXs53gIA51ctZsh2iHD
	 1K9LxwNavZ6c962oJRuKhvSdJ0novwbI7mTpUIpZjXQJRSbYBAUO9iNXBdWX+YQ/Bg
	 VjmNotrjvC4B2ifNPcfrISDfTNQqvFnbI5fCXJOT9GpklKbeCmwRJdFUP+ea1qdHAp
	 cM9qMdqdGvk2vWqDt6hXfdv8c8ScSWr4P2CbnjPY9m5Js3E/8bRNgNJ/cUMRD257iP
	 rDp4FR1UvaDSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 151/715] arm64: dts: qcom: x1e80100-qcp: Fix supplies for LDOs 3E and 2J
Date: Sun, 24 Mar 2024 18:25:30 -0400
Message-ID: <20240324223455.1342824-152-sashal@kernel.org>
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

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 7eac281cbedbd71d777eabca3a52d97983c61692 ]

The LDOs 3E and 2J are actually supplied by SMPS 5J. Fix accordingly.

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20240129-x1e80100-dts-missing-nodes-v6-11-2c0e691cfa3b@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index a37ad9475c90d..3112487d2a168 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -243,7 +243,7 @@ regulators-3 {
 		qcom,pmic-id = "e";
 
 		vdd-l2-supply = <&vreg_s1f_0p7>;
-		vdd-l3-supply = <&vph_pwr>;
+		vdd-l3-supply = <&vreg_s5j_1p2>;
 
 		vreg_l2e_0p8: ldo2 {
 			regulator-name = "vreg_l2e_0p8";
@@ -349,7 +349,7 @@ regulators-7 {
 		qcom,pmic-id = "j";
 
 		vdd-l1-supply = <&vreg_s1f_0p7>;
-		vdd-l2-supply = <&vph_pwr>;
+		vdd-l2-supply = <&vreg_s5j_1p2>;
 		vdd-l3-supply = <&vreg_s1f_0p7>;
 		vdd-s5-supply = <&vph_pwr>;
 
-- 
2.43.0


