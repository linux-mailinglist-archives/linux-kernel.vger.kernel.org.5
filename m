Return-Path: <linux-kernel+bounces-146586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BCB8A67A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C057B22182
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5CA86657;
	Tue, 16 Apr 2024 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjwrFcHA"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFEB83CBD;
	Tue, 16 Apr 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261893; cv=none; b=AO2hVvkh62owz5wLWVoAHfgBcDnS5+gro5tDK9OhKwBbuZBY+mngAbITRSZLIwvc5I+CmTh2rorSNJd7nYuUyOfKczuln0ieaAfsF5MKf37jEZIXbOq3oWoYDhSowp0snwfvsl8hedst7BwdRQPb16jFORL7UIpiP2ydoAHkjGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261893; c=relaxed/simple;
	bh=zxmZjlSjC50ctGKMd9KirXGcH0meV7fsbeLJHJDWq5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCVRRuf8a5HRgCROT96Gqq+DajU+LMEvAbsKGPZCqi6BC/jemAoGLs18e9hpkPOdyRFJ42EJVVZIMO9tGbR35UgHqXCSTx6bO8woI/TVgamFjFEmSGF7hWF24URxjOXNbMu5NpIsp31g5dXPRp5M88Laz+fh1k6wSKreHs8OdQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjwrFcHA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso26522965ad.2;
        Tue, 16 Apr 2024 03:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261891; x=1713866691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NB+9rCl0w0mkCoHtP/OT/21+12AJuJupEYMotjqnv8U=;
        b=jjwrFcHAhJa8vMd96Exk4EEX24duQqCipZDrEb4t7O7EFGKD9WEW69n8ArmHxRfz5d
         Sh8MXnFHt7ZKAS5KeBZFxOhacja7Q7OZEAeBq65FG8Vf68H8lYXyehkUWdjYR6AVUACc
         BBx1WM+nq6t+cJAIFe+Nj81qyTmIM6ybZeJbb/3T306EF2TTvaxcHzqfj6mv1KihxfdZ
         Cr5NXPr3cMj5RPdUIYhcHcAgGnZim/Yuvj0zN39ye5SixZQK6LDHPpIIclMnytsALdZu
         mPEVccw2pmqXe7NKrkCsuvqsZpjSp4nQCVLgSYxvQSwx8bRDH8J6Hp7X0vxrM3wIEG64
         DaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261891; x=1713866691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NB+9rCl0w0mkCoHtP/OT/21+12AJuJupEYMotjqnv8U=;
        b=mcpVuZm+yuvQvq4Ovspfilj2RISC8D21bZ9+yJsBtHs66BgC0CUZxiDaZllmvzuY7B
         QOvFG79bReXnEjb/Kg8Pf1Dfv0kvq//BBlkIpKqGW1FnFzP67bJC239vP0w6UaBlY3tD
         JCRCRYsvPNIEZ2HqhUZe1FAc3nm/i99fvM4VPzQYJkesIx+33BDFPKmuPb6j18K6kaOA
         vZ4w+qRt2ySF7f/RFxp46b6HC+FQEPfjRhgo5T1P7TZPgfDBD/j+w6Etg93rbb6xS+y5
         MmGS/LWWs3PKbBmYxQOZOTqeEPZzVE99OI0bQIyeRoYz2zSLbpz2vfm9TaZfQIkI1mS3
         wEgA==
X-Forwarded-Encrypted: i=1; AJvYcCVdIvyISVhxuRxUQS2dVK/6OhyQwHtd6CW1SSME2jHpTDYHWHgJmu98wDIXMgEBDKqbtcROuinkbrKEcWIW1v6KhIkyuypSZ512JJXq
X-Gm-Message-State: AOJu0Yzu8J+tXyTYqPeQiOJ1tkMV94yHwwvQdJlDt7aE6219m3VuRGxG
	ai7o+4tXg5tDu8wIiwvHATQFKfU6A381RmGk8hqExCz0nWRfuspHI9oQflux
X-Google-Smtp-Source: AGHT+IGHIAevlju9o2P9nCxD6tgKtz9wAJ5dx0YTi6TYeWKdj9XVqAmXyRYQj1prEqYd/rToBGqISw==
X-Received: by 2002:a17:903:4291:b0:1e4:24cc:e020 with SMTP id ju17-20020a170903429100b001e424cce020mr12342424plb.67.1713261890921;
        Tue, 16 Apr 2024 03:04:50 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001e0b287c1d2sm9353651plg.215.2024.04.16.03.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:04:50 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v10 00/13] clk: hisilicon: Migrate devm APIs
Date: Tue, 16 Apr 2024 18:03:34 +0800
Message-ID: <20240416100347.395295-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate devm APIs for HiSilicon clock drivers and remove redundant codes.

This series is a partial improvement of [1]

v2: fix test robot error
v3:
  * size_t for all these num types
  * hisi_clk_unregister() change into separate patch
  * keep relevant header inclusions
  * split driver files changes into separate patches
  * explain hisi_clk_register_fn() checkpatch warnings
  * not fixed: MODULE_LICENSE("GPL v2"), as stated in SPDX-License-Identifier
  * not fixed: "hisilicon,hip04-clock" un-documented, as none of dts files in
    arch/ use it, better to ask hisi people why they pushed this driver
v4:
  * typo: hisi_clocks_get_nr() should check clks->nr first
  * unexport hisi_clk_unregister_fn() as no one use them outside
v5: catch up with remove_new refactoring
v6: fix compilation error and expand macros
v7: rebase and use mod_devicetable.h instead
v8: rebase again
v9: add linux/platform_device.h include in patch 09 according to reviews
v10: fix compile errors across the series

Links:
[1]: https://lore.kernel.org/r/20230322164201.2454771-1-mmyangfl@gmail.com
v1: https://lore.kernel.org/r/20230326052757.297551-1-mmyangfl@gmail.com
v2: https://lore.kernel.org/r/20230329075104.165176-1-mmyangfl@gmail.com
v3: https://lore.kernel.org/r/20230410110733.192151-1-mmyangfl@gmail.com
v4: https://lore.kernel.org/r/20230411174329.424763-1-mmyangfl@gmail.com
v5: https://lore.kernel.org/r/20230723162245.35033-1-mmyangfl@gmail.com
v6: https://lore.kernel.org/r/20230731121821.22242-1-mmyangfl@gmail.com
v7: https://lore.kernel.org/r/20240225065234.413687-1-mmyangfl@gmail.com
v8: https://lore.kernel.org/r/20240411070503.38093-2-mmyangfl@gmail.com
v9: https://lore.kernel.org/r/20240412051041.90376-2-mmyangfl@gmail.com

David Yang (13):
  clk: hisilicon: Add helper functions for platform driver
  clk: hisilicon: hi3516cv300: Use helper functions
  clk: hisilicon: hi3798cv200: Use helper functions
  clk: hisilicon: hi3519: Use helper functions
  clk: hisilicon: hi3559a: Use helper functions
  clk: hisilicon: Remove hisi_crg_funcs
  clk: hisilicon: hi3660: Convert into module
  clk: hisilicon: hi3670: Convert into module
  clk: hisilicon: hi3620: Convert into platform driver module
  clk: hisilicon: hi6220: Convert into platform driver module
  clk: hisilicon: hip04: Convert into platform driver module
  clk: hisilicon: hix5hd2: Convert into platform driver module
  clk: hisilicon: Migrate devm APIs

 drivers/clk/hisilicon/clk-hi3519.c        | 127 +-----
 drivers/clk/hisilicon/clk-hi3559a.c       | 250 +++---------
 drivers/clk/hisilicon/clk-hi3620.c        | 216 +++++-----
 drivers/clk/hisilicon/clk-hi3660.c        | 194 +++------
 drivers/clk/hisilicon/clk-hi3670.c        | 250 ++++--------
 drivers/clk/hisilicon/clk-hi6220-stub.c   |   9 +-
 drivers/clk/hisilicon/clk-hi6220.c        | 228 ++++++-----
 drivers/clk/hisilicon/clk-hip04.c         |  39 +-
 drivers/clk/hisilicon/clk-hisi-phase.c    |  13 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       |  99 +++--
 drivers/clk/hisilicon/clk.c               | 457 +++++++++++-----------
 drivers/clk/hisilicon/clk.h               | 141 ++++---
 drivers/clk/hisilicon/clkdivider-hi6220.c |  24 +-
 drivers/clk/hisilicon/clkgate-separated.c |  26 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c   | 171 +-------
 drivers/clk/hisilicon/crg-hi3798cv200.c   | 200 ++--------
 drivers/clk/hisilicon/crg.h               |  11 +-
 drivers/clk/hisilicon/reset.c             |  42 ++
 18 files changed, 947 insertions(+), 1550 deletions(-)


base-commit: 96fca68c4fbf77a8185eb10f7557e23352732ea2
-- 
2.43.0


