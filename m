Return-Path: <linux-kernel+bounces-135637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A643689C8F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476601F224A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619881442F4;
	Mon,  8 Apr 2024 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbmIVOqq"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4D143C53;
	Mon,  8 Apr 2024 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591606; cv=none; b=PI84acAM2EfXyJjAt4FfdHlY2CbZd76BuOdL2nvyRSel0RuWNC5NW1Ke3gSFU5ZkysXDGKZxKUsywt28EInlyB8S+rCYSNfQiS3pw50v6Nlk00Q/4PwHJAZgOuAsTtVaNPHmCAYoHx7rxSIQxcdzmz7pa9OoalDYU5DexQO9vCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591606; c=relaxed/simple;
	bh=GFvvp+NJ4mdI7BDHKwvdqRInm14P4YsnxCRqORkt+n4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m2+Vp1FLLX59vamU9plPtQPGYxE5fJ2nAVcFb5q5JfLBL2PZQ1SVlUbGkHJrYuay1yJP2HKGIctVyEpoZ6MVzQW7f0KRl6laqPc5Pn3nyQzFQHO4nqwcJnN5wzomOUUgQbToa3YN1q6wxAWAocIP+a3W8joSL7yMuoW5xaymbnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbmIVOqq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so5162039a12.3;
        Mon, 08 Apr 2024 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591603; x=1713196403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWg1ENlXHc+/PDZHBiKvXmfM9dCYHYF/K16ZOemXbZc=;
        b=PbmIVOqqH+jcMVJblPcJDOE/04aa7+wP0RGvk8KyBhpB3ZCBZ6tXfCLUVNNKdoU0E2
         opdbAqKZDtiYgtWaSQQ0ZwuCRsgSDvzAf/Ta8iYUyfcHeEiqaRLFBfxCqDziNg2q3hRe
         2Z1s5bLOPJTezaT6u4rdC02bVRsgwOGf+Ebl+5zvWZBgBL6uDqWxwwx/b6ELtcKUDBmJ
         1cPy6PlMF9VdV31YXnkdUkJHpNoGTL9wZnRAeBPQztIBjs8euszOaqMYDa96SveoEhSF
         jZ1OM91J8hyylqPL+EYdS6UW8ZMxZhMvxCh6iuIKfwID3toWJsmYMhSHsLEjD8uEZx9A
         7+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591603; x=1713196403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWg1ENlXHc+/PDZHBiKvXmfM9dCYHYF/K16ZOemXbZc=;
        b=emekNNjx6Q22n+4iNu/+kid1iMGPkivQmszFne2Yz4Ts1QT9HfrH+YbeB2ntGm66dN
         qFg/ZdWUydWT4iOexpR105B1XwAUQdgPyPrODHbxjvWbkZ5z5pc9dxpwcRaGOek4ZK7p
         Xv19bUcmxJOQE/MEfnYA8nm1MIE63m9IBqMop4JNryRkQ5bJYVY7nSJDSpP2RIYAxSVS
         5xzZQOqqZn3GbHvkzNY3dMoqXcXKsyGBP0T1Cslth1pe9J94VzktYWgIZbqGJb8gaG7t
         gg+cgfv8yA9oEjvZejeyBXUuD7jqqTq6FoOc2sFEltxfA0P/YNO3nr4ujUDRvSBasIPC
         dHmA==
X-Forwarded-Encrypted: i=1; AJvYcCVisyfskTaTJWdQJ9nfd7VeGIYNwGnqS0ICqN8iWhkttg6wj6MafIELEdG7R5lamMAYSiGwqPdmCaxnwegSrmJ1saFwSZBrPskZO4hjPYxhcYkLOjS4+PJWQ6zHrNZaF4jqrG2QOB3waQ==
X-Gm-Message-State: AOJu0YwkmwE62v18BRPMaLGJreEqSpoGIbj9i3H0dvGzPkMvvP7dbVOA
	+ZfqxLz4uZAu0RWBUxHWEkljst6x7cOJrLfj/niYJIlBrnEfjA3K
X-Google-Smtp-Source: AGHT+IFepnQDpHcqTbdYQgYMHbQ520Q8WNttr0OK2ZunJaGOwvtIFCl5cwFDkeGXluI9lcMo/d7pvw==
X-Received: by 2002:a17:906:e08d:b0:a51:aec8:eae9 with SMTP id gh13-20020a170906e08d00b00a51aec8eae9mr4956245ejb.10.1712591603486;
        Mon, 08 Apr 2024 08:53:23 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906794d00b00a46a2779475sm4547849ejo.101.2024.04.08.08.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:53:23 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 08 Apr 2024 17:53:07 +0200
Subject: [PATCH 7/9] dt-bindings: rtc: spear-rtc: move to trivial-rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-rtc_dtschema-v1-7-c447542fc362@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712591586; l=1628;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=GFvvp+NJ4mdI7BDHKwvdqRInm14P4YsnxCRqORkt+n4=;
 b=bs3zfnUcz5gwpaUPlz/wrRwcwYBcEGy6bYrrJTdSHbRau10DwIlYJxoxpsBmwPdugAX+didWp
 Edw33B+ngJbCvBBtLqoFKH6Nttpgzn3gnZWBbsX7feyzl34c8LGzx9F
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The RTC documented in this binding requires a compatible, a reg
and a single interrupt, which makes it suitable for a direct
conversion into trivial-rtc.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/rtc/spear-rtc.txt    | 15 ---------------
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/spear-rtc.txt b/Documentation/devicetree/bindings/rtc/spear-rtc.txt
deleted file mode 100644
index fecf8e4ad4b4..000000000000
--- a/Documentation/devicetree/bindings/rtc/spear-rtc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* SPEAr RTC
-
-Required properties:
-- compatible : "st,spear600-rtc"
-- reg : Address range of the rtc registers
-- interrupt: Should contain the rtc interrupt number
-
-Example:
-
-	rtc@fc000000 {
-		compatible = "st,spear600-rtc";
-		reg = <0xfc000000 0x1000>;
-		interrupt-parent = <&vic1>;
-		interrupts = <12>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index 0f773167d32a..d75c93ad2e92 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -81,6 +81,8 @@ properties:
       - ricoh,rv5c387a
       # 2-wire CMOS real-time clock
       - sii,s35390a
+      # ST SPEAr Real-time Clock
+      - st,spear600-rtc
       # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
       - whwave,sd3078
       # Xircom X1205 I2C RTC

-- 
2.40.1


