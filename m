Return-Path: <linux-kernel+bounces-28988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2768483060C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F04B1C210A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61811EB52;
	Wed, 17 Jan 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh+I5iMv"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909E1EA95;
	Wed, 17 Jan 2024 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495897; cv=none; b=h6ocaOXCi8hYlGnab+NOZGJ+0sT95ZXIGZmG8bAJSCsaMuMN5V/lWGns1i19ZX2+4gljKhFOvkcm3KlHcaXRUf7dW2hOiYhc6/yKcXuBYwI83ueIrsSNnimT37btaf40Pc2mcMulFDeonLCWDWcQvm0ptmguHrzW9cmwfLEUqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495897; c=relaxed/simple;
	bh=lL9tEj72B8RLSGVKGJnXqHrnROs1OMlmSlpmLn/ellk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=c4xuRiqx2dW9Mtn1Dj0KkwzHUS5c0P1e5K/tmayp6+zIrIJwT8gbn5K8CopqyiTTwyYFVK4EBtuAhpy+AjphNo7yxprO5jZp60wqq5ZwlchR0+OYN1K+IDDyLJ647AkvUV5jjrNs3yCIyOjngeEeKxP3mGDmkNDeA0DoiE1F6J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh+I5iMv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-559edcf25b5so206676a12.1;
        Wed, 17 Jan 2024 04:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705495894; x=1706100694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wlAJ3HOeN+i9mwkmiHE0QT6wa1Z9g6FI4uNkE/zgM8=;
        b=Mh+I5iMvSNvaY4REwTAi4lnbDxCjABKEcLYsWUKlmDNMEx/rodjVgMyRjNTqVDP8P+
         qvnVkmDFKEBS1ZgIzUs/ES0612miz1RtqkVz5UiHkhvPK6lWPs20JNbALhU3w7PVfaEr
         jJ7i6WT5dVuyI5+VVFZekNJlh5s5J3dy8PPCT8zUC2nT78cCCafXNRtGQNiuemUDycxG
         +O0kwFBibcvWuotngoZ/0sQ4YtnsWB9KNR135P3XbOMLpaTtE4pYQw+ep8o9LmNHV+X5
         ZgcplO6TNWZCceSyCOtU6+fmWnq+BfEDsUfdpVzZGSiT1EZ9vxMh1fLABtih7y9SC7ub
         Rdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705495894; x=1706100694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wlAJ3HOeN+i9mwkmiHE0QT6wa1Z9g6FI4uNkE/zgM8=;
        b=OohkMb1giU49+RIx5NQjZyl9O92Q1re7q2Ycast2XK7AH4PMqHmN9EOWXKGDhfPdzW
         g1zVJsA1ITHcwOgVPr7UwuygL00yZxbPbtYdUSv1T5yTwcaPemIblVX21hHGjy/3/NjJ
         wKiaUCCcZ9JE2ToqbeipDKL8oLbfCUt2RtOYaiu4Khec8eXR2QeIvoMgCdfrkWtpZa2G
         8K26bFzRXdICrS67lO725EJ4b/RLal7nRnKcIsp6a973lkC2gS86MHrFBX8UVdtIP3oN
         HkJkYno+ub5rO3HawDQgniXb7u+baqDxqJrOY7d7dh81pwukTERpS12KdyOEHBbfMjo6
         nQwg==
X-Gm-Message-State: AOJu0Yy+XI1QOsdKDApk+2CjoiMB8ZyRCcXDUmwO3vOKaQqz60YVPz7P
	jQiaSPra84IZTFyaXIkhzYA=
X-Google-Smtp-Source: AGHT+IHCYD0OV4UlkBBgtGc+mENZgOUND0+EF1UV+VhL+oGPuJHBHlps3jyx1H7klHTDKCqQuBvAog==
X-Received: by 2002:a17:907:c9a9:b0:a28:e3b6:a199 with SMTP id uj41-20020a170907c9a900b00a28e3b6a199mr3982628ejc.38.1705495893577;
        Wed, 17 Jan 2024 04:51:33 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b00a2ea45637desm1277247ejd.112.2024.01.17.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 04:51:33 -0800 (PST)
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
Subject: [PATCH v4 1/5] dt-bindings: iio: hmc425a: add conditional GPIO array size constraints
Date: Wed, 17 Jan 2024 14:51:10 +0200
Message-ID: <20240117125124.8326-2-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117125124.8326-1-mitrutzceclan@gmail.com>
References: <20240117125124.8326-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ADRF5740 and HMC540S have a 4 bit parallel interface.
Update ctrl-gpios description and min/maxItems values depending on the
matched compatible to correctly reflect the hardware properties.

Fixes: 79f2ff6461e7 ("dt-bindings: iio: hmc425a: add entry for ADRF5740 Attenuator")
Fixes: 20f87a9a26be ("dt-bindings: iio: hmc425a: add entry for HMC540S")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
index 67de9d4e3a1d..a434cb8ddcc9 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -33,11 +33,38 @@ properties:
 
   ctrl-gpios:
     description:
-      Must contain an array of 6 GPIO specifiers, referring to the GPIO pins
-      connected to the control pins V1-V6.
-    minItems: 6
+      Must contain an array of GPIO specifiers, referring to the GPIO pins
+      connected to the control pins.
+        ADRF5740  - 4 GPIO connected to D2-D5
+        HMC540S   - 4 GPIO connected to V1-V4
+        HMC425A   - 6 GPIO connected to V1-V6
+    minItems: 1
     maxItems: 6
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,hmc425a
+    then:
+      properties:
+        ctrl-gpios:
+          minItems: 6
+          maxItems: 6
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: adi,adrf5740
+              - const: adi,hmc540s
+    then:
+      properties:
+        ctrl-gpios:
+          minItems: 4
+          maxItems: 4
+
 required:
   - compatible
   - ctrl-gpios
-- 
2.42.0


