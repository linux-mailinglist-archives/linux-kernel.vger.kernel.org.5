Return-Path: <linux-kernel+bounces-141952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512248A2574
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87CCEB21E25
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFA6182B1;
	Fri, 12 Apr 2024 05:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt3RE1ra"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527E17731;
	Fri, 12 Apr 2024 05:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898692; cv=none; b=INe/q++JHo9xs/uWCyBGzP0Eq7b5YXrCk+vSCpdgOwqQtHsf1rKm3SXIbrTHkoiIORXzLkhpnvPUvECwsZlo9pi61+2sGlPpa5KeEhHMeAJfgaR43wNPGy+mKoFucLNYVXKa41ouK2DsqCrEuZVVdrXBAbgJA5MPsBpV5C+Pq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898692; c=relaxed/simple;
	bh=hd/nqxw9+93zH7FcyAKlNOOEyQTldfVZ2x3gcMcMfus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nm1fuTHH18jxESyRrwTxD/mpGp0g+XdveUuIAedfNWcflFr2GSsrOioFSjutDQNsxshbcOccsMLkQ2DDFHoTPons1eKTNrkGSTyhe23P0/cPhobZi0jkGjz1gT6xx2MO2Z5Cp2Domfbxn+V0U4N5gSG4a6K+zQBYxsH4Ai4VKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt3RE1ra; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e2b137d666so4537255ad.2;
        Thu, 11 Apr 2024 22:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712898690; x=1713503490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXKOR4fLTMOu2WnZaGce97zyt5vgv5h2VasZVNQaszc=;
        b=gt3RE1raT3QmcCw5QvcHteka2eWT/woJyP/0wNnIMIm+jESByav7GK7hI9hp3zo6nr
         u1e/kjV0yIRRIN69TIgjnBnsTNv3XYZilEvq/71CylltR0C22GHiYRW0EHEOW6VVjoo5
         Sr0LUzbw1cwJej/p52xT4Gl7ZL6F/Ss+iwU8spGh086OqelbRd9NvknBqcsBamSjwm9i
         ZkviX2WdxxeGAZcJeJRVXh960tvd/LGqK/MfZIhIyiO+wyPV8qaXJ8xh2Rc7TOhjttbT
         CBYhIaXwgVCcXC7afPUy3Jrd5oWl06ULnAskBUyrvRAu0NYO7vQGgusQ+c9xJGWC0DyS
         zoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712898690; x=1713503490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXKOR4fLTMOu2WnZaGce97zyt5vgv5h2VasZVNQaszc=;
        b=t9ipes5r6Fah9eecRYQ6hPGFUi/gsUv8xI2V0/ZlZoqKQS3pQtJbBv7c2GIxaRXKG5
         ZD1AzZvL2xt430VDwVUMMsvr0b/6ISPD0tvGi+O2bvO169/ow+VH5JcuZEkZxMV0/eXC
         IHJUr3z5s2IJRsQeuQyngoBKMYeiLxisof0AYx3fusD9yLK8jamY86wNZfhlMycO0ew5
         RZZrpw+QiGNSVYIFWbNlqAOPXY28nvnNFFEUudYjdnP29QipdNRn0qe4m0YfK8ggxbTl
         NTOcGNhkOowmI2YaZ2eU3DgG70HWZ5+Fr0MTwEQtD5MsYhimaYNBcSV8+2BcwbjNilIh
         uW8w==
X-Forwarded-Encrypted: i=1; AJvYcCXBVTGR4Mb0JlKEJnYPUBXta4GVUM5DR5IArn7ipTlGzSw10+fHn1hIBZY2FDlWYZhFHWlWOutm/jdiL0kN5nxq9YCusRpYNYqfAdbR
X-Gm-Message-State: AOJu0Yy7bZiCjLt84DQePwVaxg8SaRlCHt7e91+QspFJEsSijTiIIaBW
	nwftiYagzwVisDHRCCtVg1SuOHvwF3zGjDBu9+cq3/YnKOR5+wUhdIA8WmZ9
X-Google-Smtp-Source: AGHT+IEvlaffhKlC9NRXZtkYcwkt7RbXc02T0P4rh9CjTB5N9y6JzePWsOC0st75qtC5YnLjaNwNQw==
X-Received: by 2002:a17:90b:fc5:b0:2a5:3637:1968 with SMTP id gd5-20020a17090b0fc500b002a536371968mr1708755pjb.9.1712898689975;
        Thu, 11 Apr 2024 22:11:29 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id fh16-20020a17090b035000b002a53b9cf356sm3734902pjb.0.2024.04.11.22.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 22:11:29 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v9 00/13] clk: hisilicon: Migrate devm APIs
Date: Fri, 12 Apr 2024 13:10:29 +0800
Message-ID: <20240412051041.90376-2-mmyangfl@gmail.com>
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


base-commit: 586b5dfb51b962c1b6c06495715e4c4f76a7fc5a
-- 
2.43.0


