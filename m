Return-Path: <linux-kernel+bounces-30155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E69831AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E72B21E94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01DE25569;
	Thu, 18 Jan 2024 13:31:24 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135D250EF;
	Thu, 18 Jan 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705584684; cv=none; b=JrwN8ZEfiaX+r/3Odvjg0hSBi7Gvhf2aOrnEyVmVarSvPRhjwSbP4/04EzHU4QbfQLOgTOqAzy6fqVkjxtdOscw7ZEt2Ne2H3SoEIC++orl8YP9XV8HYCpPLi7mIbilE68ZHD2IjLwHKmjwc8oE0XApoDLN5Yids8wqPTX7Zro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705584684; c=relaxed/simple;
	bh=YCSLDRcNcUHZlJNPEpFCiUHc+hOkTwgbBxDfzJO2/IQ=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-HM-Spam-Status:
	 X-HM-Tid:X-HM-MType:X-HM-Sender-Digest; b=o9MkWdVQcetH/LlWGMNoYfRa11k5HVIefO5jp/BqtbG0zvSU2aAB6HLTBQEJV01SmAcC+HvNtTSv+zROk3BhY7gEeRORIO9ITLx3vQMNZWDXffgp0fyC88l9pCAge0U5JlPN9Lp24k9gT1+EbLl3r6y8laJJ/gIx0dv7a2Grz9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.118.189.0])
	by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 48E0DAC009B;
	Thu, 18 Jan 2024 21:30:28 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 1/2] arm64: dts: qcom: ipq6018: add LDOA2 regulator
Date: Thu, 18 Jan 2024 21:30:21 +0800
Message-Id: <20240118133022.553339-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240118133022.553339-1-amadeus@jmu.edu.cn>
References: <20240118133022.553339-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGk1CVk9JQxkeQ0JDSU9PH1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVKSkNVSkNCVUtZV1kWGg8SFR0UWUFZT0tIVUpNQ0xDS1VKS0tVSkJLS1kG
X-HM-Tid: 0a8d1cc41355b039kuuu48e0dac009b
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mi46LSo*TjwqOhcCSRANNRMJ
	ER4wCjpVSlVKTEtOTkNPTUlCSkpOVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSkNVSkNCVUtZV1kIAVlBSUlKTTcG

Add LDOA2 regulator of MP5496 to support SDCC voltage scaling.

Suggested-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 5e1277fea725..322eced0b876 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -174,6 +174,11 @@ ipq6018_s2: s2 {
 						regulator-max-microvolt = <1062500>;
 						regulator-always-on;
 					};
+
+					ipq6018_l2: l2 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <3300000>;
+					};
 				};
 			};
 		};
-- 
2.25.1


