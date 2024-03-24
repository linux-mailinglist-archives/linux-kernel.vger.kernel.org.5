Return-Path: <linux-kernel+bounces-113707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCAB888628
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4880C2925E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2802B1DB081;
	Sun, 24 Mar 2024 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjZEowzU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B91DB412;
	Sun, 24 Mar 2024 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320692; cv=none; b=qGCh8xN/8nq8B6Rzgz3//cT5aAiJo/7NfMFhvtnjsowU059h4R0I+sZ8idmnzRUqmAY9LyVvc1tdrD+XlwG0ymsA715Poh69xes1kPa+zsqLpNUW9pzaBxi9TvOlYL5fcEh/SdBmb0/mhw+sR1rgFuk83ELXw9cWZEsdOh3pxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320692; c=relaxed/simple;
	bh=bcI9wS3VFYaaH9yiTWy3phxmoJ2vvyOCNAo5/8GBxgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7QTnmykbEpeIx3g2r4V+tOpTEHcNFk02L1HsgDUnAUBa1qfeKr/tjGxoyFrZiQ2LVNM4vt4bEux2J0j2Eeay4fC9aVGjOMmGT9YkYN0Zk7Y3no4r0Ndmb8e+HGFNzh5rKluEH/tPFx2T8kIwIPmDEaZBcKdEPLU3K76MG+fHHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjZEowzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2249FC433F1;
	Sun, 24 Mar 2024 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320691;
	bh=bcI9wS3VFYaaH9yiTWy3phxmoJ2vvyOCNAo5/8GBxgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qjZEowzUoRzK1rN+1UCKiVL2mKbzY0AYwkvDUOgJGnwSB0BpKNNukauTRsN2vXu6V
	 ZGk1CDFBpSMftwyAF1jWyh+jJ67+VvORg5gja5rEFMkSzhz+pDoQ9RXCIPRIagmsBQ
	 SucG1GbFOletbpmsccMdlPRIlbUO9+VRLAQZkSirJ21efU32iO9U0YxDbRDtb5ckCq
	 pV4ZnPxP/XbtzE2XUUn2PytVhwIYWCay9kHvEvhShnvx0DoVrsLXpH9ilRyeJqWBLX
	 6jhpRve6t2ICZd1Q7xBknYxvfqC6//wzmuAziVwdNBFodm4caoKgpjuxGbzKe6UB7E
	 7e6F6JaxUVJKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Craig Tatlor <ctatlor97@gmail.com>,
	Luca Weiss <luca@z3ntu.xyz>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 253/713] ARM: dts: qcom: msm8974: correct qfprom node size
Date: Sun, 24 Mar 2024 18:39:39 -0400
Message-ID: <20240324224720.1345309-254-sashal@kernel.org>
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

From: Craig Tatlor <ctatlor97@gmail.com>

[ Upstream commit 724c4bf0e4bf81dba77736afb93964c986c3c123 ]

The qfprom actually is bigger than 0x1000, so adjust the reg.

Note that the non-ECC-corrected qfprom can be found at 0xfc4b8000
(-0x4000). The current reg points to the ECC-corrected qfprom block
which should have equivalent values at all offsets compared to the
non-corrected version.

[luca@z3ntu.xyz: extract to standalone patch and adjust for review
comments]

Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes")
Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240210-msm8974-qfprom-v3-1-26c424160334@z3ntu.xyz
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index 0bc2e66d15b15..f41cc4b4b518b 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -1226,7 +1226,7 @@ restart@fc4ab000 {
 
 		qfprom: qfprom@fc4bc000 {
 			compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
-			reg = <0xfc4bc000 0x1000>;
+			reg = <0xfc4bc000 0x2100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
2.43.0


