Return-Path: <linux-kernel+bounces-119251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CF288C62C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CC0306A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612F513C9CC;
	Tue, 26 Mar 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDyghkxZ"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3D13C9B7;
	Tue, 26 Mar 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465247; cv=none; b=QesItnVxkVJhG5Uvx+ur4D9MsfIHYNRVnHJOeLq6RyjQMeT85yDe/zbCDOyC6aQzDs7+zz/oOFnnr80TnqaL+bDTsOATGZc0ZBJsbgM8nBzJEoCLJN6r1/0jlOeWYAk2PxjD21YoRPptqinH8fajmhP4RZNVCdRnp6WEw9ZAWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465247; c=relaxed/simple;
	bh=uZfnDGW6R8YxxzhmPXNOoQ4C6Vi6QB/c1rE2mdl1BHU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdV/Jh9WNwqOtphIHkDyRTaX9r2E7kiGzkmcAysEqV8EDkSKfgMPvcGbBgykRRwk4zqqdypj9zRV+6cNCa9wfMEBMn5TN/0Bgm8QWqBV4Y2h7JdeV4Y4hLvcCGjfUNZuI4rwon5ewQvI2LvgwgA8hmsg0Gan6BRv1JGBEleZw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDyghkxZ; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a4f9f94e77so3175481eaf.3;
        Tue, 26 Mar 2024 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711465245; x=1712070045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9G+01fnYmsgdrsm4iyF3y0ufJf0ihC4vR7iu7tY8Oc=;
        b=FDyghkxZErRKWH5L8jX19hT8MKBL7kY+Y1/F5qq3oIZfY9n9xJ3yhxbPd1cWuL7W8k
         UJOWsYIfIc0yqTjcoGjV7CCDiFjho1pyk6TkIz3wGniSt5J+t+/uw9mT4tInQTXu77hw
         WfoKQZ0UuzXO7MYuVzRYd9Dd9hWaaj1ECA0XK/ImKovRybvA0sea0egAmOulKiK4zPtU
         AtRDYX6dmJsy2SjvSt3VEh9KSn9EtP1iWaEnAz12I5D6ZedXZ0bLFj/l9+os8soExRf0
         F3lWaxEtxsEl2gvUz20vd5AgAFlQuPqvlHwm33mtFpH269gWPmzdDnZ5jRLZNgN0om/a
         vD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465245; x=1712070045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9G+01fnYmsgdrsm4iyF3y0ufJf0ihC4vR7iu7tY8Oc=;
        b=XAjgmdWqCfODhbczRhoUeCFVntW1KtXHbYVMCRx7lY7tdQqPuYVTpl+Kmn0gAe9g+t
         s2dWzk+WuFfA5EDpXBlaqI15u2giovZcmNI45TFnQoWG7GIITJtt7WqaB71YvGjoqXdf
         wtEXgOQ55lbmM9q+phoqcH5c6BZbNlU942MUkthQITELkkpIIYxY88JfdaTyO7acAhnM
         y5Qfln9M0epAfzoiNw6KxcfQD8zvO/1oH00Wuag80uqjyiO2O8zf7ja6OhaRI+QTjuJO
         RP5uM43hhsfXuXJ3l3lokGFJZCsPl1ls6HXTGu1G8zV8SILJ/og7hW54mEZXisi+nUMY
         NMvw==
X-Forwarded-Encrypted: i=1; AJvYcCU9jks7wiucwlvx4Qs1t72IlxrrPw467NHWT0V8bAU5ALU8MI5Ir9DSGLq9FU8QkUnjy96Sby9kDe8Fqsf6brFR7mQ9AaI0AFeEycsdccko+WR/re9L1L05xFLKilafwr+2NTqy6A+jCTG9/eJNsveCPxBCFHB8P0X0CpqS7NQwYuXkHljaiBOL
X-Gm-Message-State: AOJu0Yx6ls9gmeF+qMQq4ugTuc/S89+T+P0hHt+qyEH7jmM0/n8aWT/O
	sGlrOEJDkuy7B/TBYY7NNodOoJcsBGRE/eh/HWKZH1XVmEAVusxR
X-Google-Smtp-Source: AGHT+IHN+fopr69FJ89Yh2+C9kaCZwgQMMF/ZNQmyQw3jN0rS6V6fpUrceswbHdxV8p2In3aXxih/w==
X-Received: by 2002:a05:6359:4c1b:b0:17f:5a02:e938 with SMTP id kj27-20020a0563594c1b00b0017f5a02e938mr12309821rwc.1.1711465245390;
        Tue, 26 Mar 2024 08:00:45 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id l27-20020a635b5b000000b005dcbb855530sm7658404pgm.76.2024.03.26.08.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:00:44 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
Date: Tue, 26 Mar 2024 23:00:26 +0800
Message-Id: <20240326150027.3015958-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326150027.3015958-1-peteryin.openbmc@gmail.com>
References: <20240326150027.3015958-1-peteryin.openbmc@gmail.com>
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


