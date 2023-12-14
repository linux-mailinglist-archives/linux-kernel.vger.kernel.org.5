Return-Path: <linux-kernel+bounces-10-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 124FC813AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD5A1F21A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF3C69794;
	Thu, 14 Dec 2023 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLVOB3t+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5C68EBF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a1fae88e66eso538463766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702581896; x=1703186696; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wW/GDlju1SlGiHxyBADi4zieDq7qt0NNlAx5gIb5X2c=;
        b=cLVOB3t+J+3+sLqigbU4jgcI4l8O8TIPMFEw3McLPbwimp8llYnljx/D5fEk+44sLD
         2ADf+59Rcdan1KPxpdJArCratnqJaArYSoSpb6gReG59M6r46HFjCd6iLQ1CxKdBvi7Q
         UN49PFOpRW+3tFfbfynYvCn2pnNgH50K5G3clFu1qmXr4R1cJVO/5S/SZ298ETAOAAJm
         KBeg1eZ98NoO0Z9lMhCaMbEm7YPPskgzcQJDQLP8aWUYQRCX9uHHXLz9aUI97nbxuJQ8
         Y4ZwbiHC55TDIpuU4fWoYbkxDnODFqKBamr9yIFur2P+Z+Llkv/j/rnd/p2ubchPxBxh
         +CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702581896; x=1703186696;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wW/GDlju1SlGiHxyBADi4zieDq7qt0NNlAx5gIb5X2c=;
        b=UJsxOxbLgyxb+SxldwBnJcLGd+kGTvJoRd5RbWQg6GycePbgluUyI+SOpr7qW9m8zZ
         vQmW/NA5BvN9lg/nHSIok/oqLp0Ku1LU1Xhfk2O6UmLHzE3GVxZP8hAZDHcEV0Dt1Olz
         qnSFpzWVgGlLpMiNKNEgL5BtNm9Yj7ufwojKOwmbu93oTQy1IEvuXQVqnKW9nFSUiVSV
         D/h4m7DOJ+K1JZscyXjQxrjoAhd22w35V96re6r7q5OerNyHfyVML9XyKwqcVnNPbKHv
         Whikg82AM0mqxzGIGi2dp8kEUPSn/VOTVR1kuxejAX9zbn/YAS8CijgKckDmHHBQph4T
         uCMQ==
X-Gm-Message-State: AOJu0YxQ44JTYRmXtBWzJilmA54A6ttj8Nv2rewpQlr9WhMO7fna9m7L
	XNlY4yfMu4xlJuIsUdpTl/mgNQ==
X-Google-Smtp-Source: AGHT+IHMbXE/Abwze9EjqdpU70sO1enIjtDNJ9uE5t83WoTmA2Fs9hT/sHcWMvbLno6r7B91hf1hLQ==
X-Received: by 2002:a17:906:cb85:b0:a19:6483:d899 with SMTP id mf5-20020a170906cb8500b00a196483d899mr5306891ejb.66.1702581896680;
        Thu, 14 Dec 2023 11:24:56 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id vg7-20020a170907d30700b00a22fdf10c96sm2876292ejc.180.2023.12.14.11.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:24:56 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 14 Dec 2023 21:24:50 +0200
Subject: [PATCH] arm64: dts: qcom: x1e80100-crd: Fix supplies for some LDOs
 in PM8550
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-x1e80100-dts-fix-pm8550-regulators-supplies-v1-1-6b5830dc337e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIFWe2UC/x2NQQqDMBAAvyJ77sJu0rTSr5QeQtzYBashq0UQ/
 97Q4xxm5gCTqmLw6A6o8lXTZW7Alw7SO86joA6NwZHz7PiKO0tPTITDaph1x/LpQyCsMm5TXJd
 qaFspU4siiw85+ts9pQytWKo04397vs7zB0US26d9AAAA
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=OuI3ZT6TSbv4+Phx9PQrKmxRLVqKlP7HvLWZobRvDFs=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBle1aDFfDkRbCA6udlRBLwiDsPgFeLMm6UE6AHm
 xqOJ7wcN1GJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXtWgwAKCRAbX0TJAJUV
 VooTEADK2iEU66Bm0GdvcfQWVxdhoXrvjSAFEt6qDI/1n7Q3x2P2BLhcnYpRnlxBtE542lP8ApG
 PugrpvLtUqtTmthUK9l6pUXu+TS1/66iYP/ZuRTIU9mGGM8VeQGUnnBcfHqKds5fK958rATdS/X
 nPq9e9t/jmBQ+Y+kGXH/+3IaOMlXjo+PtUiwgWi7I4HaXSEJ7A13KSM1hHwOpNbP+5Be4cz6e3H
 E11Bwfo2NxdE2lh1tTOmveCei40s5FjZp7NfNQ/YZ2FyTuZoQ5Wp7cibgLE4WAn0NlY3xePAcZL
 mGnX9OqQkSKyRsQifNvsywbt+wxBmQY45BpQELh/thfld5VvQ9M4resXX9Cta6ukks7vSNCp+1Y
 IXXy/9DF/xGuU0frcC/gEJTTdvMryhlTYeJz1OyzTZW8kPftnAo2Oq9AG9Ctd63AQdeXZhQ26XL
 DOD0kqW2Ns/e2tH9IJTOuP/A7HgAcb9Evsu/lhvrByZegg0HeuEybkLrfUb0HL7zK211vvsGHkd
 3Ftcqz/ISSg5iFPHNVjvuPIADGSnFnzvqrib7XzwMplKXGWWWFTeSqw1Fjkd7+/zWj8/SxrYfel
 Ij5grSMP7mWZ/WucR+55rr51ugzrDil0/xYdBdh7AGE9ygfZ7XjxVcewjV3YeY9l+5a3xZ9vH9T
 qtONEsHxOFX+GTQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The LDOs 1, 4 and 10 from PM8550 share the same supply, the SMPS 4
from PM8550ve. This needs to be done through shared supply approach
otherwise the bindings check fails.

Fixes: bd50b1f5b6f3 ("arm64: dts: qcom: x1e80100: Add Compute Reference Device")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index c209ae59c6b5..7532d8eca2de 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -58,13 +58,11 @@ regulators-0 {
 
 		vdd-bob1-supply = <&vph_pwr>;
 		vdd-bob2-supply = <&vph_pwr>;
-		vdd-l1-supply = <&vreg_s4c_1p8>;
+		vdd-l1-l4-l10-supply = <&vreg_s4c_1p8>;
 		vdd-l2-l13-l14-supply = <&vreg_bob1>;
-		vdd-l4-supply = <&vreg_s4c_1p8>;
 		vdd-l5-l16-supply = <&vreg_bob1>;
 		vdd-l6-l7-supply = <&vreg_bob2>;
 		vdd-l8-l9-supply = <&vreg_bob1>;
-		vdd-l10-supply = <&vreg_s4c_1p8>;
 		vdd-l12-supply = <&vreg_s5j_1p2>;
 		vdd-l15-supply = <&vreg_s4c_1p8>;
 		vdd-l17-supply = <&vreg_bob2>;

---
base-commit: 7b0e611dc474ffa67d3a6ea235085bf423ee5f2a
change-id: 20231214-x1e80100-dts-fix-pm8550-regulators-supplies-1e35fa367ccf

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


