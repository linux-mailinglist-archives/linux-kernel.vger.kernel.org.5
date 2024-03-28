Return-Path: <linux-kernel+bounces-122283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F96F88F4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF201C2E1B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78C028DD5;
	Thu, 28 Mar 2024 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdoJWqQb"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F52557F;
	Thu, 28 Mar 2024 01:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589602; cv=none; b=oWHx1ZRxhhkzsHR/9aHwRRtFrqR5S6x5rejIBpPQ9/ww2uKXED9vcx9UQLMJgRxO/UMSsQhMua2NoIo+UBI7BUNAToEywTmjLjM0UrY7mLOEr868IXOJ4s6zOPP8F+/7ceyheEawiGq833uh2DjCZDRKFj/WHIGjSizRB85bTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589602; c=relaxed/simple;
	bh=uZfnDGW6R8YxxzhmPXNOoQ4C6Vi6QB/c1rE2mdl1BHU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PG4OADJWirGCwOjkFH0Ki0WjRNrVAav2up/PNs3SwTy2Zpp6dDEmsXSjjfZJnZONrZcx516Z1EjJyBEkdkpGG3mZXJUC7KclE7JX77zyfoIaW67hkb4F6zQfhrPckBoUr/9aqtndtrJK4srSTYNVDXmz13I0dYidSQX9eFM4OW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdoJWqQb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e00d1e13acso3555335ad.0;
        Wed, 27 Mar 2024 18:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589600; x=1712194400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9G+01fnYmsgdrsm4iyF3y0ufJf0ihC4vR7iu7tY8Oc=;
        b=IdoJWqQb2n1RKzmSjnqk7C2nfyKh1bwpDFCFdtVKRNoaerPhs+pfu7nufPgTQa4P0C
         omrI85WiDq/GwBnllDxXrHdmzfZ1SOC+X6vTga9n/Q1N79pufZYn2DOkiO1EtrcqETyh
         M17p/Vq+7fjnWkvlTZYXw0nnp4WrvrHg85JgBo+ZX1lFTfqQAtcHoXEvPLmmO2kDobad
         fQZbDu3A64DWc7Y/SdceMD4mQcadKmWauYghENm3sOD7dJYt0MMdZvvSVjrW9ea3cJJq
         nUshl1thUFaZmyLeS8aAaaAKHphQDu0QXuer8woZHD3UYhlAP8rfZH5NAjjaGP9bm8MM
         X7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589600; x=1712194400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9G+01fnYmsgdrsm4iyF3y0ufJf0ihC4vR7iu7tY8Oc=;
        b=CJOjPD3gX6aws0JXcj5goAFLG7ynKGC6TdyGQ469fuzjnv41mausdPKUYholYKn1oZ
         4iOir3ZnAiNwhHVabZuqPZTDJs+a3naoAFK9Xnsm1w0yMw9p1A90sauFI3b2Xb3OW+or
         Vh+yko6/lZMs1ED+xGBSsLgdQEnKAGZDEIbu6ZqW4ROzG7q5hyR/ttgGO0pbuAc40LKq
         VJje5BE290pA5Gf8BgKlNBOMT2M9KJlTHqNoU/4Akp8dyFX5EAmKf/kkd3ZIaINJJ9Li
         eNhqRvzqAJqmXP/BZZjKoArK2pVGyTFppKhCKqLSPrsT93d6bUoLXxu0BEaXbLniE3ox
         3U2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXI6O/Yo5TfrzYiwCUjNH4MAY3nTVUDdYYC3wBNHs0uhEYjwUn3yZw9ZBbRi29OcDilQ5iodhgttX/vHLh0AM90dbhsGvjrPoa+e9vPo9MwymAvK48rlPEgBUaKEsAXwOYXYRa4KitRKlKZjZpfZnreE7M/J92GLCZl1TJPBKeJRwGV8AcfrY9T
X-Gm-Message-State: AOJu0YwV658ip2UOjMFWB7XuCRKg4vHkL3EjCud0rvoSJBwlBPadD75H
	lVUP86zyqJlcnIKqaCq9HB5P2lad8TPVHNxRWKtd8er9RX/tvze4
X-Google-Smtp-Source: AGHT+IHiJqaLeX1ZdgNRMa9pBlR+bhPRua5gteIelUWkWhnVizBcWhV4cIRYRWVS82I9hJrHDaThDg==
X-Received: by 2002:a17:902:d503:b0:1e0:11a4:30e0 with SMTP id b3-20020a170902d50300b001e011a430e0mr1966819plg.19.1711589600090;
        Wed, 27 Mar 2024 18:33:20 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e355-7eb0-b4d0-66d2-2269-ef6c.emome-ip6.hinet.net. [2001:b400:e355:7eb0:b4d0:66d2:2269:ef6c])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001e0e85a21f5sm201338plg.32.2024.03.27.18.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:33:19 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
Date: Thu, 28 Mar 2024 09:33:01 +0800
Message-Id: <20240328013303.3609385-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328013303.3609385-1-peteryin.openbmc@gmail.com>
References: <20240328013303.3609385-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To use the SCU register to obtain reset flags for supporting
bootstatus.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
index 3208adb3e52e..80a1f58b5a2e 100644
--- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -8,6 +8,8 @@ Required properties:
 
  - reg: physical base address of the controller and length of memory mapped
    region
+ - aspeed,scu: a reference to the System Control Unit node of the Aspeed
+   SOC.
 
 Optional properties:
 
@@ -62,6 +64,7 @@ Examples:
 		reg = <0x1e785000 0x1c>;
 		aspeed,reset-type = "system";
 		aspeed,external-signal;
+		aspeed,scu = <&syscon>;
 	};
 
 	#include <dt-bindings/watchdog/aspeed-wdt.h>
@@ -70,4 +73,5 @@ Examples:
 		reg = <0x1e785040 0x40>;
 		aspeed,reset-mask = <AST2600_WDT_RESET1_DEFAULT
 				     (AST2600_WDT_RESET2_DEFAULT & ~AST2600_WDT_RESET2_LPC)>;
+		aspeed,scu = <&syscon>;
 	};
-- 
2.25.1


