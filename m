Return-Path: <linux-kernel+bounces-111232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBF788697C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE921C21853
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DFC224F1;
	Fri, 22 Mar 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+gVQIRh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0C20DC5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100569; cv=none; b=CUZ043fR/HLhgOsiMwPpWDeKkzXrWAb6vPPa9XTzG0I8ckavjPFvnQJyzI51LkndKN+x4SE3DQHf33BkxnaHtfLvDFqA8sZmL8huBoiKFTqHZcLa4MqTTqnag7n7vfpNgKDDDmvu1DIYIU0DLDINSxb4RvPOiIDsvPZHvuuPO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100569; c=relaxed/simple;
	bh=c1g+yc7zI9maix5fpYJ7QOTQi0BGTOzrNoya3sqaYyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLeaN1iI5eknXmsH4EzWQbDHy6cLT6dxPFMwgPCYWiupJFU2xXvI6CBgeTjZDe814SFcffNndNspdZNN/eLi2wr1UxttBhtFTFiAnlBxSmO6nIR39RfVarYJDAlgpJR0oJ/VwewFRxG3peK+VdZP5Us0rsXDXQV4yXhKMAFp5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+gVQIRh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4147c8e27a8so2812585e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711100566; x=1711705366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HN3oSp+JRbtDFbrldKc94Yfei/E6XtVFhEcK3+4cH+Y=;
        b=O+gVQIRhAMGCO0kIM3DFjor07geNPISuuWb14IYZQSn9PQ5nr5vtBrQVRi6BGhKuo2
         4j9j3QexwgS9fEj7E6uE02GGgQoGrX4V/rhePVPpRrPc2fEsB9QEOZ4+1RLry1CROvR+
         bq2IBMzxW+SOen2QNeqpy3DF7jbYyyYS/l4avledvqq09T88RZsSy9hEfbtDRnQdD1jf
         VSgQBwfjbFcHdiLXvX7jap9UatpW5s5mbl0q8d005M347BFgftRyvb5v3Hnygyq2BhIQ
         vrWgPk4DzDr/u3KUrh/MetC0cjdHyorzdZa6seAwdw1adI/60os4kW8IkQKmhkrhWLQE
         vP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711100566; x=1711705366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HN3oSp+JRbtDFbrldKc94Yfei/E6XtVFhEcK3+4cH+Y=;
        b=jxh0zz1jbGYzuxKWEJv39/y5MJ2qt/Cum+k9bFzYNK6KMN3IqAzJohoTj31xnBO50t
         eZG43iyaQfW7C8HMdXHeNq5IqxtmASEml8vTAbM/Q1jLJx5rvzz1CwwkvRg6Zt7BZbCs
         aH4aeT72fwn5JUw1yMnG0E0ZBLJEW7L0Jx3BON1Eh8z+LrUV9FvcBVb0MWTd6JeLOrGH
         R78PC+5WW08pc1kvyvgWyEO6XzUM7FQa3hd7R74kciEKBSm/L0/435P2V1EK/M7TdRJJ
         tRSwnR5PKDHXN8Cq83aVpZ18czDKriejaj69EztDvYAYsbVGrhjLY86MkPyB/yFio/MJ
         TlBg==
X-Forwarded-Encrypted: i=1; AJvYcCVGwQdz46gE4hHc9n9TAeoMcAfO/d9DWj2ZSpoGfZbs/DCc07NvXZWz/7+vTSWOdofNk/vaIB3M3eS6PA8KxEDG1waqRdOVlDsURF0U
X-Gm-Message-State: AOJu0YzD2uvbIK//XyG/z9OkFrrTvSKbLHd2mq/E23KieJ70IxSWdMXk
	cTjeCwYho/+BQk2lEXjGQcFl+OVpFMmSHhO2SFo7qWj1kZDIM/XSEGt5sIG3b9I=
X-Google-Smtp-Source: AGHT+IG7VkUWz6FVtAHIOz/kPgFoX46zbE19qmEXnmSxhaPJzIoQ4SZJmcLQCMdI29EgkuYgV6UqtA==
X-Received: by 2002:a05:600c:49a7:b0:414:5e91:124f with SMTP id h39-20020a05600c49a700b004145e91124fmr1587412wmp.23.1711100565747;
        Fri, 22 Mar 2024 02:42:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b0041461a922c2sm2547845wmq.5.2024.03.22.02.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:42:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Mar 2024 10:42:38 +0100
Subject: [PATCH v2 1/7] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 document PHY AUX clock on SM8[456]50 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-1-3ec0a966d52f@linaro.org>
References: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
In-Reply-To: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2562;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=c1g+yc7zI9maix5fpYJ7QOTQi0BGTOzrNoya3sqaYyw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl/VKQPPVHn83qKZmKU5a42tPZYhmeiWh1Tb7K51SQ
 fIFCcqGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZf1SkAAKCRB33NvayMhJ0aQKD/
 0WoGrEk5PCnTh5wshSN3AG4/GTZZa3TCtIjHOqnp4tTYGh1UpEUVYmozXoh9xcB2JzUykASy9gChBD
 mYzBtOUNoyIMi0hdM3SEtRncIL6D+6ijJaugNzIZN/KnOnTTL5D746DD2cSLi3yVGEeffOlcuKdG8g
 cGREHJsWXeJwuBIeGjh2ceVVqBMv4WUYbGTgmY2P3NHARRKzFmf+kKVDGMXueMz0+gvFZ2mpKst2QH
 dw96UNpSBcpjgHlPM7DkhxNHdyAPyWH8FeNyZPL7Nm78myAY98179dVpm6RKBZ4YSH4+g9K7lkeiII
 52N5pGM7IgfUQ+TLypND+mDOX87ExdrepHW5ugoD59vTeBORxRQ9kyGNf4trW0Objx7FPcyoJqR7DF
 zPx2dPR+i/vkrKfBsHE8+ebgOPbXDIqP+axLP2a93K5a0O6irPmNZTKDyKXV3uCgLtgpmxBpmapGmb
 Ja3PgogUrAnR99k70cuZJQUASADE7pImF4LfSJcDK5Vw75YYL1hy8/BP57QKo5won8UP/sgID0Y32A
 YihhzzuPOvAz5JGHVBFlND0adUUiAALypPNBYSOu5P1Q5dDsly+UwYUDTpuEa9L8dnOUyHvHoHRm2H
 /BnwRf9Z3nBLI7D0DST9DA01jY6eBIv66tCOgWEYMWsB+yEaWOM5w3z3Chmw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock named
"PHY_AUX_CLK" which is an input of the Global Clock Controller (GCC) which
is muxed & gated then returned to the PHY as an input.

Document the clock IDs to select the PIPE clock or the AUX clock,
also enforce a second clock-output-names and a #clock-cells value of 1
for the PCIe Gen4x2 PHY found in the SM8[456]50 SoCs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 27 +++++++++++++++++++---
 include/dt-bindings/phy/phy-qcom-qmp.h             |  4 ++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index ba966a78a128..14ac341b1577 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -88,11 +88,11 @@ properties:
           - description: offset of PCIe 4-lane configuration register
           - description: offset of configuration bit for this PHY
 
-  "#clock-cells":
-    const: 0
+  "#clock-cells": true
 
   clock-output-names:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   "#phy-cells":
     const: 0
@@ -213,6 +213,27 @@ allOf:
         reset-names:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8450-qmp-gen4x2-pcie-phy
+              - qcom,sm8550-qmp-gen4x2-pcie-phy
+              - qcom,sm8650-qmp-gen4x2-pcie-phy
+    then:
+      properties:
+        clock-output-names:
+          minItems: 2
+        "#clock-cells":
+          const: 1
+    else:
+      properties:
+        clock-output-names:
+          maxItems: 1
+        "#clock-cells":
+          const: 0
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
diff --git a/include/dt-bindings/phy/phy-qcom-qmp.h b/include/dt-bindings/phy/phy-qcom-qmp.h
index 4edec4c5b224..6b43ea9e0051 100644
--- a/include/dt-bindings/phy/phy-qcom-qmp.h
+++ b/include/dt-bindings/phy/phy-qcom-qmp.h
@@ -17,4 +17,8 @@
 #define QMP_USB43DP_USB3_PHY		0
 #define QMP_USB43DP_DP_PHY		1
 
+/* QMP PCIE PHYs */
+#define QMP_PCIE_PIPE_CLK		0
+#define QMP_PCIE_PHY_AUX_CLK		1
+
 #endif /* _DT_BINDINGS_PHY_QMP */

-- 
2.34.1


