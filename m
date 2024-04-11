Return-Path: <linux-kernel+bounces-139915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7595C8A091A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32261F22117
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD213DDB0;
	Thu, 11 Apr 2024 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2pHIqQJ"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C2513D8B1;
	Thu, 11 Apr 2024 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819174; cv=none; b=CGRapyhfuy0ziRtaCBIIMsBjPyICTenmJMAxL880GwdkMjVDjsO8skWXfwwHZJ6FMG1pwuzVpyPOnbD8HBZ+uKpSRFeYkKj+OeEGAB/6c329YBqHjyWbAs8BzoGNVMy8IkWwBibZi8FfAsUUB5oU8RhcWSO/034lmmHR7bwEq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819174; c=relaxed/simple;
	bh=W0e4pg4PP4tjMTxh70e5OvmUG/fRkSt5GiNNmx8dKIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVRbezFbp0vcggVZljiJiZD7A71AQ6BrnRDC0VN3NbfRyAIbmkcKq5AGs3taiQnqn3Zv0bpFjbNl19GTDyPRUUARijFYhe69N3V5LKpGoXtP7z8gWbdf2KIb2J+yYOYM9Ww0WlUJnl2NJ1wyjwKYFmKD/WK/cJcjslXpXA5fyrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2pHIqQJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso3852427b3a.2;
        Thu, 11 Apr 2024 00:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712819172; x=1713423972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTjSPf2T8PYEikwUD6FZmfJCtqLzKWgWP6VBa8LC/Eg=;
        b=e2pHIqQJuuXlYfMTOOE008rvgi1ZOT0LRQfeNs72pxOjwHNcjTzUshk5WBnp4H0UO7
         z5FF9nwltGPHxlYsA9StCMPi7j4HQEKv7nKgxpAVsUyNxu3K7ldczUN1EWsNlHkRT730
         nhsHmqQD/HxT6zcdxp/Ue1TSTj/76ewERJeap3DrOMaRfz46qOI2Ls97MLThz14yg5av
         G+08CNYIErwhAmVPnP56T1Z/nTcu3CqzAJHu4m+VQ/KAocWwZJdeF4S2OlWVNA1y7fcP
         A2WSi+9Hg/7TDyJcK3GGvRKL3Lj+u2LGsP0fQC+jC3bJD91BBmz3RlZyErJn18ZtRI9Q
         xIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819172; x=1713423972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTjSPf2T8PYEikwUD6FZmfJCtqLzKWgWP6VBa8LC/Eg=;
        b=S+4bN7vts9GdmLRa6NdjvqXRcjE8qw5nZW8Xrf3Um0b1rNW90CIU6CCZJlqruErVd9
         7VjrQo9btllMI8D4pXQ4NBiRApv1v5wSRheIp1Mh0tzuwMxa+MiJVtw17pCWhk7BAMUw
         8XvBoydImoXRz2GL672/vqDJ/+6zaWhECX1MH+IG8GqSHMa66vKlnA1SJ0P8UO8E8TYl
         R++n830ys94HWwxa0ejb82lH6VgVUMQbzdphM9G3oqPe06KVYDIdL57MeA2oHyy7jepe
         x15J8C6GhwO0EgVAu2EYm4Ot25wta/W9M56Y+pzdQGygMNfuTKtMbMw7aPhnnHslwgBL
         JkOw==
X-Forwarded-Encrypted: i=1; AJvYcCWP1uMKHCd6FAMDmfI5D1FOND6fUyxSnVKQQexdg7+EoNSMzh5Fk/Yj36N+qSaTgfz0kn4EwsuXXWjqPU+KzN/lPVL6EScwxBJ6wLSU
X-Gm-Message-State: AOJu0Yw1B6de+zfBLyH/8M1u76GKNLlWFJ2iydlSUATHG+6F0pruC7EG
	8BlTgcVAbUPgLtOQn/GBlvnzSKJVl1VwUeZaTHw0ntl7QIpIr3oJN4ObB3QP
X-Google-Smtp-Source: AGHT+IEe9JsSEfHb1JkQFnhZ08MDxZREUzhKcn6DjOf4ie3kKlgN/z6KGo6qkNUZiN3/FMBzQvYSOA==
X-Received: by 2002:aa7:8885:0:b0:6e7:3223:4556 with SMTP id z5-20020aa78885000000b006e732234556mr5087249pfe.32.1712819171895;
        Thu, 11 Apr 2024 00:06:11 -0700 (PDT)
Received: from d.wok.cipunited.com ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b006e6be006637sm647402pfc.135.2024.04.11.00.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:06:11 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v8 00/13] clk: hisilicon: Migrate devm APIs
Date: Thu, 11 Apr 2024 15:04:45 +0800
Message-ID: <20240411070503.38093-2-mmyangfl@gmail.com>
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

Links:
[1]: https://lore.kernel.org/r/20230322164201.2454771-1-mmyangfl@gmail.com
v1: https://lore.kernel.org/r/20230326052757.297551-1-mmyangfl@gmail.com
v2: https://lore.kernel.org/r/20230329075104.165176-1-mmyangfl@gmail.com
v3: https://lore.kernel.org/r/20230410110733.192151-1-mmyangfl@gmail.com
v4: https://lore.kernel.org/r/20230411174329.424763-1-mmyangfl@gmail.com
v5: https://lore.kernel.org/r/20230723162245.35033-1-mmyangfl@gmail.com
v6: https://lore.kernel.org/r/20230731121821.22242-1-mmyangfl@gmail.com
v7: https://lore.kernel.org/r/20240225065234.413687-1-mmyangfl@gmail.com

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
 drivers/clk/hisilicon/clk-hi3559a.c       | 251 +++---------
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
 18 files changed, 945 insertions(+), 1550 deletions(-)


base-commit: e8c39d0f57f358950356a8e44ee5159f57f86ec5
-- 
2.43.0


