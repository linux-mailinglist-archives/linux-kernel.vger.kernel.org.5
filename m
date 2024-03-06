Return-Path: <linux-kernel+bounces-94012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED3F873848
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFCA2847BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E52A134751;
	Wed,  6 Mar 2024 14:04:00 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645613248F;
	Wed,  6 Mar 2024 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733840; cv=none; b=eGYrk359E8qxZ7aOMf/GZxpRWoZjklVdiff1ulYAVlT7Mr0rySG8opdYFxDgwc6YUqrRJw/YLzC+rHSMwzrfE2WTwzAqUHimyzlGdE1UClrbd55iHV3FK4sMrriKVhPlch8OGxJ0cNZBkjdHkmPQT733dFvpgb0jSY3nfE5PzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733840; c=relaxed/simple;
	bh=L64mzeVNFc5OsAcWRE5Ix+mgIBf8QZHe+Pr/czduqRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5yyAEcIk1ElusAW3IbjZQ8j+ZXIcQ4TRERMVG+0wre4XqqoHdZqv2Fi0JGwBZP8r7wSBHGvn64+blfv2TgF8VgA31zCdUuoKme8ZzuHz/pTAl8ENUYU+7XnwJJA8u43P/oLU5uJc7ajo3F651YvDS01goNuz7WC9yrfXilqDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4970:eaac:ef59:d8ae:5dc6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 16F147E0132;
	Wed,  6 Mar 2024 22:03:38 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 4/4] arm64: dts: qcom: ipq6018-mp5496: add LDOA2 regulator
Date: Wed,  6 Mar 2024 22:03:06 +0800
Message-Id: <20240306140306.876188-5-amadeus@jmu.edu.cn>
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
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTx9JVk0aSEJDTUxCHxkdTFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZFhoPEhUdFF
	lBWU9LSFVKTEpPTENVSktLVUpCS0tZBg++
X-HM-Tid: 0a8e1413afcc03a2kunm16f147e0132
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kzo6KSo*HjMPA0MZGEgoCRI1
	GgMKCTJVSlVKTEtCTEhIQ0pDTUtMVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZCAFZQUlISU43Bg++

Add LDOA2 regulator of MP5496 to support SDCC voltage scaling.

Suggested-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi b/arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi
index 841fd757bee7..9910bec8a70f 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi
@@ -9,9 +9,18 @@ ipq6018_s2: s2 {
 			regulator-max-microvolt = <1062500>;
 			regulator-always-on;
 		};
+
+		ipq6018_l2: l2 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
 	};
 };
 
+&sdhc {
+	vqmmc-supply = <&ipq6018_l2>;
+};
+
 &CPU0 {
 	cpu-supply = <&ipq6018_s2>;
 };
-- 
2.25.1


