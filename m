Return-Path: <linux-kernel+bounces-135695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015A689C9E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5E9B23DCC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22689142E9D;
	Mon,  8 Apr 2024 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="KS4m4dnK"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD183142645;
	Mon,  8 Apr 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594397; cv=none; b=jvwek5d8F1ORym5eDuaJHgQfYNBf69L5YbV15HJWZLj1XvsbbaSqfx8aYBbZhEenoXtHpnszuXiXawClNboOlyNu/yzFnndlVRjf1Ijv/e5IAPtgEIDCBBQ6YY/tUnBoB5/qje5NCTwQNNe/XIyiGeSk2Msr07t1bC55elA9kPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594397; c=relaxed/simple;
	bh=2GYv29Fsok0X6JD+oXe6kLYK6S8BGbQcfnAa/pcmuhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlDGG7b5oOdawZpBvVepFd8kT6WzSNJ1mFpvIioyX5p5E88Zl2WF/6P1D5B8C7JTMU2TSfudS71uz1bZtrfK2DJOPmRmKdGK89xsRyWVbCwSY6P9kX65WcnI1pdrvxaMrfDyxQVdm3or8sgF5paK30KjkcbtbIitjwVKmtlliaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=KS4m4dnK; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712594394; bh=2GYv29Fsok0X6JD+oXe6kLYK6S8BGbQcfnAa/pcmuhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KS4m4dnKr7XcFeBj9pQ6oiCdbFou1IRTBm1J3W4b92HRkqd9GGPO2dDF6ZrVb147g
	 WXbUs4QgDPZxJzLC942G7iq48jm2mlLl7SCx8ussbsa1VlGzCKVDnHtvYFH8jYtM1P
	 M/i2VgX2GaPXLcXirWHvNE4NHOTq4M0vTTTHIqwg=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Mon, 08 Apr 2024 18:39:47 +0200
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom,pmic-gpio: Allow gpio-hog
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-qcom-pmic-gpio-hog-v1-1-f61fc5323110@z3ntu.xyz>
References: <20240408-qcom-pmic-gpio-hog-v1-0-f61fc5323110@z3ntu.xyz>
In-Reply-To: <20240408-qcom-pmic-gpio-hog-v1-0-f61fc5323110@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=2GYv29Fsok0X6JD+oXe6kLYK6S8BGbQcfnAa/pcmuhI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmFB3X611y2N5u0Q2ngK+/knuFNkHK57ffj/NcD
 ZqqCjBr+7yJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhQd1wAKCRBy2EO4nU3X
 VnKoEACjujI68ndMostexaLACKtT8ya1vJiH05v/764AfEu4/DKbM1sMrChnVg8lDO0onj3pP5a
 OgbFFVnphfPJ25ApOci74bDKCCqaF+OGYSN2DnZjW4Ehfdu1PySLW+7Syk00UEuw7XK7WvKEkQ+
 Wh6w6FL8HDrynEUhH3s3Lw1fMv4v6IhKctEnyQMZyuTjfUt+isr1XjmsnWPdxXVSajNWqrMB6mP
 3qy/X8S99H8ojvTvivSerxKPnDDZSjFizwfU0JX4j23RjiwDrwf1xbK58w0MonEmCGyARBcjb3Y
 SL1G5oOQBi8TzKx5ltJ/JMj74A8SRaWmK/bxNes/R9+xiE3k46TdMfFdXoS34xHI5KKGmetJsyQ
 4CVz2oqhBjXgKp90KdmMnruVnM6i8Ql1dYLcHN7pQAlLS0y70tSH8ahJcjcO+LYxneDkBXgAJPg
 Lw8Pyd+XSqYK57XhiU09ccLbYKp6fKyBjJaUMToggwp4JiylgREbx7oh9xabSYg6kJvrMByFZ73
 N90LuzUIEFMy+U+6Be5ud5oSO8JTGIBtOTZclg41ia7G5OQjibHFuC+RLMTL7igYX00rdPNnGwy
 peSg/3vDt5tZ5mFj7opKs79gPG89L7mVqr6/LEB9qrpxtiT5Nio+YeLWWAddymqfQ/3XspCk0+K
 cpraqBQJNgnOKRA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Allow specifying a GPIO hog, as already used on
qcom-msm8974-lge-nexus5-hammerhead.dts.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index a786357ed1af..510a05369dbb 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -424,6 +424,10 @@ patternProperties:
             $ref: "#/$defs/qcom-pmic-gpio-state"
         additionalProperties: false
 
+  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
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


