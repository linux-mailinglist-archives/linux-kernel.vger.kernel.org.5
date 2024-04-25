Return-Path: <linux-kernel+bounces-158864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6EC8B25F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD30F1C21B66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3D214D43B;
	Thu, 25 Apr 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAlbA9vd"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C414D281
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061034; cv=none; b=JBYIW1tYehiZY0k84IQP4KFWD5U8digL9+Bp5kGcFG22eq2nfbFwpgkObI3okLHBO73KYuZOGyXUrJkYdWt+sXFAbtbfqWzKd1oejRx4Jpj9vSmGKdk94c6ffSf5iiDt2W9e4Eam2XWKzucrM7Pn8+LGa5sDf79v/4WUkWqMbes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061034; c=relaxed/simple;
	bh=qjiLRzQ/LzL957Tztom+GeWOX7MmZNPVIPPVkVPDhT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PWKIbYGXHvpvdD/aT9bzceZLpExEGyYqz1/JefEarcyeJeOS1hhRo7CukdTKmgeb0BA6wYXirVwKVdV9gylyxQSSze9XCbXi35lad5Y4hQAL/Jgx48Thxic+EvlI97z0YQ8242H5JxRbFHaRJa3xcTAO8flSO0ia1GJDdYOEZ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yAlbA9vd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a55bf737cecso145285066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714061030; x=1714665830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyR9vWPsqsAUgpTsJMpV9yCJydAsWbKkcw3s9RwSvbs=;
        b=yAlbA9vdpKll8bZrBaNU6rcD8+XAh04F/rFaXX6fvdSYj7XfQyV/lRlX+DS/oB/ZE2
         2CdeQJjfrFiOBvbyA2CkJv8fmUbiroEz9Fd3VrZyzRu5Y/GOvkon9oWMLE/xz+giL9FC
         ExeqkDI/X0Yw88AcsFICWjF2Otw4xvIeWtohxik0UDwo6dwDGLfWTXdicWJQ6b7W2KO8
         BAbcG8r3KMVjkw4ps1K/KHydeONaQn/fz6gHqwnSfcXTc7uA0KxhRaTLthbeu0DmW2Cj
         bjKL34eDFNWECfY3xGewwDGAWj0PTP9ISvKOE0jn6Y0G4xx9Bl4DMLIhLPyql4GGbs0W
         /i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714061030; x=1714665830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyR9vWPsqsAUgpTsJMpV9yCJydAsWbKkcw3s9RwSvbs=;
        b=TggACDNoZSaq5y8UGVPNfReVQrOXGQh8VQGdjVSuGzIh1ngGClB4+E7EDhVe/sC236
         q4oaSra0GRjMnfLWqpRibkotag4eb3TNOJYcoYsFDBOu+7LOXer7uiw/bRDMft6fnB1V
         hRMssaCGcMmQQ0reRkKAhS6cEkPqzPW/7T231lwIPnXKfajHxBPzdipLcZKqxkMwCQc/
         znF4T5FbhjUXKxfMw5FNVKdRgUi84dDWBBe6Dw8u/+ENMmBIV/ZuUxBn5WWz6PC9p952
         Pq5LDVuRGOtc1QHmsL8zSR7NBdmb/Bp2bIKLifHKJE8yhXFXut620ofL7Uk3dn+lOwv+
         vLKw==
X-Forwarded-Encrypted: i=1; AJvYcCUTLBliybImMC5tgWFnnJWSeWdurSuvWb3doW96tvkA8KHeT1Y15NbCDFcXa0Q2EgTwKENrMshiuxQogEPRVeGlnSoAA69uZ8RXiLyW
X-Gm-Message-State: AOJu0YxUbDcjUjp5sBcmpjdBylmIk+fkUr4P8BTjJJ7CUCJdbTjXWEiH
	n9db9XmsjPD50tV2FnUMiUlTA4DeW2oboODoBJvZdr9od020ARdqzvCQMFhK4Zg=
X-Google-Smtp-Source: AGHT+IHWlzXObnhoIYoQz5NBCn2aut5u9/VWIBSK4AfPvrhlCDjNKP1pLhTffJGnUYMckpFjpwyP/g==
X-Received: by 2002:a17:906:6bc6:b0:a52:367b:e4ff with SMTP id t6-20020a1709066bc600b00a52367be4ffmr120217ejs.42.1714061030485;
        Thu, 25 Apr 2024 09:03:50 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00a58a44a4419sm1329562ejb.57.2024.04.25.09.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 09:03:50 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 25 Apr 2024 17:03:31 +0100
Subject: [PATCH 1/2] dt-bindings: pinctrl: samsung: google,gs101-pinctrl
 needs a clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240425-samsung-pinctrl-busclock-v1-1-898a200abe68@linaro.org>
References: <20240425-samsung-pinctrl-busclock-v1-0-898a200abe68@linaro.org>
In-Reply-To: <20240425-samsung-pinctrl-busclock-v1-0-898a200abe68@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

The pin controller on Google Tensor gs101 requires a bus clock for
register access to work. Add it.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
As we only have the one clock here, please let me know if the
clock-names should be removed. Having it does make
/sys/kernel/debug/clk/clk_summary look nicer / more meaningful though
:-)
---
 .../devicetree/bindings/pinctrl/samsung,pinctrl.yaml    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
index 118549c25976..49cc36b76fd0 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
@@ -73,6 +73,13 @@ properties:
     minItems: 1
     maxItems: 2
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pclk
+
   wakeup-interrupt-controller:
     $ref: samsung,pinctrl-wakeup-interrupt.yaml
 
@@ -120,6 +127,16 @@ required:
 
 allOf:
   - $ref: pinctrl.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: google,gs101-pinctrl
+    then:
+      required:
+        - clocks
+        - clock-names
+
   - if:
       properties:
         compatible:

-- 
2.44.0.769.g3c40516874-goog


