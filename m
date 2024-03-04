Return-Path: <linux-kernel+bounces-90258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 476A186FC8C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2921F22F48
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544CC1BDC2;
	Mon,  4 Mar 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BamzbxTe"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199091B7F9;
	Mon,  4 Mar 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542783; cv=none; b=YrkxfjZmpTj8XbVNNoqiPrQxauNtfDhVl8ZNi1NxHO+iZL0D7hnsyv24qLfbPt4t6wzXa/TonYAlbEvJ26Pfa0CLwVmlF/GfmeFJQkCHczsXzNGJpvtAix86PcKYpsyPQ5zOLf/UkQYaWpoedmwkeU515uZv4ZQ/xVE2daEKcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542783; c=relaxed/simple;
	bh=5n7Ca93sgt2C4nvaRXiYy2nhqL3iHW3hsRzfzicQJdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sykFtMOnKGAhP68kH07bxFNp3n3AIEcGh5H/xrlhpWPoXk5B19s+Iq8p8sIBpcbTC+2XX5iccnOJGNfqRLtVLAnYcEHidghkJhwntT/uwsPI2SoUPFSbG1oAKCoM2SVRpDMyZ1qsJr33LCeOXfOyrH6fDnYDYjsy5nIZQ+l29Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BamzbxTe; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c19dd9ade5so2577645b6e.3;
        Mon, 04 Mar 2024 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709542781; x=1710147581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RfbJF1AHvLx68TbsWfPK5aQiL25UBSnWB8Job9Vv4g=;
        b=BamzbxTe1dqLweW5/I4gzs8xZklZZMmR5jy150GwQtqTatC5V8UvwYZi49Mp/eqg70
         hL8c69nSDDTYFnKWjKaJqoHxvrHPN9ieMXizKv29dUfDMTAwXbRnQu7L61b9hUhFNLkp
         o1mt9YrdFAzY3lOD3mZB0cYCnFmyjnV9ZenLnAlTw6hkBIyqpwf0HsZEJfHPiMg3ADhB
         nClL6pwDYKyI0HtAtVdYPSzjT1oLSKzHutb+3b5fZ2laLXL/fHxYpeL59sdjiSIMt1Fa
         qEFPMwKc41CfQjLsh/sREgpdQpDCMgdG4A0J1w9BeM0UHFPNLgcUtNiBpmD9V9iIQzDE
         N7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709542781; x=1710147581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RfbJF1AHvLx68TbsWfPK5aQiL25UBSnWB8Job9Vv4g=;
        b=MP4HHyY1Ga64nrZxCVKWQvdI8qk65UufA5l3pRjjH+UgmucAp07nKYNOBxwamosSRC
         dt8XZEqxUh0dQ59xEsY7VoevHhm0NSa0MV2d2gkujJyg1M8K9EAlRjeIedlfdg1YiP1b
         55M0w+mh7BFrViY6/nt0sq/Zq5S0ylwYXr2JPIN3aVubbvDLHhPV6ysm0UCXGkTvMO6y
         7NNaNQ4gJSHccetK22W1P3l3Sk2yaTdLrzxDojR1m7b6yvLgHm6gCZTKz5aebFADcdDo
         Bl9+COG2bPaKe8BT41Esm8V1v3hJV/47YTiaT3VyDGrzSIAJUk805D4bqZTDXUZooX9K
         Qc9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZ7sBLESXeassi5zcplpB0Ev2m0E4SWVgI2vMenx1MKF9OG/NNmaHR3XLNMWtHafsDtA+pAI6NPhogZiwTfAIUOwLvmybYzcXvjR9uFhEHBWJ5zQBV5eJ2M6UWTTBf5h1SdgrqkOARyA==
X-Gm-Message-State: AOJu0YzKBRak50OikTBdkt+QmFhtDyjNaLN2EWxEDh3elTe2/NPzf7+2
	3EitFqNKbLIpwJmiRpWaqS/QoNfTKaEP7t3a3ihG2/ZZ0RWMsy4b
X-Google-Smtp-Source: AGHT+IFrJApvRiyiRPUBdBTtRF+hbAqJUWjUKCjR4DKkFz7uLlV4nmg8qKkGl8e+Xbjpdw86yiP4GA==
X-Received: by 2002:a05:6808:148f:b0:3c1:ae0e:9c4a with SMTP id e15-20020a056808148f00b003c1ae0e9c4amr9910219oiw.24.1709542781008;
        Mon, 04 Mar 2024 00:59:41 -0800 (PST)
Received: from localhost ([46.3.240.107])
        by smtp.gmail.com with ESMTPSA id k76-20020a633d4f000000b005dc8702f0a9sm6903483pga.1.2024.03.04.00.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:59:40 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: u.kleine-koenig@pengutronix.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
Date: Mon,  4 Mar 2024 16:59:32 +0800
Message-Id: <20240304085933.1246964-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240304085933.1246964-1-qiujingbao.dlmu@gmail.com>
References: <20240304085933.1246964-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding to describe the PWM for Sophgo CV1800 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../bindings/pwm/sophgo,cv1800-pwm.yaml       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
new file mode 100644
index 000000000000..b5b819d780f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/sophgo,cv1800-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800 PWM controller
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+description:
+  The chip provides a set of four independent PWM channel outputs.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm0: pwm@3060000 {
+        compatible = "sophgo,cv1800-pwm";
+        reg = <0x3060000 0x1000>;
+        clocks = <&clk 60>;
+        #pwm-cells = <3>;
+    };
-- 
2.25.1


