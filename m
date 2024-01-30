Return-Path: <linux-kernel+bounces-44669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A691D8425B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4683B1F2E611
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D7A6DD02;
	Tue, 30 Jan 2024 13:02:07 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42B467751;
	Tue, 30 Jan 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619726; cv=none; b=XUYQ9lhaK9uyYrg8kYVUCd+LUJImpdgihERtMa+WOdABWeKFFkw4u116rlScgZH9xTa3v7y7UZkdCRy10R3hnfpVDlq2az+RGWqsMEQ0GDe4ID/tmUDGk4cEzTX74x/C+rGbkS16b1l9CPaH+YjWKVvIZU+Uvlus9NoNiNGWYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619726; c=relaxed/simple;
	bh=YCSLDRcNcUHZlJNPEpFCiUHc+hOkTwgbBxDfzJO2/IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dr4QqIxcigWLrBDlMBD1vLOs8t/GjVlc403uBK/8e7eSrL+1ecuT5FlmkXn1MM81fRgRtLwYcgxE4umAhZgk4oQ7Zq46+Xdd+NdqDhx40C1eosji/1Gij1c7XGlhZXS5vbiKVfO01gRpF6j0ZbcS8RaBVBC7u2EN2HjM6n8ng/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [116.25.94.16])
	by smtp.qiye.163.com (Hmail) with ESMTPA id EC4187E0137;
	Tue, 30 Jan 2024 21:01:41 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 1/2] arm64: dts: qcom: ipq6018: add LDOA2 regulator
Date: Tue, 30 Jan 2024 21:01:31 +0800
Message-Id: <20240130130132.9550-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130130132.9550-1-amadeus@jmu.edu.cn>
References: <20240130130132.9550-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQk5IVkgeTUxKSRlIT0hIQ1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKTVVJTlVCT1VKTVlXWRYaDxIVHRRZQVlPS0hVSkxKT0xDVUpLS1VKQktLWQY+
X-HM-Tid: 0a8d5a760cef03a2kunmec4187e0137
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTY6Lio5AjMNEEoeQwwBExML
	DCwwCktVSlVKTEtNTUpCTEtJQ0NNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	TVVJTlVCT1VKTVlXWQgBWUFJSUtPNwY+

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


