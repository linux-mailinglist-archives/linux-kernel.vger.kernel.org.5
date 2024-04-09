Return-Path: <linux-kernel+bounces-137476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB75989E2A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9F91C22AB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060B156F50;
	Tue,  9 Apr 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="zue3yUMU"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EDD15699E;
	Tue,  9 Apr 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687816; cv=none; b=WQ58Q0g9QvqapC4W8hczSt/FoMUV4k4dIXWe+/zGLphL8MJgOPGYp3XY5qkzV3cLTmX2VSWaRJcctUlMayz172Te96krMJetsAM9tDQQcqvNOOtBBYRoBvqwMDlEHhKvxgleO4bPrJCCQO83kcfIwcGdQ4GUioaIQ7V8/CMgu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687816; c=relaxed/simple;
	bh=gW9l8dJqYNA4+L4w1oT2wdP2ExgySRT9xOXqm3Xu8FE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/qKTXHV1VRwdK0iHo4x0z7s0MQl/VEkOrGUv9dnnaRDC6K3KUvHTUxTYRoLHNuto1j0rXFNjj2EDbJ9SOGRSC80w5volXCXVfUlWjp6HmMHYgRF8V/ssUaR1SegyFz77D7KLHDhsFL2Be8oDxIeAdaJz2ZYR149zyZHqedC7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=zue3yUMU; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712687813; bh=gW9l8dJqYNA4+L4w1oT2wdP2ExgySRT9xOXqm3Xu8FE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=zue3yUMURFIxbQkIWVbAEpwWv+0dkmcUGJfeOMDEuK7DJ7fSmwu8xP/VUx7EGnPj/
	 ohtFe9fqtW2tB+R1r1gDqXHTkfEA9Bgx7Qur4EsDioRm+hFJ9r9P8QxJmXJa1Ykaej
	 sbhSAbiBmYNMeBveA1CcxubxBTP2JotWY7SuC8LM=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Tue, 09 Apr 2024 20:36:36 +0200
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: qcom,pmic-gpio: Allow
 gpio-hog nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-qcom-pmic-gpio-hog-v2-1-5ff812d2baed@z3ntu.xyz>
References: <20240409-qcom-pmic-gpio-hog-v2-0-5ff812d2baed@z3ntu.xyz>
In-Reply-To: <20240409-qcom-pmic-gpio-hog-v2-0-5ff812d2baed@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=gW9l8dJqYNA4+L4w1oT2wdP2ExgySRT9xOXqm3Xu8FE=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmFYrCS3jskqiCJInq5g8aIMm7iBtLFfIK8SmcE
 EfhgRjo5AuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhWKwgAKCRBy2EO4nU3X
 VgRNEACVGtLFS9M/K/Khp++YYzmx7MwAwYJKSl1YtUl0Og5meQaZMNBHcO4d7OvCd8w85xNyr18
 /a0qDnV9KOZVZNaGKOsqc9kZR/h+U0rLlGRz6rbOhONav0GDJs1Gvfp4eFyldF8ondZygbiNYeQ
 YaWhEma6+BY12C3dwzslwB7ySNSdXFT1RCrfeGox8bHq4E89bWomOPQinFaSgl6xTfUO92AWaSP
 GJERIj/RJLPWt7JjsGJnJWb5LXWbMwErJrjs55FiXlU+gBi9jGk8e6l3Y4ACvVGk88cqQrlkM+V
 zhfhFXaYRLgf78MkUWgoKpDZap4EDsJyoppw71c/GQnu5Qu5oD8L9jFWd18alxUTRjdg7VOFUzu
 DtAvCYMZVqLOsUqNdvBhM8Lp8vQkOZUsIyRwZajbS5GykFBVimZtNv0ZZtbf5XSl91mEXMKNa9E
 ao4gwoPcK1oxwtWlhLeYzAYLhSakZZVRJ/crtzaF6qmHo3ajDdokx5xz2fg83D2/yu3P07J953U
 j1OTDU5YwBH3un/luCVzuR0NKsPIdUROxN4E2Tbw9SI2oNLN0Ke+gRpsUuD4wch3p5UJ3M4qixo
 8H2GW6jai9yxOnkmE/ioP4xhw0jkhBcoGF/0OQgHJxBBsHqTh0EHiZ2MUc7biTakQViq9XAGR7E
 fGzFajCgCVORCUA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Allow specifying a GPIO hog, as already used on
qcom-msm8974-lge-nexus5-hammerhead.dts.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index a786357ed1af..bd9471de0c69 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -424,6 +424,10 @@ patternProperties:
             $ref: "#/$defs/qcom-pmic-gpio-state"
         additionalProperties: false
 
+  "-hog(-[0-9]+)?$":
+    required:
+      - gpio-hog
+
 $defs:
   qcom-pmic-gpio-state:
     type: object
@@ -571,6 +575,7 @@ $defs:
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
     pm8921_gpio: gpio@150 {
@@ -594,5 +599,12 @@ examples:
           power-source = <PM8921_GPIO_S4>;
         };
       };
+
+      otg-hog {
+        gpio-hog;
+        gpios = <35 GPIO_ACTIVE_HIGH>;
+        output-high;
+        line-name = "otg-gpio";
+      };
     };
 ...

-- 
2.44.0


