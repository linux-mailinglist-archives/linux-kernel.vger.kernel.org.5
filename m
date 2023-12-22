Return-Path: <linux-kernel+bounces-9605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C481C850
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6E0283925
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C114F97;
	Fri, 22 Dec 2023 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sllWArqx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C55171A3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c31f18274so20904645e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703241669; x=1703846469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tOWdLJ/qZbSy8WR0cdDIT9XcPRLZLEVuRq3Zyqwz0U=;
        b=sllWArqxCxX3lrRtq8WfEYUw4auv4L/nGax4xLFx+6S6gas1nHJNRHAT9FGmpfzNo/
         Vit6pr/pTyknVWXkySNI7/3sgLTPkwJGajz5k5+iqmsATQxkKJ7fK/yQLZU0N+025yrc
         U/giQX/ht7TiJjUVU5+UufMNjKaaJXLgCtn7+IDfhKGeSr8hz+3ZzrEcQl7Wn87moWVW
         tUO2bG1Py4ffESMbeDC/q6Abv9IDHr3ajhpNRjrQA8YgnOOcvLNlGZJiNGm0n5t4eie1
         1TeaHvFKVFfETbYqFKiEKg7npK+2dx1zt79dDqAhjjmtAEw5MtzD4O8q63pHVh8cnEa2
         r4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703241669; x=1703846469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tOWdLJ/qZbSy8WR0cdDIT9XcPRLZLEVuRq3Zyqwz0U=;
        b=sExAFPi9ByVZhdJuHogF4BAM60+vA5lJTZ7ZEtYskdcGCTAiRYhuETJYuLz+gXQpEE
         UsmM24EX1BGdeomREcWAgj2FB2awUHG7hU7t53Hy2doS7SgODWWOrdL3M3w1LtJVTYQ4
         PZHyZU2f06YsMGNMXLDvCJ5k/HVQb6zvVdxPA4KFOTAEYFrmBVARJXJCo6a7aD73Bk+L
         bhn8UblMN1ga7GO71EcY1jwmXbo9A0vyBNF2XVSKf7rN+kAh3B4n/AEGuboYleY6zJt/
         0hpSV58WacisAnBDO25KJh44p6uDWvJdD3qo1xla/50dM3jCWd2yKgwmczv9Z/ABNlq6
         zJtg==
X-Gm-Message-State: AOJu0YxZS7YH99YJMQ1m3L4QAfJEtUlQBYurk5jMBhUsa+kqJXXf6gUt
	Vr3noAK6XfTpJd424XPAC1anPGoN4QzyeQ==
X-Google-Smtp-Source: AGHT+IHlgGpHsPmPZ6o7F+D0KoHY/OSoELcVoth/eynYcp3Ou/FckjiQSMxcHoGW4tX/Ngg2HZk+mQ==
X-Received: by 2002:a05:600c:5494:b0:40d:44e5:9baa with SMTP id iv20-20020a05600c549400b0040d44e59baamr439971wmb.212.1703241668849;
        Fri, 22 Dec 2023 02:41:08 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c470b00b0040c5cf930e6sm6348728wmo.19.2023.12.22.02.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 02:41:08 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 22 Dec 2023 12:40:53 +0200
Subject: [PATCH 1/2] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document
 the X1E80100 QMP PCIe PHYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-x1e80100-phy-pcie-v1-1-b74ac13390bf@linaro.org>
References: <20231222-x1e80100-phy-pcie-v1-0-b74ac13390bf@linaro.org>
In-Reply-To: <20231222-x1e80100-phy-pcie-v1-0-b74ac13390bf@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=R8BI8+v89/SHzkE5IaFv+EDCthFqId0vtwYtd9w6b4o=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlhWe/heco18MecLvIMzZeQfAX3Pk29W9uQ8KYS
 +Y2M9wmeHSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZYVnvwAKCRAbX0TJAJUV
 VnecEACCZHTNHmkVyl77Yx9p32RdzMgfuZ22r1gkMXlyl4dxu1RET8hK6+gSdyxXaDjgXe1NKul
 qclkUvLEjTu6PakpyQDb4TJrcKHZ00YHcl56HPw/TJM9QYd1ZE7Bqf1pOLQS2L8YE61Yxg/5ENJ
 7vdmfZEpVJTM0RE4klO4UJhrYtVe/QyNMQnmr842sKZ72QtSnC9dvGIc2ZLr5VL/YM3/r5hy6fY
 3OM6GSxCIJYe7GrWcHTqS5qUtGR/aP0ejBaOTR0nI9SBOglMCm5RIM9eMte0xbhP6JuLe6LLWLQ
 UR6AJKq6h+rV6vhUleT/R4WpzD8s+lUu3VPKISE3tIcbyKU3/oSAKvN0089jLFe35kLMa77Ax0k
 MrR7sm6PGRFDhvGRLNFW0lDnxW5UabLH32DxCEcVJq5AHrSDBhx4FHr9jRWQl8ADc/ZSLBJ2zRN
 s84n+kEUZVEzKtqX4BJhGKuWKjYOGmrcsMSD3QTUTbQBURDBOaGn5M9a7AvKTv7T2sUblxQSlvp
 rqfNjdBSMAHL1geFWz6B2ZCD6xCyBpKrOX5luGtkB323XtzH2jGdpSRzMgddzegpCk+yVFrOGJV
 fjMq9tz/nICn2kE4mSEo+HuYSP6z8gM8oVcONgB7et8rinfx9AYyLvH4gr8IZIldPuhVLZpT9e3
 bVhOWiygxz9H4TA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the QMP PCIe PHYs on the X1E80100 platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 6c03f2d5fca3..ba966a78a128 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -38,6 +38,8 @@ properties:
       - qcom,sm8550-qmp-gen4x2-pcie-phy
       - qcom,sm8650-qmp-gen3x2-pcie-phy
       - qcom,sm8650-qmp-gen4x2-pcie-phy
+      - qcom,x1e80100-qmp-gen3x2-pcie-phy
+      - qcom,x1e80100-qmp-gen4x2-pcie-phy
 
   reg:
     minItems: 1
@@ -151,6 +153,8 @@ allOf:
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen3x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
+              - qcom,x1e80100-qmp-gen3x2-pcie-phy
+              - qcom,x1e80100-qmp-gen4x2-pcie-phy
     then:
       properties:
         clocks:
@@ -194,6 +198,8 @@ allOf:
             enum:
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
+              - qcom,x1e80100-qmp-gen3x2-pcie-phy
+              - qcom,x1e80100-qmp-gen4x2-pcie-phy
     then:
       properties:
         resets:

-- 
2.34.1


