Return-Path: <linux-kernel+bounces-110570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8CE8860BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A2E28274F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8991353EF;
	Thu, 21 Mar 2024 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXon3lwB"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FF134CF7;
	Thu, 21 Mar 2024 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046645; cv=none; b=UGqf0+uLLh8mePDntKGfeyJ/5y0p29xwUCqM7LrloMz7+wQmq3VwZySujntXtVauz/ltC5rSmoS17Gvu9dKhy/IuH3QmAG7X6YI3iSdMuzk3MlpQD3CYzqCbnRHCy98yxzi3OuZLpaxFvgkyDT5K1D6i0iPoxD5SexbN6ashqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046645; c=relaxed/simple;
	bh=V6VzvACmmg1HSyifxT5g+gPzhNzirrHnP3f/hmF8jMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0bE3RJ2DavaoxDIDcoUB6KMeLDrk37VQS9Bw8jn5Sl5YCypkd0ai7vV+WsgctxEFB/R+x0rqfnZJBaZezgI0YLHiG78WmdVVNaaLmcZSmYUJuT33prgOCPa3WUtb+M8VPUB7+oVYaBpiujxUhYD+ef3LIecD819FONWcbORrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXon3lwB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso157543666b.2;
        Thu, 21 Mar 2024 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711046642; x=1711651442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZP+gNYu/Kkn8nZAdI78yJHmmqjo52vGxGg0tHY+NoU=;
        b=UXon3lwBlgxUTDfDVIeJ0P+2Vuvd9PlM6v2qK0LXcTSYLwJkLsv3xi73iwOz9vC4vY
         33xsU9IuSkKLYK3yAs3QsedjL9nHtVEy/GYwjecC2pko/fYBQPwnt4Vy1S1B2sL2AolE
         Mbu9yJ8/DKqKUk7HqYbzt0glg6E96DusqtbXQcbrtsSv7PqAfGvBYxONQL7Tgy8jbeE1
         /KHuIt9M6LBEcrHbSYxABwWAZC9Yfwt1o7SrwbDC4XwSaLXPXZJiqMrMlxG3rWtA2Yos
         dR72rmgOahBBud/GoXG4YE/oCKAintcV6QaUSN50vR4VbttlDzhfbkXWgHm4nkiVSjwn
         UJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711046642; x=1711651442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZP+gNYu/Kkn8nZAdI78yJHmmqjo52vGxGg0tHY+NoU=;
        b=A+R9p+p4ByisNi2tV08EU0J0q13ZxUN6US1+N9Qkv2WFo6Qfc3CdjR/P7QAWuhdq1g
         /kB1kQ0LBe6mtnX5GZ18kQAmFRnKFdjA+5WrsOpHabzjDAUd0qAV2TWykQbzkjSyj59q
         wR73qK+OohTyJZ9qb+gLxlWtvd7D8pQrvcc25RpIrvXT6BVbTeUHbync6DY+gKpHhhX9
         bZeIPIBNJUtAsSMPu6JLf+FbpUgW8udzZyV4FwbO6Szidx/jFS2H/aGfM675GfrdRh4E
         weX/4r5NlEN4/lk81wLHXpoSLt6ZD55AL9T8wN+0CDcm8i4SGS54BIPrFqkSbbmJ52Lh
         o0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUunAdk0mjKz9IPb0L+a1Os5zDc3WrU0dvw7yZ2O6ttA1V1XR+rFrNxEbrqB+Uu+ZUBA4LWVxsK3eJn07oR3PSa+Id0RiOxT7tAMRhBhnxHubCU00S0Uo+LbLZ5x4zDqa82CssiLq94dg==
X-Gm-Message-State: AOJu0YwqHC25f6Lp8mV9O9lAx5b7TbTkRmq8iYE8SaS1Qccd86/K8urj
	hexA51Mh+6hbwkqMx+TmCc46FYSZk7XjOMHoAZAHDFt2ZhLs5DKk
X-Google-Smtp-Source: AGHT+IF7he+6hAV9Yv95T9uxTXIAXg6hiYAdZakGXqqD9dT16Y++ep9u6yth94oazmiB/4HP9J5m+A==
X-Received: by 2002:a17:906:278e:b0:a46:f888:70b9 with SMTP id j14-20020a170906278e00b00a46f88870b9mr197252ejc.51.1711046642214;
        Thu, 21 Mar 2024 11:44:02 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7db2-5855-2c59-b89b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7db2:5855:2c59:b89b])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00a4576dd5a8csm188627ejd.201.2024.03.21.11.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:44:01 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 21 Mar 2024 19:43:46 +0100
Subject: [PATCH 5/5] dt-bindings: hwmon: ibm,p8-occ-hwmon: move to trivial
 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-hwmon_dtschema-v1-5-96c3810c3930@gmail.com>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
In-Reply-To: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711046632; l=2007;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=V6VzvACmmg1HSyifxT5g+gPzhNzirrHnP3f/hmF8jMU=;
 b=TXRk7ekifN2YtRLJ/Oo1oWCpa34HsD7o7GbskHBhTUhjZ/+c8V9/Lo9lAKj1cgeGDnIUGQN/h
 5eAaiamzRueCoaHV4HQTQMpkmSZUfx9tlT1/TlKltdb/wu3ufWHZaUu
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This binding meets the requirements to be converted to dtschema
via trivial-devices.yaml.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt | 25 ----------------------
 .../devicetree/bindings/trivial-devices.yaml       |  2 ++
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt b/Documentation/devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt
deleted file mode 100644
index 5dc5d2e2573d..000000000000
--- a/Documentation/devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Device-tree bindings for I2C-based On-Chip Controller hwmon device
-------------------------------------------------------------------
-
-Required properties:
- - compatible = "ibm,p8-occ-hwmon";
- - reg = <I2C address>;			: I2C bus address
-
-Examples:
-
-    i2c-bus@100 {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        clock-frequency = <100000>;
-        < more properties >
-
-        occ-hwmon@1 {
-            compatible = "ibm,p8-occ-hwmon";
-            reg = <0x50>;
-        };
-
-        occ-hwmon@2 {
-            compatible = "ibm,p8-occ-hwmon";
-            reg = <0x51>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index e07be7bf8395..87b0dd9b0734 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -126,6 +126,8 @@ properties:
           - ibm,cffps1
             # IBM Common Form Factor Power Supply Versions 2
           - ibm,cffps2
+            # IBM On-Chip Controller hwmon device
+          - ibm,p8-occ-hwmon
             # Infineon barometric pressure and temperature sensor
           - infineon,dps310
             # Infineon IR36021 digital POL buck controller

-- 
2.40.1


