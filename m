Return-Path: <linux-kernel+bounces-113701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C6088861E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074DA1F24AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581C41E5848;
	Sun, 24 Mar 2024 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUEYLvam"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4FA86638;
	Sun, 24 Mar 2024 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320690; cv=none; b=uh/+U9MYEZ/bS9+sjRuDCirV5VHkyY7/fpPZCXsp/ulTFGjnSucUkr/goC/OOwWKFJPWeRkzdSAEdNMR+aYZa8Dihgjymiv8AJGlIxTQUx46iLxocNqrRHF0ggQDn0HGfNNanQGTwbHjJDvvtH4w+CAslNjbZHnBPmP57mw6Qbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320690; c=relaxed/simple;
	bh=WGTDycXs3pSFgOQuZXxQtwm6ivvARn299Bk7dfwWqhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exWOvxYEMB7u+lBLB0Bx0L43yXEohaW1stdd++1pqMzAKYbT7GA+pwIlEAOCthU2mTOt7KrSfM5HCEEtzM+OjlF1LqZzpYak8rMyEvWgQFWRMmeDaLHbIRNY+OBvCReVizZlcsmSC3NretF2647SVDC0Otgh0Ao70Ngn8tYdPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUEYLvam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2291FC43390;
	Sun, 24 Mar 2024 22:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320688;
	bh=WGTDycXs3pSFgOQuZXxQtwm6ivvARn299Bk7dfwWqhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUEYLvamyr6XSI+EObRqCiQjO3NxpQVSSrYAYAT/t5F+NiOs8R9YEv189EC4qfJeH
	 MaeuIyFCAWRupRms501UQKoUf+VV+SJa5BmvnCbMlKCXdjkehslb/BvNmu4H3TWKy8
	 hviQYs7HDSr+mWfKazx3cTEWaivbA+fyMmSADO2PMbS6gSQ2uxLVdVAF8+RVhUyB8O
	 eM4oreBX9GiuIafeeM0vnCusM/mA76ITTtDvIYPcjW5BHl3vu+8Iio7U6krYAbE/de
	 DO/P+KsUTk9BVNGi6Y3R4fQ579UgkbXU/iALFrsI7pCOebLNtW411+bsDIXDuV9Gs+
	 /xbQjRg18oOuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 251/713] arm64: dts: qcom: sdm845: Use the Low Power Island CX/MX for SLPI
Date: Sun, 24 Mar 2024 18:39:37 -0400
Message-ID: <20240324224720.1345309-252-sashal@kernel.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 5dd227ccfb9568935bdaf82bc1893b36457dd4d3 ]

The SLPI is powered by the Low Power Island power rails. Fix the incorrect
assignment.

Fixes: 74588aada59a ("arm64: dts: qcom: sdm845: add SLPI remoteproc")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231220-topic-sdm845_slpi_lcxmx-v1-1-db7c72ef99ae@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9e594d21ecd80..88ed543de81bf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3353,8 +3353,8 @@ slpi_pas: remoteproc@5c00000 {
 
 			qcom,qmp = <&aoss_qmp>;
 
-			power-domains = <&rpmhpd SDM845_CX>,
-					<&rpmhpd SDM845_MX>;
+			power-domains = <&rpmhpd SDM845_LCX>,
+					<&rpmhpd SDM845_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&slpi_mem>;
-- 
2.43.0


