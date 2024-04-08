Return-Path: <linux-kernel+bounces-135632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5396A89C8E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867611C21C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81881428E3;
	Mon,  8 Apr 2024 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0TC8yZe"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321031422DD;
	Mon,  8 Apr 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591599; cv=none; b=ck7082bzpt9J4m1g/J1EMVKkwhaU/DQVYUiwBQ9BXTCiKQIGv/RNja7cNU7Hk0ru+cYBcCZRZfWmF9R77QqnkSVwnZr7vRVQHyQbHq13GHaggLk+PD+GRU8ZuDX8oa44CW74JPTgeIfEu6uvcEmA9KI9mnGC0eQHz7MhZtrXCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591599; c=relaxed/simple;
	bh=oXF0IOpDbbU06OjI6OgtSVdRvz0EfEWAr+7KUKC2fPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HG1UhfdhyLvgSHphNEOyAa0USbm741bjyAdghbrXGYjkhifQtM58KG/cJ7g1T7Dt2df6vGoGN37BAeuNdu1Hh1LWKGgxccfDDlCyiz9IMDcNd3neIl3jhdjUkfrrs9Uh4LhDipW9Ioubaqz0vMxh5P5S618BkliK8EdpLcw5Vd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0TC8yZe; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so4632688e87.2;
        Mon, 08 Apr 2024 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591595; x=1713196395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZNPSolpsyW2BBt4Cv9G0c69Pzyf7OGHTEy9xs9+O7A=;
        b=H0TC8yZegMO+X3le90cx46Q8Cx1YNjaRCived1bgdughzuizA8CDVdVa30LFcipXBj
         2KuJgAgrJ/MWDz4/v4CqWEabQffMw0L4vMbIiGntu9SjQvVlf4202hBEiLCYUEzm+G2I
         qH9kUmF//L0kcy96i1oA+SyQY6FURngGqFgyeeMtK6BdG/RLI+JDvQjVKC7VTXtaHf8b
         8OgqtU+FgFA/S7IN8wi1pfE2Kf5JSXNQv42tmoip2KajjnurR7H6DJJlV9rTGLmZqxLA
         WE9CI4OIWoxtJ5ZSed63q/PwjRl9w2c7SrVZeksBnIAynd+7V6WWGXAD6Eky/SynSlP7
         DzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591595; x=1713196395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZNPSolpsyW2BBt4Cv9G0c69Pzyf7OGHTEy9xs9+O7A=;
        b=nZWLG9FbP+qhvxFaH0K4nfJFAOpF9WiNe+i6DEhIHXmG2jOSNNCbtMyUQZVchCU4D9
         /Hk5KKxtKD+GCAKhRJqDsSFJvnLp2N0YabLV3FiM+Aj3BfYxwxsuK5Nr/bOyczv+bClJ
         +5VKJVd6SD1212wDaam4XIq7YaYpdgxoolwTl8f2tx0WTKv4yg0q820cSuorP9fY2hbR
         e9lqmJFN/2T2ShqNyrPZE/w6UD2ehQzpLb1geI3laWrShZALO6biJg2xBSqoc3raHcxf
         Qci4Mq8aJ5pzQeo/iszYtKBW0hN0l43AoJ1L7VIXO6+BijxHHoOLvbCEFwq/rTtUvMTp
         xmnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX580uJjRzM5jXagOQmxURZ+40iauypJH3rUJjMgumuwm+kPLMQqCGI8/eq7EYuVWIYtNmvw9kXmUP34FMzEa1LS36AKCtnoGm7hqloUKO0dHAHlQaTiMQtl+YBREE9acpSJWjzJ8Okkw==
X-Gm-Message-State: AOJu0Yx6Inmw9UuqR+bciwqV1YFYXu68Ulor7bV5i8pUEEDW85HaDdtS
	AXHWbkHJQ8SU/SjHPsobkP4J6zRVeFTwWUmDsYHPXaaYPKzrshhk
X-Google-Smtp-Source: AGHT+IHHjnlpbYGoVoRBTjaLp6Pq3A5BQFRFuLX80oSlH+nvQTdtLncSAg4Fv6oSY2gm4yEe75RZ0g==
X-Received: by 2002:ac2:5f1c:0:b0:516:ce06:ac8e with SMTP id 28-20020ac25f1c000000b00516ce06ac8emr5820717lfq.51.1712591595088;
        Mon, 08 Apr 2024 08:53:15 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906794d00b00a46a2779475sm4547849ejo.101.2024.04.08.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:53:14 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 08 Apr 2024 17:53:03 +0200
Subject: [PATCH 3/9] dt-bindings: rtc: lpc32xx-rtc: move to trivial-rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-rtc_dtschema-v1-3-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
In-Reply-To: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712591586; l=1653;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=oXF0IOpDbbU06OjI6OgtSVdRvz0EfEWAr+7KUKC2fPo=;
 b=cXwmCtklzwmwm52UDPVuk6WWDHgL1i0zzCtfIEhsTmu1EI8lNZwtM2+GXUd9vnJCrPPqUZ8mZ
 dM7tV4/p9z9AnwXdlchsL+guM1nOVq79TSHnwxlzcL0CuAAe0Fn8NP7
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This RTC requires a compatible, a reg and a single interrupt,
which makes it suitable for a direct conversion into trivial-rtc.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt  | 15 ---------------
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt b/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
deleted file mode 100644
index a87a1e9bc060..000000000000
--- a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* NXP LPC32xx SoC Real Time Clock controller
-
-Required properties:
-- compatible: must be "nxp,lpc3220-rtc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: The RTC interrupt
-
-Example:
-
-	rtc@40024000 {
-		compatible = "nxp,lpc3220-rtc";
-		reg = <0x40024000 0x1000>;
-		interrupts = <52 0>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index b889b9317a41..d6ce7ac29033 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -55,6 +55,8 @@ properties:
       - microcrystal,rv3029
       # Real Time Clock
       - microcrystal,rv8523
+      # NXP LPC32xx SoC Real-time Clock
+      - nxp,lpc3220-rtc
       # Real-time Clock Module
       - pericom,pt7c4338
       # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC

-- 
2.40.1


