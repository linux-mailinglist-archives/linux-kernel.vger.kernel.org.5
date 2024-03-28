Return-Path: <linux-kernel+bounces-122331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E2A88F54F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091F21F26915
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B133B2A2;
	Thu, 28 Mar 2024 02:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRrXNCx5"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92439FF4;
	Thu, 28 Mar 2024 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592571; cv=none; b=XJ9lCURbr0vfKdPc0PHQYHpeQwu/nZcYBpmIoIbT+Y+Df2RMG7/caHoYRpardUJFvBvc+ssE3psIBboOAliH5lk01XkNyytspL9wc7eLTbC0WqsOrmbuaVGVRE8ZirWOurpNG8I118LJ9iU3faR75Jq7coObrW1SAJv/8o4IgLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592571; c=relaxed/simple;
	bh=uZfnDGW6R8YxxzhmPXNOoQ4C6Vi6QB/c1rE2mdl1BHU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/ujw7dc5h+ICOnmk6jAVmvw7VVYRBTjE9DnlFY6eGyOPK094M4+ddVsQPRlC4Yyk3UVV40mS5RPWDG7+8WUFGPkEU89UZQyTNRedi7XOMORV0xcixLli0Tl6yWDpHGgAyHSVdVxq1skAp07W7FGTDcIHi4BFMOu6fzzS0+hdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRrXNCx5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da202aa138so384840b3a.2;
        Wed, 27 Mar 2024 19:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711592569; x=1712197369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9G+01fnYmsgdrsm4iyF3y0ufJf0ihC4vR7iu7tY8Oc=;
        b=BRrXNCx5C8AEJtYN2jBw/m6tT9YMysqiRA0bxw+CSCAptduhS+A9KHmvHuUm6JTvpF
         SbsbSUETr82SNigVzxCIWTAzDKTvoHFsbxs1GOkNSlFIe6ipV5GARG/TikSVhg66+hOx
         FbFhnLDi7oJJkYmLXMkFr3G4xDAVjM8qgWu0H0AjKsw9Il3o3dsGvo794YJgixxIhrHU
         DeLsxOX+9zIie90dEAxXjuTGvO6/xUnHyedRJYsq+u3J0HNIbywFsxrnTdu2KIs26zTO
         d5OVptV0trogO7AvsXl29CPXE2WycwQ2a4FklWs/beOwk/sbXIWdX22/wmhpVq7mqA7N
         Hy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592569; x=1712197369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9G+01fnYmsgdrsm4iyF3y0ufJf0ihC4vR7iu7tY8Oc=;
        b=faMQV4kOj3WY1Y61HRerLVFgO4srrMmSiKnHi/aQuFaT0+MOYSDr3EISoyKA+to9nR
         FRBizDJuLiouZvDQ58xRAoF0UBneZUEVF00oPA0f9VbpGw/J+BPGXlBzsgNvBnxN3UsN
         2sH9VUjK2lOuoi9+kGaHlosVTepRsAZ3u/YgtOv+pzW/G6ou3E6zd520ig+WhCzbX4mA
         Ee2Mvzt28Do/KX5XopSTX4Gcwgh4mNC0RxnT6t7uo6khKJ10+AEcabQ6HWhO9H+Tz2MD
         Rgdh3Sd66F3knhFTXKBOO8Vi+YHFIpUqu4NEsc6iHmYlVET/S5XZOcJPwEAu+tMK8PCp
         nxYg==
X-Forwarded-Encrypted: i=1; AJvYcCVcWXAeRdSAhPtLVQB5mdXlGnFa2WyVgxB6+4f59iW5z7XyUCuXgkFRO0semdG8EWgf1Mbb1EA0J/CpJ5/2ccuD1Tri8VqFDz7xAtNrghdz2HoJfG1sYmr8yvg72qe7KQ1DMFd6IP1HseIW2l6k5jmO7pOiixG4X5TD5Gng1Jtpi/bl4UV2ATBL
X-Gm-Message-State: AOJu0YxCCPeR0qvrjhndex7I6kg/LSMyLYEBRloe1XwNPhvoUk3HP949
	5m+XzDTQcYMsL/Xzfz2ah0PCPVhUtKvUv5JgkomiDW6ijLvQ6UA9YD98zTu9
X-Google-Smtp-Source: AGHT+IHEYik3ANtnRa6lUOZjg98pWEyljQMpLalhqqnQpsJMdrecpYww0XTbhYN2Vm8Jo6MXl+PZ+A==
X-Received: by 2002:a05:6a00:1a89:b0:6ea:bb00:dba6 with SMTP id e9-20020a056a001a8900b006eabb00dba6mr1983301pfv.26.1711592568937;
        Wed, 27 Mar 2024 19:22:48 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e355-7eb0-17c6-c47d-d4ee-f9e8.emome-ip6.hinet.net. [2001:b400:e355:7eb0:17c6:c47d:d4ee:f9e8])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78699000000b006ea858ea901sm229256pfo.210.2024.03.27.19.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 19:22:48 -0700 (PDT)
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
Subject: [PATCH v6 3/4] dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
Date: Thu, 28 Mar 2024 10:22:30 +0800
Message-Id: <20240328022231.3649741-4-peteryin.openbmc@gmail.com>
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


