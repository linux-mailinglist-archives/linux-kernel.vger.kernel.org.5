Return-Path: <linux-kernel+bounces-122279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0D888F4A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20B41C269E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E87208B0;
	Thu, 28 Mar 2024 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq6v7xIV"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD00208A1;
	Thu, 28 Mar 2024 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589577; cv=none; b=iudM+FRxHak7QrDg18gUo1FPqQFXYh2f13sbYsAFcxdj1OZlhFcFoTc9lZGiI5B7NXZmcK2xV+lNz42ri1N6IZLDgdCPhzlurnuKuWomkHf4y2O8g3B2GubA8D6aJCytPYxcGVSbksmhOL04/5i4jEyNuVMJttb20E9wrqt/C4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589577; c=relaxed/simple;
	bh=iuwHyz1syU2AnQIHPzBZMFgUuJdJtfSc68KscSNZrv4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=iciiJ9EuLYhOWVLWrFw7zMMO6ipkt8AeK31uDPMTmL03YzeZM0t01r1uhZnfo9vxp0YDbuBb3MVsGebm+GbYhMwH+8F+iKo9n2XQ3xUwKIxg80gmY2vlnTTvemsEHt2/oJfXLzGtQk2ye9KMTuEa7oqSrYmOIoK4rwfy2Yi5SMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq6v7xIV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0d6356ce9so3803775ad.3;
        Wed, 27 Mar 2024 18:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589575; x=1712194375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwzVZ+IWpczySSp2ln+6XuuWUjbpq64nflGUKemUacE=;
        b=hq6v7xIVjmUbvReaOZ+8TAcAf2tOiVDsGPumxmX6Q5u0XjurKGkqztoyyQZ69+3OvB
         xYoOcjHcyJrMCvyj49G9p7tsVbBw6kFg1TdkDkjGTE13iswMmLrIwjL2aQGkr9tAwk52
         jRJtpZjOiilyeeO6hnEY6CEBnNunYKlVWloTmvcToNpqmXzSBWi3AJ+d2K+LobWy/Qyq
         2YL68ONS7qr/nQm7JcwrjibkbtjCqQKd4e1sSzN8skAB50dkDgxSPjWQ4OxdQBzO1gDd
         757qAHKj/S3wg12WUACsVmD0YXCFLTzHKfnSUexWbh/d1tDDWlTMf6voSYA5H9IZP2h5
         VqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589575; x=1712194375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwzVZ+IWpczySSp2ln+6XuuWUjbpq64nflGUKemUacE=;
        b=YtLPkro6V+fK23NwE8IFNZ8BQKfprkueUuyETtMWXGFsWyJIp93YBkVbGw1WEFn4aZ
         xpJCFweuF+bwxxfkd6JaGWpBcodMw3IDzbyamrsfKzwbMleDOWvKxNUQaZWe3yG5GPKx
         1pxzETtw/rjWkKSA37UOZszMoXQA87gDRl+q8c3vwd7Yy+UU9+3NNSeDOZDtoL4liKkW
         Zea99YDwEHfnd9f2JUQM0DnZG67GqI0Tg2LsTkBmGlI6/XQAIfaQd0qO2xpt5wI4Vte6
         eb3+leeYbTkn3rMHv9JEX1FpMCQzkJ1f+uV2nRZdlV4A+ZjRtCRowtnV41RyPTAp533e
         7QWA==
X-Forwarded-Encrypted: i=1; AJvYcCWDsTb3KA5dbiq3i0AuYXAn4jVvMFr/2d77mrRCd7DItZTV5O0obqqsogjFXDIBg8QibcnwtT/PCxVXBIZb88qcbFldxCDAVk5qOeUO7VxojTzdBq027jgYFE9iYkqNs5QhiNzwd/ItMcKaHC4igPz3dbouOICgRwkZuAnFTpFDAfQzWDSkt8eL
X-Gm-Message-State: AOJu0YxtEjG0CBcTnjxftVMgQDprdyXSg157W3YckjE6u04RR5S7QZjF
	PBrtNpbdj3QT3Ulkqr4Km7sM6X1bLKZ8fV0PyKo31VgTK9UC28We
X-Google-Smtp-Source: AGHT+IGJiNm3BXlzN6cmEh56HkRazQmE2ErJ3ixpcojiNRSHT7tBktTULxMZ3pGOAZ0k6cV3jsh6qQ==
X-Received: by 2002:a17:903:24d:b0:1e0:f5df:277c with SMTP id j13-20020a170903024d00b001e0f5df277cmr1426217plh.69.1711589574850;
        Wed, 27 Mar 2024 18:32:54 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e355-7eb0-b4d0-66d2-2269-ef6c.emome-ip6.hinet.net. [2001:b400:e355:7eb0:b4d0:66d2:2269:ef6c])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902dac600b001e0a2cf62bfsm191904plx.201.2024.03.27.18.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:32:54 -0700 (PDT)
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
Subject: [PATCH v5 0/4] drivers: watchdog: ast2500 and ast2600 support bootstatus
Date: Thu, 28 Mar 2024 09:32:45 +0800
Message-Id: <20240328013249.3609225-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2500/ast2600

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set.

Include SCU register to veriy WDIOF_EXTERN1 in ast2600 SCU74 or
ast2500 SCU3C when bit1 is set.

v4 -> v5
  - Revert indentation. 

v3 -> v4
  - Add error handling for syscon_regmap_lookup_by_phandle and
  regmap_read.

v2 -> v3
  - Fixed WDIOF_CARDRESET status bit check and added support
  for WDIOF_EXTERN1 on ast2500 and ast2600.

v1 -> v2
  - Add comment and support WDIOF_CARDRESET in ast2600

v1
  - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
---

Peter Yin (4):
  ARM: dts: aspeed: Add the AST2500 WDT with SCU register
  ARM: dts: aspeed: Add the AST2600 WDT with SCU register
  dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
  drivers: watchdog: ast2500 and ast2600 support bootstatus

 .../bindings/watchdog/aspeed-wdt.txt          |  4 +++
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi       |  3 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  4 +++
 drivers/watchdog/aspeed_wdt.c                 | 34 ++++++++++++++++---
 4 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.25.1


