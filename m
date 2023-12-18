Return-Path: <linux-kernel+bounces-4077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD1D8177AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672351F25AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B17498B2;
	Mon, 18 Dec 2023 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rYAwltur"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC05A84A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso42128515e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702917405; x=1703522205; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEiQXLxdqBICDnY79OHSv3Sv47jiKw8LbCcpfTgH4AA=;
        b=rYAwlturr+bIMqMBYOyTwtLqEsayxtxFdwk18m/lDSyCXh1s6+KXm6LvfY0dKH4mOK
         B+/FDrdu3OeTWD2irdRWBgTOnf6LiILkdHJhiOptG1ncJuVLEh+4RHUiuBSP5endswuI
         J/QKH2H0Tg8OTMT2gsBrcyg3BUlNUK4EQeQIR28ZEFhw4cyvbElUQ5EfTUG1hj9vYOQi
         wciLta28AwOBfBA7k2jYEFeAppt+ZsurvDXsxYIffgq+xSBPZLn/GIYp8/uz0iS6ukiz
         JCP2VNOgVsrwGjcYf0cy8qAk1SJnJc5C8dY7IyF7U7OpwsXi1E81rK8blOk4ngNw/4xb
         jTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917405; x=1703522205;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEiQXLxdqBICDnY79OHSv3Sv47jiKw8LbCcpfTgH4AA=;
        b=Sc7YD2tH78w1FmangdH3gklAOvJJltYsFbPNNwIJB0tmPl+bcWqRKhxLDz7Jr4Jy2I
         uEfxoVATfqrV/lsqSnP5ZCLg9lS5htrHXu7bcd1NG438BjwuUSJAzAgicLBha+mKkoJQ
         SiTR7769egxRYWYJ7zUQqObn1/C791BQePtyQGvEnzdw1OxO2G4I3f+r4B5L7eEikDQi
         aTxH15KF1P5WYFeA7YLgKRhbc1TrIIJBfJCTYm+fP1bNRpyEnx6WfqNQOdVJWPP/tKSE
         vYm7MT/xtAWSmDKZupPbleNWG2Rv8AjNxsVjdTpA/lTUKYuUDXt4u+0d5Z2iHJ+L1QKU
         0q5g==
X-Gm-Message-State: AOJu0YxZai2dWBXb1kGdcvfAlXwHT95ovef0D0mf4nb9G+0eezJeZqq6
	TQa55eeoPjEyNHVVz7z2bshsWA==
X-Google-Smtp-Source: AGHT+IGcR59A5Bj1YcHV7wLTQuxeAEf6nNsIf2gMifDZJ7RvLX6KX0t1OUKr656X8kPMPXJYtBhlxQ==
X-Received: by 2002:a05:600c:4454:b0:40c:6af0:ccea with SMTP id v20-20020a05600c445400b0040c6af0cceamr3046238wmn.223.1702917405037;
        Mon, 18 Dec 2023 08:36:45 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm35836936wmb.15.2023.12.18.08.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:36:44 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 18 Dec 2023 18:36:40 +0200
Subject: [PATCH] arm64: dts: qcom: x1e80100-qcp: Fix supplies for some LDOs
 in PM8550
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-x1e80100-qcp-dts-fix-pm8550-regulators-supplies-v1-1-0a313ce87745@linaro.org>
X-B4-Tracking: v=1; b=H4sIABd1gGUC/x2NQQqDMBAAvyJ77sJugiX0K6WH1Kw2YDXNahHEv
 7t4nMPM7KBSsyg8mh2q/LPmeTLgWwPdJ06DYE7G4Mh5dhxwYwnERPjrCqZFsc8blm9oW8Iqwzr
 GZa6KupYyWhjJJ36L78ndI1i1VDHjOj5fx3EC8amMG4EAAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Cl7h63hRqbdjD8FcBXVyS7ODnGEJNkYQ9rmoYCPxuEI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlgHUaVLNVexMcAhqX6L+thj8elYSTNMwz5ezpi
 k/tIpAcuxSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZYB1GgAKCRAbX0TJAJUV
 VqJSEAC5J89LYaPgxDvV0RCxay2Vbk3bACk7uXnEbEoKbLjeNrB01LDgfcRRf3GS3bri0nKitnd
 3fSggNdcNLFN34f1F2v1rm6WIU8uHMe+biLnCwL+n4CAU/AcCAoMt8Te6mGO6stfIRu4kuzMRTK
 UPAr2jjSNwl3jpbpbyw+zFugqFiVuq5gkmC1EJBEJeKLJKsKBtSXLDfanC23S00AiQtpG5LvHlO
 UKHVsfxhykUGJgbFLmUS5wv2p+8+sn3FpR2OyxJZqTimRP/7ZuxL79QpS3JM2Pxrq2KKDudaH1V
 056Z/GMhM3dTuciPekcj3YbqPCHts6DqsfrO6s6U+86vCo1G453lx4NU4XON/lWVNclTeNkvo+/
 6g80OmpRXOXt9S5SmEPnRvmk2G54mLKJo6YIT8GikU2ZaSXkyWB8k1TlqCpWW8WXCzZvbyv/9R2
 MRxBoSpOyBkJnor0903mZLkhYRvGQBn8Ei8/i2jxR5IRK+4/AF3wAjyEj0gP2q7pCEOmfmb2rwC
 v+Wp04tqo+6JAktjIDCnV/ii8hQpX8pl6DOrkQV83tHv37Yeb+0FcTV+pIVB4wk5IuN08sYEcNv
 QmDUME4ntIXfl3KJ6BZYSV4al31v5KcDA77sALTH+Brylw0mhxjQcgVoe49UEyWmxkZ8kzYAEDM
 uMorS+bVjjjZP8g==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The LDOs 1, 4 and 10 from PM8550 share the same supply, the SMPS 4
from PM8550ve. This needs to be done through shared supply approach
otherwise the parsing will fail. Also fix a bindings check failure.

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Looks like I forgot to do the same thing for the QCP board.

Sorry about that.
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 3746e1de3623..a37ad9475c90 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -40,13 +40,11 @@ regulators-0 {
 
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
base-commit: 48e8992e33abf054bcc0bb2e77b2d43bb899212e
change-id: 20231218-x1e80100-qcp-dts-fix-pm8550-regulators-supplies-03d1be3f026a

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


