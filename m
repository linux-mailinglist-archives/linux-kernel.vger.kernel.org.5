Return-Path: <linux-kernel+bounces-120574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2C588D999
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D114B23E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCD13A1D7;
	Wed, 27 Mar 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+JwgNcr"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E138F91;
	Wed, 27 Mar 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529631; cv=none; b=I62Kp53+rQvnO4tbxHDZZF8ewoAQjSxd+lIlQaYvUItES33ORJ+uPBigh0tcyeqItqDant8Soy2wXMZeQR4CzhsWwTu1gKAGbWegNqikdeHNZH99dfy71orzHiir51wJqmfen0SiVOEDEpZWVFq8OTm6od8mYSomXw8PvN4eJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529631; c=relaxed/simple;
	bh=uZfnDGW6R8YxxzhmPXNOoQ4C6Vi6QB/c1rE2mdl1BHU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkZT7Cbq95K4X2w1UAK/5NoMSSMzwU86c9Gkt9EeLWYmzwiJDxjBeK8s4Ww0Ayr8ndLrZlguHB+N9CXc2ViqqR9dCzy+Cr+XzdLlTuWsExhG2VwpsUxSUop3SUMfiP/MhHL9QYEHV3IioZQibkSH0yqfBcBSLsNjrN5oftMtCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+JwgNcr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0189323b4so50458795ad.1;
        Wed, 27 Mar 2024 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711529629; x=1712134429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9G+01fnYmsgdrsm4iyF3y0ufJf0ihC4vR7iu7tY8Oc=;
        b=g+JwgNcrp1VEMApevgQF3DomfW5mmrx6DmKYn/UCuf6Q90bHKjfQ6CC9s85AOuhxPw
         bgh0KO9asDOHJHU72KhKnOAhBhC7uC3jhS0Wn2iE1ubHOtVJ4uRT+bkfDNTmXAXMjbew
         XtCeLVc5lRENVR297RZ+AtIYfdsbHb+nl9vlXaOfnasyUd+bPdr1f3e/7+N4mNdCgHLl
         TcR17rpe5Gla8Pyb9Hls5IMJ4FpVKU527Iljctycj50Q0eNQYF8fXNA8mitl2MAfnXL3
         GObHSG1NNsHwU07PM9h3MrYEOdHVPrQrE6KYJ2NpFuYRbfZpZlA+FliA66BSS2KgfTyx
         W9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529629; x=1712134429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9G+01fnYmsgdrsm4iyF3y0ufJf0ihC4vR7iu7tY8Oc=;
        b=ozuNaZrZRF1iJwqW0jbZadzA1aG4L3PdnrJJZFzr3zjFvtXBNAOlpX1T9szhZjKFCo
         g2ztrejudocrWcD+czYFayRxXA0w9qWIFlcY8UsIH24L+ZO4FU52u9UB7f8qdfxl5AoO
         ET6K8ctNbQzJqZtd0qjez0HrdEtzfn1ZV56NM0joZ+27sbdxoMmKkhCxwLg3qtA9Ve70
         3meOZYBSrDJQJgQbhIg2OZ81XNREbv7rW9yjEQNyJmbjxk7jscfJQxVctESAHG+Oi00S
         U8ij9uRJCRjMS9ILDrXo7+b0HEqA7ofu/+/+D+jxFRkcEb6TKOTnDFK3K39gfegx/I6v
         9/UA==
X-Forwarded-Encrypted: i=1; AJvYcCUyhY9ss2Oh0epFAXiBdY15bgFGMwTsJtJFfsoQR6tqPVWrxA9I4/fHB3muLuJOU8PqaKPr2QTkfO24Z4ZZ6WL3sLiv7QJdeK2KpxhLpe+O/pnqIQQFuzS+o8bQ4Wu5zWbvDuoNpMNNcZVAMwD/GM91lYfcqjllqGODcuP+59SFUi+4qvKvdEgf
X-Gm-Message-State: AOJu0YzwluFAdBRRUoJegbWV/8715/7j/d/t51iZySseHytmmigYj++F
	JxkrYis4grEowsPRo2YF0KgvP8PqMghJnIXNpBrbSRvS5+8vDwjR
X-Google-Smtp-Source: AGHT+IHMtf+g4HCFGxUFbq7vGIja15S+RN2FfG532r/JlKdvx3ne3MqOCeZu8bYoa6cKVVkgxKSGoQ==
X-Received: by 2002:a17:902:a3c6:b0:1de:e5aa:5ce with SMTP id q6-20020a170902a3c600b001dee5aa05cemr1931176plb.41.1711529629258;
        Wed, 27 Mar 2024 01:53:49 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e383-3566-013c-5a87-9abc-381e.emome-ip6.hinet.net. [2001:b400:e383:3566:13c:5a87:9abc:381e])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b001e0501d3058sm8356848plb.63.2024.03.27.01.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:53:48 -0700 (PDT)
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
Subject: [PATCH v4 3/4] dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
Date: Wed, 27 Mar 2024 16:53:29 +0800
Message-Id: <20240327085330.3281697-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327085330.3281697-1-peteryin.openbmc@gmail.com>
References: <20240327085330.3281697-1-peteryin.openbmc@gmail.com>
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


