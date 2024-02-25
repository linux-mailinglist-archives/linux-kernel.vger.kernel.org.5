Return-Path: <linux-kernel+bounces-79996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE76862979
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D31282369
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FD5D2E5;
	Sun, 25 Feb 2024 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llf+f5p9"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E72DDA0;
	Sun, 25 Feb 2024 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708843996; cv=none; b=qvXy1wDdWkF68UpuMiYqpiBUHHzCKskGI7z2mY2bW6UmbDZblxFsszorPj11z9M9XpWLt1rqihfV/85oEH08wy0mrO2X7VaA4qzKtFWhyda99lqSrrZFy4ZYy7dbBK7NMz3GrIZ0J83YdNZavqlt8Hs3f15X0p5FD9JGLVCgFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708843996; c=relaxed/simple;
	bh=x5wqZxeWxQ1HDm+fAeMhlm6rEFJshl+5WF7xO5IgVz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZ9t4SfA21XA/Lf8pXPRpn3RG6mwxjjHNX12HszaF5FgHkAk2oMH0KnXpNvD8R6HFrgphaieDq3H48EXCuz/TsK66Aw9YzRbTMOzFIN/gM0lC/PWLFIZTBxtENn5GPsVDys5QsUaQXoOyWLjlcNeqRlwrdZcjIdjEqT7nAAAMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llf+f5p9; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd72353d9fso1309022b6e.3;
        Sat, 24 Feb 2024 22:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708843993; x=1709448793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyJtFNAMcaV/bHkegnktooOwrMmoOwyEbQlBmTfIDJs=;
        b=llf+f5p9jDenFvD5jNy8tXLcz1T1grAeQZcFjNki5x45xxNWUB9iPBYLju8GBy05d3
         Vlp1k40eCHQS0xOEqBCIqBtbB1SDtZrXQfiwSmPumZa8z/JLpxqelPbppul0L9jJ30/I
         BtHuta9gwVm7bx6GVlFTsDRex2ByKhXttUTQYmuXUysNDPR/WMr8+ZelnnWf81BcRkQl
         kuh8a9OJdJFfDFCtj8CJYt1qqPrLV9gwrf51zad4k63FevjAl+V+BP7J3qNYa3UQbL4/
         mQ6+OAztZu3U1t4Dxd0rhHPHDKW3Eo0mTwlrjfRrwdkp5qZajDvjIl54etDUqww+PuIa
         sSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708843993; x=1709448793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyJtFNAMcaV/bHkegnktooOwrMmoOwyEbQlBmTfIDJs=;
        b=Njdl9sC7GBY0HKPUiSOTcF+YTTnZB8D74Iw6o2uj5zhJhRj9kXM305HPyaeNHKu21u
         YzRgANCAG4jcYH1EijU23ROT6jVlsPzUKXgBQyINkYnrHqy2hQOn/NtEP5fshn1Bksie
         gP1JjCXEFF5X0tbo22Riz2oFoUT4q9QBGZnPPPtTSnoayTmcdDp+9og8D4C21m5mZJUf
         RIsmra1KeVFkP0Dm7oo4hXeGd9sY+gys92nUHvI+EuB6xA9A/gb8/5B0Jcw3GerQD3zR
         vJyBUxHwgC0KDmJKXvFW+XmMC0uuk9Kup8e2LqJM91Ky7qn14Ru34YhX/Alcg1Sr5mEq
         u3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWl2S7Tb/YGvxL7qtL02vAq1vHoQzG0UwU+M5CTF2nno5mQ8lGV3MJa86n//Ol7tS/ZG8CrJ13+Bq54iwDvsTaIARJrEyRWtDTSjodX
X-Gm-Message-State: AOJu0YyJk2nWW6zmUzks85+wZWdkA7lJ3fZEO+CiyqVOQZps0e925Vwb
	f+U7PgLsEF6iO9OJ3qW3haZXJBBGXsN2v+w+/groVgFv49r+sBoDTSVOzPshZlKMBQ==
X-Google-Smtp-Source: AGHT+IHdMXWqRoBxb9oIxOk2PE2IqASOZeOS2KfP3t96iNh1R+ASEMiWIPBe91eAoE7nZ2A8YJ2zUg==
X-Received: by 2002:a05:6808:f8b:b0:3c1:9c5b:749f with SMTP id o11-20020a0568080f8b00b003c19c5b749fmr1558420oiw.56.1708843993566;
        Sat, 24 Feb 2024 22:53:13 -0800 (PST)
Received: from localhost.localdomain ([171.218.176.26])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a0026d200b006e45b910a98sm1930313pfw.6.2024.02.24.22.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 22:53:13 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Yang Xiwen <forbidden405@outlook.com>,
	David Yang <mmyangfl@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/13] clk: hisilicon: Migrate devm APIs
Date: Sun, 25 Feb 2024 14:52:15 +0800
Message-ID: <20240225065234.413687-1-mmyangfl@gmail.com>
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

Links:
[1]: https://lore.kernel.org/r/20230322164201.2454771-1-mmyangfl@gmail.com
v1: https://lore.kernel.org/r/20230326052757.297551-1-mmyangfl@gmail.com
v2: https://lore.kernel.org/r/20230329075104.165176-1-mmyangfl@gmail.com
v3: https://lore.kernel.org/r/20230410110733.192151-1-mmyangfl@gmail.com
v4: https://lore.kernel.org/r/20230411174329.424763-1-mmyangfl@gmail.com
v5: https://lore.kernel.org/r/20230723162245.35033-1-mmyangfl@gmail.com
v6: https://lore.kernel.org/r/20230731121821.22242-1-mmyangfl@gmail.com

David Yang (13):
  clk: hisilicon: Add helper functions for platform driver
  clk: hisilicon: hi3516cv300: Use helper functions
  clk: hisilicon: hi3798cv200: Use helper functions
  clk: hisilicon: Remove hisi_crg_funcs
  clk: hisilicon: hi3519: Use helper functions
  clk: hisilicon: hi3559a: Use helper functions
  clk: hisilicon: hi3660: Convert into module
  clk: hisilicon: hi3670: Convert into module
  clk: hisilicon: hi3620: Convert into platform driver module
  clk: hisilicon: hi6220: Convert into platform driver module
  clk: hisilicon: hip04: Convert into platform driver module
  clk: hisilicon: hix5hd2: Convert into platform driver module
  clk: hisilicon: Migrate devm APIs

 drivers/clk/hisilicon/clk-hi3519.c        | 127 +-----
 drivers/clk/hisilicon/clk-hi3559a.c       | 252 +++---------
 drivers/clk/hisilicon/clk-hi3620.c        | 215 +++++-----
 drivers/clk/hisilicon/clk-hi3660.c        | 194 +++------
 drivers/clk/hisilicon/clk-hi3670.c        | 250 ++++--------
 drivers/clk/hisilicon/clk-hi6220-stub.c   |   9 +-
 drivers/clk/hisilicon/clk-hi6220.c        | 228 ++++++-----
 drivers/clk/hisilicon/clk-hip04.c         |  38 +-
 drivers/clk/hisilicon/clk-hisi-phase.c    |  13 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       |  98 +++--
 drivers/clk/hisilicon/clk.c               | 457 +++++++++++-----------
 drivers/clk/hisilicon/clk.h               | 141 ++++---
 drivers/clk/hisilicon/clkdivider-hi6220.c |  24 +-
 drivers/clk/hisilicon/clkgate-separated.c |  26 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c   | 171 +-------
 drivers/clk/hisilicon/crg-hi3798cv200.c   | 200 ++--------
 drivers/clk/hisilicon/crg.h               |  11 +-
 drivers/clk/hisilicon/reset.c             |  42 ++
 18 files changed, 944 insertions(+), 1552 deletions(-)

-- 
2.43.0


