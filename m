Return-Path: <linux-kernel+bounces-31968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A598835490
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23976282AC7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 05:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CB7364D7;
	Sun, 21 Jan 2024 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="HU/Tvzsn"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F983611A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705814281; cv=none; b=lH0HAMKTmzJE/wMjL/di4DFFExFznl89IjkLOeJEgWgzKg/Aq9lZ4bFsZBPYqMtjtDf+vF+YwrwxQMn8DytJ45hIstXlVyic4rU9DbmMqqsEtHAWqaKS+2OeWKV2N/WLJ7BcYD+Afpa3pAJQ+IbwjYaYU/zehVtWK+5de2CoMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705814281; c=relaxed/simple;
	bh=9PPgyl4c02AhR7tsdj/3jHF5jJWRSgTdQEG0MfhuJW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pR6V5hforp+TUpkmN0DXhMTvATmOX/kZvszvpz5nKlD+KmFM05dp7sb9+0hgQTvE1TPcPvXYOMYQXWQ+oA/sHfzUCPGkg6z3vFlAKJLDjRYqG35j1uqDlczVH77E0WXofjQ9Tiew6M5FvGa0s+yMWu3dTGrKUIaXPhDmQe20nVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=HU/Tvzsn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da9c834646so2170812b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705814278; x=1706419078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbZe2AzIkKy+l4ATOd5FQ3m1RMu6EicdGaUIFG7TJls=;
        b=HU/TvzsnK5Fq+1Re4RIUSjQogNCvsbQ/PcWz66oY/FNGgUZkO6WYaALZMeTH5uMHp4
         BcnGJ12iXlEjsD5Ck527bHmP8wMyRIWUGSlXC/ToZFyhL92Yqk8JDhQGSeWrbEv82ZN8
         dX8etNCuRenb+Z4qWmcZh6Be4OFXV/vm2Bed1vYJ+NnI8Awf5V5g0Pzh4ivSSkVovDsj
         arA0i2CuagxyoSq0jjh5hMyn3eohYk5dFkvxLIaGLsE2j0HH4cGvd1A82lcSH2CQKJHz
         DPftZ9/SX8tJgn+B/MEFrI3hHHE0QhaGFu73Ubz32F88jXrDmkoPgW2OhguH7rzMle+O
         1NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705814278; x=1706419078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbZe2AzIkKy+l4ATOd5FQ3m1RMu6EicdGaUIFG7TJls=;
        b=M08jbZ+c8aqXg1YmyS29jwfGrdgDCSvNqx4hiNC+zeyzw+WqOpfx21Vi0LwaAqau/Z
         MgRLd8HFkVNMHBPd5fJxX9+HcbR2tz5hRE2sk0KqNxIfbyBRN4y85FcILlwKUMOl0Y45
         blWr9eson+G4OgZZoCkumML2HGAjtb6TAPBcHB1lqf0RDAU9dQm4oiTe2Ihhd37jR/FP
         8WW+q8sfYwCSgg0a1qlUPJ7uZQtiBQ3iWSu64wF21PpaIWFjfGJ0ZmdmeTW/HaNMhQ70
         qGnNDgMWfQqx4wna7Q65hgpGMxN5O4UeAAWUeJ5eXPF9rzzbgG55LAsc5Q1JxzLsdRnW
         BiQg==
X-Gm-Message-State: AOJu0Yxr5I5BdSCoEWDuElYWcJQucte0D0YPxt+j43KXHzgsyK+xsV81
	uxe/dQZ+CFdVPDiUZN9o6i8DSQG9cJjMM1yVNlZl3BqRAfLmSzOMBvyF9n25g20=
X-Google-Smtp-Source: AGHT+IFevGHaPKM+SIBslDZEahr4PU5NhW4eEVPcS+/9n12nXetRoXAFD6wxA8n1WRWV1BaAFBZizA==
X-Received: by 2002:aa7:9d1e:0:b0:6da:b959:3782 with SMTP id k30-20020aa79d1e000000b006dab9593782mr3416555pfp.35.1705814278565;
        Sat, 20 Jan 2024 21:17:58 -0800 (PST)
Received: from localhost.localdomain (2403-580d-82f4-0-3fa1-f9ce-6074-3bab.ip6.aussiebb.net. [2403:580d:82f4:0:3fa1:f9ce:6074:3bab])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a000b0600b006d96d034befsm7547196pfu.30.2024.01.20.21.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 21:17:58 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: iio: light: Avago APDS9306
Date: Sun, 21 Jan 2024 15:47:33 +1030
Message-Id: <20240121051735.32246-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding device tree support for APDS9306 Ambient Light Sensor.
Updating datasheet hyperlinks.
Adding interrupt definition macro and header file.
Adding vdd-supply property.

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v2 -> v5:
 - Implemented changes as per previous reviews:
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
   Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/
---
 .../bindings/iio/light/avago,apds9300.yaml        | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index c610780346e8..bee73a590424 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -4,19 +4,21 @@
 $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Avago Gesture/RGB/ALS/Proximity sensors
+title: Avago (Broadcom) Gesture/RGB/ALS/Proximity sensors
 
 maintainers:
   - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
 
 description: |
-  Datasheet: https://www.avagotech.com/docs/AV02-1077EN
-  Datasheet: https://www.avagotech.com/docs/AV02-4191EN
+  Datasheet: https://docs.broadcom.com/doc/AV02-1077EN
+  Datasheet: https://docs.broadcom.com/doc/AV02-4191EN
+  Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
 
 properties:
   compatible:
     enum:
       - avago,apds9300
+      - avago,apds9306
       - avago,apds9960
 
   reg:
@@ -25,6 +27,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+
 additionalProperties: false
 
 required:
@@ -33,6 +37,8 @@ required:
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -41,7 +47,8 @@ examples:
             compatible = "avago,apds9300";
             reg = <0x39>;
             interrupt-parent = <&gpio2>;
-            interrupts = <29 8>;
+            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply = <&regulator_3v3>;
         };
     };
 ...
-- 
2.34.1


