Return-Path: <linux-kernel+bounces-124722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E633C891BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DB91F25123
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862CE17798C;
	Fri, 29 Mar 2024 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpmibIrG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE8176FD5;
	Fri, 29 Mar 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716012; cv=none; b=ifgCIWpAhbsZ2wXKmE6jUYRT2CEI5+HaSCby1bAsfzXUFNsBzjPptQLbg8KMQmo8hVS5uNcpOojRV+8wJ8Yv9S7+8uPVhX971nYVAyd4WBLQur9WTwQccfeBGvXTcaFZj8kf4OHyFp3gWb27nI5ZNmkAOr+Hs8ax9SqDeutDp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716012; c=relaxed/simple;
	bh=yYW3e9AMlBSHzJkJoAc0wxNP8CWlh2H0TvfQaDrp55A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDwcF7fEpYPgZYUqXvCRpqx21FnHoJQnVxsRXKS6ORvalTwrMfunsli9KQz1gHwr233YtRXEugBqouIDuxjf/UUf3DgyAJ7cRf1KbI0f2ayAs9jP1NDlfI7nSD/+2cs11mDlhsxermC+kb/hkpu9x6QYXcKZp+SNTAkuLXRZNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpmibIrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0187CC433F1;
	Fri, 29 Mar 2024 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716012;
	bh=yYW3e9AMlBSHzJkJoAc0wxNP8CWlh2H0TvfQaDrp55A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VpmibIrGaOUJlSEp00zkhIGa+lNBIPLNwweQb9uxW12QKVIykGrg/NKlvYO05p4Wc
	 IBgCaaIii7h91Yy7W4zomSpUy3Ca7jwwBBtc4ji0vs2MBJ9rUzJWT4J5u3RCK8Fg7a
	 DIVDutVqYDM5DS290P9zHTffWHOQi0vDIEYbHOz4WjmMyEcWqBSzL/+MmpgwnFXniM
	 JnK6MhNcx7rSXX55EQ0BH8OHWJWlNONAXhBt0VPURfdw1r0cwh25Abxe3rkOY7aqlp
	 tJkvUBCL1WP+q3/dz1A3/TrBuJN2JORmTlrlG7ACzibv17ykEt/I+RVCEDTP2l1O6m
	 8VCmA1m2/34tg==
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
Subject: [PATCH AUTOSEL 6.8 13/98] arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
Date: Fri, 29 Mar 2024 08:36:44 -0400
Message-ID: <20240329123919.3087149-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
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


