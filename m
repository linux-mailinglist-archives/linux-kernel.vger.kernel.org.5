Return-Path: <linux-kernel+bounces-119033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F388C2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A9A1C378D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170517605C;
	Tue, 26 Mar 2024 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S84oZQ6J"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620674BF8;
	Tue, 26 Mar 2024 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458214; cv=none; b=hIZ5Y3rCjhSp0tc/zRbwHLtOLct1+v8Xxii9fjcH6pCrrG5dToz+GqXpnI/Vv6TB1i+FLNKSeFhWGXB0xg+NHKF4NWnxY5sXPGxe6QauBsxvi+99/2UgT19Rkonb9g/7NLcN12ruxmVcQFkJjMwioz1WpmHbzSxhpeME3IyZUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458214; c=relaxed/simple;
	bh=9OJ1TA8nBk15alYVVIdgebpgYxEwA5HtYZhEvfcdSw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m62tprP2Gc4kTGSTAUYjZqFbBEbIUMzvzuurcacedfqCQNtMNbj9ulbHJiTqUWDrnpuNsfssw3LgX4RjTriSRELQhTT9g4I8dyleW5Oe9vR2HDsNKy+zX8kTTxhtVLGaCIWvoYxsN8tM7kW/VFFHKgKRi/OmHBAiYJi0BZ3WIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S84oZQ6J; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c1a520659so2078322a12.1;
        Tue, 26 Mar 2024 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711458211; x=1712063011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKC8R1hCPvugRXnK9Fdgmb9c0E/uMfRyylDmAlcuzT4=;
        b=S84oZQ6JTmeHN/uHDg+ZHjLrXB6y4dvu2ipxxHwqM3kBIki1VDoAW7D+eTBJo7ZyfB
         0yhBxphv0oMuptkacZbhpApdYAD/Pk83CBnh7BibQEOJBrLgti33s7SNiLwu6tihd8R2
         0uBNww3v27as3lGE5lzXF/ruoKrTZvyKsu863v5at243A5GAqPTlq8p4WFF2R0DBa6kN
         C+jXe20Wyrwi32WC9wtKEUoocgdboGdcyFXLvYm9G0kYVO10vlbxu/b3FhNNKtsFoA8b
         5Vh0YksOuGKdrkZ2DGRwfqvnHKeu6lfGpL+TUcpsuE6Y5oDVUCfdnEmEVhnNxaz3cvs2
         61dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711458211; x=1712063011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKC8R1hCPvugRXnK9Fdgmb9c0E/uMfRyylDmAlcuzT4=;
        b=Sdcd5ihQqmT9yL/8rKQSmo94RcN/OW0ITD6Fk/xD3I6Y8vu9w71EGmYUxEqwxlyPTQ
         CC7G/lk8Ly6iacM+id6U4TUfaoVWE97Qafu1tZiMURh5FFN8i1VhW2GQDFZjacHGCrxj
         aF+bxIGYeB21AucaoE5DBhHIWGuT+JMZaEfYEg/8MoBM4a1/ZRVOZ4gT3TOa7/7aLrqY
         eUrXp0LBR9uZ5YO7prfO4uoKtLArt3gpsuVXmYUt+xIG+gXSSHTDSx6XNyqE/Ee32++N
         6JNukPlx27BOGMDoI//H2fYZX1f7bOoHH6Oq0uIqdgJPXdhQsqALuL6q5gDyGPngXtGT
         Vnpw==
X-Forwarded-Encrypted: i=1; AJvYcCUoRLmogvCYZnKJHChEUA+j1yWzPt0rlHK+dKQUpSCqzA+KH3d7KFe2yT+ujU+ZPhn0bAakezRYd5OoyaXbWx9wCWHQrngbyETQrYHes44TxZkq/7h/vmQ2p35XiuaiQolYtZYfDOh2Eg==
X-Gm-Message-State: AOJu0YzoML4zYjJwoEoHtUwV5/iPP6fTLFnmCbyAwlg1SZMN1TDbMJ+L
	uNuAkteGO6RaskvZ8Gwqa6f8xxUdBEdI3eZLYtwm5+BsS3QPcrcD
X-Google-Smtp-Source: AGHT+IGK0Zbl19z3o9Guado/1s7tfyfBw1z/R3DkN06l6LS9myoeftqA8Z4lh2Zuedxf8vDNBvyLwg==
X-Received: by 2002:a17:907:986e:b0:a46:8e02:19c4 with SMTP id ko14-20020a170907986e00b00a468e0219c4mr1644569ejc.77.1711458210852;
        Tue, 26 Mar 2024 06:03:30 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b4b2-cd0d-1ebc-3c05.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b4b2:cd0d:1ebc:3c05])
        by smtp.gmail.com with ESMTPSA id wg6-20020a17090705c600b00a4a3580b215sm2206279ejb.80.2024.03.26.06.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 06:03:30 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 26 Mar 2024 14:03:25 +0100
Subject: [PATCH v3 3/4] dt-bindings: rtc: digicolor-rtc: move to
 trivial-rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-rtc-yaml-v3-3-caa430ecace7@gmail.com>
References: <20240326-rtc-yaml-v3-0-caa430ecace7@gmail.com>
In-Reply-To: <20240326-rtc-yaml-v3-0-caa430ecace7@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711458204; l=1937;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=9OJ1TA8nBk15alYVVIdgebpgYxEwA5HtYZhEvfcdSw4=;
 b=a+mbBl7/KDuHVnDBuikMDe/f6beVvBYIum8TzT7M0Qpy6XDUsg1CARWfdZNb9GQOMZRP2RuA8
 GIF98g7srZfBJOdLLY2Cr1+2VLLqa9xSXMuxwGL8HCAEl9zueSULQB9
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

This device meets the requirements to be moved to trivial-rtc
(compatible, reg and a single interrupt).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/rtc/digicolor-rtc.txt | 17 -----------------
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml  |  2 ++
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/digicolor-rtc.txt b/Documentation/devicetree/bindings/rtc/digicolor-rtc.txt
deleted file mode 100644
index d464986012cd..000000000000
--- a/Documentation/devicetree/bindings/rtc/digicolor-rtc.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Conexant Digicolor Real Time Clock controller
-
-This binding currently supports the CX92755 SoC.
-
-Required properties:
-- compatible: should be "cnxt,cx92755-rtc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: rtc alarm interrupt
-
-Example:
-
-	rtc@f0000c30 {
-		compatible = "cnxt,cx92755-rtc";
-		reg = <0xf0000c30 0x18>;
-		interrupts = <25>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index c9e3c5262c21..a3db41c5207c 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -24,6 +24,8 @@ properties:
       - abracon,abb5zes3
       # AB-RTCMC-32.768kHz-EOZ9: Real Time Clock/Calendar Module with I2C Interface
       - abracon,abeoz9
+      # Conexant Digicolor Real Time Clock Controller
+      - cnxt,cx92755-rtc
       # I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
       - dallas,ds1374
       # Dallas DS1672 Real-time Clock

-- 
2.40.1


