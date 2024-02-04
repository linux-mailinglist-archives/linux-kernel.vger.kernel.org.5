Return-Path: <linux-kernel+bounces-51422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D44848B0B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890221C21FC2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80679D8;
	Sun,  4 Feb 2024 04:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de263Vc1"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA8611A;
	Sun,  4 Feb 2024 04:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707021713; cv=none; b=kHWw2pI8G2mljpRzCuGq+tI2svxCD8yd1D8BvfWYzD2zVbsb6ok3twb2ibTl+y5blPfSPXWPQo7u937+0F7EGBmJ1K/qLUwFP+1tRHp2lWN1/VxZNOQy7rD8WeJCVCwnuHzfCaxwpIT9XpW65Sj+Iq8PQxOWeI2ZfUDtjFCMMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707021713; c=relaxed/simple;
	bh=7ZLEr1ApXsNePqMUJXvZEVkV4+p5v/fZFJNxNfst4vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GC8FkJ30bLJubyqRDzk3Gch2KRzEX2dEPNbkgJuwXFdN/MvY6+2sZTjhsfhZ+dED7iFZaD1vgvJ8xF7HwlOvFS7Y63ZzvQYm5dsy87eR5O1nO9ox4TcPWiPPbFiAfGfoSasTkNXLbf+1zj26qFIbSP/pLUzJU0OQcZa696kaI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de263Vc1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so2601547b3a.0;
        Sat, 03 Feb 2024 20:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707021711; x=1707626511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ifjH6savS/1chV5K8K3CSmBN/c/aBjrReSIKeDHfF4=;
        b=de263Vc1743txwCiZIYxsrGakeVvdBN2Rb6YbBz+aIxuKzLiNjt1cA4uJnAfNegDGK
         HwvFBFGoMVxBNxyuHwR4+NLKWc8BMBUWX5B3IL3DBCjbusi0Q8y5vnRtLdZ/sJYBWFmO
         WK54T5uF2LIcbWAxy8pdCl0b1NVO78aalVjPkfT/NeHSx/aq4UOYDParCqfsQtccwZXu
         cq1/pIRrO8TS/S9/yr8X7xzR4wiUPbFGms9sPirzioiReUriILhHyTqZbCByauH8J3Ia
         Lmc0tAz7rg4EbfbuxfIJtxMKl1CKHWR5jDWLc3dLi/l2c+punI5a40WmUJIy4aCGrg/O
         Mnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707021711; x=1707626511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ifjH6savS/1chV5K8K3CSmBN/c/aBjrReSIKeDHfF4=;
        b=asbZlmyoJIFTt/t4e9Z4A3Zf543yaZwZEsHIBUEWoRviY4upkXsUG3KuVKfLjy4EVi
         jL9tdM8dMpFmLeq1XhdimeFXXu8ZkS8nAQ3MJMpkCG98LHUFWCKGmiOeA5cXhG+lkaDD
         ZaU76voKzbWyxqD9gVYGEXMgIRQWefR8gSM5i7ACgaGwGtVD1retdULHJfSbzgv8oZ8N
         jxbJIdJXK0LFX+f0X3Kpw1SFb5YQcjzSpY3roGLBh1JFmhSiQl9wg7PPrdG3UGCjhzfC
         BqFsE/z55gKal9fWiDogt4RAfwx9hJ27J/2Z/i+VaqYdTgFXMe/BNV/6kWE2WZ2sEo5a
         x00g==
X-Gm-Message-State: AOJu0YxlIPCRE96Hnr5C2ezLGbi96PmjiXqE0HOuzdF+6gbQHMou4sux
	lH/P9DIRODTTGjjDthfwi/c7URN+LD/z9VvpencqQ9TysWf29VoZ
X-Google-Smtp-Source: AGHT+IG2ctVBygBH2dEAtHnytdAiCbo76gkTuFhWgskxlYZkA9TcWJXfFr0zVqbYBLL1V8S6AYMVkw==
X-Received: by 2002:a05:6a21:3a87:b0:19c:773c:570e with SMTP id zv7-20020a056a213a8700b0019c773c570emr10034708pzb.39.1707021711075;
        Sat, 03 Feb 2024 20:41:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUm71oLdi74vPZUvGMf5+n/bNf7wylfZauvEDyIRfEH/L4VQ1rYqHPYLbpwrvgrjhTANH6v+n0VezjRwEQIOW2BRas2rccNfnyq7vrFw4qfvvh5CbRI7V4xl6Dubov5heS2rTDVr9RyHQf1m+0cXG5e3rrierc0iF0CzCbIstPdkt4xQpEjaXTM+BN73Yz0TxYxFItvp9ykz/n5hCEPahcveTGhErPBIMiXfwiMHZva92+l62srGqzBc6TiIpSHtKdMooUB/Y3PlnI9inztfk58YFsYz9EQubJGZWPDP66QOInXPbvIl84tjIcFU603mlBvO7sD8/pQr1yQp0UKwWzQncYIa1nZ05QQNS+BDXZFEpwq/bVspcJREda4EFheKJrqXd1FcxhMWX0m9OkMzO5+YKCA9mn2ZkoTmesZlsmrmjAHhf4JCn+zhX3XWSFlAwyu3w90mo6EljgAYJ0=
Received: from localhost ([46.3.240.106])
        by smtp.gmail.com with ESMTPSA id n33-20020a056a000d6100b006e031155271sm1361683pfv.118.2024.02.03.20.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 20:41:50 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/2] dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
Date: Sun,  4 Feb 2024 12:41:42 +0800
Message-Id: <20240204044143.415915-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com>
References: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RTC devicetree binding for Sophgo CV1800 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
new file mode 100644
index 000000000000..b36b51a69166
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/sophgo,cv1800-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Real Time Clock of the Sophgo CV1800 SoC
+
+description:
+  Real Time Clock (RTC) is an independently powered module
+  within the chip, which includes a 32KHz oscillator and a
+  Power On Reset/POR submodule. It can be used for time display
+  and timed alarm generation. In addition, the hardware state
+  machine provides triggering and timing control for chip
+  power on, off, and reset.
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rtc@5025000 {
+        compatible = "sophgo,cv1800-rtc";
+        reg = <0x5025000 0x2000>;
+        interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&osc>;
+    };
-- 
2.25.1


