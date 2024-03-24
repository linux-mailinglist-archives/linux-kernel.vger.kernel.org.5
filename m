Return-Path: <linux-kernel+bounces-112992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0CA888054
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A1E2817D8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AB512E1F9;
	Sun, 24 Mar 2024 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOWkF85W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC912E1E5;
	Sun, 24 Mar 2024 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319804; cv=none; b=KDj5uivokX9ao4lzn31xsPDYIMXzY47IH6OizyFqGHgIwzRko2Rex0NrNoXdbc9AT4voymhRGCota4S6JOr4NjUmNs7hMzQKXijOSGspiGjzOi8eQ5RB10I8FNDxE5FGvZ0yL5sUnZbwtBIdfBRp8QvL6oHi4WViRXX8ZA65Clo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319804; c=relaxed/simple;
	bh=UcRpu7p1jKQyG+pfEXtk4kRecvA2V6BI+5dODNtRxC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lojf3mYES+k/lWzrC5eyV6+3pEz9bKNwWOf2chGlfHE2i7KkKYVKdMhRQTY0Wm0xC6Nb0d1i+ddDbDUkyRtAZLIVLMa6boIw/ZQEsmJsPPfcCt5H1D8Ovt0rD1SxWAksQryCKkuIHzm08VnCcDTr70pMHG9INLNmtGV0s+c1hk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOWkF85W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BDDC433B2;
	Sun, 24 Mar 2024 22:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319804;
	bh=UcRpu7p1jKQyG+pfEXtk4kRecvA2V6BI+5dODNtRxC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gOWkF85W3yaicRYmF6DlaxStaJ3/JwGLFJK6o7VJVtEWPuvQGWEVUe3aseW6YIKEh
	 xC+USqObo24/Marvg20Mb5eI3wV6wmR+4oWuhguUApG57Zf+mKCSH4N7Yj2wTRvgNO
	 2YGG0RDOrv5O4OMKRJGiIWbtDCE2Mm500GJahR8TkAK73eN1IEiVHCYo1f4DeQjWaZ
	 +/ZWA8TviiGvsehgFCIC0Qim0GCzKJaioRe+8IV//vuX7dBUY8LlzJRJU/HPxtAyr7
	 /CHced3jLzv22J6CZx0N3JwfOiOmfPSIQRFySfvTKiwaXWWNuXTo2drNg05qsRgxTZ
	 Xcf04WsJyF/uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 105/715] arm64: dts: qcom: sa8540p: Drop gfx.lvl as power-domain for gpucc
Date: Sun, 24 Mar 2024 18:24:44 -0400
Message-ID: <20240324223455.1342824-106-sashal@kernel.org>
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

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit fd5821a1a83c969ed2dcc72fef885f3a82c1d978 ]

The SA8295P and SA8540P uses an external regulator (max20411), and
gfx.lvl is not provided by rpmh. Drop the power-domains property of the
gpucc node to reflect this.

Fixes: eec51ab2fd6f ("arm64: dts: qcom: sc8280xp: Add GPU related nodes")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Link: https://lore.kernel.org/r/20240125-sa8295p-gpu-v4-5-7011c2a63037@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sa8540p.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
index 96b2c59ad02b4..23888029cc117 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
@@ -168,6 +168,9 @@ opp-2592000000 {
 };
 
 &gpucc {
+	/* SA8295P and SA8540P doesn't provide gfx.lvl */
+	/delete-property/ power-domains;
+
 	status = "disabled";
 };
 
-- 
2.43.0


