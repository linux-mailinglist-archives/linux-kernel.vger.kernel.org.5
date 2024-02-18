Return-Path: <linux-kernel+bounces-70209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C348594D4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3971F21617
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800A17492;
	Sun, 18 Feb 2024 05:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="S/LO0+3p"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801D6AA7
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 05:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708235327; cv=none; b=XNHpkDlagJRBB5bIYghHMJf5p4Oo91IJ1kSNkQyit3hMuBIcgpoJhUvrzUas338cXonVBA7YtWgKA2azJKywzguXa5oSOhBGKULC7LWvqjaTQ3uGlAEo8gEseyvaAFEwrOeyCGUPRYdsBMwzoh7Ui7brarSzAucq/b/FXbPEzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708235327; c=relaxed/simple;
	bh=W7msNTPwOC1JLINdPlhehwFsAdnfLVuEx5Ht5Pb0zvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NMK6/SMLs7V9psVqIY20sN+omRlSn9JIU/+2062QpG0XRzaCokEHR4BDcmrf/yFK4iAjIAjfHcuuTX4LLa2WoEDLREpqLzdegYFUgcnCci5neyOz/8m1H3xofDFfj84fkaYmmQ1RuDgOb/2GO/cHWL0AApPZamdrPeaP6VA0EYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=S/LO0+3p; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so2802156a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1708235325; x=1708840125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiKWalcCLIOMhwEVIummwXhjmBxDcdD9aBdYU63b8VI=;
        b=S/LO0+3p1FjQ7OXmg3pHx8Gzul9SEP2fjVhKa2uax3lmUtEJtCM+bGZOf8kjdguOHO
         ZabVYLNsri8HfJSsF2wilE2iOvp9RyjAlr2tT6jdZDgujLjRkd6oaZcllcW2SP0azoth
         QH1ScqESxiSDkHnTtBqHTBD4f4GVeECTKezG1KOG9G/dJlOm8Qv8VXlhcXLjq090t+ua
         9tZxN5niPUUBoxna4qXGEG+0B68gFZpZcGUIBXYH3gdRzUnDgr+5RRYtPgWMeRCiGWBO
         XqnA6hOD5a0kJpgLNss6x0BmFSRxwyu6sM1FC01CC9MUTHXfHvql2CiIa+WW+2A8OQkl
         vK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708235325; x=1708840125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiKWalcCLIOMhwEVIummwXhjmBxDcdD9aBdYU63b8VI=;
        b=aWn/WS4XFPNDnRn118LXETfIwgVvAaKCpH3MYpm0EUR/hj8zO6COAUS0de/Qd68miN
         n/v21ST7VFVMsNMoelGMub0UYiQMcDtt8HdwYCPBhkMjqQNwaOKpDlUgDLv0B77mm8CT
         2MMqSIcXY0dv7U7qT14AV/QLsUO+J68tbxlV44woxoNsZvNpvq2h2OA2Lju/D/brkG/B
         NbZ6BoR9GLMcILqWs85uK+6/8liKHfx7lx4tF7A9o/gH1hKOTI2rqIkxBfZOKDUwpayd
         y/EZKHkv5VCiUwTCy+z7CUnq9gh1oFVNVZ2POETA5fmhidAYrf0BLpeJWKVV7pSJCCRC
         Uifw==
X-Forwarded-Encrypted: i=1; AJvYcCWcxvilRWbvorpmejojah5+xl9mhvV1DxTkJJqX5+YjTigxywOkSUFajQspqhU0PzeVSGsqSsc2mPbVezIS24YsSnpMloMZLx7Vs+KH
X-Gm-Message-State: AOJu0YyCq9qL1v5GKzTGLm3gx9LAugq1ffc1cgG0KrpLmkuihZs506Bp
	A1z3SEzE7svcYD4dSoQl4bYr4zuKdHfCR+7Xaw0VppZpy856KnUorTWZcTWgBn4=
X-Google-Smtp-Source: AGHT+IFpA6aqjJbtJmtqiE1GHjIBzDYD2sLguBsdvcDN30dOKjJiQERa58NrL4z7K0w1naxkUSXStQ==
X-Received: by 2002:a05:6a20:9399:b0:19c:90fc:f0d3 with SMTP id x25-20020a056a20939900b0019c90fcf0d3mr12552241pzh.46.1708235325536;
        Sat, 17 Feb 2024 21:48:45 -0800 (PST)
Received: from localhost.localdomain ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id 32-20020a631260000000b005d3bae243bbsm2394808pgs.4.2024.02.17.21.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 21:48:45 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/5] dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas
Date: Sun, 18 Feb 2024 16:18:22 +1030
Message-Id: <20240218054826.2881-2-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
References: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge very similar schemas for APDS9300 and APDS9960.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v6 -> v7:
 - No change 
v5 -> v6:
 - Write proper commit messages
   Link: https://lore.kernel.org/all/1d0a80a6-dba5-4db8-a7a8-73d4ffe7a37e@linaro.org/

v2 -> v5:
 - Removed 'required' for Interrupts and 'oneOf' for compatibility strings
   as per below reviews:
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
   Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/
---
 .../bindings/iio/light/avago,apds9300.yaml    | 11 +++--
 .../bindings/iio/light/avago,apds9960.yaml    | 44 -------------------
 2 files changed, 7 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index 206af44f2c43..c610780346e8 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -4,17 +4,20 @@
 $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Avago APDS9300 ambient light sensor
+title: Avago Gesture/RGB/ALS/Proximity sensors
 
 maintainers:
-  - Jonathan Cameron <jic23@kernel.org>
+  - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
 
 description: |
-  Datasheet at https://www.avagotech.com/docs/AV02-1077EN
+  Datasheet: https://www.avagotech.com/docs/AV02-1077EN
+  Datasheet: https://www.avagotech.com/docs/AV02-4191EN
 
 properties:
   compatible:
-    const: avago,apds9300
+    enum:
+      - avago,apds9300
+      - avago,apds9960
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
deleted file mode 100644
index f06e0fda5629..000000000000
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
+++ /dev/null
@@ -1,44 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/iio/light/avago,apds9960.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Avago APDS9960 gesture/RGB/ALS/proximity sensor
-
-maintainers:
-  - Matt Ranostay <matt.ranostay@konsulko.com>
-
-description: |
-  Datasheet at https://www.avagotech.com/docs/AV02-4191EN
-
-properties:
-  compatible:
-    const: avago,apds9960
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-additionalProperties: false
-
-required:
-  - compatible
-  - reg
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        light-sensor@39 {
-            compatible = "avago,apds9960";
-            reg = <0x39>;
-            interrupt-parent = <&gpio1>;
-            interrupts = <16 1>;
-        };
-    };
-...
-- 
2.34.1


