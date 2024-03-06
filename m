Return-Path: <linux-kernel+bounces-94010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A5873842
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA9AB20F06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5915413328D;
	Wed,  6 Mar 2024 14:03:58 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED2B131747;
	Wed,  6 Mar 2024 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733837; cv=none; b=jddOGTfCEQxhYJOoPrZ7uDjGPG3Lj0ENp/R1UNYeN24nIdefbIhctKe2FQhWGbflZeUP+90+QeuXjps2/ffFRK/Pk4dB8kcW27K9/HmluD5c35s2AJdvJDlUPfM++INssiSsJupw9/+uqNwUj3T7xjWwg9aUrO8sf/ebWRzp76E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733837; c=relaxed/simple;
	bh=itKQ1vPsAiynFvJF5JgG4Ou1J1T37F0iPQXd/ermgi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jVWpkPhz9VH8hctmmizdQ6MvVsRtlJXgiRdZGqkBGetidgsSXHj7Sume4bDFaUkbTBloPrCaEkm6nOoBZSi/27lGFZ+yjZ3zTLhaT+psxIUY3Ik2OelSDEZsffv7MYtCmKuarBeYzanDOvWN87EqEyKwNlvFN2OEYnWv70MXYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4970:eaac:ef59:d8ae:5dc6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 5CAA17E012D;
	Wed,  6 Mar 2024 22:03:36 +0800 (CST)
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
Subject: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU Frequency
Date: Wed,  6 Mar 2024 22:03:03 +0800
Message-Id: <20240306140306.876188-2-amadeus@jmu.edu.cn>
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
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT00aVkpMQx4aQx5PTBkYGVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8e1413a90403a2kunm5caa17e012d
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OVE6Pio6VjMOSEMcNkgLCRc9
	LjIwCj1VSlVKTEtCTEhIQ0pNQkJOVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZCAFZQUlKTE03Bg++

Some IPQ6000 SoCs have CPU frequencies up to 1.2GHz,
so add this frequency.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 4e29adea570a..7fdb119083a2 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -119,6 +119,13 @@ opp-1056000000 {
 			clock-latency-ns = <200000>;
 		};
 
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <850000>;
+			opp-supported-hw = <0x4>;
+			clock-latency-ns = <200000>;
+		};
+
 		opp-1320000000 {
 			opp-hz = /bits/ 64 <1320000000>;
 			opp-microvolt = <862500>;
-- 
2.25.1


