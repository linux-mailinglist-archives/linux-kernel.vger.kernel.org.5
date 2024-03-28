Return-Path: <linux-kernel+bounces-122280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442688F4AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284E61C27E54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC7F19BDC;
	Thu, 28 Mar 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn8FrFPj"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033CB1804A;
	Thu, 28 Mar 2024 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589590; cv=none; b=kUcna9q0v3KfXDlR4d9OO8/tzlKaRA1oZ7CppofUH3jlNn6wijIXVZBz2OQtmGNaxouD7CsCNH6OGlbPQunTWqkeOknkk2FXrqO5MATAWDXZv6gUPOT4GRophtU/7D3yB1T42B80d4xDWWJmItyTzflaX/kXspGmuf0iXULTrZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589590; c=relaxed/simple;
	bh=iuwHyz1syU2AnQIHPzBZMFgUuJdJtfSc68KscSNZrv4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=G1Ca9NPOTGp8CZ4kCWC3q/xbkmTGQAVvBHlE3Q0+qpYY+PdpZa7tO/eTISuiHjrGFCxpjm6E8TS/QMtSYj9Ma/PZv5YzKhyVJk4BmlQZmjzXzLk6Tn5akNnMvwtIoYQe8VPUbowH9woQ7ZYvE85UGUbRWlveczTq+O+JNkCLCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bn8FrFPj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d3907ff128so310381a12.3;
        Wed, 27 Mar 2024 18:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589588; x=1712194388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwzVZ+IWpczySSp2ln+6XuuWUjbpq64nflGUKemUacE=;
        b=bn8FrFPjc7Ofs2MmFaBN8rMH6CNqeqO4IAztFaGPsOR4NerMzoKjREy3/yJSQvLYyl
         4/dJwa7zJ7eA0yQqY7FDbcIf/6qog/MV5NW2qxvlXd9zq38T//7PVIMX7QMEqo0Wt+d3
         XgwICVS2TOp1wzIzF32eXlhHa0P9nK5SrkY0CBHJz81f34ICuPHDJvZTULvCx338+U09
         J+XXSJ3dx1Xnrw42xv867aUhD2p1DZsoqCEWlztat7b2gquap/08iAacPQAGTpEhD8Uv
         PaW6Do4Eby1s4cfSyAubd3Bc2ph89Uw4l68RCqaMxwuJrBYI+uHTncud0kAdCcv2rFrt
         iQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589588; x=1712194388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwzVZ+IWpczySSp2ln+6XuuWUjbpq64nflGUKemUacE=;
        b=oIa00RWHU8PsxwmnSde8tEV2kPOJ3nknYxSGMNADDKTBGpDvz90yvATty4grLsF2Og
         Y3VvALHoDnamNdRkk+5qkxZY9sBQd3yZKUNHQJ6kJAZgyTgybjrvbnXZbuJPx/g2kCG9
         jVaLoQUziPdQWKPasioqVFBTjSTMmSDkCbhDlbemajo2AhnWlkrJ02Z6zoJ4BP4K+kEd
         TYTwtDzXQgqoaU9L1HN04LDlMgvJaBk3q3LVujxyEsrTaX75TuFEsaqIJwaQls2c5Gfk
         hEdm4CcwZN+W2/NWy3JBfmVRXQMUJYnewWekaqP25Syol11MxqdHxgTJJ7WBkhkU8D48
         I1qw==
X-Forwarded-Encrypted: i=1; AJvYcCW4Mzgo0lmDLLnF6FlH7Zsmmn4HKtkshrK6CFXLoMpRBoVv0Z/qMnyf2CzX3HBtXXbbWo152jTwH7ftYZKXWOR9q7/B4/XcE9m+e3ZKy5WjfE8u3yLY31dz0ADhdjcbjPysU/uJAXXs2WOBvu9tP4VVdhLzQQr2od66GW+Ffa4ijGc9bIYW4wr0
X-Gm-Message-State: AOJu0YwkX5ms9+NY9oQhcreoTzarYTLK/1gkwyYuhQB1UMl8GkggGr3+
	BRYM0JdWeL1hn4qEv147wIkYlowv5aKcQBZX4l/938Ew1g3qzI6l
X-Google-Smtp-Source: AGHT+IFuuOxiVIqTtkjpl1E/e0b+0s1F3aV7PFkrdsx5dIaIXuKhPY9sIiffaQCR380fHvq1VgjLeQ==
X-Received: by 2002:a05:6a21:398b:b0:1a3:4e31:ab8f with SMTP id ad11-20020a056a21398b00b001a34e31ab8fmr2153722pzc.17.1711589588358;
        Wed, 27 Mar 2024 18:33:08 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e355-7eb0-b4d0-66d2-2269-ef6c.emome-ip6.hinet.net. [2001:b400:e355:7eb0:b4d0:66d2:2269:ef6c])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001e0e85a21f5sm201338plg.32.2024.03.27.18.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:33:08 -0700 (PDT)
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
Date: Thu, 28 Mar 2024 09:32:58 +0800
Message-Id: <20240328013303.3609385-1-peteryin.openbmc@gmail.com>
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


