Return-Path: <linux-kernel+bounces-46212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2FD843C57
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE89EB2AF59
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2631B79DBA;
	Wed, 31 Jan 2024 10:20:46 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238C27691C;
	Wed, 31 Jan 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696445; cv=none; b=X4qFLljcLPn9WnYXJGBp9Me9rdCUMkMI5Df4lWE7uHrUTCous2UjD+06B8/PBuIpBIB7aUwYwSRpiAEszl4EQDX72az/2R7Dx34SIY3w/1UpBAYH19vXL51ejLIzkpQKuTEUSMCvCZ+AIMYF132b5phQX33E5nQYkmmSmL0lShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696445; c=relaxed/simple;
	bh=/iB53CvDFAY7qn7PsG267goK9x5YCww3JuxRgNYOupg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=st9ggo1wT6qId7S45qNhohu2x06b12CEvZA3pdwJFYjuDy+xo30yjp6ecK0GZIHVcqoCG3wgmDtJm0AWY1PvNdlMKn2kn/nxghm8dtCHNC7VE1pHC5TK7wiuA5uVVyOXE289J/jB5F1e7VPvnrvnx+b+p5vNuwGGlZh1uVaEnig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [116.25.94.16])
	by smtp.qiye.163.com (Hmail) with ESMTPA id F3BA77E0144;
	Wed, 31 Jan 2024 18:20:23 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 3/3] arm64: dts: qcom: ipq6018: add CPU OPP tables for 1.5GHz
Date: Wed, 31 Jan 2024 18:20:03 +0800
Message-Id: <20240131102003.2061203-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131102003.2061203-1-amadeus@jmu.edu.cn>
References: <20240131102003.2061203-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSx0YVhlDTxlPTRlDHh9JHVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKTVVJTlVCT1VKTVlXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8d5f08bc3603a2kunmf3ba77e0144
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mio6Ayo5TDMJHE8TMU8VAU8c
	Ew0KCyNVSlVKTEtNTUJNT0lOS0hIVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	TVVJTlVCT1VKTVlXWQgBWUFJSUhDNwY+

The IPQ6005 and some IPQ6000 SoCs (with PMIC) have CPU
frequencies up to 1.5GHz, so add this frequency.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/qcom/ipq6018-opp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-opp.dtsi b/arch/arm64/boot/dts/qcom/ipq6018-opp.dtsi
index 9c0bed2d8bf5..a0d53588f298 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-opp.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018-opp.dtsi
@@ -37,6 +37,13 @@ opp-1440000000 {
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


