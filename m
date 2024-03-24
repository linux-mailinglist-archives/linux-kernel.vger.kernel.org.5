Return-Path: <linux-kernel+bounces-115424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CA1889B80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D6029ECC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B1920AF9F;
	Mon, 25 Mar 2024 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7QMaUtJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699211D7917;
	Sun, 24 Mar 2024 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320604; cv=none; b=NkmQnsowV54LNvnvxEEEPVfVWZZzQCAJcpSK4oseFdhtsxP88sBaQEPdosAPHm2lyqjANsCcVpyo6uf3t6/DkiEusp7j+o490tYPfhOVWf6qUD7ORWZ4a3SMekr1fcfURfKp4TEUmo+bAy9xLSTro7BMpiUZDamTU3vj4SqVWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320604; c=relaxed/simple;
	bh=90XilqNwKsvj6KfNoaZh4D0UAY+EEfN938ceSpFwJeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcuHFlVEfxddJn29sa6oSwYzHxNGowZ772xNMOvLgSxTY+1CqtHux/aJtLdEYy+4KL2b6l0SifrflH+ixEJGhFBVTr2Tt82VlwY16yg1sdWmh/fN5bxD7DEqNrPiA5metpeGPyRs6qijSjjegcnlmIbfHjR5uqYKR+7aEE/oEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7QMaUtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798B7C433A6;
	Sun, 24 Mar 2024 22:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320603;
	bh=90XilqNwKsvj6KfNoaZh4D0UAY+EEfN938ceSpFwJeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7QMaUtJ7jRGEr4yVYnBve39E5pQWg17FliMGoxA4o7XIEPUF9NPH5x2SHY8rsYf9
	 Ke/HQltUWq8sntKWcrkOvGIF8hng9tjrfSDJ5rR2dMFv7I20rqPi/m2d386O8T4mhr
	 pRSqlV0aSh0MAsIv/FVEr0B5eID8TYJc3PphMNq1EnVw5cDxn3RGTrM/6xmHYFnJng
	 yjFT875Dnr3owccQ4vu69IlfKt2zYj5t4oI7iXPxifIFdrKN14S5As2CWRCscwE6p0
	 yw04jTUXk0OOlkUqF+WN0zxnTnByYOiqYmapiRj01JzfCG4n9nI5JNABTlIWKERAvC
	 RUlko8LLqza0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 164/713] arm64: dts: qcom: sm8450: Add missing interconnects to serial
Date: Sun, 24 Mar 2024 18:38:10 -0400
Message-ID: <20240324224720.1345309-165-sashal@kernel.org>
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
index f82480570d4b6..9d06fb0d4d1fd 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1026,6 +1026,12 @@ uart20: serial@894000 {
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
 
@@ -1418,6 +1424,12 @@ uart7: serial@99c000 {
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


