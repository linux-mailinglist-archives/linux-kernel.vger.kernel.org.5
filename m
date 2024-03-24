Return-Path: <linux-kernel+bounces-114125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C4888F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8635E285999
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D8D1607BA;
	Sun, 24 Mar 2024 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIKNwS0M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0E4D595;
	Sun, 24 Mar 2024 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321430; cv=none; b=ksPPVsYK7bbninpiTq3X1SwEZviiA/KZsMcaKa/P0xq6JLQF5HPMbL5XGWkWxOk2PkJ53WIFYrpW0XUbjQ5plhyQas1AFznyWOxNSYe+rbVQfPYGVrGfqQDAEgZKZ2VG7Dolj9g7KrSiyl+BpHvF+EZgI6qC3HQc+ZNSb1dvxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321430; c=relaxed/simple;
	bh=UcRpu7p1jKQyG+pfEXtk4kRecvA2V6BI+5dODNtRxC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0zRAmYL+GyxoALCOf1g/kZZPKxmYAIgCZr/efo5k+zEeLm1Vs4UAWiCdaiCqwr4itEjAwT0D6RskMc/BwIshJKGvXSqjyM+icQTHC7TYE1wrnGhOuFeebG+HBSaMJ8Kfemhg7KG9ZLe4Hl3W6t0wDz1rHIgXWCmXpHiheBgLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIKNwS0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D03C43390;
	Sun, 24 Mar 2024 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321428;
	bh=UcRpu7p1jKQyG+pfEXtk4kRecvA2V6BI+5dODNtRxC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIKNwS0M3m02bpBbeWmg3P5pvIsC0zYwq2gtzfhXSDR5GdUOMrL1yRHZzs+jNeUPn
	 OAybEgl5PqMMCwpUSMxqSGuEmH51HOxzHxWBYVhDazz52hGww/7KKFf2qs4dzoZsrC
	 cnDEGC8aCR9HoSof1rD9gmxHY/MemtI0rp9mxvL5xLo0TerDcJNgaDUn2LwYPD6k0w
	 LAq4ZvXXMVF/KjAEfIaXmTQtW55sJ0Io1chuDapW65oAKQ2fL2XyVGAWiD+qNGWEBm
	 jWzleSDcmWpi2rX9zkTOD48c2Caevva+z76e7AEhh431HTd7C3KezdsBDHloYb5KKa
	 7tGkV5HztrVrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 152/638] arm64: dts: qcom: sa8540p: Drop gfx.lvl as power-domain for gpucc
Date: Sun, 24 Mar 2024 18:53:09 -0400
Message-ID: <20240324230116.1348576-153-sashal@kernel.org>
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


