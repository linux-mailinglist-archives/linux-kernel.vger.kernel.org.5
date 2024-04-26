Return-Path: <linux-kernel+bounces-160025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D54328B37FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CEE1B21528
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8E81474CB;
	Fri, 26 Apr 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbG64VZD"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21DB146A9F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137053; cv=none; b=KU2HbApRUUTyG1P6W3MUDF98iSkOV6+a3ri4eoIs6wiJzlGj3LCmRDRWEUFciJhLeUNhA9EN8+39zCZb7Qg9/IMsz24EFwNGSzkcbO1ueR/+TvatWbRemnF+R27mCZO58DfLf4/A2Bn1X0iyBs/P+uLVWUa91PoJCMC7nJ8AcAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137053; c=relaxed/simple;
	bh=qjiLRzQ/LzL957Tztom+GeWOX7MmZNPVIPPVkVPDhT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoKgutRuGuRbCrpE11sl70ENLidhyf44XMAbr4rGdcveSSI1yG2xEJ1pyb4+2GvGYOXL1J6xmXv0wyUqaFfz5wt43RS3YQ+DIPTve9nX649jZjJr9YS52cp12cbeWzkK/h+rH61l+WYtEsaPEeWSrvZi7UBX2pmhbSywCSH+tac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PbG64VZD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a524ecaf215so271324166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714137050; x=1714741850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyR9vWPsqsAUgpTsJMpV9yCJydAsWbKkcw3s9RwSvbs=;
        b=PbG64VZDwv6t0cG8cCOqgFc9OvK6Apl84w+cbx68SUJ1r1dE2GZyAqQn6U9rTE1Wd4
         sGCDuugL90/Hnxth7RTyVmnJK245OiVpvxCDrbMWJNS2iNJna/dRjUhrWlAkrVBahIyg
         lVlS5JCwzBAWTurfxEjG6TUqc6pt1meE8i6XeMqJObgqiCHMW+tpf6VPMq08T6s9k2F6
         XFMe7kweiOo7xMJ+tGqBXelhHDAhJYkjIp/7bgqLaMdArCX8vJS1yCkU0P9mtWyxj3HS
         zCb6u8TASk5puWwmz84kfWU5osv02uDdlLxVqH1EDfu60eodFn43kVJbmetonDRd2Hw4
         Tatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714137050; x=1714741850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyR9vWPsqsAUgpTsJMpV9yCJydAsWbKkcw3s9RwSvbs=;
        b=mxRFvUjn30wEMxOoS/r1Dmb+n3HlgNJyvcxxDw+dWrU6EVWBn3S30KUUBPgXH3s+AH
         jA6NfoWXY9E/37wrxpvTHnk1sJ+2y2N9QeXkJmtnT0NnQwogqLMxrxSTOfgGJ7BFKOOp
         p0CSN6Px6nDHfoFHbn6NRNn50P70lMcfFbkBSTsQFctG9yukXAK2RR8Nb+z8Z7fCQE1F
         KsXPmQbl8CI01pxlxmwsOMPZez+pZ+BXE/30X31gS7c5bDZ4TbE01mQlvKm7w1k5lsXy
         eWz0OIeHUkVZ0eKuw0ihFl/7Gf6S+uijDSip0Z3+QMVo26FxMqJYyEFiS+q7bXsgmWaq
         ds1g==
X-Forwarded-Encrypted: i=1; AJvYcCU5kYYK1+ZatxFM7+k0E82D7JTA2rjCn+GO4+Ks2LylKNt7hlRw95GM+l8XB2l7byu/sTnBidhijOBMUbNI1V1r4Pi9GLuqsF37f5IJ
X-Gm-Message-State: AOJu0YwPjkh8UU3JXXdPpuBAp/HJhW3qfx+WvGVxbimA071q2Rorz67v
	Lf7Gm3bwca5kpWF1u6QERrmEoq5fPMJtY6tnyVhwcZkEkYyYQp6vvZgsJVlMsuGpJF4obfuC6VW
	KTH/D0w==
X-Google-Smtp-Source: AGHT+IGSGholbRCB3xXRiKBdGHoIKLecb79/UgfewA7TWa6VNEesp01r2lLxHu5AHKlfCKAu7HlkxQ==
X-Received: by 2002:a17:906:305b:b0:a58:a4bc:575d with SMTP id d27-20020a170906305b00b00a58a4bc575dmr1819263ejd.40.1714137049990;
        Fri, 26 Apr 2024 06:10:49 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906c41200b00a58bec2ae2bsm1396948ejz.39.2024.04.26.06.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:10:49 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 26 Apr 2024 14:10:46 +0100
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: samsung: google,gs101-pinctrl
 needs a clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240426-samsung-pinctrl-busclock-v2-1-8dfecaabf020@linaro.org>
References: <20240426-samsung-pinctrl-busclock-v2-0-8dfecaabf020@linaro.org>
In-Reply-To: <20240426-samsung-pinctrl-busclock-v2-0-8dfecaabf020@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com, 
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


