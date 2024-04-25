Return-Path: <linux-kernel+bounces-158246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5972A8B1D76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BDE8B25405
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552A684E0B;
	Thu, 25 Apr 2024 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9Ve72q6"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256D7FBB0;
	Thu, 25 Apr 2024 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036054; cv=none; b=oNx2g6II/2jQ6DjfA3EaV1+PgFo6GvLPpYPdogox07f0dMUMYECHqen8XBpDpmHuguvYKZBRyfnm9pZK54eYC8cNqKss8vkrvJBmPPSGnkk/hXjfP/TqAk/uHI/DiJSavtL8cETkrJsEkgPoC0/5aLCd9muOxz5VbHXLwcS1w9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036054; c=relaxed/simple;
	bh=vOkJCuf6obwG2EXnrFVqIavQOTRQCN2Q0BgWA/eiDsA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=hja68wJs6R14swoNgAd4qQCvBO0BQWt7E3x+xcNnyaQXPpSpWlJHPVx4yRtu7PLQiXiEyHzkTYwbr2b2UWXn7BBkHNGvI2Crj27txcAToCU2jrSZSpPLRL8/t3Zc2GxfhRtOjEGaub8+ttwfdBKvxp3YKWhHTpg66BSRG2OKE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9Ve72q6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c66b093b86so1418650a12.0;
        Thu, 25 Apr 2024 02:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714036053; x=1714640853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aF09Zg4sIkL9gC6ySi6dYbvMyiOsYCbmHeTeGavPjPQ=;
        b=B9Ve72q68+csV+Itg++57rAkCZD46qq2QBYFNWDo604Aws5NtSFbdasJxbetU8/zS6
         vIOePRhZhP+l3XDVCMyyTxn+zAMEIwg3pqhlob/FAr/3bA34phtAsCuHtkrLq1tzCDqd
         jzxtZe0L/OqnU4u/kQIJANonnWPGD7pL0SVTRukyS/ec7Fjr51rujn7hV4K/r36FKrdo
         ZdZiqfwBUWRcRhCa95HMXEPD9KiiYPvJfN9cxyWFVFRN8bkdIXziaV6Jc+CuU4lUTaF1
         pypgxGASINz1yRuJqWEIzDeV8L67mJxaijO1cUg0KMm4puzteNOeKsOfIk5s6ljpMaBp
         M19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714036053; x=1714640853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aF09Zg4sIkL9gC6ySi6dYbvMyiOsYCbmHeTeGavPjPQ=;
        b=AcZrnLht8elaLfT2Q3hP+cn5laW3Lbdpx5EgXs2C5MZIZXCu7+0qYsiFEMdKqSg50M
         iEkXAIUeQrgUN7+CZrn6tXWMDI+aic2Pyr+MY4P72O2jBMQj8+9Ih23mjPHe8pKmFNvU
         xXn13/GvbvOMwqQPcJW6s0cMyK81YFa0rKOzgoUAUDJQR/vWHTKZJSXFPoR0pt9z6pVi
         7UH0x2C4G4qoDH3ziPE3EPDGMyytf5qdHLEThdiQXQJtDZ08xwNRdnF3b/aIfidfcqEz
         mGNQsr51h3qlI/JzOV7MHADj0Wwjg4kztfhFtuoovV1Q8C6TCdXiUWWr5595s9Renvm4
         8TMg==
X-Forwarded-Encrypted: i=1; AJvYcCV75ZlT+YMKQkDDbA9aNgaFXlPNKll++y/wZb1zSL3UoIw8Grngq1T+Rl+hR3LCUs8UJXMWeWeMaTxQ4BG6gb3NDXgskYpMH4CNw/RQvuYYwn+JOdSLVdqZfJvS+WodLOpyZXg6sc1rbOiwx3U=
X-Gm-Message-State: AOJu0YyFjK45Xx9K5BfGLPa1j7Kw5r3x52rapiiN7LR94qFm84R+klHu
	bHZ7MzTDEeJa/12yke/NO4fnpUVt/h06Z3+TY5pF9OzNzDdaLDl7
X-Google-Smtp-Source: AGHT+IFD21qLbGfQ21jitVv21MhnQqqwNte/oiTmCZXGuAW6E9cGj+omlxd/uQgm3osJKLLf/+qgeQ==
X-Received: by 2002:a17:90b:4d8d:b0:2af:c3ea:8122 with SMTP id oj13-20020a17090b4d8d00b002afc3ea8122mr2283601pjb.7.1714036052036;
        Thu, 25 Apr 2024 02:07:32 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e339-24b8-1743-5d70-cc45-1c02.emome-ip6.hinet.net. [2001:b400:e339:24b8:1743:5d70:cc45:1c02])
        by smtp.gmail.com with ESMTPSA id g21-20020a17090a7d1500b002a574ab7f5esm12489938pjl.53.2024.04.25.02.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 02:07:31 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/1] drivers: watchdog: revise watchdog bootstatus
Date: Thu, 25 Apr 2024 17:07:25 +0800
Message-Id: <20240425090727.3787160-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set. However, this bit can be clear when
watchdog register 0x0c bit1(Reset System after timeout) is enabled.
Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESET
in ast2600 SCU74 or ast2400/ast2500 SCU3C.

Change Log:

v6 -> v7
   - To use syscon_regmap_lookup_by_compatibleys to get scu base
   - Power on reset is set when triggered by AC or SRSRST.
     Thereforce, we clear flag to ensure next boot cause is a real watchdog case.
     We use the external reset flag to determine
     if it is an external reset or card reset.

v5 -> v6
  - Fixed missing WDT_TIMEOUT_STATUS_EVENT.

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

 drivers/watchdog/aspeed_wdt.c | 109 ++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 6 deletions(-)

-- 
2.25.1


