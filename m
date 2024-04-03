Return-Path: <linux-kernel+bounces-129013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491F389632A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8CA1C21E24
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A379445005;
	Wed,  3 Apr 2024 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hr7u0PgO"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E066F3D98D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115841; cv=none; b=VIIQXsTwgj0M0/EUAzHnR3yd8sLwCogLteoK+CovrlY0FAt6YeWbewI4Ofxs7B+jBuQYn9mesmsFfXj8BpxE08BLcjVuvGe+bcThu54HXy+FSeH2gmU9f2ims09UgCz8nfWBETr3SpMB5l/CSJ5uSSv+ZIrvXo6+YNgbHe3gYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115841; c=relaxed/simple;
	bh=vWEb7jmHKp7plqaXgrmEtB1TTF7h90FJxtovdzgscyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GrMxoWji2nuSh+rNC8h0M+1FzP85CWfwZnWxHFZ7qqrVO/XIxyUslbK7zqPg/ZvL6Mdcdh98dEp45clJML1PHeNfnvKrz+QJWTRUUDA51eois2KPNfTsHRByiS7PUdqfbmx7eRWIQfvleC1Q3a8pYkJPNLC02Rtr7EMWvgJiUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hr7u0PgO; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516a01c8490so437059e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 20:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712115838; x=1712720638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOB/W2al4fAWY1hZvIX+eyNZGmg0uhdq3Rfxx+fRp2E=;
        b=Hr7u0PgOqi1kxHVQvk7qSANIQfDxTLkAHFKnCsvMun/d/n12lFoCzbzllOAN1uS9MM
         eS9L7iFJxWhJKH1uMSF8QmxKTPYM13dhLxV3fY8UKOH9I6o/DnIvhAnVLjYREmIHbWfo
         FYJYvrQP1taAphpHlh0RVVyJcl2GPyTa47U5ZtiOoM4QRlSGVhImaFGjXK5I3csdAXms
         9Sh1VpgqetbmperuyEyUYs135vz5dwAkCRpXOb6vgc3IGo9HPbLbiFTYcbCq0jH1wJtB
         tTyFvzwuYw1kfAkQFzPBP0hHupYFmzNN5f/GY++7gv+AVycDySTYGOhQ+wKZIfKHSBY8
         Q3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712115838; x=1712720638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOB/W2al4fAWY1hZvIX+eyNZGmg0uhdq3Rfxx+fRp2E=;
        b=Gq7grO1iG/Riq3RboykfuSfovROu2SOhOfiq667st6uiL40hSp7nbBATxlKY77caxF
         3KWkgPGS29bRuKGjIiysAaxaPi9PNI7m+gRDClkeDwYMpeCQiRkudXgPSJh2jWinQFUl
         j5hHbv3Gn7KWc6A7Qg27BRixbfpdbf9FGUxqhUAXHpOvWldDh+P1mwIjy6+0bHcwGWTa
         K3xhkE4J8Ex71rkjxFvaBON7xT74HvConO02LGLvaeOzEZwqFBRXcTEkUhi7Jqj6DbIK
         H7ardPE0zvzAlgq/IKSZAv1w7LPqBgET3BtrFT2W02Qy+I+xVmDXti3H6FgtAW1Lxh6I
         0xRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgsQmE+3u48IN8j2l6pt4UdMoFqbhX4AiA2CYAuEDs0EKmmsFq8Pk5MiT9+1Mgi0DnC9veJ2FvGJPJs+1ENg32y283e+BP8yFCKVND
X-Gm-Message-State: AOJu0Yy6ORFrMp2Sw+rixYP9GWmH9qvfcRIREPYEskilAiXfx5SSdzYf
	JiLJUZqWd/v0ObaeBPtZUsiM6s726jKWiRCpVBzJ9T1L1PZbGAt0gw2XWCTQaQ8=
X-Google-Smtp-Source: AGHT+IFdp6MlJx8Q86tmUkW4rWuR7xllrv3RX4DfJ/SDa8Jrr3PQWwHeU5veK8Heu+WrR0BggbwFAw==
X-Received: by 2002:a19:9144:0:b0:516:57d:e4f5 with SMTP id y4-20020a199144000000b00516057de4f5mr428324lfj.16.1712115838113;
        Tue, 02 Apr 2024 20:43:58 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id br31-20020a056512401f00b00516a69b1dcbsm940985lfb.78.2024.04.02.20.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 20:43:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 03 Apr 2024 06:43:55 +0300
Subject: [PATCH v4 1/4] dt-bindings: panel: Add LG SW43408 MIPI-DSI panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-lg-sw43408-panel-v4-1-a386d5d3b0c6@linaro.org>
References: <20240403-lg-sw43408-panel-v4-0-a386d5d3b0c6@linaro.org>
In-Reply-To: <20240403-lg-sw43408-panel-v4-0-a386d5d3b0c6@linaro.org>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Vinod Koul <vkoul@kernel.org>, Caleb Connolly <caleb@connolly.tech>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=GwVgZdE26NDUHVKCdQIs4DldqMTJkpU3Pk/WgyxXJjg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmDNB7ss42XbFQ/Rh0+k3rxq0P6Jbz3+FOfUfiD
 DVWcLzhqb2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgzQewAKCRCLPIo+Aiko
 1UYIB/49YPYpkZtCCB7WnsVhlqTzEQjHe5iJJj1W9/Qwq0FgmL+5+K5z/b8IcGre5ssYS09Td7F
 vG6sNUB+Y/7uAcrbPSjOeWvHI8AwjgfKNs6+U9wU/VUWcKMyx4xPVVrH3m7yJhhMjWo0+x6FPW8
 IzJaJXaJk4LbyaoGMmAF1zPW0d6AXcHfntRdAbK4gy1vIt/DY8BkfU0nmFtVCh7Pp1vGpzg6aDa
 dikDTmV1S7EXpqXMwb+JdcjaEbNAc4fsbXBYzqBSFnyAGp+TZ5jeGlPNfFPXr62uiXZJbsgAZj4
 Q6wNTbIrbltQwaK89UARj2T2D064XYnLcQFJc6+WTcBvvQyQ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

From: Sumit Semwal <sumit.semwal@linaro.org>

LG SW43408 is 1080x2160, 4-lane MIPI-DSI panel present on Google Pixel 3
phones.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
[caleb: convert to yaml]
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/display/panel/lg,sw43408.yaml         | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
new file mode 100644
index 000000000000..1e08648f5bc7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,sw43408.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG SW43408 1080x2160 DSI panel
+
+maintainers:
+  - Caleb Connolly <caleb.connolly@linaro.org>
+
+description:
+  This panel is used on the Pixel 3, it is a 60hz OLED panel which
+  required DSC (Display Stream Compression) and has rounded corners.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: lg,sw43408
+
+  reg: true
+  port: true
+  vddi-supply: true
+  vpnl-supply: true
+  reset-gpios: true
+
+required:
+  - compatible
+  - vddi-supply
+  - vpnl-supply
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "lg,sw43408";
+            reg = <0>;
+
+            vddi-supply = <&vreg_l14a_1p88>;
+            vpnl-supply = <&vreg_l28a_3p0>;
+
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
+...

-- 
2.39.2


