Return-Path: <linux-kernel+bounces-165038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4C8B86F1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF39A1C22C91
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A59D50248;
	Wed,  1 May 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0Q5d981"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8053392;
	Wed,  1 May 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552374; cv=none; b=IEvsufa1+0OVdILOUWnvOx9Iit6pltAM5StsBlDvJt8G59nbQGSInfa47wEVIIXReuj22/ap9ZKJS0CR41gzELPYY/jM2u73U6xnnYlhtP3B1gULdmFrqsVgqkRewMfikoauCbIToZ4JAqi3sJbi7xxRRRBidzWnIZ9X/1JfwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552374; c=relaxed/simple;
	bh=5n7Ca93sgt2C4nvaRXiYy2nhqL3iHW3hsRzfzicQJdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOA9BzxoGyDsBm165NHRgV6VEJzYkoKnPWjdmRsZGpRNgDALpqiKfqVFuGGwP1SYHCGNmRUYCPDZySzW9z3RSFtkjiFshxzaaUVcRimlVq6j61VpIvDAtLjrMykAWVB5NT5OPw/egsMJBGEKzvuz/J4Y/dCd6ie8uX1dIBaLrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0Q5d981; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso9953175ad.0;
        Wed, 01 May 2024 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714552373; x=1715157173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RfbJF1AHvLx68TbsWfPK5aQiL25UBSnWB8Job9Vv4g=;
        b=i0Q5d981SgWWQcqD/jOHshw7A75664r2C49/NZxEhJeNf507nIfkYBINQc9AI1Nzap
         hwEhqy0o3Hc7KblykNSKoQHudYXTc3tibFCWzzQj2frmjBpkmX+rFgfCS48mgmM2Z5uX
         hGYGbTVAmWTxLhMmt0iwh6yCxlJpLt7WefHRJ2+UBQbeumvEUAO5DCkIVLcPyAXyTaxe
         CQCInp7SnbApL6XufuFaohfRidRMQ0gGKoqmhLFNqdMfB9VqPHAN6YKQLFkxOZjRpdAJ
         TN1Y9sgYaZRBu2KEKxMDD8/jRRUY3HIJrOgFkxZ3kHjyoAjcU+Fz8hHEKChQFkJHBsNH
         UZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714552373; x=1715157173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RfbJF1AHvLx68TbsWfPK5aQiL25UBSnWB8Job9Vv4g=;
        b=CWTJNTW5x8Tec4mHpzKEGTMjGhjqzQUGREtXHOo4wKeKIYDL0iiCUXlO9YCluTRwgn
         g+4xGw1TxfWDIG0/hUq65PQQtlwa4XGxFj7+27FMdcJaURtuD8PUnUrePv4qTZlHSWFV
         67nkZfpypuJ+36YV+BEJhw2lu/T2mgXRUEzjUpUOOgph8umpiQ9Fur6N5qYfEivbZ8nF
         lR6XtYv+AbewGBxzscg95dUu5u2f1GwiOni8t6lX9dHUWjZVm6dGCm/VVPqM/fusPI6u
         R3OaP27oPGR+wDBkAe+P3Q5a4xDTE8Vb7GmXAZX8J4VlVLNr4UgQonQEwielxo17EYyP
         aViA==
X-Forwarded-Encrypted: i=1; AJvYcCUtJbhvN1stSb4F/LQk5lsRh1gcrj9mgf8VFA7IAglZch3AfwodMi70EnNVeuNHwImQkC9jdmo0OURaPpcrkoQkdWSQOF3w4uFaAq5JoHJ5uN3ibxTGFTSk2HIu2vwm/Dhd9wbhb8YdW58U7MMMAu2J4gpjhlfwuW1U3Fo1uRL15yHSLg==
X-Gm-Message-State: AOJu0Yx5gWFqxMtIHan3KqpOgexVszqsWjJ7NA84YsR2xzOr1vB/SZFy
	I3XgO0qDWxhBL5DE/req6RGjUm4uzu7I9O3Xoqo9F3+xvJk6tKoh
X-Google-Smtp-Source: AGHT+IHXAaPkZGd5Nh8t+ernOYHnVoWi2W46KeG7qa8Pc+dwOqN2qBR97bt1o8e7/+/xUA+of306Lw==
X-Received: by 2002:a17:903:1c6:b0:1e5:c0ee:a7f9 with SMTP id e6-20020a17090301c600b001e5c0eea7f9mr1809339plh.14.1714552372317;
        Wed, 01 May 2024 01:32:52 -0700 (PDT)
Received: from localhost ([39.152.149.70])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b001e5cadbdf8csm23761863plg.37.2024.05.01.01.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 01:32:52 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com
Cc: dlan@gentoo.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/2] dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
Date: Wed,  1 May 2024 16:32:41 +0800
Message-Id: <20240501083242.773305-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
References: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
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


