Return-Path: <linux-kernel+bounces-61537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74E185136A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43548B239E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74A39FF3;
	Mon, 12 Feb 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKsEtlBP"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE5E39FEB;
	Mon, 12 Feb 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740261; cv=none; b=NAqSGUsO+Y52gpb9uwXd6JF//Evczcz6eMY7ZVwoshvwrzPiBMe9QySlb61jfebhPKDA5p7biyAbg1nQBuiRbBeHUYE5a6N4T8JOVEfsGTFueFJBkBIZ+x+UxaEc2hLWm16Gj1gqgEX6MbqsL3KvDPePR6Ix1lguiVX10UXc8Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740261; c=relaxed/simple;
	bh=5n7Ca93sgt2C4nvaRXiYy2nhqL3iHW3hsRzfzicQJdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQ1sftGed+OX/swBuwpdMljmbwffLHfjm9dMEf4/H7e8ip9/E//IbjZFXe4Z851PrPA7Lftne5MXiIyAHEyCDdL2+xopVIhz+V7uDGRjRp4bnAE/jc1eglMpp9xcyRtJlxgo34IICwjc+HkXk/sXv7AJXagXGYSNMErkUWOD9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKsEtlBP; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e2e452c852so580998a34.3;
        Mon, 12 Feb 2024 04:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707740259; x=1708345059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RfbJF1AHvLx68TbsWfPK5aQiL25UBSnWB8Job9Vv4g=;
        b=JKsEtlBPppBy2JVWgouei1oTqjrn0zGisGoQ1r6aFMOragb20Sg5XnRJjlYk4b7rl7
         04U3cnWpLPb0Mu4iyta/2pZzhGBRk5f50tEaKLoxASLpx7RdDUjU/fw1VxbeIpFgKtr8
         4Oami5lleFn5vFQPXmb8H33Y5wK4BtRMoMOIESk8TaR9LC/lBNmtLap6CVghe5sS3iad
         McjotJb9JZWH/HCwnXGf82mVEJDut6LSxIXeJuthZCfu9/QQYDUazWvpRfDPpfa8GTqz
         F4UpqcQ5mAEz1r3OBeKWWpk+z66jWdprKnSmFxD8kQdjSVoHR700yzNpC+XKaJ3/BKEg
         Pyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707740259; x=1708345059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RfbJF1AHvLx68TbsWfPK5aQiL25UBSnWB8Job9Vv4g=;
        b=EV7u9rVd04QDOvMUswJhFD8GwdjJXJBQaTWbjK4atHTs1qvOWI7slZa7wv7RK5+IIk
         EE/Q9vKtH0n1JyBRYyMfQKVCXG+sI8cxg3NxNwTYXx9vpHcKfAxq+90/658sf4YpPXQR
         Va8LqhFIy/tKUOzJluRLSs2V6wxhvR3k4zyC2o3Ibg8GMN/S7LAEXAqWdjV0mBvLyiyi
         tP6qTcjvBIZJPUwwIfcBB47pQPW4EHVnbQQgC2vAkZMVJS20EFXt+omlS0E0Rs7ilugk
         /711LCJDaCz0hx8Sxv4JL4oXVbvxzmdwuoDNLi9Gz+/BZ+sA3zZjru+rp9mk5Vm68hqm
         AhHw==
X-Gm-Message-State: AOJu0YzlQ6RLehmOzNDjaZctNuXfOGZXQCNrDiZTsAUg0ZvoyQpDNmNR
	/cmm82JoT7h4aygRvHbCgK976VFaV8E1lmWP+NZWY4xTVpeEhP/k
X-Google-Smtp-Source: AGHT+IF1V8fjciPDIVrbirrW65r6wp9hguDDTfeW5poRWxLAD6XqNoHV5/CpwG9m+ZX0np/f/YuM4w==
X-Received: by 2002:a05:6359:2192:b0:176:b156:f69d with SMTP id lr18-20020a056359219200b00176b156f69dmr9001594rwb.31.1707740258740;
        Mon, 12 Feb 2024 04:17:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlUx/5elAYWFUyu3JBsYBwId9m/koGZaU1mU7SeGEzzCwQHHCjUkHr8ZLVBF1oOnqSPyqAtxWBXhXtha4Dn0aozg0tvbpYa2HjafCcj7uZRyev3FleJzrjuZxPpQix6KKpXyaPzTObBK0MiMj+d/iL/xKufqbFSP64R06LcFi7gki+igvtuxzxxAQLPoz085GK8HVkpy10v6wM/TPSLkStXWbeT96ic2ptQieYjI6c1Tm9e+jO62+yXcdEL7cvKA1PN08/qLNf7kRC/sF4IUJ8cRFHPDClV1gq8atT0w+A6ouYNiIaIGVxJDYp2chNJLoSf08oGaBOvUHapXE/5yn/H4EJjQk0zQmtX2jOvmOY5s5EF7hQ733jOGsN1Wc33ZqR3E8sjW4DBh4fPsxwdjVLzKk4SfDe5tJ9QUjb51FM6qTN9G5BWyDPFkZig7G6D899AHm939ruXNEH/JWkJvYiYCsbJidEJbw/vHNTtwAA/trcPxoloDm+jzgHhS0=
Received: from localhost ([46.3.240.107])
        by smtp.gmail.com with ESMTPSA id q23-20020a656857000000b005dc2ca5b667sm253534pgt.10.2024.02.12.04.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 04:17:38 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
Date: Mon, 12 Feb 2024 20:17:28 +0800
Message-Id: <20240212121729.1086718-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240212121729.1086718-1-qiujingbao.dlmu@gmail.com>
References: <20240212121729.1086718-1-qiujingbao.dlmu@gmail.com>
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


