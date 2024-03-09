Return-Path: <linux-kernel+bounces-97860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE31877095
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EC21C20B3A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5813A8F7;
	Sat,  9 Mar 2024 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="Ieu2+4Cg"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BEA381D4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709981524; cv=none; b=R+JNVtMGzceSNnZ4edrVIYAADleMQPPlm0vdnHKTfJgA0S/ypR2iI2ghN0Qv4GrEXlNM3mkEoV8cDZQ+rHT1xebVex8wnFokc5IY7+jeKy33UERDN7kS7HvL24hIXamKQSaUy5hZ+MTFWAe6sdTSZr1uf78Cp2Uw9mEKehnIc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709981524; c=relaxed/simple;
	bh=hDBSELfog980UJsB1AHu3cDz2jpqL2QkVWTF8TkILpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gbhRoSUIQbbL2fC8ekKiPpKGwHqwKowdLneyDwImSXkVHvUx3ckeO7MHQZAZHVrg0aL7U1aqN7K73bLLEDaie9WbquwhwYjJ/cuCdsdyTS+TrhsvfLsAomw1bC8glaiV4Ev5FVAme/8HH/Nq9GJZjdSCZleJ977v8Fl4rF3PdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=Ieu2+4Cg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so1945049a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 02:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1709981522; x=1710586322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0vW8+8EPIeJP2ze/+Mml88eQ6oO36U77YTuQq6Bbbc=;
        b=Ieu2+4CgE1Ly9nGnMMivZOE+I5TmRJFDFV6OvavlEf0sqoAoXDmii+q0g9vTkp+QIi
         r6e0YjVos1ZtrxKGLJcPgTe1hB9jBqfO4lSzDzeXGYcgRmzHqoKg2UimWlA3s4gJWS1r
         SoGaHA+QngZwPbQqwINzbHqai+q7F4Nt6UCekbziso3lsn7qrDAikJyIXm1oFcxj+WTU
         bbl0iYZ9I3FUbdxo0ukhKh3zMlVWoHzOxLJ3IWV5GyExXM70of9XRr/7fziLKe1huJ/A
         4mzYFFins0Pfjxjo7/NqQDhRKt+CdWnyxjW5YTW/nFlxRKj81rJqQfd8g7aju1oW3aFL
         i/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709981522; x=1710586322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0vW8+8EPIeJP2ze/+Mml88eQ6oO36U77YTuQq6Bbbc=;
        b=fQLcDH/z61t3YH4ojEmWtvFT+Cch0IV5T36Sd60+xXED2V0yOJJhGtOHwMJ6Qqf7d2
         laX71HfnylCz6c/CdM7L/nmOEgIgbUv00XT/DCw+59X9nl6W8P5zzpOpqrkdajL73+kN
         k1Corxcp58DCMPzFHJD5Jz8twye12rEncKY2mDnWtPs1ky++Dshh2ysJrpdYR5BDVqx8
         J2thF4XX7qqpN02QzFBkwqACxyresL6JIue6F4U3bafPSaUSEVrnyNGqKJIUuol8zVuC
         7DY3Jtm2trbSQEFxDxSq/JOoSHo6ZFezn8jHb+vJwLRJr6A1yvuZwrB63MuIXMFkZwFG
         bwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6cFzdn4eyxAH31J6ljZnysYuZNI0wKU7b2kSdT0JOPQUWcvE+WjHJ11m6FreNDQIV02OLFtD0b9HOAQouVvh41btVfDR3Ic3erVx
X-Gm-Message-State: AOJu0YwcfGxImRWaGuvVLSAvnLtR4BEpqZPwhIaGblVXS4P7sESYj19i
	PWgJ/pOxDZQdg8PttD3O1Vy8t3X/i1SDORxhLE3QwVyffCqn0pgd1u2kenMsVE8=
X-Google-Smtp-Source: AGHT+IHsCNb9C2QlSZnpREnzl4XF+4vRHpxTZIwp33Mv1k/wgc7UQ36zjZSm7Z+S+AshupuoUOD84g==
X-Received: by 2002:a17:903:40c3:b0:1dc:d50d:f669 with SMTP id t3-20020a17090340c300b001dcd50df669mr987861pld.12.1709981522004;
        Sat, 09 Mar 2024 02:52:02 -0800 (PST)
Received: from localhost.localdomain ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b001dcf7d03824sm1070608plh.55.2024.03.09.02.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 02:52:01 -0800 (PST)
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 3/5] dt-bindings: iio: light: adps9300: Update interrupt definitions
Date: Sat,  9 Mar 2024 21:20:29 +1030
Message-Id: <20240309105031.10313-4-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
References: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include irq.h and irq level macro in the example for readability

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v8 -> v9:
 - No change

v7 -> v8:
 - No change

v6 -> v7:
 - Removed wrong patch dependency statement
 - Added tag
   https://lore.kernel.org/all/20240210170258.17fd1099@jic23-huawei/
   https://lore.kernel.org/all/20240206-gambling-tricycle-510794e20ca8@spud/

v5 -> v6:
 - Separate commit for individual change as per below review:
   Link: https://lore.kernel.org/all/20240121153655.5f734180@jic23-huawei/
---
 .../devicetree/bindings/iio/light/avago,apds9300.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index a328c8a1daef..e07a074f6acf 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -35,6 +35,8 @@ required:
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -43,7 +45,7 @@ examples:
             compatible = "avago,apds9300";
             reg = <0x39>;
             interrupt-parent = <&gpio2>;
-            interrupts = <29 8>;
+            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
             vdd-supply = <&regulator_3v3>;
         };
     };
-- 
2.34.1


