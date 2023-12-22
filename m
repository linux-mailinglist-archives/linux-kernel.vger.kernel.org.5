Return-Path: <linux-kernel+bounces-9566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C3481C7A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51661C247CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DE111704;
	Fri, 22 Dec 2023 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1iKoKl6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0416FBE8;
	Fri, 22 Dec 2023 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2698cff486so201163166b.0;
        Fri, 22 Dec 2023 01:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703238787; x=1703843587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pv5du8nTtlBmNN8G6GAX4FSGesWSwqNtRVmismLP6Po=;
        b=J1iKoKl6hNf6+2g9+T1pPFWTLjejdNKPUrT1B2anX+OnZ3lqMr67kvZOeu+zd5jXif
         Wltnwu1kTwMtMlLncs6sZHLXMvifz+3wGckWIRNUnb8voer7am72AG9kYwt/9K9pcwGq
         y6vdax5XV/s9NjzCPun7SteWGCa8twt1fMkg4jqjgvgWq44f4y3quRvl7+JCQH2BRDX+
         LfbNAl6EupEUH1qKQSW8kklaBhuchIYoj/i6hnEfCL/JSD6+VJMVYmUqHCHrCTknDAOq
         AsAnLhY/WNSqLoiJKNjnCeSjmXSuJCFucJwwY7qFo7WuGWIxBn7kkieCjh+WJTI6axWB
         vBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703238787; x=1703843587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pv5du8nTtlBmNN8G6GAX4FSGesWSwqNtRVmismLP6Po=;
        b=YnPmVGsR48zTRmfQEzmRH93Econy/igdYu99xEq1aizsAC1kKbAWk24TxS9OGaLpTo
         b3wESsvabD2bVMRecusJKWioGRXE4ONvkTDjvvkQMUTC5z/66b5qUQm+gjyMzHdNITJj
         lgRraYrx7m2evW18Zzi3kqQXZMDeDDyFz+D4g+q9UTEAzkGYAdvAycdbMx/Tfz9h8yCR
         XeuuUIQ4NlBq2P+PjnI/9lLHDcWCDQmvIVx9eb6bx0ca2+B+Vl6AWGGmA5z4RPbqgpqk
         YErfEJqkG8LADAQdMOSCL5Pu3Gp1mJV8iT8xJbD2hZocOgXB+KC1M1ON3seS34oO33+B
         32kA==
X-Gm-Message-State: AOJu0YwHakCTZmB71CJc2b1SuQxMi3nKU3eqYSDgGJj46l8MEHiKBHLG
	7Zno4HHrGLw3tEoygF6bCMI=
X-Google-Smtp-Source: AGHT+IF4XVGQoCCX24Fe46dZLkremdlMqaE9o0+oyenbWtT/gNJ7oMEVag9MCqloaEfxy96Mbg9UeQ==
X-Received: by 2002:a17:907:9842:b0:a26:97a1:48f1 with SMTP id jj2-20020a170907984200b00a2697a148f1mr267161ejc.81.1703238787003;
        Fri, 22 Dec 2023 01:53:07 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:f05b:3f84:67d1:580])
        by smtp.gmail.com with ESMTPSA id su24-20020a17090703d800b00a26ab41d0f7sm1311838ejb.26.2023.12.22.01.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:53:06 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linus.walleij@linaro.org,
	francesco.dolcini@toradex.com
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v2 1/2] dt-bindings: input: atmel,maxtouch: add poweroff-sleep property
Date: Fri, 22 Dec 2023 10:52:57 +0100
Message-Id: <20231222095258.33369-2-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222095258.33369-1-eichest@gmail.com>
References: <20231222095258.33369-1-eichest@gmail.com>
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


