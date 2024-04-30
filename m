Return-Path: <linux-kernel+bounces-164171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6772F8B7A25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1142928227F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2D017B4EC;
	Tue, 30 Apr 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpYjzEUz"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DDD770EB;
	Tue, 30 Apr 2024 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487600; cv=none; b=EF6o8O2kkvLSh1JXAfySwvdzv3+JqsYAGywGJ7/6DGREr3cvb8ooDQt0sPYCAt6hk9QlAqWufsZonAjtXNDMuHM5JiFO7k2OhXY9V2lqWS8c+0jNExNXeMgcxYRFxcTihqzicDmTtfduuikCRVy1uCvT5LMN3/1pElvZHK1Htak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487600; c=relaxed/simple;
	bh=hHDKALZBtDaK1XJGZDjr7mtvwr3Wa562sY8T8hfckD8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=byc+2SDkcVJa5ztPl+4OwpADm9Yes9FPU9Geb12g17h4xp7QtHo7YwDPlgziPFfAmXNjQOJ2cjQs4BYw+lDV42GZSbKsxu5ppedoMWDVU5FHyBVQsUIXdzNorVpaZkVavix9CZ5hiVNVZYUp8xiB0ymHvKjQny4b/QQwKH2XIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpYjzEUz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1eab16c8d83so46018285ad.3;
        Tue, 30 Apr 2024 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714487598; x=1715092398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bbWyXy7tzUTKU9Yx8i3878cyT6cwUmzUpkwL6XCiHGA=;
        b=lpYjzEUzHBSh7KiTmalCi6XVh9n+SaNrSm0lDnK9FYQw8r2UXK5A3IEYV0OwkiLjor
         6vVQVHi1ZCCGyuMy0uQF+/ENdlEW+Oc/grhNSRzctKo9X1M0T6foWjLlMlqSnRVG5w6N
         tLgCw/EzlooiKwczqV6URwUujHjgmx9Bmoo3fouo/QpQN6mJPGNIHc3au1Nh2QA0kjAe
         TckN/b48scT6i+hhEalYPJkSeS8wtwkz+/sGuF5lBMKtVvhRiH9sF+QmG9I1+0dfT8wm
         A7xhASAdnppGHwvTUasC3G2Pv4KBsZmabF+p190IoxxV0q1CGlXnrbbxryLb+qi507fn
         PE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714487598; x=1715092398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbWyXy7tzUTKU9Yx8i3878cyT6cwUmzUpkwL6XCiHGA=;
        b=QIMVpLjB7yuidbu8Fsd+GRV8gmPC4f50NorAlKFm6LrMf+/FhYmLV8x+Vni2rndaaq
         gv+YYcMmCbsMP8+sfGtJy3CO/m83GaN2+vKGr+mGQgUYcBF218jiZdfCz8uFLMsubs22
         CK/PFfhN+RquVnC4arEXGAf2ndw7FOqva1j7r2HB6s/g7opgciDRE4TCA9xpe1E1pwUQ
         oFybDsyYNum/N8Xu56oKTTmCrRjn6HyAE1Y2+bL2YGaKQVNpn0jy0FcedjgglSKRkWhf
         /r65RaD2Jv/BI7tnNMTZOn07wKNELjDZSZPovdX1ZgVySH+XPKb4asQusD8uHYc4IPcP
         0sow==
X-Forwarded-Encrypted: i=1; AJvYcCVx9xC3Rl7ke/ZENB9wiyzWzkcPBPXzvP5kBDVdj0Vk58Jdepjami8LblupeRsZY1+J9g+r2E8J6zjtZ4DIDDboAmdxrWeFMVsc/734s6sszVdtCvq1KDFVs2PmnF1lCs7mB6HXiMIG5XAtpII=
X-Gm-Message-State: AOJu0YyEMjNenOakZ4t0Kmpyfrj7SsmTY4NNzHdvlawHfibqOze7L9pG
	J0q3QsIY+MgbfX0Q63tjmgJrfObPE8y4D3rPopiRCWZokNWONGE1
X-Google-Smtp-Source: AGHT+IF50zEbOnAs+x7qO5H4ytE8qglKw79WJLKnIPd4tguVAA/lYC9ixRtuKAvGTVIN3+mdp7kasQ==
X-Received: by 2002:a17:902:d648:b0:1e7:89af:f267 with SMTP id y8-20020a170902d64800b001e789aff267mr12052976plh.37.1714487598039;
        Tue, 30 Apr 2024 07:33:18 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b001e47972a2casm1682431plx.96.2024.04.30.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:33:17 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Eddie James <eajames@linux.vnet.ibm.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/1] watchdog: aspeed: Revise handling of bootstatus
Date: Tue, 30 Apr 2024 22:31:13 +0800
Message-Id: <20240430143114.1323686-1-peteryin.openbmc@gmail.com>
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

v8 -> v9
   - Rename and restructure the SCU.

v7 -> v8
   - Simplify the code.

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
 drivers/watchdog/aspeed_wdt.c | 90 +++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 8 deletions(-)

-- 
2.25.1


