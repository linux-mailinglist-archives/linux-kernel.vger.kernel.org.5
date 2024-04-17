Return-Path: <linux-kernel+bounces-148205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7D98A7F35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AB51F219BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591BB139562;
	Wed, 17 Apr 2024 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+zuGh8r"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0457898;
	Wed, 17 Apr 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344757; cv=none; b=TxF9bgYf6l8Hvube8XKfO6EgWNQ5kd2XEUjKkmr3v/FZAhWc+B+oileaCcg6HoXzAFYFWaFo4F2wFwOlIc2OYr/MTnVIKiE7fK7QdnuyHYqu/XF5eK2kAPJMpAMR/uS1rgyahqsnCKDcSMSy6HqXwc3tTy05P/jELcM3jMVNZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344757; c=relaxed/simple;
	bh=t0Yp1kY6qtM37V8D5tGl8e+xZzRSxjruApL0YIVR4Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kUlmGvss7i7P1LlAd5oieIPZVgxxVCQFrT9ltkVqiL7YhO1ErO8XUZlnohZ1HWUcEFwUNXLsnLpFILZePPyPQSoVBDNx12m+sXULyaWD+gG/wDgRWE9QYAStzl1vuAhxepG50zJ13BMJvGFaqX84l5Z3RJAihfUVBfsWPKV3OI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+zuGh8r; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5701f175201so1028012a12.1;
        Wed, 17 Apr 2024 02:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713344751; x=1713949551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZwRK1DevWHs7TSy/8l1VCGmE7RT9MSmuvvOPNO04ZE=;
        b=i+zuGh8rKomRn6KSCG47IAnmsZf/Q9We1UJzgN13VYxlNBHWW5h47v174hwQZecImd
         FV5fB1f5WCkn60UvLFuwVNLHr7ZYwEJSwyGwQRabzpbWkz3CtLqe3b50Chkn8cdXiQDU
         hW8MZX5EOPB24XbKnRgoHxFI2Nb5sVqbXvsn/Fj8Nu6Hj8iVC1Y8IBVnW+dOEYjf2RQu
         u1HLTmhGYPyfQb0r7tbdxTC4JEvu6c/uUy4ORSUQSu50mmPVa99AnhUln3pCsFoDRKJh
         ZmEXoyWOmo6lpXbcxULHJ6S1NMfdPT4EoNXtXhU13hGmaPNbCx6R7pvqIMAli7g8/RGL
         YHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344751; x=1713949551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZwRK1DevWHs7TSy/8l1VCGmE7RT9MSmuvvOPNO04ZE=;
        b=p5ZRTaWaPxhdSYTEfo3ks55Om7Ub3+B6P1flEsNDiC7fSDbx202bGNtApCXou1RmIV
         +Igo4IJZ8j/SCT7pceI9pIE4g11MqyP5RzTRlKTRsTCHVetr8fM8M2aiOOMR7CWQLeny
         zRw8Y1WAbfZ4GF1LP3pg6wY5/AF0FCyKM4BeE+dJybAYi2xGzdMdHSQvApvxNVtzglBx
         IDHzZ44mJtHBPj3D+hariAG3dI1xnFzx4naW6GRbyf5yk68In2SOhVLMERZXPg1Vs+oI
         eZoKmmZDjvdDFLUhi2tlR+oS7/lxQbRQyIOXiWdO4C5hQ5K051qrz2yQMvvk90mtv4o+
         mTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTEAqjH1yJQLy8vsRx+MneJFcDytSKkk4pSqXEKLw7cTWLH2IxBYVoOMEQhPQYQ3Wmg64iWf520wtFaQXLUMIcLgM11ljcH/DzdFFua2Ama4sBFABxi+aPaMoz9gk5rN92kQF9YDcACw==
X-Gm-Message-State: AOJu0YyUy10x1tZvIzuT+K9mZOA+aof8EigYqJJ5rAX5ocm7wFm7sk7/
	9Y8IhxlOa0+EHb1qVE03Q8sqyRNpINtNV/zWWwJb7wHexuq6k+qP
X-Google-Smtp-Source: AGHT+IGE2DnDV3rpp3b8Ce/rnKgMZfX7uxAsyjA9iUq+P1/TDU14340g92GIgBrYF0+l9pSZ9cbGAQ==
X-Received: by 2002:a50:a68f:0:b0:56c:18b4:d2ab with SMTP id e15-20020a50a68f000000b0056c18b4d2abmr11801276edc.42.1713344751147;
        Wed, 17 Apr 2024 02:05:51 -0700 (PDT)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b00a51a7832a7asm7897814ejb.199.2024.04.17.02.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 02:05:50 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linus.walleij@linaro.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/4] dt-bindings: input: atmel,maxtouch: add poweroff-sleep property
Date: Wed, 17 Apr 2024 11:05:26 +0200
Message-Id: <20240417090527.15357-4-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240417090527.15357-1-eichest@gmail.com>
References: <20240417090527.15357-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add a new property to indicate that the device should power off rather
than use deep sleep. Deep sleep is a feature of the controller that
expects the controller to remain powered in suspend. However, if a
display shares its regulator with the touch controller, we may want to
do a power off so that the display and touch controller do not use any
power.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/input/atmel,maxtouch.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
index c40799355ed7..8de5f539b30e 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
@@ -87,6 +87,12 @@ properties:
       - 2 # ATMEL_MXT_WAKEUP_GPIO
     default: 0
 
+  atmel,poweroff-sleep:
+    description: |
+      Instead of using the deep sleep feature of the maXTouch controller,
+      poweroff the regulators.
+    type: boolean
+
   wakeup-source:
     type: boolean
 
-- 
2.40.1


