Return-Path: <linux-kernel+bounces-124170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A32891359
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E832288EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94263D0AF;
	Fri, 29 Mar 2024 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSR/FECW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A753C482;
	Fri, 29 Mar 2024 05:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691227; cv=none; b=ozvVxQgKik1qqPIuKbo+QRZRAsAe/tdlo5t2galcP70tE5u6Ynn31JC7pDueCJooPLbzNnoFw6DipdzJ1OVSMIyCNKYoIzeTRV0A4mVJqWvepn03h/jiJquSpYVzp+UeRDp22EMyRTdxu6atEjgF1WboLv4DIkkKvyOXIOx9S2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691227; c=relaxed/simple;
	bh=wBp+ceh/Gi5LnHoDZJeLCQWxE+UPBatPPcYDpPIISaQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=odnzvtNLVmqSL93wrojoz8KOdOWTH6bCwsX4dp460wkjLSeW9yAoSeQ11xslxHvWmo3dNiMWx2swLBHaS2DBGGMaN59DySs/qed2JxbY3lJQYJEosbXJkzUq9qCPM8V3hgUQWAMOSkZAqbrO9udUg0DBJerWHYteD3Rk1B5aru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSR/FECW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e2266655b1so6404465ad.2;
        Thu, 28 Mar 2024 22:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711691224; x=1712296024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2mjGX0SMVp3aAe3JX3OUIFGC3HtwxrC9WrcrOvDfNY=;
        b=iSR/FECWCTwtuTixMIv1Ec8OQO4/+bXHGQx4QRida+IgRKwD+LSVkWGqmJMl0eJV7Q
         5NK590WyMnyji0n3UMiPLBSH8Xcs/vqGGrKDW0KR56ID+lHpn5IFoa4QPEh7qU6WLlIi
         yRNKQtCAuZKZ8IcsbfM8c4erewTcUuKqVzLRpBkSK5tHBH6BoV5ezngxoCCJX9FJ43tG
         BuviFVgqlNHg9PZfw+x/SGwaZhhgRrbmsqjNws+qjoRmodOEQVFcgD+9a3k+P1K+wPqX
         t48d3eXiQoZnuaZdupj23hAGU2gQG6H060SnC4sXuy7wsHGVNhvfmWsnuQH1Djj+Feud
         twiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711691224; x=1712296024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2mjGX0SMVp3aAe3JX3OUIFGC3HtwxrC9WrcrOvDfNY=;
        b=xJAseVLtAXF4ueAlCdvhxlThnzcd5J0GNbWq2XuL0TKSQktIEZWEf+bJYL5O+k+/Ij
         YM0aEBhT3PlbEGIVCX9hKhK/2dSVWKex8KHsVKf33mOJjdvg2KIYE0ofGW+zLLsCUwQb
         ZK/PUjhiQCdSUuMIrSHlwhPbb/AnnDZC3E1YHUf66UzEOoH64Al+UfPd3Ar963Pebbwe
         NXLL3UbX84Q4w2knuKp8nsw7KaA0vV9pzXVtUErkLRAIhe3dvPvW4SvsX4/8Z11XZAR7
         PHbVY6tbJLn01Qi+NTWXYENsWtWNuelQ48SEwHu6dsNWkMqB2nad1+dDc350lOaO/gtG
         xNow==
X-Forwarded-Encrypted: i=1; AJvYcCVaNjgGYoiDPqX0m54PKMa6RWtncPFUV24TeD6g7r2tOdz5oSDXgw743D54D0NwhhSHSHnCowyBDyw0PA1/yHaXEeYtxq57qYmTJqXx/5ol1G7UfHp+fl/uwLouq8PLq69lW/YB7NifJtLsIGYmKXHR2hoTFoQBpt0vUcHije2cyaPs0g==
X-Gm-Message-State: AOJu0YwFJ1qZadaaDSOF2YD7dVewr2W33DsQ6isZxFoyshmGVcrvDXie
	yQoWHVP/lzRZjkVX2xhZcwDOnUYB18nWgJrf/bX7iwx2PWz+fmTE
X-Google-Smtp-Source: AGHT+IH/JkdGkpoouYO3YvvMDfxjKrOGwB1PvpruKzfCExMM9LyDsN4kDmn0bP6vCuJx5y3lpFCn/Q==
X-Received: by 2002:a17:903:2ca:b0:1e1:a54:1fe8 with SMTP id s10-20020a17090302ca00b001e10a541fe8mr1907625plk.53.1711691224520;
        Thu, 28 Mar 2024 22:47:04 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:6249:183c::26a:10])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902654500b001e0b3b0e03dsm2679363pln.208.2024.03.28.22.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 22:47:04 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/2] spi: dt-bindings: add Siflower Quad SPI controller
Date: Fri, 29 Mar 2024 13:46:56 +0800
Message-Id: <20240329054657.1602450-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329015147.1481349-1-dqfext@gmail.com>
References: <20240329015147.1481349-1-dqfext@gmail.com>
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
v2: fix dt_binding_check reported errors

 .../bindings/spi/siflower,qspi.yaml           | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/siflower,qspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/siflower,qspi.yaml b/Documentation/devicetree/bindings/spi/siflower,qspi.yaml
new file mode 100644
index 000000000000..15ce25a2176a
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
+      reg = <0xc200000 0x1000>;
+      clocks = <&apb_clk>;
+      interrupts = <39>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&spi0_pins>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
-- 
2.34.1


