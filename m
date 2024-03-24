Return-Path: <linux-kernel+bounces-115619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA2188944E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFA21F2F836
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A3934A308;
	Mon, 25 Mar 2024 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYDXMWod"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5C131738;
	Sun, 24 Mar 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321404; cv=none; b=BkAAe01gjCwxhEkjtdGdkPqNvPsO0CXdnRARA8PGfdt4WH7Rvs3+MKzFQikCxxBEeztfZqBA0QqUvW5GtXCE5n8C9N/uXH7HWPauHx6MCljpN1o8v9P8FZ3oPl7r5+o3bLE/gZXdTRGRMWOAm1vBxPR/miSxDaFPlFe2jx1mQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321404; c=relaxed/simple;
	bh=+PQn2Xt32PVXtxetymmoxToLCcedOoj6FzicUSmW7zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnjtDmqlc69U3jrZsF77bpjFajO5B4FkH3bvl/fTuIYoEuiAhwCPZ0gK2CLtGKkyWLZaKWqNn2g0KVrqUdpKLTICFqxDpkgcsnyLLceosAChNhYnxrAJGVPr6nSxFi6s6azauc0d5PbRpFw63ujdlf+l82abfRYjfrpWfgcYAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYDXMWod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540BCC433C7;
	Sun, 24 Mar 2024 23:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321403;
	bh=+PQn2Xt32PVXtxetymmoxToLCcedOoj6FzicUSmW7zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYDXMWodb/CoFGUU67/fY3fERpc18Lv2EqHbK0+5rOqQvPjepvqFnJ1BzpoqK4VRu
	 XptdgrfHOk0yJ9y7fkFtjtRDsbeyjLwCyhlJBYCJhK7nismPhga4o4T/DbOH5ebvOf
	 VWdJB6GksxFTXP4VhT7hQtN93MZw8h3VcTIc8SF/OqqYU6n3s4CgjteHNZrcPWJyuU
	 6CH/hPBclVMbwlQ7kXqF7E6+AJ/Tivu+mzJkdtiGSAcU7Rhg8MuMu4qfZim4GdgbFk
	 xLdGF8Nd8G+ieAoqm1YSmyfyF460BhOrviwNCBV+hoAwO7qpV8UABQu3plXYDizwlf
	 34z1fcES0MY1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 128/638] arm64: dts: qcom: sc8180x: Fix eDP PHY power-domains
Date: Sun, 24 Mar 2024 18:52:45 -0400
Message-ID: <20240324230116.1348576-129-sashal@kernel.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 24e98cb3d5e2c86565680e00008a794b4eac0040 ]

The (e)DP PHYs are powered by the MX line, not through the MDSS GDSC.
Fix that up.

Fixes: 494dec9b6f54 ("arm64: dts: qcom: sc8180x: Add display and gpu nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231230-topic-8180_more_fixes-v1-5-93b5c107ed43@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index e15f4facc0021..548dbeaf823e4 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3194,7 +3194,7 @@ edp_phy: phy@aec2a00 {
 				 <&dispcc DISP_CC_MDSS_AHB_CLK>;
 			clock-names = "aux", "cfg_ahb";
 
-			power-domains = <&dispcc MDSS_GDSC>;
+			power-domains = <&rpmhpd SC8180X_MX>;
 
 			#clock-cells = <1>;
 			#phy-cells = <0>;
-- 
2.43.0


