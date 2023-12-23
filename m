Return-Path: <linux-kernel+bounces-10383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD43681D399
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920D61F22436
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69210D26C;
	Sat, 23 Dec 2023 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQeiQiyX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44148CA4C;
	Sat, 23 Dec 2023 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3368fe3466aso1448785f8f.1;
        Sat, 23 Dec 2023 02:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703328377; x=1703933177; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GObqlSd+UFZn9ETimylqSCaYLb3U6IS49FiU2RlSFWY=;
        b=mQeiQiyXhJkMxtT8YH2FGSEfrZtwvFxjCWVV59NPrlAcAv7oMdCqq7B4rZpH2ZaSmR
         VFujMuyg+xLNxS4hkXJ2fBJp9Txx3TWjAUr12INq8j1VGOEm45ZJy/rLwNU3/w0fTpm2
         cULbyvJE3/EgRKXV3OGAOnK4MzE6cwXek7bC45ygeLxi9ckBVclh2w2M+6PcdMwdPZuB
         4sMNs4olOou8+An4yWGODN0wJPt5DY1YgAr1U2koaofWyCBY3PKfTza90GmdlCrWN8tw
         4CY0PZ+41/LoMmMrTANUXsHI5ouNTX0WM8kMtUPrDQdHlpQ13VQKBAa6I1wszCKIrYKV
         mfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703328377; x=1703933177;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GObqlSd+UFZn9ETimylqSCaYLb3U6IS49FiU2RlSFWY=;
        b=qM3Ry8ncy50J9urEsTtE1Q84qamDBBVVHOSxJe94iVn/ZvpGo69gFo9GOORc1KLqCu
         p8C6cTQZqWOp1Wvg9swmjb70r6JUVss9DSrrNtUUpQYfLp0bpAd4N0WqNErh+8qg+luK
         xXxAbwYfqfILAcq135TlBJ2mn27zwQJ86KhhPD4N0X2MF34qqtBwHyyXDM4RfHtS1GPn
         5Te75NOdl5+ysLdjrSX6eqgyEeVvfWLlYa4O6EB6nuuDO2embOv/n2EhkqKK17cvtEmn
         T0NgzektB8F30C0MDNwn9jQy/riHg8XrvPB/r/zeX4nF+VCCujpDqGJwxlLuAZHC4biX
         iDdg==
X-Gm-Message-State: AOJu0YwyazYQSv4E620PE8ArCo4Q5p8ZmnNbZBS6kfG+/AZ6hcyxBU6O
	oHmXJh3hkrNA8gs/6YHhvYELMftEppKngUHl
X-Google-Smtp-Source: AGHT+IFfi1E4JKzpUjQ+olKZS+fhHDjnwd0NQOYsA6kAYQCgTdA3o386WK9C6zNby5CJxOM4CLZ5XA==
X-Received: by 2002:a05:600c:1381:b0:40d:258e:fe9f with SMTP id u1-20020a05600c138100b0040d258efe9fmr760767wmf.90.1703328377397;
        Sat, 23 Dec 2023 02:46:17 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-a224-d056-3f15-a90a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:a224:d056:3f15:a90a])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b0040b3867a297sm10045373wmb.36.2023.12.23.02.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 02:46:16 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 23 Dec 2023 11:46:13 +0100
Subject: [PATCH 1/2] dt-bindings: iio: light: as73211: add support for
 as7331
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-as7331-v1-1-745b73c27703@gmail.com>
References: <20231220-as7331-v1-0-745b73c27703@gmail.com>
In-Reply-To: <20231220-as7331-v1-0-745b73c27703@gmail.com>
To: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703328374; l=1531;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=+ozvp/tRLsqpzqS9hu/veYaLWjTFSiIOggyP14IhLb4=;
 b=Pm3WIr+XtqpKpWGn7xApz43rLF9lDf88PENzwgr/v21GwkuFngiIP/TZlMIxQkQheDz7abzyY
 tE8TONPvrgzCnMA8EnKHtF/9MR+/l5IWSxim4b1kS4uyHYlUVO2SB7d
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This device has the same properties and I2C addresses as the as73211.
The only difference between them is the photodiodes they use internally,
which in this case is irrelevant for the bindings.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/ams,as73211.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/ams,as73211.yaml b/Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
index 0e8cd02759b3..062a038aa0ff 100644
--- a/Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
+++ b/Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
@@ -4,19 +4,22 @@
 $id: http://devicetree.org/schemas/iio/light/ams,as73211.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: AMS AS73211 JENCOLOR(R) Digital XYZ Sensor
+title: AMS AS73211 JENCOLOR(R) Digital XYZ Sensor and AMS AS7331 UV Sensor
 
 maintainers:
   - Christian Eggers <ceggers@arri.de>
 
 description: |
-  XYZ True Color Sensor with I2C Interface
+  AMS AS73211 XYZ True Color Sensor with I2C Interface
   https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf/a65474c0-b302-c2fd-e30a-c98df87616df
+  AMS AS7331 UVA, UVB and UVC Sensor with I2C Interface
+  https://ams.com/documents/20143/9106314/AS7331_DS001047_4-00.pdf
 
 properties:
   compatible:
     enum:
       - ams,as73211
+      - ams,as7331
 
   reg:
     description:

-- 
2.39.2


