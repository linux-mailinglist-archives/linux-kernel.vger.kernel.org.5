Return-Path: <linux-kernel+bounces-114117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99578888889
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D00287616
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11CD23DC71;
	Sun, 24 Mar 2024 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6agTLF3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA414131E41;
	Sun, 24 Mar 2024 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321423; cv=none; b=iVCEVsOCv3RkCfukpwEwATfvypzIpTwUnCjoU7OlajMAVFmj3EtDD6qZY7sbMkV07sli1tq1qqJF7hsyQ5hYXUv5Op0hswHgpVUgBYOmzXSmK56MGx4PiNjrtmSP8aGhL188vEfrlE3UjrHH3E7aSGEECR3GQrNVmgJvE62pIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321423; c=relaxed/simple;
	bh=oAa4yi03u1UrSreAkt5qZ+unRgWT5oJHZu69BduOjac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkaZTefodnSG9cZ0lgTzRyphlm2EYI3oWWJSWqJo3186Sxbz33G3nmPBKp8Q+euUMSlmr/9ScE7SeHGXD7jrODjrb058tzUnR0v38GW4PR/tFPdzzBdcY/7xnnZ3Pthz13JiNlywDpyMg34WF8ilJUUSXIJGdbDtwD+9ypLt4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6agTLF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48DBC43390;
	Sun, 24 Mar 2024 23:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321422;
	bh=oAa4yi03u1UrSreAkt5qZ+unRgWT5oJHZu69BduOjac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6agTLF391x/MTZjYRchcm0RW1o+mJpEMQ1NuYf5mYDkuQXRer07N2s4rnP350d1r
	 6U6zzTGZqdoVYmwJXzAWzIVSCLTjwq/q+6tUhOImZe1UyO1rZmMX/i98FGMbyG0EBH
	 GSZCgkSME5E6HNc3ZSOjh97bi5gzN/9XD6sr4zH4bMx7icv4ptG8KVm65K+ocF9TLI
	 4Y74ZPHSa5ltOSjCzvNCJmg10Eq70mtdHihuAO2/mTPY1VnMzrzx4T0jblYkQXfaYl
	 YmWobhaxpVjj9we+4hv/HbPSoxRVQDkT4QUWNp8EFPOkUoB+YM4xtc4O3UidCJ3opM
	 rshw0DvBw2rMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 146/638] arm64: dts: qcom: sm8450: Add missing interconnects to serial
Date: Sun, 24 Mar 2024 18:53:03 -0400
Message-ID: <20240324230116.1348576-147-sashal@kernel.org>
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
index 91d856e5b06b5..0fc25c6a481f7 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1025,6 +1025,12 @@ uart20: serial@894000 {
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
 
@@ -1417,6 +1423,12 @@ uart7: serial@99c000 {
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


