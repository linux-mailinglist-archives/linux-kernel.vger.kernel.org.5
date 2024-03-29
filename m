Return-Path: <linux-kernel+bounces-123977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228D1891095
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2EF31F2368D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B281CD38;
	Fri, 29 Mar 2024 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfyCo95I"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86F1DFEA;
	Fri, 29 Mar 2024 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677118; cv=none; b=e3E++AJOAJLF7uSy4D4SI8pn7KPvIJp/3FjMgbTNnOgyi2vPQKSYoANKgEDXYBXCgUpqymbIB3md+mNVnVwqVSy2BENK76zFpnyfUB562DfeySEWH7HnWyGT0qPwmTbaLNQtCVTwDaXwJXISsEyyF/mPB4WSxCypEUqKu383A7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677118; c=relaxed/simple;
	bh=DA2Nqr+7aaAof6BX6BmNpPRJMxjaC4Vi61KC7Z8EPXU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ielOqhOX0upA9IS9RXln3Gxb8kkv7f+Lo8OlfpT1Q3xKz39ertb079PenbwlKpeh5G0DOY4b6o4SAThEsIc4k3zM/+Gxr8CPJGiBaOYrmRFPaIVYqGcpRKujvLK4B7smevHVPwtgRwD+ePNzgdHkyB0dRqtZKNtiHv0EEB3nxzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfyCo95I; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c3ab85050cso1085894b6e.1;
        Thu, 28 Mar 2024 18:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711677115; x=1712281915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRrrnrJz0OsLrlpb3Bg9cadSdfyQ7FLgYfzP5YY8WMw=;
        b=PfyCo95I3Ass1pV4YfVEmYyK8t9ZzO+rofuQTKxm2tJ7H0OELFVrc+e/on/Yc3FqZU
         vk3UZzB0hbp2FXlm3BT25EyHhSuPD9tjIt26W7aYwGVJ3JUX8SSZVcukzpR4tApPX01u
         Y4NobJMgTjC401gt+kaV3P8rlS2OTIPDDfhvgc1DQyY/CkczdPDbMG6p60EPORPWKT7I
         WxvZIyhUSGyTrd68QSttUxlXxtPsoyeQAq+KzdGP/H2HSIHmzEdU9fHykpJhzwM7vYw0
         uVgS/0/DJru0wDIOLU/mWW4gsle3WWKRTeUdLOFKPwLsAhyTka3YEbHgkVbjqQsLUjxA
         encQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677115; x=1712281915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRrrnrJz0OsLrlpb3Bg9cadSdfyQ7FLgYfzP5YY8WMw=;
        b=FHI7ye8gCs//IYul5cOG5CTvoHVP0CDEIhh7rvVSUtYfQrUaXz+HnHyIJ/1a+SOH+W
         P4r4F48Aw2MJ5pHBaEBspKUSR6e0RWUto+vLn0b1KAFzoh31zs8VK/EUg7/M8uW+I6NA
         KEF6vihI9AJHRdy7i6yhOb8KE1JN/ItZU8Y/rqEzoG0oSm0FLU1Nwu27zrI694wrGMCZ
         +Zfo+XlkgjIkN0dVPTgUa7rFkRuYF78JpbCeiN9NzSiFxRmJJdguav6qi4Qt+N0kxVHA
         rDVDvYiQBSs2+xskvho5p9twm8Td5AiPIpZGHv5FKtIiina+WJ1S47ATsI2gg2wMfzRw
         KDPg==
X-Forwarded-Encrypted: i=1; AJvYcCXIU8sNQuwH+RfUd8b22LWmumyat4MAiMp+hDN+8mdOhzIbiUCHV4/2FS00Ab5oM5uhrQ93UCbAk4N70SCl1XsNzrIPArvED5GJUBkOXA27AdJywUbarA1wpORU1LEIdMzkNnQuwdZNeZOKmSLwCnPon8ye5Pzv2VWKbEEzd5L5hcQ9Yw==
X-Gm-Message-State: AOJu0YwFUGqGISZX/DkHpeB4w4JW8Mp5ojaVeRgKtydPNsxDKwPam5d2
	FFZaHL0Vkz6ZKp1g5baFqmdS1MP4jBJYtKXV3OknX2mNxUyT9UNU
X-Google-Smtp-Source: AGHT+IHediZs+tTSzokOpohZdOZPsDnmWz21eIcmU65e2cIs2AK5jJ4xOn3VGe9+9ccCf3SDMNBKoA==
X-Received: by 2002:a05:6808:398c:b0:3c3:e511:296c with SMTP id gq12-20020a056808398c00b003c3e511296cmr1192468oib.9.1711677114912;
        Thu, 28 Mar 2024 18:51:54 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:6249:183c::26a:10])
        by smtp.gmail.com with ESMTPSA id q13-20020a62e10d000000b006eaab548a0esm2044554pfh.152.2024.03.28.18.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 18:51:54 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] spi: dt-bindings: add Siflower Quad SPI controller
Date: Fri, 29 Mar 2024 09:51:46 +0800
Message-Id: <20240329015147.1481349-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

Add YAML devicetree bindings for Siflower Quad SPI controller.

Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
 .../bindings/spi/siflower,qspi.yaml           | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/siflower,qspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/siflower,qspi.yaml b/Documentation/devicetree/bindings/spi/siflower,qspi.yaml
new file mode 100644
index 000000000000..c2dbe82affc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/siflower,qspi.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/siflower,qspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Siflower Quad Serial Peripheral Interface (QSPI)
+
+maintainers:
+  - Qingfang Deng <qingfang.deng@siflower.com.cn>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: siflower,qspi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@c200000 {
+      compatible = "siflower,qspi";
+      reg = <0 0xc200000 0 0x1000>;
+      clocks = <&apb_clk>;
+      interrupts = <39>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&spi0_pins>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
-- 
2.34.1


