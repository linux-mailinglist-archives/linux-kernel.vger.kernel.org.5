Return-Path: <linux-kernel+bounces-26029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ECC82DA1E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB101F21186
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A40217583;
	Mon, 15 Jan 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOHv4n8H"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32666171D2;
	Mon, 15 Jan 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33761e291c1so4959096f8f.0;
        Mon, 15 Jan 2024 05:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705325429; x=1705930229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IfByO+2rIcCGnCKsv3npkbJVqHFL3ale3i7+O8UKFk=;
        b=IOHv4n8HB5d+9DkcD57JE0E15ym14GRk2wpxrRxH3n9eZ2QZdRZQcDIoaLyQKnqxtI
         Z/ah5tlMM1yARYJNX+RIYvM37FATjkVO2MvNpoX6pjIVmJu+HiESvxNv5qiPZbL+iHO5
         yBj07UjSv4kJXfwZsjTYZ7sO5wESOPavFSEj7p9K+5U6e82CesWMhM/yLp5V59lh28E/
         aJnqbC8LwFAwmgKXrkAa+dsGeJvLq25RwsNAqULrjmeRCvR6aZLK2Poj/elUTg+iaqiP
         Ef0hHLseNgqHT/h5BebjhbouBrS97MnkZzHk4JLNal6CsnVOsllQ+RCCH1QRoPMYucf0
         mXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705325429; x=1705930229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IfByO+2rIcCGnCKsv3npkbJVqHFL3ale3i7+O8UKFk=;
        b=I7U3xCSWuLVVZUrxZr5d6LY+GUMvt+k+Jzn0lS4ztMTXxS0jshFXs6mu/CzbFqOh7n
         DeUs6J/7rANji1rul8YLOAYLmVbhQgqGD72HQP2C2PVvdqyfbO4F4/vu44ZQg2fORCUr
         phFzks9aJSsZYCiUyEZsCuARCmhT4Ib7r07ipCaNJ6cpz/ytTV4F9SVPDHY305lKuUTA
         LKpkLrBdvNebHaClSg5YEeQQh6EP96g9wrzC7h/a3UABa1zrwG+u/BrV2tdkbhq1EyvF
         Ua/13/cnI8W7SG2vGLMrkDLd9f2hSnJTsDurI7BxXU73hfcUdIGKNNFarp4KMGIo4g49
         4Elg==
X-Gm-Message-State: AOJu0YyiYuwixy9KQF/ge7eX35Adans+MTjbMQrtRsNbzuFK3DttBQjH
	9IP57PhSPaWxdBG0sIjYypA=
X-Google-Smtp-Source: AGHT+IHEOhdLprHLpE5Vb4yblwxY+uJsyFQqz7PpnPrXQPXIZPBLdES3DKWdIc0aU5NF2vX2WGnBJg==
X-Received: by 2002:a05:6000:14d:b0:337:a0ae:13a6 with SMTP id r13-20020a056000014d00b00337a0ae13a6mr1455472wrx.64.1705325429489;
        Mon, 15 Jan 2024 05:30:29 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id i6-20020adfb646000000b003378d89737fsm11566669wre.46.2024.01.15.05.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 05:30:29 -0800 (PST)
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
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/5] dt-bindings: iio: hmc425a: add entry for LTC6373
Date: Mon, 15 Jan 2024 15:30:15 +0200
Message-ID: <20240115133023.3465-3-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240115133023.3465-1-mitrutzceclan@gmail.com>
References: <20240115133023.3465-1-mitrutzceclan@gmail.com>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


