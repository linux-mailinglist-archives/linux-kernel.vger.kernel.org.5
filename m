Return-Path: <linux-kernel+bounces-103086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C754287BADB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A9E1C21A17
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1656E5E6;
	Thu, 14 Mar 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYHKww8n"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FCF6D1B2;
	Thu, 14 Mar 2024 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410511; cv=none; b=sgyDKtAZhgKg/xg7yBdAztru+jodsp0ykaRgCoJXKGtIAtdk4F6YjY1RzmsvqHKlkmi4DfFB7pc0dh0TWhqWDQA/pCNQbET1Rtl7OqcYAlwnSAWR6Xb+sYt7/x6KUWyFGnZWk5BMvPM01Ecn13q3uvvp9jFFGWtKrvakt375dQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410511; c=relaxed/simple;
	bh=5n7Ca93sgt2C4nvaRXiYy2nhqL3iHW3hsRzfzicQJdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2oOSR+Gb5CGb+hKXpVejUGtgbu1IJerpsV17bxRzzVXhHmE+HAPT+XplnrBC6LmWKYu/SNl6otkS79imK8+BsqJEg1OV+p9xH1Z82xoXHjQI2ccM06umg2MBqlKmWgE62EF5rY+ksRUYbCdoNh7Dei7J59XoFZcb6V0F1AQK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYHKww8n; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29c6a917a8dso683749a91.1;
        Thu, 14 Mar 2024 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710410510; x=1711015310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RfbJF1AHvLx68TbsWfPK5aQiL25UBSnWB8Job9Vv4g=;
        b=EYHKww8nmEylWheokLlKrexwFIXj+Tq5kyoYZJvrTOhZr+A7v44bO0HtYEA9cELJ7K
         BLhQb2iSR62HmQf6W82CzpoGll2wp7ZQv4LaGJ+tbML8yGBhdkS4joUnDtcbIvx1sXhL
         WpQeib8XeABvT2MwFoN7WkRE9Q71+v0GaRIqGRkfnEDSAN2HQ+OGE0KqJLmUB8keclru
         qbLCWW4wU+M3SsDAFg1hJPfR6ThWGz4leOQRUwGFfkQbfrAeP7yE02UjC6ZOr8eWTYvk
         Jbfw30ij6h67oi6/KqwxyvqU2SzZv95KUQWfDVlegc25f2+fslCIOIAjzHSF3Rhb4KGv
         5+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710410510; x=1711015310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RfbJF1AHvLx68TbsWfPK5aQiL25UBSnWB8Job9Vv4g=;
        b=SukaCAc8ra0BJ2+DK0Gz0eNEYCkUpxbSsy39is4fpLIUNM3IKkgxv+vx/sKt+IQLiM
         OH5m7AckoWuqoCt3hVuw3S5rAg4PbUOugPASWYFaAjYcUX5UN1ihkkcWEzqWQEE0f1h4
         P/A4GKIelN/OqjQlwGf2zrBZ0aAkQ5r63m3q1rZRU3qjIXYQ532iMnjmU+46ttNoLvSK
         9BohsTOd2kMRuTc12a4/bwhJBQi0EsZZOpI/XxBGV8tbEBlnoXOYoLB/chvZqCvus0HV
         DaZYuvuvttfE7A3Mjaio70fZrH99KHaJKn0gm89f+xbWt7DtlkrT9QfPcuByDcf4TFL1
         sJKw==
X-Forwarded-Encrypted: i=1; AJvYcCWyj/MMmBQHXsxPbJ2xLfdoZZHNsmn6ilEP5JJ2co1UVM91PoNikMVQgqLl2TKtUb5JPVbH7LYuRNiGzCF9ux4Y9Wd3ud5udQ441kH7XVy+Ma5zfH8XgtNIHAf309YYq33J6wlqLYlpcA==
X-Gm-Message-State: AOJu0YzWoHVFIos7TwR01xJKw6CM8lQ/LCwSbaIoIbe9Z7sc6QG5BkQ5
	MyTIO3IPLSq/kG1jw3PHz9yw6pVf6s8hz3jg/o+MDzp4o7V8STsM
X-Google-Smtp-Source: AGHT+IFOug+prJyXuRGFeVODmozS4fHIyHcN5UlA0KXkTsIv7Ms3lGTNvz7tnZ/bHi5vnYPctGNhqw==
X-Received: by 2002:a17:90b:c12:b0:29b:b736:71b8 with SMTP id bp18-20020a17090b0c1200b0029bb73671b8mr1166414pjb.28.1710410509361;
        Thu, 14 Mar 2024 03:01:49 -0700 (PDT)
Received: from localhost ([2001:da8:a801:69b2:6cee:23f3:5da6:de15])
        by smtp.gmail.com with ESMTPSA id bo9-20020a17090b090900b0029bfac322aasm483186pjb.30.2024.03.14.03.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 03:01:49 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
Date: Thu, 14 Mar 2024 18:01:30 +0800
Message-Id: <20240314100131.323540-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314100131.323540-1-qiujingbao.dlmu@gmail.com>
References: <20240314100131.323540-1-qiujingbao.dlmu@gmail.com>
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


