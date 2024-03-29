Return-Path: <linux-kernel+bounces-124494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA828918E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A07B1F22913
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAED13DBB3;
	Fri, 29 Mar 2024 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrDLlLQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600413D60C;
	Fri, 29 Mar 2024 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715235; cv=none; b=pAgL4iDtog1CPyUXVms6om0JLYJTUhQFWtGMlVjJBgLWe81vFSYTFqsHcAV3c4nuQ7locT+obbpvAf7wVn/OfNm1q4yUBihy06gymJTPIZn2BV5XCtTYOFzalRx+WPpXit0GiEViUBkZkPB55x4fLarF/yytvw4VGv0IMMHoJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715235; c=relaxed/simple;
	bh=C+Hlu2wyx3m09ioqAbE2t7oSm9alsY9rzaHbSgW4ENw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMEGcGxk4zXcTnNGQ+W9np3RJxLQOzkSfQ4V3/G2TvHOC/5b7eeA67/EAFWWBmx9HZO8eiEnz8zJud4zx15kCAkVcm2yTStpGN5CVwp0XjIyXFzP2+FdW7YpUXfoywHB+VNIowZf4tKszMHA55wdyt7061jsQTGCzSQwiB+coFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrDLlLQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD480C43399;
	Fri, 29 Mar 2024 12:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715235;
	bh=C+Hlu2wyx3m09ioqAbE2t7oSm9alsY9rzaHbSgW4ENw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrDLlLQSBUJ79293oXW+B5PkIw3auORhXCxaYFezUPfPlAQymu/1d9dS3ZpCnmKFc
	 V7ZKk37EoD8WHKgjFfy+r/wPk3nTZ+c7ll4XcSPvnZX/4nwy3LcVsF9zIJSw6uNe07
	 PDW6BdnlIO9RQOHEc0QG5Elo4LVVqU22FqimOaXPIUnbzuTnpDB0C/KNha/S+eioga
	 i25dPfXlIiDrTp0WICdL42vVqXg9hXfKCe/KAw0jmwn6Ho3mjGWRlk1H/KyZocSEwa
	 zz7KKEZRq7lF7aheRbHd7rTURWYmNQ0aiGkyZcZzh3hlTGroGOg4U/C7ozriPNI84C
	 ja6/25Ip6TeSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hui Liu <quic_huliu@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 13/68] arm64: dts: qcom: qcm6490-idp: Add definition for three LEDs
Date: Fri, 29 Mar 2024 08:25:09 -0400
Message-ID: <20240329122652.3082296-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Hui Liu <quic_huliu@quicinc.com>

[ Upstream commit 8385383cc2c2f7039ecc57864043112cdc7026c7 ]

Add definition for three LEDs to make sure they can
be enabled base on QCOM LPG LED driver.

Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240126-lpg-v6-1-f879cecbce69@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 03e97e27d16d4..b3853fba5c3c5 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
 #include "pm7325.dtsi"
@@ -415,6 +416,33 @@ vreg_bob_3p296: bob {
 	};
 };
 
+&pm8350c_pwm {
+	status = "okay";
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.43.0


