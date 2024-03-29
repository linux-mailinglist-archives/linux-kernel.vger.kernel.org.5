Return-Path: <linux-kernel+bounces-124487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBFF8918CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA391C24468
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5A28565D;
	Fri, 29 Mar 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXxJghGH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD713AD05;
	Fri, 29 Mar 2024 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715223; cv=none; b=AelIy9cG0cBVa7M4IwfIXe62xlKsTKvhb/0W+PmxbIi2MvZATiT+MDiFQVGvqGiyPk2J7q9y9gRBj95KGWTgFQORAts7EBi85uk1hc76Hk4uS0U4r7ECewPm141U4t5Wp+RriezKUy1Ol+O+LWteI3r5cJU3w22wRlmB5QU5yQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715223; c=relaxed/simple;
	bh=yYW3e9AMlBSHzJkJoAc0wxNP8CWlh2H0TvfQaDrp55A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4rJUWArS+2qMZtg8C2ZsWbRFd8NuVj+acTccMVDWpuP5JX9n8BZn+gDIzpkCXr1IhilUvSEv5IM5ofPt2LE51Ml/AOIRUmGfh04+31Ojecb7uyCKDNsMcZmuItGIIlfN5ZjSUzvDDnXjYmmZk8bnoZTa95N9PEH5+tql6qN+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXxJghGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F79FC433B1;
	Fri, 29 Mar 2024 12:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715222;
	bh=yYW3e9AMlBSHzJkJoAc0wxNP8CWlh2H0TvfQaDrp55A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXxJghGH2W5rbKkNruipQRBpr5ictEUbYNEByeaYr1t3bDVTLUm3PcsLiPavlfVLT
	 vUMePDSFaQVtEtT0yK1oVb7rvz7fg5vlwpaPiIQ6d0M4F1DJcIofseqb4y+PqgWeEN
	 PGLRfX8SjxxzRi5Zei8GEaOmV0Inal3D4PDCLsmJbwmvSrJAtHB9WQHTyoAjlI8b9A
	 HkNIe6SqKLfQ4QvhD+PpgvqyM1ZNPk2mDRmOU/SuVNCcRIePLW5F0eADicIbw2yTHU
	 0K7YPfw1kTgUC5BxLpyRhmKI1MRc+pzi3FOqQnmSvHaLT8rXw4P8iqtlZUD6f7i6E/
	 SWt1QYjaKG4UQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joe Mason <buddyjojo06@outlook.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	David Wronek <davidwronek@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 06/68] arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
Date: Fri, 29 Mar 2024 08:25:02 -0400
Message-ID: <20240329122652.3082296-6-sashal@kernel.org>
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

From: Joe Mason <buddyjojo06@outlook.com>

[ Upstream commit 6016fb7c91f72f4afbb4017e13cd91954d0f1a9b ]

Add a device tree for the Xiaomi Redmi Note 9S (curtana) phone, based on
sm7125-xiaomi-common.dtsi.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
Signed-off-by: David Wronek <davidwronek@gmail.com>
Link: https://lore.kernel.org/r/20240121-sm7125-upstream-v4-8-f7d1212c8ebb@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/Makefile                |  1 +
 .../boot/dts/qcom/sm7125-xiaomi-curtana.dts      | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 39889d5f8e123..2e6984bbbb836 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -210,6 +210,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-curtana.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-joyeuse.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts
new file mode 100644
index 0000000000000..12f517a8492c3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Joe Mason <buddyjojo06@outlook.com>
+ */
+
+/dts-v1/;
+
+#include "sm7125-xiaomi-common.dtsi"
+
+/ {
+	model = "Xiaomi Redmi Note 9S";
+	compatible = "xiaomi,curtana", "qcom,sm7125";
+
+	/* required for bootloader to select correct board */
+	qcom,board-id = <0x20022 1>;
+};
-- 
2.43.0


