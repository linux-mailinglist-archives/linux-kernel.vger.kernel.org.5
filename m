Return-Path: <linux-kernel+bounces-124497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A18918EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1701C24A36
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9955513E88D;
	Fri, 29 Mar 2024 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwaxTKU+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11A613E6C9;
	Fri, 29 Mar 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715241; cv=none; b=duyU9apJbefCKsSWput1No2kiiO35QWHT8g+v1MU52YiOb3/JLV+8gjUqvT9LQrqVrw458dZSMT7umYfvAsFMc19hjqEGt6lp3sFSovFAr8PQSMTM7d+sAf9yrwS4TIBsZPq7NGhxVBjDp/PFH3tZFSbkA4X9hOdiOonnfUNdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715241; c=relaxed/simple;
	bh=Piir5zdi43LZWoQqSdPcDuK62iZcCKEBs+ueBudT8Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USfs0+3wMHwWCKjBOJMsuNJFE1aFoDNnCdvsDClb6hiSi2UO4BRkbKTpYdrsfX/gugMNbbyOCIlKYxkPkmKCTk3AJFbtcg1RGE8QmrD9ejMtq9+E/GDM8swhO4ivCscxh6wRyuV5zCIVMuhD9JV9AC2bwUfUv2KNWnFN24cKpVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwaxTKU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FBDC43394;
	Fri, 29 Mar 2024 12:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715241;
	bh=Piir5zdi43LZWoQqSdPcDuK62iZcCKEBs+ueBudT8Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nwaxTKU+bBcW3b6BAnQdSwA5kRCw2J0+ZjgG2eEpYlMOTttdb2YAiIdWgZwMFFfJK
	 roOIiLgGpRSd1XB69x1GwihDFoqZvU1bubNgcZ70jMjV7PL3m1Y2oiLH1taBkHDqq5
	 wwScuAs3Dvf3QhIDBIskusMJqZSQxT4bysGI7EdnJli9mfSkz9jVfEwKyz1OJCl+gN
	 7v4FTFSm5ifWAr2l6/LU1n6dciomSo/jR6jLMuF1PpKbH06gDjy+Gt+fKClS34lzR7
	 8x/lNdIFNuvS9mSsUGaswowf/rxQJdHgd3xZAU+D1y27EJ7EyuzSejyI81h93F8dcw
	 WXai6egDk+YKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 16/68] arm64: dts: qcom: qrb2210-rb1: disable cluster power domains
Date: Fri, 29 Mar 2024 08:25:12 -0400
Message-ID: <20240329122652.3082296-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 7f492d48f08207e4ee23edc926b11de9f720aa61 ]

If cluster domain idle state is enabled on the RB1, the board becomes
significantly less responsive. Under certain circumstances (if some of
the devices are disabled in kernel config) the board can even lock up.

It seems this is caused by the MPM not updating wakeup timer during CPU
idle (in the same way the RPMh updates it when cluster idle state is
entered).

Disable cluster domain idle for the RB1 board until MPM driver is fixed
to cooperate with the CPU idle states.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240130-rb1-suspend-cluster-v2-1-5bc1109b0869@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index aa53b6af6d9cb..9a0308ef8b0f8 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -177,6 +177,24 @@ vph_pwr: regulator-vph-pwr {
 	};
 };
 
+&CPU_PD0 {
+	/delete-property/ power-domains;
+};
+
+&CPU_PD1 {
+	/delete-property/ power-domains;
+};
+
+&CPU_PD2 {
+	/delete-property/ power-domains;
+};
+
+&CPU_PD3 {
+	/delete-property/ power-domains;
+};
+
+/delete-node/ &CLUSTER_PD;
+
 &gpi_dma0 {
 	status = "okay";
 };
-- 
2.43.0


