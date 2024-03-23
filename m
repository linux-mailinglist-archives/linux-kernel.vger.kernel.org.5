Return-Path: <linux-kernel+bounces-112506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0823E887AA8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741FC1F21734
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584785C61B;
	Sat, 23 Mar 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hmwa9WiD"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8DC5A0F8;
	Sat, 23 Mar 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711233993; cv=none; b=tsd+0MjvxNs92yT7zSiWebCbZLrvmD/N4s6M78wmzU11FAVriYb7FHGw0zyyHqtcHgwNJyqdvhPpMwAtv/jHaBVD+6PulhdpYBqF/b1ioJ1PWMFdj7unHoukpgBnJwgKdoBqrCjE2QlW3HlFA2Lc69lJYM5g0YEAXjxc1izfdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711233993; c=relaxed/simple;
	bh=1VMNQXmeUQY7C0pUkOYDvJgVAie+xO6NAGifkWicA7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rlN7M+NOTYtNaRMf8ND4JwHvdvO0ZAkxLxnvePx36DcYGlVGKmar0ZWyZpHyUeiM8yK/P+FL9TJ6eAI1G0vHZp9q0U4gOjpnU9Bj+WxFSzvTVQVwho//KXsArlIv0sB4y6n0fC+xvCWGsn13RdhCDScWdH9rJfuyANWxft2s8X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hmwa9WiD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46f97b8a1bso419853866b.0;
        Sat, 23 Mar 2024 15:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711233990; x=1711838790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBCpb6Wf0XTbTigPp4MVj4IpbN3WREllZU5o7XvaAks=;
        b=Hmwa9WiDwPjiU0CzSw6hSbhTKuqZnYl5J5zrWZl6vLgbhy/fX4ql7/l8p2Q49sr+ny
         LcmPPm6yTnQ6ELITm/ag0tsd+ouVEf0NU69elEyIZRq+VKTzfCA1dkjxOnutBn7+ASUd
         P5mPkB6Rb7jR5gt8pG3U3NPxgCQcC4LUcYS6M/2tAd7ZAPJh8caBIYLZVBaIbZcpz70r
         eukd2oY3GYPW6xoraiRnjnb/q8PH6iu1DNuY/lsEh92DNEivwvkS4l3L9gE+rDJIaEyz
         85XU0uHiVcfAcJ7Nl4GzOk6ZnlfFq5xIlcHL37JUc+wbMjjjr4TEL2z92a/1vhIpldFR
         MAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711233990; x=1711838790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBCpb6Wf0XTbTigPp4MVj4IpbN3WREllZU5o7XvaAks=;
        b=CfiN4hORa6I3qJsRzJH/e09JJxI3fG8uuj3x+sqoIRyeVOSrOB+5bplUZOeRcf1nQL
         o4QlMSleujP8f2+Klsh/YdFa3nJSYN75Chj+rF9YyIJe4XZZb+f6C7PVdyVlPeFssfLG
         1j1CdHRAsRITS9ZCLy3CEcGu1aIuseh0Rhj2oEsk+ebYpdcpx5Mt0jiNiuyH0E2OG6ho
         kHY7Xb8V0Pt8pQucX/NnYH+xAoGTbqVptk5YZYGFLL5sanGfNLQPYgcyUbyuZTi8tGbO
         ztTiMw0Vw+5aTkMyQZIWm3vmkosQPBwT/a/wBhGKGL82ibYMNVvlYACdkYkaXWQDUpWr
         rIxg==
X-Forwarded-Encrypted: i=1; AJvYcCUXcf0pcue7mp/349yAZEh7ui+pNqpYMsZqCtrKZDlPUeCuiNps1fXWcVIi85/inVe2I6M1zFR1GBH5xcp5OnPqcJmfUXrtOfKne5FcY7urOH/tcoZVM+1GTc8yxrsNBWvutKAErzqSzw==
X-Gm-Message-State: AOJu0YyGn4GpCpvAoE2NwUg2XVwmRxtKE+NU7U6hT3IUR+HafQF6pttW
	n32p/VMPl3+WV7i6vaf6n12kLzLV6r+vxD89gGEzqUZSFEiI6F7l
X-Google-Smtp-Source: AGHT+IHZFufQTJf2mMNcT4PHhG5kTCywxCFCFzNtkewebtg+5rnmIe4lLw29zdRpZWCi/JPv9nZZjA==
X-Received: by 2002:a17:906:ce36:b0:a46:dd30:7cb5 with SMTP id sd22-20020a170906ce3600b00a46dd307cb5mr2525609ejb.76.1711233989853;
        Sat, 23 Mar 2024 15:46:29 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-195f-8ce5-d7d9-2242.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:195f:8ce5:d7d9:2242])
        by smtp.gmail.com with ESMTPSA id bu22-20020a170906a15600b00a461d2a3374sm1350424ejb.47.2024.03.23.15.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 15:46:29 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 23 Mar 2024 23:46:13 +0100
Subject: [PATCH 1/4] dt-bindings: rtc: armada-380-rtc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-rtc-yaml-v1-1-0c5d12b1b89d@gmail.com>
References: <20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com>
In-Reply-To: <20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711233987; l=2880;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=1VMNQXmeUQY7C0pUkOYDvJgVAie+xO6NAGifkWicA7g=;
 b=pgRthcH67RYVpV2KMYVagY+TjvK0mIydNmeOOj/wzvX9rHTU0GiqKSBVHNdYNJPl/Wd8fM4/q
 6lvwvStx140ASoMJxumPOnfM6weigsCIYSVRLDnPo81/6KuuuPuPCKM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

This is a direct conversion with no additions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/armada-380-rtc.txt     | 24 -----------
 .../bindings/rtc/marvell,armada-380-rtc.yaml       | 48 ++++++++++++++++++++++
 2 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
deleted file mode 100644
index c3c9a1226f9a..000000000000
--- a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* Real Time Clock of the Armada 38x/7K/8K SoCs
-
-RTC controller for the Armada 38x, 7K and 8K SoCs
-
-Required properties:
-- compatible : Should be one of the following:
-	"marvell,armada-380-rtc" for Armada 38x SoC
-	"marvell,armada-8k-rtc" for Aramda 7K/8K SoCs
-- reg: a list of base address and size pairs, one for each entry in
-  reg-names
-- reg names: should contain:
-  * "rtc" for the RTC registers
-  * "rtc-soc" for the SoC related registers and among them the one
-    related to the interrupt.
-- interrupts: IRQ line for the RTC.
-
-Example:
-
-rtc@a3800 {
-	compatible = "marvell,armada-380-rtc";
-	reg = <0xa3800 0x20>, <0x184a0 0x0c>;
-	reg-names = "rtc", "rtc-soc";
-	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/marvell,armada-380-rtc.yaml b/Documentation/devicetree/bindings/rtc/marvell,armada-380-rtc.yaml
new file mode 100644
index 000000000000..388c7d7a044d
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/marvell,armada-380-rtc.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/marvell,armada-380-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RTC controller for the Armada 38x, 7K and 8K SoCs
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - marvell,armada-380-rtc
+      - marvell,armada-8k-rtc
+
+  reg:
+    items:
+      - description: RTC base address size
+      - description: Base address and size of SoC related registers
+
+  reg-names:
+    items:
+      - const: rtc
+      - const: rtc-soc
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    rtc@a3800 {
+        compatible = "marvell,armada-380-rtc";
+        reg = <0xa3800 0x20>, <0x184a0 0x0c>;
+        reg-names = "rtc", "rtc-soc";
+        interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+    };

-- 
2.40.1


