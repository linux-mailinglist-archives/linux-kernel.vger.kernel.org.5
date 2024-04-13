Return-Path: <linux-kernel+bounces-143866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B1B8A3E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25ADD1F21783
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1557884;
	Sat, 13 Apr 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsrL+Z4O"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423095490D;
	Sat, 13 Apr 2024 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713039775; cv=none; b=RzH7dNQbSeG+r5KrCRBv+gOE9JN6AmGr+YkNcESpf0LQ6tXIBfLaKaOWfhg29yogHN6hygwJ15B1hwwNQLnDbTVz1vPnr4H7sFpa8++B8PkUstEGH5mnLVomkRbnBUfLYjBaWBMMAjp+PagpwFYSowqkGH/ldVDnIydiI1Nrgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713039775; c=relaxed/simple;
	bh=BajpLIZvweL+aLqlkIOgDvaU5J35KCKUJstIeHQsxoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgOsMr0pMTc/lhDDxzIQOQQYTxrQ57/0u99EGdFYAYLFHjPue8fZm/qvI0uHy+lCVMFDBycwVFBIuguWdc1WU2Ctl5NQ7ZIvr+ic81kEp6FMBDXle3f7z3CBZL9H7D4TH7N9o25bXrtGt0sacKSSE/9xR8FRKOKVUfxC5pSvxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsrL+Z4O; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso21996911fa.0;
        Sat, 13 Apr 2024 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713039771; x=1713644571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bf5pKtth7HyQMR2CRAxRCRRYX77dJfg+HACjzgrcpPA=;
        b=NsrL+Z4O72oafMbC2BS4XzfKGpLONHFUGyjfNdrCuOHsxYhvDWTJnSWqtesAizfDtR
         bYf+SlrgO3tk90pi0cukf7gLBLiGFyBrkuHxl4IwG+GEF6XvRY9X6V62dCSop0vZexrc
         AY0R5qCxAeRRsi2HUSKgPfeQ5l3BiJA4GUudAOqlBHVzZrrkqlp/Ql6/vsxPvOTiXb4c
         jPGKP66kwzGcjJ4ziIPmW1vKSYKby2k9GVVmnG3ehlwfGB+Nj8WeG88jg4Dytupidyho
         hlmRE8Zjl9nayQIZksma7U5sXpQ8vS0V5OxLC6wNcCtRstZ4IzV8cYKHbMrSNfjmNotp
         CeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713039771; x=1713644571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bf5pKtth7HyQMR2CRAxRCRRYX77dJfg+HACjzgrcpPA=;
        b=ezVj1p41t9fpmQdLLLqlhzJVWBaM9xrSvLEFPJkE3Q45j5kfZONugAfeVfUs7XB8Rg
         lVXpUoz9UR6z5X5mKPVkW00686jIqh1Bxcbg+6JWbt3M0EULcrPxA26pm6JLqLPvLl0K
         Grw0nr60/S6oGYtFTL9NcPkM1Fy9z4hefCRb7E/0Oqj8s5jkjuuqc+z8bmUBmriXzCoa
         SE0B8Gxg6vUD6BcZQLbY9j2kfKIV98DPbqGOQghz7dKJtU3FfUUYTscyqV5qHT8GrMOp
         ic0hWogBYvB94J6cWN9kYPulLnhX64m0P9jDf9ZyqKUZUPFiBNjTHklVMgQZVuBX0N6u
         7mlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8KPg56shsFY/ox8ojmvGWKsdkO+rzB1Zyt5jDCny0pgGcAER32UH3oKtTcnNdiHkVXVNN+wSeQfMxy4E2zEQfB1OtyK/7GQT+s01KNMnsNuGOTrh2JxSFv1zL/AWrkVx1LiXphVqXHg==
X-Gm-Message-State: AOJu0YyEowm/RPsan6w6JB6AMbm1UPcfwT7g7uBShty/pJyL4aQYhprM
	mzqF+mkOSpCsdWVTvfEuOfksBNfh8YHXjiR1lTcvgq/JbcYP9ocA
X-Google-Smtp-Source: AGHT+IH8pm98C+MIRAOaUO30GuhCqlA7nqVnCkzi+qWv1twrQuvRXLCHEscsJF51tgcr39Bl8I72wA==
X-Received: by 2002:a2e:b98a:0:b0:2d8:7320:e36a with SMTP id p10-20020a2eb98a000000b002d87320e36amr3641252ljp.17.1713039771430;
        Sat, 13 Apr 2024 13:22:51 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id f16-20020a056402161000b0056e2f1d9152sm2881222edv.93.2024.04.13.13.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 13:22:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 13 Apr 2024 22:22:19 +0200
Subject: [PATCH v3 4/4] dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240413-rtc_dtschema-v3-4-eff368bcc471@gmail.com>
References: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
In-Reply-To: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713039763; l=2723;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=BajpLIZvweL+aLqlkIOgDvaU5J35KCKUJstIeHQsxoU=;
 b=S/47bucyIciRGwOyIDM4sCMC2ax8kTneRsSd1bLRdQE94vG3Y0Nxyh/wm8FM1t7r6CkFTA87M
 btFBUkYaNdOD81nx3eSUsBIfPwCF1xZL4/z7cQjrzsUTpq8WroVMQuO
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation and
add the undocumented compatible 'fsl,imx23-rtc'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml  | 51 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       | 21 ---------
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml
new file mode 100644
index 000000000000..534de4196a4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/fsl,stmp3xxx-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMP3xxx/i.MX28 Time Clock Controller
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx28-rtc
+              - fsl,imx23-rtc
+          - const: fsl,stmp3xxx-rtc
+      - const: fsl,stmp3xxx-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  stmp,crystal-freq:
+    description:
+      Override crystal frequency as determined from fuse bits.
+      Use <0> for "no crystal".
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 32000, 32768]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    rtc@80056000 {
+        compatible = "fsl,imx28-rtc", "fsl,stmp3xxx-rtc";
+        reg = <0x80056000 2000>;
+        interrupts = <29>;
+    };
diff --git a/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt b/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
deleted file mode 100644
index fa6a94226669..000000000000
--- a/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* STMP3xxx/i.MX28 Time Clock controller
-
-Required properties:
-- compatible: should be one of the following.
-    * "fsl,stmp3xxx-rtc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: rtc alarm interrupt
-
-Optional properties:
-- stmp,crystal-freq: override crystal frequency as determined from fuse bits.
-  Only <32000> and <32768> are possible for the hardware.  Use <0> for
-  "no crystal".
-
-Example:
-
-rtc@80056000 {
-	compatible = "fsl,imx28-rtc", "fsl,stmp3xxx-rtc";
-	reg = <0x80056000 2000>;
-	interrupts = <29>;
-};

-- 
2.40.1


