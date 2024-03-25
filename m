Return-Path: <linux-kernel+bounces-118015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD6D88B260
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293F61C623AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC46E6FE0D;
	Mon, 25 Mar 2024 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckgcckO+"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1196D1C8;
	Mon, 25 Mar 2024 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401019; cv=none; b=fjKEL37GQT5n3T9a0A9R3xN7FgN3RUSUfJkTsEr/ZVV4Eqm+c1r7sbryB409V7I6XoXG2MuV8m+Yf6PtHOlI0uL3Tjvmt7pI3dAIGu0GsJkjwsvXR+mDxCv2UgPCLIe417GkMwlTDOg94jyrNPShapICtT+Qer1dZeXf6D3NCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401019; c=relaxed/simple;
	bh=OIXMYg6x/mURIcijSzztUrVZGgflCdhRHATYyK8Krl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwGf0I72hiJOzOug8spPKsH0T09CCbhuDIujzo9Rd6xs143dRxELeu8FwJu7fQzZtWhgvp9KH6eWI41tlpSOHgAeIwvrQfhOg3sDKm/7xYSKOOKyyeLLC7fT2Ir40czMvAH/OosM6UnYtNDDwqAVeME87ZxqQrJ/rGhCAMVLg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckgcckO+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4147e135f4dso21785275e9.2;
        Mon, 25 Mar 2024 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711401015; x=1712005815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AnrrJy6L/ZVisQ3MTkpEv1WAHHYQdPkUNV8Tm1bouo=;
        b=ckgcckO+fRLDDXI2h/yc20Cv34TXVZkkKoAnqrOTS5I6QNly0nEv7vvXLyOdcYRiAY
         xIbycHPe1PJ6O2pST3URsuQE993WR5g4+VsNXIFrKwvUcTeepbGXahcB5zD0b6bh2ji5
         avrbrOV4KZocw1E0k/46XymSnXkJuWteDxuAREx95uBdi8UM+42nuIiZ4LPuz3jVCVis
         mBn5cAVvcHef3CZoqz+H/5e+yH8cVxlf9uzyZT0VFguGd2gwbTEt2MeXM7YLOyXQN8L3
         JvZ27DcrfoGWI4y4J4DIkLpxAll5p27RgS+mgu1OpVCdR749oaPuY1eqPftu8mTrTTvj
         MtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711401015; x=1712005815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AnrrJy6L/ZVisQ3MTkpEv1WAHHYQdPkUNV8Tm1bouo=;
        b=psS3SgH1PEDt2fNIrivC/FFOz6uOriNxpm4SdoXKlNakuDmUKQdKFQirtCe668vRww
         44CSg4+RpLkUMoCqU0yOBiAt87zN2LzhAjQHEsv/gv8jytfjqKl2EsN+YGYzHKSKZ+in
         3R9P0yRyAA4T6Yzc1ODk9EqXm/LRYhXgryFUy4R5cElI6ktrjlypnW0szxqDzaos/fon
         XrPmgA+yRQZdxcaqWG6FQkdLMiBO6j8grWIrkJJIe11GW96ar0+BoJz5uctAjGeIZmJo
         +JsUTBgqNIYyF3Wwvz//IVPiqtiuLq6BF1ohHR3D4GhpQOMUjRFx8Jc0DzZdR3KPkh4I
         Uc8w==
X-Forwarded-Encrypted: i=1; AJvYcCW2fQBC1DIeFOsyA2pGofyblcN8JO2/KqE8IkJE8WEoKyZ0KOmXydtzoJHvaSBEFlgjqFp9lHKz+noe9qOIiQgjCY7WQ+l8boe2+arxLiLIdxZkJAq/P74u+Gzj4C3JK06KBy89vnPk/g==
X-Gm-Message-State: AOJu0YxcY+K+63BPHGNDgIJdB0jufzsHi52fMIB/h3nMkbJhJLvFyf7W
	f2Ap7hTgrBuBDW1PdFZKbsDaHXxpqSsCjdl+kXBN0ePRtiOdiQLn
X-Google-Smtp-Source: AGHT+IEKTaim4HNVp5Dh7Wgll3gc5ntD9adIFQU8XGzIYhBgfCfgYcoDxelagmiSKXBFjPGO17oi1A==
X-Received: by 2002:a05:600c:1c24:b0:413:e63b:b244 with SMTP id j36-20020a05600c1c2400b00413e63bb244mr5963446wms.7.1711401015571;
        Mon, 25 Mar 2024 14:10:15 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-36af-6d49-8348-9a76.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:36af:6d49:8348:9a76])
        by smtp.gmail.com with ESMTPSA id n39-20020a05600c502700b004148c3685ffsm1520768wmr.3.2024.03.25.14.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:10:15 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Mar 2024 22:10:10 +0100
Subject: [PATCH v2 3/4] dt-bindings: rtc: digicolor-rtc: move to
 trivial-rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-rtc-yaml-v2-3-ff9f68f43dbc@gmail.com>
References: <20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com>
In-Reply-To: <20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711401010; l=1870;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=OIXMYg6x/mURIcijSzztUrVZGgflCdhRHATYyK8Krl4=;
 b=kGUOEQCytjF7nTckvqqmcLKZ0451gPd9pnvIAHy8gYgUsurTfkRJbDhMkMhJ4yeV7Eutv4p7t
 SL7VcQ2ZgEwD6W0balsAnTD4wzJMtgoMEu1LHT+bxri0noSKFrAB+OY
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

This device meets the requirements to be moved to trivial-rtc
(compatible, reg and a single interrupt).

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


