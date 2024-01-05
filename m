Return-Path: <linux-kernel+bounces-18336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E310D825BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9347028628D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910DC364B8;
	Fri,  5 Jan 2024 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zLOFudDu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC335890
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so5489195e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704487152; x=1705091952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTm+vhEbcdsQDKA/4ycfDlFDuTCjL4ZZBDFj+o8PNWo=;
        b=zLOFudDuqA7t46+V0CXAnpMF2y1gqCEtkfLaQzJI4o5WC45OVwELY9V6e+/tbk9wKw
         SEKSo0qmgmGh+boM2qhpcsLJw1f0zaJOIR0My0dP3sxjvi21IqjBse4jZUXpVTvKCuK+
         wa8DNrbi3blAxY1Dk01NnHoJs0cMbjYvdbfBKwRNV/77uObGd+BlHMId8f8oMZpToSYs
         kNeAIlz3MlVzsf9HS/SWqBlsNAP+UxMYw1UdYe7Yf30xNq5lV6TfBr8YM4Iq0B2GFo87
         Xs8QbfvFzSn4n7ifkXf/fLOn3Y8/vque6M0nD51IxbvUYDgFyI/qrUo3gAvKnrxzzrEX
         cxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704487152; x=1705091952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTm+vhEbcdsQDKA/4ycfDlFDuTCjL4ZZBDFj+o8PNWo=;
        b=G5cfXeC8Ltkoht19Kq2D5I/+4ZuQUVmBB22W94wo4Iki6qbEcwXcN4Rc+W1thLWc8A
         Nus13QoiC36PK+NpdM9kR4/WTuvF4w/cRzed/D4PNwmhlWl4A/1luHJnq9TiJkVCwyWf
         MJlZ7YFrpQNo/zNUKMCKLwYlbngEzsAqFVjWiVqvbdGbiIxNqUH5hf7q5YkPz9TJCX7h
         zBICBpCesZPh46Mg1iFjG/BTPS/XN6f61m7LtUVuSF7/qdacuF6vlO2mR0XUPpwl4upQ
         EAjoC4kiECmjiOwtQkmJs+hg3xPjYd09mj4zlBDzoCaDgc8Zjhxs5sGOEMXyAT6Fxzbw
         gyog==
X-Gm-Message-State: AOJu0YyeWILfAbWTDNxRMTRnSfUcik7UC0a/eF7hcn0mEOCzdSAr83tc
	a7SjJxtKhgrVgQI0wcrC42wJGC0xBvBqHQ==
X-Google-Smtp-Source: AGHT+IFpE5jPD9ukRUuNcZhD6dc0H6TEZxzlpPq+1g8dBH1rFwjrQKC1Kh19CDLtG81IZ7GbW0LTAw==
X-Received: by 2002:a05:600c:209:b0:40d:4e46:df6a with SMTP id 9-20020a05600c020900b0040d4e46df6amr31023wmi.63.1704487151748;
        Fri, 05 Jan 2024 12:39:11 -0800 (PST)
Received: from [127.0.1.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id hn3-20020a05600ca38300b0040e398f8cafsm2283890wmb.31.2024.01.05.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 12:39:11 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 05 Jan 2024 20:39:05 +0000
Subject: [PATCH v2 1/4] dt-bindings: i2c: qcom-cci: Document sc8280xp
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v2-1-7a57b8b07398@linaro.org>
References: <20240105-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v2-0-7a57b8b07398@linaro.org>
In-Reply-To: <20240105-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v2-0-7a57b8b07398@linaro.org>
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-4e032

Add sc8280xp compatible consistent with recent CAMSS CCI interfaces.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 8386cfe21532..369d72882874 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - qcom,sc7280-cci
+              - qcom,sc8280xp-cci
               - qcom,sdm845-cci
               - qcom,sm6350-cci
               - qcom,sm8250-cci
@@ -176,6 +177,24 @@ allOf:
             - const: cci
             - const: cci_src
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-cci
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: camnoc_axi
+            - const: slow_ahb_src
+            - const: cpas_ahb
+            - const: cci
+
 additionalProperties: false
 
 examples:

-- 
2.42.0


