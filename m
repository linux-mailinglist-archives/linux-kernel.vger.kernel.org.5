Return-Path: <linux-kernel+bounces-122282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E041288F4B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946412997C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E15A22094;
	Thu, 28 Mar 2024 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9Y/M/tU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029272554B;
	Thu, 28 Mar 2024 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589598; cv=none; b=k/m+rbCQt2ljlXXZTmEK7DN8MXRF7+ECvpg6w7G3sGzwWlVWbDQzrQ0ok6dR3K9+eYEEfFaEB04pZfIdXda5cUoQQmajGbtDg9jM9f6CiZlkIpltaJibNBD3lGlfl7/E4GRaM0Z1RNH2M2haQbY4kdMJ5pj6Kr+xB7G3kpn4/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589598; c=relaxed/simple;
	bh=YDcNcquXcHWCPOuOTYjyhuADwug6LeexFaOD5IjWu+I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gCt9LxusrUv1DOD/HVvQWKp6pWkrfDD7Yov+ej+kqE+ff1OJhwDjdx4N9LaqxFYDI3J6AlVa4HCjo9sOfMZnch4GKYgYmUz54zg6GT4r181Z5Any5UlaQxbpzLw1ZUv7r0ZlYUon8khyXiAUXZA1ly+gdMap1qPru/L85lxG6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9Y/M/tU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e00d1e13acso3554905ad.0;
        Wed, 27 Mar 2024 18:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589596; x=1712194396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bI/8H0pAGYbJspCOpWpVMnvSIVC0SWhWj4SAbo7SW7A=;
        b=e9Y/M/tUfjbn5quw3FZIDGzYB6Fa5GGq8dri7zRHcfjiDlr0QcOHU8i30f0Wvq3qVR
         SUrlhj2Qgvc42/lJLzGBNiW3ytpKry1cGk2IxIPUjyfb/L9TQK8ME70ssg6yxJsYbuf4
         OZlWZOHFNJAScZmObvthcdCUNXJ0MDQfEOmT47NQ5e1bhV44uvCXehFltQDGRAqDNr+h
         xMb0h+Ra2pnVxsfRYRhS43MK2IHxQIbHnYQOwkS42XO2AB6UKTfkrO/boVHtqkOcLHeh
         SIXi0Zr9lfFKeZ9enGP2eZIi0E2V/0MRTG5Ow+VaCyjNnjAcrkXs3+qeollnGt94h8iF
         yaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589596; x=1712194396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI/8H0pAGYbJspCOpWpVMnvSIVC0SWhWj4SAbo7SW7A=;
        b=TDTE7wRMWd5xJQeBRnx668C0SUN7GvrK17ywwh8GMBfeZM3gA3y9XaS1/wTakpaZVj
         9SHyx6yBj2PypYWmA0xovtPROPdyrPoQ4hJ6HK0E90JLqucwkPA73WIqUiRwP0KbOrHu
         7I5uKnqu70KB7C3yFdl9qRmu0WZaHrTOcBYCyj9nx+Y/Dp9mmVGQ/BG06CICpBXc8qWz
         g4gEGetmDnUKIIl/onYGweSxjqD4qw80YypvJkGdoS/xjAoOQW/QKnTfdYnfu4Os8OZZ
         TAgHmaKTiTJAMzDiVwW6d5JubA4PpZEalSD6CIVUi+QxU5fl8n2vfI/r/yNxqMcXn7Un
         olaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZUGnryW6Doh/1k5MbAiWMhdBLe197MpiZvSmxdYSAl4gW9hUHI8n04+1TmboAfjfadieXiY1XGaopcoxd0FOGwXxjtRNoJcjL8FT7viyAtHJ8F7deLTvoc+R9U4GgMriM+aDGntfZQSH9aUyya+WiANCfDeRU10B+KMTS4QnWOyG3oH2dcmOC
X-Gm-Message-State: AOJu0YwVfvLT6Ly9k+dV8j3y0qoGBb0O2qm3DrWeM7PlJImxQUIRtTBl
	n/u4VyJw9xYqxuGfyTDNcK69Ev3vU4+IlEcjuPBn8aLhCR6nhrV1
X-Google-Smtp-Source: AGHT+IFsBLzrq9PPCeN5NGFGoiK1EWQwfPzGwMyzieFUAaPbnalux9RNDxGXm3wYog97cDv+yXPGLw==
X-Received: by 2002:a17:903:986:b0:1e0:d9da:b126 with SMTP id mb6-20020a170903098600b001e0d9dab126mr1644145plb.15.1711589596275;
        Wed, 27 Mar 2024 18:33:16 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e355-7eb0-b4d0-66d2-2269-ef6c.emome-ip6.hinet.net. [2001:b400:e355:7eb0:b4d0:66d2:2269:ef6c])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001e0e85a21f5sm201338plg.32.2024.03.27.18.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:33:15 -0700 (PDT)
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
Subject: [PATCH v5 2/4] ARM: dts: aspeed: Add the AST2600 WDT with SCU register
Date: Thu, 28 Mar 2024 09:33:00 +0800
Message-Id: <20240328013303.3609385-3-peteryin.openbmc@gmail.com>
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


