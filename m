Return-Path: <linux-kernel+bounces-50323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE82847765
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C632C28501F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CF014E2E1;
	Fri,  2 Feb 2024 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARsjzRK5"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C0E14C5B6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898428; cv=none; b=LXp3TCQFa28W0ZdYd3CXtfxiGq6W+4jsmIJsbm7prkpn/PZkSPipqbJIskycxW1kPPss8qgLLZezjBZm91qrIavgJfHRnb5yXGXlVeWqPPd9dd8jR0vr4kBwi6k/43ZPAu/vxT0io7xH2Tb8JlQoCcB0zB0gGQ+HnUAZuGDMROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898428; c=relaxed/simple;
	bh=AuG54Uj0q/PfEaWTOkYGzFnun8tTyXRxUufowfu9JRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lp/JZnOWH5crLPilFUrKx+KdiglVyXYdSJkt4z62HHLIBxgTpPa/gRFS9sEYOqMTmEXenXXz7WoqYaxFAAniVYR4Ho5PdzoMdOQ4y3vqo41vwqg7qjkpahS4yYfFZOxG9baKNvN4+jgrUTprFFB46mqEfaIo1YzH1wsX+yqDNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ARsjzRK5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3566c0309fso322477966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706898424; x=1707503224; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fjx+SwWtMIWX2qzyMAUTGHdxraIz5r50yEMfT4+crU=;
        b=ARsjzRK5Bi08qUVhpyve378icMRGvwTZFlFojPrx7i7W/ux8J9NynhUhVyMFOdop7X
         fqENjKNLFBquz5kIZZ2qjLeWgrCEMbZRGe9GTeH51IMAl8eNJjaakOngWNE5eFpCv9VN
         eaTmh1QIwT7wH0J/6qsgUA53R+mFl4d5LL3NNE70MBywbs4oyTcSS2J5y35bbMtkOs3Z
         Ws2mcVEJZuuzRX7FoeDvA5hpHd8MQ5ZKGX5vzppCgriSyjJmhgyux+P/6a86WtmxC1GK
         9c+m6owdcge9WbaM1ok2OyrxTXJ4mLOchSww+YRYvW35DXXqZCFEBdJDE+O/++rrb+ua
         /8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898424; x=1707503224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fjx+SwWtMIWX2qzyMAUTGHdxraIz5r50yEMfT4+crU=;
        b=jiUNdm15kMlk0DRSaBnpN2YaA+aHmWjOp4nwEbVrWQIydzaZNvVoOBTLSUYIUnUiPc
         I8BNCrmuR05Iei4eyhjPzrUbG4UyEmfiaC6z7+wfLY3SO4M3INnIG+vYruPcKlbo586N
         32Ix4GoqbrstoRae9ulzZoh2K5n/GtUXdiGot/JMFp6ca6//+hR5nAbkEiWkCE7E0knF
         dbKlnD7A8XJ9OMabhXCGm9lRNrqQkrjYP9nqxe5EnkY0bFpxw3MbZ75/Gky5ILpILej7
         hGthaOLZHQi4UvPKaE0X+fTdISUU93wJxh49mnxNPd2+LBP16OY6K2obJn9uQ4HJE3WK
         9rbg==
X-Gm-Message-State: AOJu0Yxrib20LrNhCVh2UILz+9ecA9T/Up4+Tj/AyVrq3NIS47d+25ye
	RwJ27/kImoHvpnnAkdufB90KvDj/t0vqaE1yIbGTod2dovCCifzmUN7qN0695cA=
X-Google-Smtp-Source: AGHT+IEFMB8eUE8VzPYE014CyTAWoZODPJC58wLi0W37ruhRiMEsWSzfiiPX4QIBSY+y9W87HQ9Czg==
X-Received: by 2002:a17:906:3953:b0:a36:bc20:9a40 with SMTP id g19-20020a170906395300b00a36bc209a40mr4134237eje.48.1706898424733;
        Fri, 02 Feb 2024 10:27:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzImViz/Ng8nZQLHkUlmUyFbYCDy2+iYNyhd4sXoEBrvEkjYu0nNjLqRXOQYrGLtR0e3OFSEytobKElVSdvTcv4kqgS9GtrvS6q++5zbq2pIxSCNJh29TPQWhl67N22jUDjz+QE89UtrcGUuQOB+DJNv95qtK4sRr+Su0fcnCG2vLRZPm4/Y6hCaXuljlFS6KIaIBogg1n1pFcU3amXiZ3vyKBtCad7BKX7d2jFnKIdtokLSqbB3PCLU4UPeDX8wgfCRBERw2Tpa50SiTvE504KfrfGZjdA+DixX6WzGlyu/fSBD50sRmUBKhLP4ALS9ek5qu+WurHyFGx5BpiyTvTQ/6ygEyLQBPGkC+YnNtFqkH92IWv+x4ENlRuMB4u25BjOK22LqatG+2EKLe+fGASTIOjR+fxvd5KHUWdfgJWwz7xpmv4xdifnYAkKhDEUU3UqH+yORCaKWxHr2EmMTjniUKL75ZrAjgDbM9FwhlIckhdjyjLonrEZbxjnQ==
Received: from [127.0.1.1] ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a370e130fc0sm791796ejc.59.2024.02.02.10.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:27:04 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 02 Feb 2024 20:26:53 +0200
Subject: [PATCH v3 1/2] dt-bindings: PCI: qcom: Document the X1E80100 PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-x1e80100-pci-v3-1-78258e9451e8@linaro.org>
References: <20240202-x1e80100-pci-v3-0-78258e9451e8@linaro.org>
In-Reply-To: <20240202-x1e80100-pci-v3-0-78258e9451e8@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2403; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=AuG54Uj0q/PfEaWTOkYGzFnun8tTyXRxUufowfu9JRU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlvTPzN5ZWQFrjBK5AJPTj+8mwB31izbuactOuT
 FKYSrNPiW6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZb0z8wAKCRAbX0TJAJUV
 Vn5xD/wKgnWvWoC5DEFvV5b41QPNL9am+ak3/ofks8T4EKNLW5OkRlkbR8n9Ps2PrwAEY64bXEC
 KIueEafDC4+e8hDU0VBWTjcktQoOVp4Hl/szowtVUtIgwLSTguvhrLn2kOUZvy0oBOwC5nMvBhy
 BCK8cWTSbl8Hzvkr0p6ifNIodILAD0Cd2x/zWPFFXI8x9yncVsSFjDAItZowlnRGyff/+SZyw+K
 beEujh69eeHnseK1cs373v5qLxJPllYwgLjuxfI/nXYObmG4gwqUg9UMLCeK5otCMpJkUI7Zg3g
 Ryzlm/ogcoDo/bHLo4fy8lQk9eG+nJhz0juru0gCO/57IbuoLg/rt0OwmxIYDoET0EpFZUfNn37
 UnGVJI7ziSAepkhrHoFgoVTU+Kdmb+8z2ZZT04A2to2DkbbZs6WO0tTxzYFRb9vbqerwR77nFLq
 Ywcat2EDY2U1b/usafMdgqAv4utBiG8pOTO3zbMYaKp7o3kvAgriu5bfnAUcMTEtvz00gk3qy7V
 o1WRUuVOC7mwJ/9oP3VdEnE3C9NpXa5MBeVusskmWpA6TxOUpJQLkMczPwqpdF6uIFraUh6ipWW
 4a20f5fcXQ3Z1IGhOesofyyLUML3amyBLlm3PJvImHnGshtDN/huMdRNPtyyVhbAuTORxhU+YTl
 GCWlfr2S59FLi6w==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the PCIe Controllers on the X1E80100 platform. They are similar
to the ones found on SM8550, but they don't have SF QTB clock.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a93ab3b54066..7381e38b7398 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -41,6 +41,7 @@ properties:
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
           - qcom,pcie-sm8550
+          - qcom,pcie-x1e80100
       - items:
           - enum:
               - qcom,pcie-sm8650
@@ -227,6 +228,7 @@ allOf:
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
               - qcom,pcie-sm8550
+              - qcom,pcie-x1e80100
     then:
       properties:
         reg:
@@ -826,6 +828,32 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-x1e80100
+    then:
+      properties:
+        clocks:
+          maxItems: 7
+        clock-names:
+          items:
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: noc_aggr # Aggre NoC PCIe AXI clock
+            - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
+        resets:
+          maxItems: 2
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+            - const: link_down # PCIe link down reset
+
   - if:
       properties:
         compatible:
@@ -884,6 +912,7 @@ allOf:
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
               - qcom,pcie-sm8550
+              - qcom,pcie-x1e80100
     then:
       oneOf:
         - properties:

-- 
2.34.1


