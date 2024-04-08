Return-Path: <linux-kernel+bounces-135631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A49D89C8E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217981C21B17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FD31420C8;
	Mon,  8 Apr 2024 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFhK/dB1"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE41422BC;
	Mon,  8 Apr 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591596; cv=none; b=kROTSoi1pv7M/9Fr2X65TVxDHQ1oW898vX3JRNWaIXpagtlWEfPcAbyhgO28C6CT9pCxAS+7ccdwUc36F4a9kl67eP1j+dDgRSIHZBLtCCnvXH7rYxRoE/NZwJvAoftFre0DTK/Vbf+IeAi1iP40ctULuNc9sFad1h4Ujd7iBvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591596; c=relaxed/simple;
	bh=yqX/w81Ycb9hVyt/9HQKZXov7UsFMLnZ7nkrSKxqels=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0sZ4k2AtDfKy5jWWAJTySzvQbj43O3a1ZKlk5wyywia85A0Ly7C2sP5FhZ+w+uwlGM7e9O8SpDMh72DDz1fIXPKyPDxykY9O4+E2M8EbZaLui2y7mtO4OGFBA1vHFdOAVg5tviSSKmWT32n+SiKO7RTAKXlIe+wjVKAk0oJ60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFhK/dB1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51e368c6dcso47251666b.3;
        Mon, 08 Apr 2024 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591593; x=1713196393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaDQO9exJCzRg/8lU1QpCZomsB1mdrpwg8BXuiBSkkw=;
        b=gFhK/dB1DL6tUKEbKPWr4qT0qb4pPS01W1QbfcpaM0ox1qjggU6ov8bvw/CiQo3OEP
         w2LgwslYAeEux9lf5aFfbfrDReVnWcF61FjMSu93/N6RyBubGwMIjcoCnRBcEqTfHnz4
         YkzkPdFFp6M6MM2lkoWjWbBEOeNBQD/+j9M3HyBG+GSjUknIhISe21OCL/RBIHgKKmvE
         aViLzR1WTPwVVHBVDyIurMn5ZDYUCh6oYdLGBL//oe6HtgCbJXcG5DLwp4hzl/cOZuV6
         cl/dRcX+fEEZxecIqj/rLOYpmohBgkwfw9x9P+JqnTP+k2zNPduAeAAHnRO8VxAyn80+
         37ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591593; x=1713196393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaDQO9exJCzRg/8lU1QpCZomsB1mdrpwg8BXuiBSkkw=;
        b=rMiSXYkgG+TyhG3wSRGbPLWRaTV7XaU/igq1hoknqpe/giZf4lUrtCYash3p8X+TGy
         z+GJFjNCiofmVThSXiSImuv59JLdpHnzn3Zw64I2l3+zPKiGRTk3Te8Dm3CpdkszsWAv
         tHfZ8j1gY46wqN3rrZ+4Xw3iN4sjIBHCJGUB8DYRZnOT9G5YSfLBpDU4MDy1uLiPzcQO
         sltb1/KqFLqk3TqrReM6J8bpqtKf78hsllExbt+1esVKr71Y7dcmVIAxsSzx1V7olF12
         UApfePG7DLB1bT/ON7QfANs9e6imtfwNZi9KyiY8zpzhqy06Jm+959loRc68k/Er+V76
         rbbw==
X-Forwarded-Encrypted: i=1; AJvYcCXSxYbeX3g+/BCYq2TvA5ybvdww09pzse9XCMSDo4YcW8XYKEhXLwnFw4NAZ+8iMn9q2wyPDhbO9l2WOq6e/x9368qZHmE1BTfSv6EFqyUuGJTJzV6CZuflkZaoPkGhXM9ghJEX/Sjqjg==
X-Gm-Message-State: AOJu0YyxcYj/6k/65mlB7z48YqH9jd4wlCO7pAEA4AyKf4utHgfPFQXU
	BaHFM5kn+++NsGyGGfEWj0yPieWdlSldsEBkp/vefpFkORJ3alpi
X-Google-Smtp-Source: AGHT+IE/brPz33bAyXkLLx9/3k7uLX80nlW2dTvsRmtq/VzJ5UavkRJXVX2o3jP/+Rc4Wx3RPpCuEQ==
X-Received: by 2002:a17:907:e86:b0:a51:d204:d6bf with SMTP id ho6-20020a1709070e8600b00a51d204d6bfmr3422101ejc.10.1712591593166;
        Mon, 08 Apr 2024 08:53:13 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906794d00b00a46a2779475sm4547849ejo.101.2024.04.08.08.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:53:12 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 08 Apr 2024 17:53:02 +0200
Subject: [PATCH 2/9] dt-bindings: rtc: google,goldfish-rtc: move to
 trivial-rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-rtc_dtschema-v1-2-c447542fc362@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712591586; l=1751;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=yqX/w81Ycb9hVyt/9HQKZXov7UsFMLnZ7nkrSKxqels=;
 b=nQu1d8ztJV2beU36YHMkXGrFhsTXDnsy8WQADo7Rpyj2BA9JfhN+W+nzzj5SHdSULv8HsoK8G
 JkFOsCM6XmSCJFwYt5mlM9kQzi2tSTNFnTOAjB50Z0RwcSmfJ/9+RHz
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This RTC requires a compatible, a reg and a single interrupt,
which makes it suitable for a direct conversion into trivial-rtc.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/google,goldfish-rtc.txt     | 17 -----------------
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml  |  2 ++
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt b/Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
deleted file mode 100644
index 634312dd95ca..000000000000
--- a/Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish RTC
-
-Android Goldfish RTC device used by Android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-rtc"
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish_timer@9020000 {
-		compatible = "google,goldfish-rtc";
-		reg = <0x9020000 0x1000>;
-		interrupts = <0x3>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index 5e63c8f7f618..b889b9317a41 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -41,6 +41,8 @@ properties:
       - epson,rx8571
       # I2C-BUS INTERFACE REAL TIME CLOCK MODULE
       - epson,rx8581
+      # Android Goldfish Real-time Clock
+      - google,goldfish-rtc
       # Intersil ISL1208 Low Power RTC with Battery Backed SRAM
       - isil,isl1208
       # Intersil ISL1218 Low Power RTC with Battery Backed SRAM

-- 
2.40.1


