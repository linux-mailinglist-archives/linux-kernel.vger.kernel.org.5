Return-Path: <linux-kernel+bounces-866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F72981473B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921061C23251
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB4E2556D;
	Fri, 15 Dec 2023 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UixfFdht"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD325115
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so2816195e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702640755; x=1703245555; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9JhELWJ0W9NFLq+9Rk9JL6k3c2c7+f6wthL7iMiCLTE=;
        b=UixfFdhtIdxkQ3LkugI3dsm1GTwCMrVUO3/3S/efIBZlXb8as9p/Kji5kQ58LIPOne
         RWbDIZtSr3KhqFea1YyQqFTE7qxUMpLLHUTQNdz0h65vdBgmXrglp0R/o8rg17HkIwlh
         NtiMhszQ+EID0nxwgZIT6FTIJyLijQIv/lyzdpq2H2Mg9CVqBxgeuhL1IKZmUiE1VvQN
         8af/7G4zn+rKQzLaxAVEmgEVGddoiqPvjip+Up0ZkPaZa3359uVJs1c3BNRu4+eoI7on
         ZuHG/G7hSRle6YR81OQkHmMdgOT5Qn+yuwe8N7r7KetG2zVuf5S4rElHevIjB1/aylw5
         CIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702640755; x=1703245555;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JhELWJ0W9NFLq+9Rk9JL6k3c2c7+f6wthL7iMiCLTE=;
        b=wbheH5vqWi5TvSxYhPTBcRDoZ6CMnqRf72q7amsvMIhg3MR8ZwlJXBkIJXHTnXg0jU
         soHaEIEtQyriYqDQNfF7/Z9OoX7PiniRQ22Vdndi+JRrkCLstnCOX5bkBQ/r0ONJBGVb
         XzXzZeOXdx8N3/dZNBh38Jwa48bCX71rarImMpWpbEfqqWZmMGRX+x3Ossjo6IsO9sqS
         s3DBCGREdUJbYQU9Oec8WyYdngPNzcH/9lSiHrxO3BBUaStyT0W5BV861lO4AEpQNGVB
         sC4VRE0qk3D8e7RalFkf6XSuSq/yclYLaeaayIwD4G6N+78gGqStOikXjHAiiXGxZo3E
         Aw1g==
X-Gm-Message-State: AOJu0YxtuWcvo9LduSmmdH1fh/rXAzvNhcddEQ+DL51cvMu3FHRsUoIf
	ktx2nm+2ofClln9karpcfM1fU1J/TPCquVNqs/Vam3FC
X-Google-Smtp-Source: AGHT+IHwPk+SmYaJSAr4+TwumGT5b8Gb+pcOKb6ZrDfJTg0L77bED39wKBT0vsudQHE3GhGWisRMUg==
X-Received: by 2002:a7b:ca4a:0:b0:40c:3cc0:8612 with SMTP id m10-20020a7bca4a000000b0040c3cc08612mr5796018wml.94.1702640754792;
        Fri, 15 Dec 2023 03:45:54 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b0040c45cabc34sm20257687wmo.17.2023.12.15.03.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:45:54 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 15 Dec 2023 12:45:53 +0100
Subject: [PATCH] arm64: dts: qcom: sm8650: add fastrpc-compute-cb nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-topic-sm8650-upstream-dt-fastrpc-v1-1-5016f685ab5a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHA8fGUC/x2NQQqEMAwAvyI5b8BWquJXlj2ENtUc1NJ0RRD/b
 vE2c5m5QDkLK0zNBZkPUdm3KubTgF9omxklVAfb2s5Y47DsSTzqOvauxX/SkplWDAUjVU4eY0f
 B9JHcSAPUTMoc5XwX3999P1KExKZyAAAA
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3696;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZNA7omWDjESiICNkiTbM/AH6p20okSBr7s87BXrfOJw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlfDxx6hZmc6HFHJIO7owTrbF7IUpy2N+D6BPxKuOY
 MzJRdkyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXw8cQAKCRB33NvayMhJ0cSvD/
 9Z9jxuvDlwvwPcg0cBlf82piPV84R2uxzuEQ0RywMfJB1lkSWjNBSQs0IqjCc1i2waIazsC876a3lw
 65OqcOK3niUITeKuVb3JBoHEkLm1FBeNTe3U+yw85oPuSDDGvY1uMISnIIBb35oc+bd62EkWnlL4Ia
 f4M4+LppgL8AMLWgXhIJmnqX+7KRgMCBK9KNwWSBk9dXjHqs/aOr1ctUJvEKrtcsrbYvNPHH498rzP
 2EC5tnCdwS5tIuPBPJNYZoIFkC6IwG6whlFbWZdTwzeQoMwAeFAOaJwbU7096z6MEFvPw2eLGUYzuX
 umrIixCA+sljgsTcGzKlCTFrKOottQDw6j+cr+1C0GVU5KuNHLcXrSbPlK8ZXBbYQCzPQr56FMRGXL
 ViuAifdLemT9Pdx4+p58VEVEweKAE55gKPFWNznQZE5ppyzH6ohetGRyzvd7Gu/hOtXNeXs9Uli2Zu
 olayRQuJ2nRQ1e7oPSYtt8ReLaMsBfiJM3PQ1rqiE6FoTIPbm2aV6CLJwVhohCGAu5uw1tAUug0HMl
 fQ4oBN6fJNdG/PY6N65m086enOTsxA9Zs+rclkWXpwn3BWC6iThIyrSJNbAezrRBghbk02kFyaL9Zr
 IzXOBWE5saVTogVXhl9ltQrT0jrTsIJ8UPEImtpomt6b702QEvHGHWSx/LYA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the missing aDSP and cDSP fastrpc compute-cb nodes for the SM8650 SoC.

Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 113 +++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 425e1e50d945..978b46aba886 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4804,6 +4804,47 @@ fastrpc {
 
 					#address-cells = <1>;
 					#size-cells = <0>;
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+
+						iommus = <&apps_smmu 0x1003 0x80>,
+							 <&apps_smmu 0x1043 0x20>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+
+						iommus = <&apps_smmu 0x1004 0x80>,
+							 <&apps_smmu 0x1044 0x20>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+
+						iommus = <&apps_smmu 0x1005 0x80>,
+							 <&apps_smmu 0x1045 0x20>;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+
+						iommus = <&apps_smmu 0x1006 0x80>,
+							 <&apps_smmu 0x1046 0x20>;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+
+						iommus = <&apps_smmu 0x1007 0x40>,
+							 <&apps_smmu 0x1067 0x0>,
+							 <&apps_smmu 0x1087 0x0>;
+					};
 				};
 
 				gpr {
@@ -4915,6 +4956,78 @@ fastrpc {
 
 					#address-cells = <1>;
 					#size-cells = <0>;
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+
+						iommus = <&apps_smmu 0x1961 0x0>,
+							 <&apps_smmu 0x0c01 0x20>,
+							 <&apps_smmu 0x19c1 0x0>;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+
+						iommus = <&apps_smmu 0x1962 0x0>,
+							 <&apps_smmu 0x0c02 0x20>,
+							 <&apps_smmu 0x19c2 0x0>;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+
+						iommus = <&apps_smmu 0x1963 0x0>,
+							 <&apps_smmu 0x0c03 0x20>,
+							 <&apps_smmu 0x19c3 0x0>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+
+						iommus = <&apps_smmu 0x1964 0x0>,
+							 <&apps_smmu 0x0c04 0x20>,
+							 <&apps_smmu 0x19c4 0x0>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+
+						iommus = <&apps_smmu 0x1965 0x0>,
+							 <&apps_smmu 0x0c05 0x20>,
+							 <&apps_smmu 0x19c5 0x0>;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+
+						iommus = <&apps_smmu 0x1966 0x0>,
+							 <&apps_smmu 0x0c06 0x20>,
+							 <&apps_smmu 0x19c6 0x0>;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+
+						iommus = <&apps_smmu 0x1967 0x0>,
+							 <&apps_smmu 0x0c07 0x20>,
+							 <&apps_smmu 0x19c7 0x0>;
+					};
+
+					compute-cb@8 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <8>;
+
+						iommus = <&apps_smmu 0x1968 0x0>,
+							 <&apps_smmu 0x0c08 0x20>,
+							 <&apps_smmu 0x19c8 0x0>;
+					};
 				};
 			};
 		};

---
base-commit: 11651f8cb2e88372d4ed523d909514dc9a613ea3
change-id: 20231215-topic-sm8650-upstream-dt-fastrpc-f3ad16fa58a7

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


