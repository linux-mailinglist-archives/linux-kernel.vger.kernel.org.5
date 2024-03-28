Return-Path: <linux-kernel+bounces-122330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690F788F54B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7731C289C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131E62D044;
	Thu, 28 Mar 2024 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9hXQ1lW"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3539AD5;
	Thu, 28 Mar 2024 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592567; cv=none; b=H40v4NszBRQjTl7OQ/dnqU0Dtv9E7mq8qR6R4w9iUf3cQyey77kNkJ6RZU8VHpjY2mO/fhQeNQDNwQgHtECd45Gp3osPhaGhLR60mJeVhEUxxwaAOUF8RL/ls/R4l96zANwVE9DGNZRdSlDCfYToOAwPjqvOqbMeWA/RjEzaWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592567; c=relaxed/simple;
	bh=YDcNcquXcHWCPOuOTYjyhuADwug6LeexFaOD5IjWu+I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nUxd+kTmMPsNw/ypSILJQ7udTcc+Fmyw/nvkmvvbkcofujilaFfMVHgbvNlc3AAPB3ErH+pCOXsh3XXZLiWV7PqzuH207/kRnVWShGDWd5X2DjxHj4kK7yO3amWMvaKdFPQk7gMPvXo0WuGd6tjU4xgXu4dvzOgyuZRz90PCBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9hXQ1lW; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c396fec63aso222312b6e.0;
        Wed, 27 Mar 2024 19:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711592565; x=1712197365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bI/8H0pAGYbJspCOpWpVMnvSIVC0SWhWj4SAbo7SW7A=;
        b=O9hXQ1lWxW+cX+sM9ZVozwwATl1sebsp0Pl5re9GVN40LupYqGzmNlKqGg5d1Py82b
         osNsA8W/qKh6qNWCfisjF3EqjjWZEAaDYtS0Qr2sVkqc4SaIVcGWo/GAw6JMqI87cF8V
         fcUOHDUuY6nkVMOVwXWfM8Kc+nSuchuaIE7gsf7HCqMkUICQB0feDAVLDafbNhcf6/03
         r36h4gWR849LOvrG2Jt5H6qNb8m2RaUvkTEz5Pt3r8756SNN3b57zPJutyXq/a0LcS6k
         M7r1phOg2asqe3z/1JrlcDB+p+4eq+pFijZ15rk4MzmaPgxrlRvcQ/LWMaNAL8diA1Lo
         kcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592565; x=1712197365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI/8H0pAGYbJspCOpWpVMnvSIVC0SWhWj4SAbo7SW7A=;
        b=a/zK+FnA1BCW3MvsqZqDlGwxoJAXQloCzUhSwL+DRHapWOsZamBvNykBvqWm9UL7WV
         oNb9E+BHeuaEO6yfhbkPi+gWwILdmu3GhUaWguIFDNFQ+OfFKGPUmK1QvuwK55LHhqeN
         f2SvEjVtoGvq32MAf3Oc4LYAodx5/rpTSgbi8H0ltBeIik2RXQERe/bgdK9ZKlqxrKaL
         UVn1bglPrjHjVoBXqiBmnfakCQ6LLeGVVO5tNBU3A3op0QAbI3+UzH6i9G8Kj2CBGV2A
         11+rboAcz5tDxV/GB4sNp0sl9JLobdbNxQtVMfFZBngNE6nRGAp5q/+Rg9ocEbN8wjcb
         dnNA==
X-Forwarded-Encrypted: i=1; AJvYcCX1AFbPjmfdfd3/M8/iXrQwszTTQtw0UXdIX7hXIzNs0U7V/hAj2djccxy2q+PYgVpV1hjav5U8tCA4dV42v3ktv5bQiCTXYshUf1VBT3TYP188TRizIRmxXYiWN4+rA9fnY3zRX9Sb39TltnUhhNA26af+dzfvvhmAZR6HHCM2naosM9fFBJ/n
X-Gm-Message-State: AOJu0Yzz7IeRuUgitOBG09UKD13QKVO3ezFIAX2ToIgNShDJGedtL7bY
	hpsuYopoEg682FffWG7qQZDSuv3nb3rUAhIjZQuLRm02G1hTgFgL
X-Google-Smtp-Source: AGHT+IGbwznYQbqi5HTXiUOA7d00ceCj8N2cmmUWUhbT755TePpGDg9zSqMamOerLluvJFoltPTgXw==
X-Received: by 2002:a05:6871:4191:b0:221:bbb6:3aea with SMTP id lc17-20020a056871419100b00221bbb63aeamr1570113oab.16.1711592565077;
        Wed, 27 Mar 2024 19:22:45 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e355-7eb0-17c6-c47d-d4ee-f9e8.emome-ip6.hinet.net. [2001:b400:e355:7eb0:17c6:c47d:d4ee:f9e8])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78699000000b006ea858ea901sm229256pfo.210.2024.03.27.19.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 19:22:44 -0700 (PDT)
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
Subject: [PATCH v6 2/4] ARM: dts: aspeed: Add the AST2600 WDT with SCU register
Date: Thu, 28 Mar 2024 10:22:29 +0800
Message-Id: <20240328022231.3649741-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
References: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AST2600 Watchdog Timer (WDT) references
the System Control Unit (SCU) register for its operation.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index ead835fca657..b47850f0dca0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -557,23 +557,27 @@ uart5: serial@1e784000 {
 			wdt1: watchdog@1e785000 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e785000 0x40>;
+				aspeed,scu = <&syscon>;
 			};
 
 			wdt2: watchdog@1e785040 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e785040 0x40>;
+				aspeed,scu = <&syscon>;
 				status = "disabled";
 			};
 
 			wdt3: watchdog@1e785080 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e785080 0x40>;
+				aspeed,scu = <&syscon>;
 				status = "disabled";
 			};
 
 			wdt4: watchdog@1e7850c0 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e7850C0 0x40>;
+				aspeed,scu = <&syscon>;
 				status = "disabled";
 			};
 
-- 
2.25.1


