Return-Path: <linux-kernel+bounces-94008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E5787383A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD7C1F247EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9327913246F;
	Wed,  6 Mar 2024 14:03:57 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B877F0C;
	Wed,  6 Mar 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733837; cv=none; b=XWysYR5goyZ+y6CJtj4eflss84oLwQnNYty5INfTpivP/IaUC9+tsftzFgTwjSWoE1JAYEAExr4EOK3cnMU+hOsNilRGoQEyaeGHzwUlcUpENrP13ecmC4/AgOH1KEXs16ftiiZLMHujeptnq5yGuqzfou6Qn7NgRoVSICOP96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733837; c=relaxed/simple;
	bh=anpftgLDkV1jZFzQS+l7zTrjOB97FhGgXOiOa+mrjaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L/9FJ6enJxvaqx0rCUSt4wgQmquOQsuH3nirkgBy0klTciy4imW03X90QJZvbmHqohlUC8MugCNjKNxfrpfDrFOBxQ+1xW3XqkzzlYbA55nuQWt/yKSAq1gCLQUsq0jDeoHbJ5BVLPqxCKJ19d4I6WyBtPRGlfcNEjE0Sni6x3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4970:eaac:ef59:d8ae:5dc6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 0B7DE7E0102;
	Wed,  6 Mar 2024 22:03:37 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 2/4] arm64: dts: qcom: ipq6018: add 1.5GHz CPU Frequency
Date: Wed,  6 Mar 2024 22:03:04 +0800
Message-Id: <20240306140306.876188-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306140306.876188-1-amadeus@jmu.edu.cn>
References: <20240306140306.876188-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQh9NVktISkhOSE5DGU9ITlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZFhoPEhUdFF
	lBWU9LSFVKTEpPTENVSktLVUpCS0tZBg++
X-HM-Tid: 0a8e1413ab9e03a2kunm0b7de7e0102
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Myo6Hjo6KTMSVkMRNk4oCQ8D
	LD4aCQJVSlVKTEtCTEhIQ0pMTkpMVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZCAFZQUlJS083Bg++

The IPQ6005 and some IPQ6000 SoCs (with PMIC) have CPU
frequencies up to 1.5GHz, so add this frequency.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 7fdb119083a2..064b5706a289 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -140,6 +140,13 @@ opp-1440000000 {
 			clock-latency-ns = <200000>;
 		};
 
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt = <937500>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <200000>;
+		};
+
 		opp-1608000000 {
 			opp-hz = /bits/ 64 <1608000000>;
 			opp-microvolt = <987500>;
-- 
2.25.1


