Return-Path: <linux-kernel+bounces-168088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6459B8BB384
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D948B1F23B02
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDB1158865;
	Fri,  3 May 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReX8Yf8L"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C99154C12;
	Fri,  3 May 2024 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762526; cv=none; b=OcTuS/BLOEI+lWh+7/pyGD070T1diD/1QIB4ZEv3t4zsvTCb71YiFSt2tsxYAsPaywp0fkICMzrPbd0jkDzmAM9Wgg6c15ekDNMrc8i/QjqlVzTJoK1A2cmX8L+kRlADeLAKMlEQ+2Ehs5Qfcnbtn11kB7MAnvujLF82zwk+Z9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762526; c=relaxed/simple;
	bh=iSL/9TbpKZMCrEtopfNilhigbnt3bHY73t6ih8p4REI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h+qvzwZWyjpTKmcApVROM4g2V0HuQc4Z0HVKGZckKVi6GX0z7NvdmnaYWVlCbHhHP3GW1I1818HKuBVp8TQOjbnYdpi+kZA+BD/1vBp+rxpVZFvWSPGlExlF6h96k+hK982xaF32jcCyPMHtbDuXHp2ILw1xjeeLQd0q1kuYhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReX8Yf8L; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so11546050e87.1;
        Fri, 03 May 2024 11:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714762522; x=1715367322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbmcMWxuo0P18e6D0ea2liBuANMn4GXXURkDxbEh2Ck=;
        b=ReX8Yf8L65sDeJFvRNJCF6HHiLNFXWKjNlFrs6hwKYD9m1PioBgjJlWh2j8iy4J30q
         YrZkGg26bH2x+5mnf0GCmOx5pRGuKmVLu70RuW4cuMGiI/lHEAb5kPBEFN/9L7kh8aR1
         pOOCJd5plRQMkqXU+u7wDcehTZEWOgW435a7bEACLOIpTnCzhu+BqHxNl2oiDbY+i9Mu
         i4X5ZPzzL9fGk0n9rv7Tu8LlgJQZJju81ckK8r5CF1Fa9lpMHnb9ie3+O4oly59+CB6c
         z+HdKWhVCskkH9xa+wR+jAEzfgsc1IWVQmWI7NImtirPpU8NPIjTtFBY9MpYrV70qn6c
         tvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714762522; x=1715367322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbmcMWxuo0P18e6D0ea2liBuANMn4GXXURkDxbEh2Ck=;
        b=kC9V6uTBNJxPeUwj8kOXqsBMUw6a6wdwdiAIBDzqQHLATEitg6fTj/4DwDT1yA2F2l
         VB3bsnhCZTu5LaGXIAuVRaSlIQfhOrbp02dphxzAa2dNV30Te0SL+3alPTxvlq/V57eD
         jCzj35L7cW1lCBaFXb02a54joCh4JUnFtW2dSsEJCXpm7y4OsEf0ur7MT13Ap7ls3nAo
         2+oNgvoK/t/uDiJnOJaz6xrUsiGY1CmSmVYjgH+Mw2mxVCNj9dKsLAeAQ/RcdHAhrLWy
         B8xQyiKC6WVSMidt8SesJ9w1YS8FD4dAXloTD2MReWoVL51KfkELLUT5xjh6USQKkd7G
         Ig9w==
X-Forwarded-Encrypted: i=1; AJvYcCVKM531evmbi+uwR/p2defEXbjvH073PYK6f+RlDpU4oJvqlUChz2y5LVfKgjvbU5odKZptjuchR26/w4Nt9IOjtCFk7MSBLJG/sH18zHpHLOiBDrHRw9/c+vnDDzW4IRgBxO8h31ivOOL28uv7HHQDFOjBoReM1t0YRFuisq47mi3rxg3clEhXzbezmJB/MbEe2AQNyntBS7VVxKwYLyWJJMri56WcIDk=
X-Gm-Message-State: AOJu0Yw5ttG4HtOQgnYIXbFWh5PPNYbVThXzwrlDcDtpU2/1TTG4wt7S
	7cO7XOFjJydsYh/XYa8NsMDXmPqpUKxCwguYNYOsj5ij8MHN5HL2
X-Google-Smtp-Source: AGHT+IHxuJfes30dEmvdnSiiOTWELTaaG0Zgc39pHJXiEjvoeWJvMYPpqTzzw8aPSPJHb+gxO7ayMg==
X-Received: by 2002:a19:2d5c:0:b0:51f:5760:dd34 with SMTP id t28-20020a192d5c000000b0051f5760dd34mr2227092lft.55.1714762522300;
        Fri, 03 May 2024 11:55:22 -0700 (PDT)
Received: from hex.my.domain (83.25.185.84.ipv4.supernova.orange.pl. [83.25.185.84])
        by smtp.gmail.com with ESMTPSA id l8-20020a170906078800b00a598d3ddf8dsm1104618ejc.28.2024.05.03.11.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:55:21 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 03 May 2024 20:55:11 +0200
Subject: [PATCH 1/3] ASoC: dt-bindings: samsung,midas-audio: Add GPIO-based
 headset jack detection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-midas-wm1811-gpio-jack-v1-1-e8cddbd67cbf@gmail.com>
References: <20240503-midas-wm1811-gpio-jack-v1-0-e8cddbd67cbf@gmail.com>
In-Reply-To: <20240503-midas-wm1811-gpio-jack-v1-0-e8cddbd67cbf@gmail.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714762519; l=1850;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=iSL/9TbpKZMCrEtopfNilhigbnt3bHY73t6ih8p4REI=;
 b=84P+PrhoPK9SG9icveouBZi2fkf11bKuxyjdVfmtV3cwHD9/v77W7mjlchFTt/lJ9bwTEE9hQ
 DCYby6BSQPDBGUfIYW9w4C9YUh1EE+E6U+7VDmfaJ7n5Avw64nS7XHD
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Some Samsung devices that share the midas-audio driver use a GPIO-based
approach to headset jack detection, as opposed to using the built-in
jack detection provided by the wm8994 driver.

Add DT configuration values that allow for describing these setups.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 .../bindings/sound/samsung,midas-audio.yaml        | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
index 6ec80f529d84..9f521131f2b3 100644
--- a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
@@ -61,6 +61,36 @@ properties:
     maxItems: 1
     description: GPIO pin for line out selection
 
+  headset-detect-gpios:
+    maxItems: 1
+    description: GPIO for detection of headset insertion
+
+  headset-key-gpios:
+    maxItems: 1
+    description: GPIO for detection of headset key press
+
+  io-channels:
+    maxItems: 1
+    description: IO channel to read micbias voltage for headset detection
+
+  io-channel-names:
+    const: headset-detect
+
+  headset-4pole-threshold-microvolt:
+    minItems: 2
+    maxItems: 2
+    description: |
+      Array containing minimum and maximum IO channel value for 4-pole
+      (with microphone/button) headsets. If the IO channel value is
+      outside of this range, a 3-pole headset is assumed.
+
+  headset-button-threshold-microvolt:
+    minItems: 3
+    maxItems: 3
+    description: |
+      Array of minimum (inclusive) IO channel values for headset button
+      detection, in order: "Media", "Volume Up" and "Volume Down".
+
 required:
   - compatible
   - cpu

-- 
2.45.0


