Return-Path: <linux-kernel+bounces-3890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755DF8174D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1610E1F23438
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859653D540;
	Mon, 18 Dec 2023 15:08:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7433A1C0;
	Mon, 18 Dec 2023 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.118.189.58])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id DA56B80011A;
	Mon, 18 Dec 2023 23:08:08 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v3 1/1] arm64: dts: qcom: ipq6018: fix clock rates for GCC_USB0_MOCK_UTMI_CLK
Date: Mon, 18 Dec 2023 23:08:05 +0800
Message-Id: <20231218150805.1228160-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSB9PVhoaGB9OQ08ZGB9LGFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVKSkNVSkNCVU5DWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8c7d785c48b03akuuuda56b80011a
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kz46SRw5OTw5PygCATxOTVEX
	GBcKCz9VSlVKTEtJQkpJS0NCQ0lCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSkNVSkNCVU5DWVdZCAFZQUlPSkI3Bg++

The downstream QSDK kernel [1] and GCC_USB1_MOCK_UTMI_CLK are both 24MHz.
Adjust GCC_USB0_MOCK_UTMI_CLK to 24MHz to avoid the following error:

clk: couldn't set gcc_usb0_mock_utmi_clk clk rate to 20000000 (-22), current rate: 24000000

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/commit/486c8485f59

Fixes: 5726079cd486 ("arm64: dts: ipq6018: Use reference clock to set dwc3 period")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
Changes in v3:
* Update commit message and add reference link.

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 2399d16f147e..d114c8096347 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -621,7 +621,7 @@ usb3: usb@8af8800 {
 					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
 			assigned-clock-rates = <133330000>,
 					       <133330000>,
-					       <20000000>;
+					       <24000000>;
 
 			resets = <&gcc GCC_USB0_BCR>;
 			status = "disabled";
-- 
2.25.1


