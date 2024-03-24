Return-Path: <linux-kernel+bounces-112982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB8888040
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F69A281634
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8012CD8D;
	Sun, 24 Mar 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0u4BKhK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED112C807;
	Sun, 24 Mar 2024 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319795; cv=none; b=AasJcyM1JwcYg9f/1ncGNlc/XVJRV8u9t06F57YqUH+rsObZdaRtNTAR4z/ZcU7N9xzxcxDpxb/e6xptJVQIR1zhekfxT21Rlpnach2RDy48KdoCZyaBXT9EHVh/PEm3V6rWReiCAs53C6p0dbJ2UenQHdAdap022RhOZFTglgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319795; c=relaxed/simple;
	bh=Blzv/RlEZdknSh9LaT2pxEkZECzLDfUTOqXdqZrDiug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XO00UBJQMNEolIt4ko8WQ1NFPcADDuCDhkC70JUqRF1piHG/4ijh3f49QVMtlxg1bqlSBwdjPkwFlLkupGr/uveY2rwGSjAbSZQc0Tj8FrvexnNPb5INxxymnoNLc4ZPTCK22hd/f0CFldNIeTdDgRxPfHEVq5o6BQhK/5fK/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0u4BKhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F94C433F1;
	Sun, 24 Mar 2024 22:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319794;
	bh=Blzv/RlEZdknSh9LaT2pxEkZECzLDfUTOqXdqZrDiug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0u4BKhKGD78YF3eeZYZsKWubarnKhZ568PPDTWm+WFrCipKhi383pQNwWztdd6qv
	 5Pq95kPQ+zwNjAgP4O0Td6UfEJP4eA2ZIggln0g/sdaDws4SwXOmys62Dxx6HqU5Eg
	 a4k1iohEKxziEEgRIgzskzKO9wSdkPZ3It2ohod1bFl7wN6i5DbvVIetM3Ze5Vr5YJ
	 Yp8U0QeAzuZJgiMSRrH7KNvL/vIS9ihjBFBYt+BKYp8Y1Y/m1oSiZs0QJrAGBAkTbJ
	 /d+IjdGI0yHedycYURcd2LPIFkSEXVNG6/gODWRC4o053B+X/R0mDrTQ50ugTFmIL3
	 85+AeHiX6ByiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 095/715] arm64: dts: qcom: sm8450: Add missing interconnects to serial
Date: Sun, 24 Mar 2024 18:24:34 -0400
Message-ID: <20240324223455.1342824-96-sashal@kernel.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 6e115b75b43bd12d4061e53c8ff175e387783d8a ]

The serial ports did not have their interconnect paths specified when
they were first introduced. Fix that.

Fixes: 5188049c9b36 ("arm64: dts: qcom: Add base SM8450 DTSI")
Fixes: f5837418479a ("arm64: dts: qcom: sm8450: add uart20 node")
Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Suggested-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240116-topic-8450serial-v1-1-b685e6a5ad78@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 01e4dfc4babd2..06f183ef8c78f 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1028,6 +1028,12 @@ uart20: serial@894000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart20_default>;
 				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				status = "disabled";
 			};
 
@@ -1420,6 +1426,12 @@ uart7: serial@99c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart7_tx>, <&qup_uart7_rx>;
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				status = "disabled";
 			};
 		};
-- 
2.43.0


