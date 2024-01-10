Return-Path: <linux-kernel+bounces-22433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305C9829DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5791C22927
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4F4CDEB;
	Wed, 10 Jan 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYpg6nSr"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D444CB33;
	Wed, 10 Jan 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3376d424a79so2654764f8f.1;
        Wed, 10 Jan 2024 07:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704901086; x=1705505886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU7PZJBE6Sseq9pTkM57wZJByEMMVutTUH+OD/JSNY0=;
        b=nYpg6nSr05fmnppjJ+7y16mhAZT6qDg1YULMecpbIZGU8H4looSu9BnpB8ODb7D1w4
         EjS7qq5azrj9voMqXgUAEmNuByHQSIFX6XDLzFysGMAJmX11SaFO727Xvv6maUoPVias
         /Ss2s+mh+G43HdY4DolW+goaEjfMKpFKaxnt+GlYAKezKauK6goiCJbEzHuKU2nVonKn
         gXtRV9PGf/xlAb5nm5MQF+S4LoNe8vGSNaEvZhIHr/B8dvHx4IJ1ZBHeIH0R3KX7ABSk
         Wxob2crEx+e954DfAYDeM9FDmvBv1jWBGx2WcXFtj4x2OsmddH44JGz3aq/87LRORnjw
         8kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704901086; x=1705505886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HU7PZJBE6Sseq9pTkM57wZJByEMMVutTUH+OD/JSNY0=;
        b=cL38gwUkmcYXyadwd2wijCtaJjncbWwLCNjV/ySRKldGmj4x7JPlJtfOuLR4NdDICb
         Hx+Ok4k5B81mo0I/Zl+b2XgHQ+fhoWAOyjr+zoA1AiNmUXGUyi9aIHfqPOFmT0N544Bx
         l8dMY5BCYQjpAwHsMFxZPswOEV9OI2/7QYq/gBr74brHGCDO4HatFN7Eg2KFPUkiMOLs
         JbFT19buQw5L25VDqRG2VpD/Eztd5sSRQzG1XREdu3aI5FRlDDSorOePkJX5I1WeIjHO
         BC8AC9wV0dbz6fk4GzcwBOXtOYXQ4ferFUPtysbr9tFeJsm/bccdXLzacTKujvtXgar7
         qOYA==
X-Gm-Message-State: AOJu0YyJ1bBpJuJrGFNVWBWzeRdKK+ymHTCeGWwpXLcGoxnWUeUfxhvA
	cw7n9vlQiVRbsAiPnJuTczk=
X-Google-Smtp-Source: AGHT+IGaZi4NmK/WhibLzOFBizcbJ2jZKTk/kN4W4RsX7/+aT7kmh7jzKjhuBwzsQJUmLsMypEBZFA==
X-Received: by 2002:a05:6000:912:b0:336:614b:5326 with SMTP id cw18-20020a056000091200b00336614b5326mr748221wrb.82.1704901085667;
        Wed, 10 Jan 2024 07:38:05 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([86.125.72.218])
        by smtp.gmail.com with ESMTPSA id e30-20020a5d595e000000b0033776a50472sm4179907wri.10.2024.01.10.07.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 07:38:05 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v2 2/4] dt-bindings: iio: hmc425a: add entry for LTC6373
Date: Wed, 10 Jan 2024 17:37:10 +0200
Message-ID: <20240110153757.5754-3-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240110153757.5754-1-mitrutzceclan@gmail.com>
References: <20240110153757.5754-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LTC6373 is a silicon, 3-bit Fully-Differential digital instrumentation
amplifier that supports the following programmable gains (Vout/Vin):
 G = 0.25, 0.5, 1, 2, 4, 8, 16 + Shutdown.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
index a434cb8ddcc9..3a470459b965 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -21,6 +21,8 @@ description: |
   HMC540S 1 dB LSB Silicon MMIC 4-Bit Digital Positive Control Attenuator, 0.1 - 8 GHz
     https://www.analog.com/media/en/technical-documentation/data-sheets/hmc540s.pdf
 
+  LTC6373 is a 3-Bit precision instrumentation amplifier with fully differential outputs
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ltc6373.pdf
 
 properties:
   compatible:
@@ -28,6 +30,7 @@ properties:
       - adi,adrf5740
       - adi,hmc425a
       - adi,hmc540s
+      - adi,ltc6373
 
   vcc-supply: true
 
@@ -38,6 +41,7 @@ properties:
         ADRF5740  - 4 GPIO connected to D2-D5
         HMC540S   - 4 GPIO connected to V1-V4
         HMC425A   - 6 GPIO connected to V1-V6
+        LTC6373   - 3 GPIO connected to A0-A2
     minItems: 1
     maxItems: 6
 
@@ -64,6 +68,16 @@ allOf:
         ctrl-gpios:
           minItems: 4
           maxItems: 4
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ltc6373
+    then:
+      properties:
+        ctrl-gpios:
+          minItems: 3
+          maxItems: 3
 
 required:
   - compatible
-- 
2.42.0


