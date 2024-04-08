Return-Path: <linux-kernel+bounces-135639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BFD89C906
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C5B25831
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1861145348;
	Mon,  8 Apr 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWuMHZHd"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C81448E0;
	Mon,  8 Apr 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591614; cv=none; b=g/cIUEP7tj2x0EF9VZv65K9CXiDOllX+ItiEsAInkwI0GW+pX0AJ/Jamh3uOn0judbJPeV120j36fSEqs35N0kSkFIFCDK3LlVJ6G6XzO7lduPxvpm6GmtDi5O6VwX00ebytoWHSUuDWhO4Zu2QrDVsd4wn5w54hBfJbC+WCScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591614; c=relaxed/simple;
	bh=vM6749OZUGmuUGhDa/POZy+5vZeS+6APRIR0QdxNkUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SBWyDbbuGrfa0znfKw9W+fJ4evAR9XfhMrjEOtZjzY0AiwWfmWGNDzlkGBogFWo+UTbyaeP48Oe6F0vEV0NvOyB13iC/qgT1OF6WD4C2VdfP3PTyARdCIIARZpatHAeJlRG4YFcMcGF+ahJM3pkUgkLJHw/iYpZdP5Vs0hBAaLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWuMHZHd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso6298739a12.3;
        Mon, 08 Apr 2024 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591611; x=1713196411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3jReaO8bBGw6JBZ1RkUcA4thqN9iUeRzORfBO64Zek=;
        b=dWuMHZHdhTXL0FtBZkVIm79kudogcTEPnnl18Hcw4bDDZbnSKmTzSCNQWUyE6dTFJo
         tH/7Y7AKKyN3t6x/VQA334k8A7HKzcKTWe+LMgWrHeoO4yXh3MdcTsDwYYxZhqEqh1fw
         /h/iFIDlk9uTwBPlvzZFCuRnsMzi316rIy8XJhldE+c6LGq8VTr5mHIfpCKT9ajZMFUB
         GYNJmIq31IhzDZvc9P3XDFPqKtuCc1jvHv3JksTNzpbYh9CGALP3O9CQvg72lfIECAQV
         +GlKWzE+fW/oBJtoIYJwGkkt518XCAWc2MZlQVWqQuZmRe44DlBDcoWZwnODKjaN0/bc
         XVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591611; x=1713196411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3jReaO8bBGw6JBZ1RkUcA4thqN9iUeRzORfBO64Zek=;
        b=tk7Y3gFC8JLfNwdDz562RpSN/Xdt25Opzu7HOlLASJtCl5ikkfF5DEeQ+bb6GcgmIt
         4jLlUs3S+zzxa/faoTKDktBdHqyIhKqlPGrEgr4v19xZrAknySVnd01kFOGPJ5OQ7Lo9
         u938Q+hHBpdjsWnOVDrolwPC+N/6OOmhMfIcEdNHnVfh9u8XEO/uM64kynmAfU5wstP4
         3QHmfnPwKx/hY56mGQk/oK2OLeWFOzGaNKAhZPQyOdidQ68ExdUYSPpZlgODn47YoX9j
         QD05RsRhorKXpHnUsvX/qtEUi+sGxMGCUh8WLIRXTTu8MXYVc6Vbq3fCS6HEoQ59tzJt
         5feQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMyl0bvQd8rFt4ViT6m+fp0DNTkCooQb4oCeatu6a0tAS1ppXwbajoLvBN0OqJYhfKP6mHtXY2V9VtDiVT0QEucf8nPa4GQqHKeT8i45OLDYW5fStI8ffJokz8ibm/2N0NglypEyL1+Q==
X-Gm-Message-State: AOJu0Yw5hYJxbiB4SCa8UDVWCF7943MpgzSMK16KYaa9Lwm2Jpp0rKdN
	4Hy7hkaEB5cG8gM9s3KpQX3ZWcQ+UVQEQ3i17iHQwYEaSetBfTm7
X-Google-Smtp-Source: AGHT+IHDUn7lM+m3JJro1I7sX1HqWbE56mUHHewyuVneCeBjUwlfT2HuBoGiCiRi+8XMgC8ngOpekg==
X-Received: by 2002:a17:907:9485:b0:a4e:375d:2573 with SMTP id dm5-20020a170907948500b00a4e375d2573mr9215871ejc.37.1712591611213;
        Mon, 08 Apr 2024 08:53:31 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906794d00b00a46a2779475sm4547849ejo.101.2024.04.08.08.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:53:30 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 08 Apr 2024 17:53:09 +0200
Subject: [PATCH 9/9] dt-bindings: rtc: via,vt8500-rtc: move to trivial-rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-rtc_dtschema-v1-9-c447542fc362@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712591586; l=1714;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=vM6749OZUGmuUGhDa/POZy+5vZeS+6APRIR0QdxNkUs=;
 b=g1Gbrdrf/K3DdsRveFmOObYxG1SgqzZ8jrKc7OFyd6Mhf+VVcEjwfoBwytdkuegPork4KUfuS
 X+/UsMcNJb0DUbXRodaJxuNiEAk9sWd0n6FZbuyavNg+PpigpZoRRlR
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The RTC documented in this binding requires a compatible, a reg
and a single interrupt, which makes it suitable for a direct
conversion into trivial-rtc.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml   |  2 ++
 Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt | 15 ---------------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index d75c93ad2e92..c48d0dfa28b2 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -83,6 +83,8 @@ properties:
       - sii,s35390a
       # ST SPEAr Real-time Clock
       - st,spear600-rtc
+      # VIA/Wondermedia VT8500 Real-time Clock
+      - via,vt8500-rtc
       # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
       - whwave,sd3078
       # Xircom X1205 I2C RTC
diff --git a/Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt b/Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt
deleted file mode 100644
index 3c0484c49582..000000000000
--- a/Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-VIA/Wondermedia VT8500 Realtime Clock Controller
------------------------------------------------------
-
-Required properties:
-- compatible : "via,vt8500-rtc"
-- reg : Should contain 1 register ranges(address and length)
-- interrupts : alarm interrupt
-
-Example:
-
-	rtc@d8100000 {
-		compatible = "via,vt8500-rtc";
-		reg = <0xd8100000 0x10000>;
-		interrupts = <48>;
-	};

-- 
2.40.1


