Return-Path: <linux-kernel+bounces-113043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD24888104
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEF91C21203
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124A2140E47;
	Sun, 24 Mar 2024 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsXU1zkO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90D14038E;
	Sun, 24 Mar 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319853; cv=none; b=oQYG0ufl1VI1td758zJ0CQSbJmVzoRS2WQZOvP2HaYPXB162DTutl7Jl5DQU0HEHqST/H7Iv3gLkQtRCGfVetcwFOfW5AB03FNPxEC6QCCATNceTJbFWC0fSEu7uozLAu3335VWSC/rJ+10acryGU97lZZuwvueCdXlPYVZTbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319853; c=relaxed/simple;
	bh=NRCKEtw5FEZEB1cAvNhMBod8zjMtinZJoPRlHF708sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NamHCsZKGWEsTD1rBBZHAHtoxIakdC+HIo7qqjSOeHws98mGP+wrzdjM7KNtPWip6TH29KOkIrAwFRlL5NRymGlSl2ovRv/AEJcd4RXNl0u4701EwwYAgMV6Yh7hI6LerOu6PQxGT6W5PqIM/okHC2UhZVno0mRfObr6a2nPnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsXU1zkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A9CC43390;
	Sun, 24 Mar 2024 22:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319853;
	bh=NRCKEtw5FEZEB1cAvNhMBod8zjMtinZJoPRlHF708sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsXU1zkOiZqtdwEoQFc+aLCyjljuWSE9+pMWBKc++GpYWlHLY/wTSe8tQCkZdtGhZ
	 yZEql1H2ie2uvLDaMo0DM00m7iVdb2J//FUbDQKh6UvzzgV7E9WCqJsJ6e7agI0mGm
	 eDSre5zuPPU/6mQXKLLlfJtZkrMvd8/AOpPbVyBQY07Hg217oLZ7evEK53n12avxUh
	 pE0v/Ph4M7WDo9FXJ6VxF/JaOphaag5nPeN3mi+owlNsrrkjU9IRYIEwIS2AHQj3VP
	 8obHNG94oZHKnTigR4H72NTJUUvjfLOyvb0AzI7CApra2Fx8krGmWb/GLOuOFM6B9n
	 tKGIQ0cFXlCQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 156/715] arm64: dts: qcom: sm6115: declare VLS CLAMP register for USB3 PHY
Date: Sun, 24 Mar 2024 18:25:35 -0400
Message-ID: <20240324223455.1342824-157-sashal@kernel.org>
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
index f9849b8befbf2..b627c473ffa54 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -614,6 +614,11 @@ tcsr_mutex: hwlock@340000 {
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
@@ -879,6 +884,8 @@ usb_qmpphy: phy@1615000 {
 
 			#phy-cells = <0>;
 
+			qcom,tcsr-reg = <&tcsr_regs 0xb244>;
+
 			status = "disabled";
 		};
 
-- 
2.43.0


