Return-Path: <linux-kernel+bounces-28989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2027830613
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E5F28B26A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651DD200AC;
	Wed, 17 Jan 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezcnxrcm"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD11EB39;
	Wed, 17 Jan 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495899; cv=none; b=RRJuFWcbA5lpXLlWKRKdo8nPRQiaLWt4hgcPTeAFUI2YsTsH96RFJEb6j3/pRpqI5jykfR3LejOkyQlpmY5irgm3+7IELCzcPIDJdm4LOpTfjzBskvQ0dhAomRpAuMEpywychPcYpt3klunFdUsgpEK5DKDV9Y5UldogadiXen0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495899; c=relaxed/simple;
	bh=WsaD/EyThPxR9x3pk2tU6dkPvkHaD1C0ZLhbybr6sC8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=eitDcGQQrz+cZ5JpGAPKgCuZTQLzm3YOrGUk8B0vvw3LtcW4qltnE7KqzExKfbthSz0aKXzDIpC8dH3q5F4qmqPEkLdBuOR/OfDO/XMfb6IObL566t3huFuFpT6km3mm+RapBSfHBn+tzN4g9rGOukoVHR74YVF05wGzvy2hlOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ezcnxrcm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2e0be86878so489861366b.1;
        Wed, 17 Jan 2024 04:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705495895; x=1706100695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IfByO+2rIcCGnCKsv3npkbJVqHFL3ale3i7+O8UKFk=;
        b=Ezcnxrcm8C2PaFJePxqnLErqaae777cBo8yW/kX3vbWpR03EiH2N7Rl+fPfyTwVIhF
         iHPzPHvpK7ckaudSbp8SuqPTQHf95i34j1d3RmjMNb2PVFnxv1rqYM1pmAPHVXgJkAVY
         VrLeP8cCpUERuCbovwfIN0GFCxflA5UpHJy0zDqBdm9fl3q9Wyci8+25EELIEXmNbKj7
         2FGiPlXqonIkWpTJ8jMSU1mWu0xyrYVGYkc1Xbrd5sLMnz9krEiX1gmv8/hr6UkbWY4W
         gLoLGWC4RZCxhCMG7bAzXBNvpQ0x2KwshYCCTaI0yJr3OPaYvG5OERN8zJJKYbYaD317
         7bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705495895; x=1706100695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IfByO+2rIcCGnCKsv3npkbJVqHFL3ale3i7+O8UKFk=;
        b=s42DPfl42ISZQm3hnbiA09plA1ti5BnEGxpGhrq91dW96WeP+/hMkdZhhAMt4daHrK
         +1raY/IAYDdJhri7bXtVXqPNNy7IKWdI68FeVrZlvzaWd9vxQK4Qk1gn761nCGDXxgze
         hS6l8Kd2gVxaU+nxu5Tj5MP//mIsQDOSL/FO2kb3497cIDISsNn88wD4mgr9WPD/OYbM
         rNPoHVld0VInZAIxNfqJMpGx4cYJRlLgphgoWqOljlbjjTC5Jrz5MdTdwTeh2FHQv0qe
         mQVFLDTZkbif427PKw2B0chCVK9GjjQRb2CNxtIw7U28gy8BfkmfyX+jsy5LIKIaaVOB
         bfMg==
X-Gm-Message-State: AOJu0YxYWnJX6J+t/eYwQ2dDx5GJm/mRINQDmNnjAXhS7g1A1w94M6XQ
	RkrkLtDMpr/dT9Umm5rBjDk3o7zrnQ7dIg==
X-Google-Smtp-Source: AGHT+IHT7ZR7hb7FwVUmmfAEiayM5v1oUdDFzCTlbUkFL2t57UwstfbSYx8w9x/i2xHFcv68G7WcBA==
X-Received: by 2002:a17:906:a188:b0:a2c:a9c3:e407 with SMTP id s8-20020a170906a18800b00a2ca9c3e407mr769102ejy.29.1705495895158;
        Wed, 17 Jan 2024 04:51:35 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b00a2ea45637desm1277247ejd.112.2024.01.17.04.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 04:51:34 -0800 (PST)
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
Subject: [PATCH v4 2/5] dt-bindings: iio: hmc425a: add entry for LTC6373
Date: Wed, 17 Jan 2024 14:51:11 +0200
Message-ID: <20240117125124.8326-3-mitrutzceclan@gmail.com>
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


