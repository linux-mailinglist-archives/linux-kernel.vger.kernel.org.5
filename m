Return-Path: <linux-kernel+bounces-164543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990E18B7F23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AA81C2278E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D72B181323;
	Tue, 30 Apr 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwraDZex"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8A17BB16;
	Tue, 30 Apr 2024 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499083; cv=none; b=WcdvMxtZQHDGTUUaT5gY25TYM4NSE1KqlqGe/LBYs5+RUnPBg8OOXYKp10lQNG+7bNR0a7hDQr4yOdERYVGs8at/N+k9q9c3v30FA6OqezTHiSCAYhCxVKNd8WrHVPt1JoKpBDdadcctvdEunmS5rGt8FmP+YSmNXyuH8cuZ6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499083; c=relaxed/simple;
	bh=nHPBa1hKRfZ9dLWYPef6NXJGJU2ladqY7W9AbvHufiI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZZLr5wuPNUt3n5qHM6Bbdxm8/pdqrMuOYwZk2s9IFu07o3U6B4lYveBCwwACeDf0Ygm8lUOSc4Vgaw0WY1iOJezigLAYtuEim7UAN//yVRYJVK5EA88y9RvrsAYCCaZize5mmP5+Hw0LWPB3v1iMmVyfsRB1clAebIVKVdZcPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwraDZex; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714499081; x=1746035081;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=nHPBa1hKRfZ9dLWYPef6NXJGJU2ladqY7W9AbvHufiI=;
  b=AwraDZex4WsSu/Jx23SAjIegN0JJkjS1c9PvvqFqFHwPs4bNsFoVm5qF
   UJTIi+DzMRkEsQTgLPqRS9K81QDX7pSAucUm3Wcd/hZauUfnP8Xdd87pB
   SRFJZaOktUJTD/zde3ezBWDX1WiaKqT2QA0VccdhMbdw47k3rZfb3/8UJ
   L0Jnc7j6peunchmx0BuexQ313jQJy/RSA8+TiNi3m46dfWv2Mn+Em+pXu
   uikz57CCvGTlW5o7gNGcn6RjgLT1oezUI9SR8HwHNMNxwmH0r3hYEFepx
   yj4nZheCEw6sSJ7TE2bmYL7ti5HUnNgDYwKnKH9s/d+AvXsNO1mlnIv2u
   Q==;
X-CSE-ConnectionGUID: NPVEXPMQRMK+H0jZETWwfg==
X-CSE-MsgGUID: uvEv6E0PQbCiqyckGuw6Lg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="27669827"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="27669827"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:44:41 -0700
X-CSE-ConnectionGUID: deO5bSNgTo+ezujjPEwEoQ==
X-CSE-MsgGUID: PNLzAvs+Qaai0A1NouEAMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26534771"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.82.45])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:44:41 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v3 0/4] dax/bus.c: Fixups for dax-bus locking
Date: Tue, 30 Apr 2024 11:44:22 -0600
Message-Id: <20240430-vv-dax_abi_fixes-v3-0-e3dcd755774c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPYtMWYC/32NywqDMBBFf0Wy7pRkfCBd9T9KkTwmdaDVkkiwi
 P/e6MpF6fLcyz13EZECUxSXYhGBEkcehwzlqRC218ODgF1mgRIrWUmElMDpudOGO88zRWi1L03
 jPVKtRZ69A+1FXt3umXuO0xg++0NSW/pHlhQosCVJ74z2RtdXHiZ6nu34Epss4UGgmh8CBAmu9
 tK2ZFWDdBSs6/oFMTrq5PEAAAA=
To: Dan Williams <dan.j.williams@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.14-dev-5ce50
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=nHPBa1hKRfZ9dLWYPef6NXJGJU2ladqY7W9AbvHufiI=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDGmGuv9st9TPPWRY8i5c9u6JlcEX7z5jyRLXjFOptzt44
 dWC0rTKjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAEzE9T0jw0qZM96Tzc9dlFk4
 Y0VrxgTvE8cU9+SYL7vbaLX996Y1W6IZ/srdPSG3SGlNcNnKY0fNZzgWN0uU8ShkWrQl/729uK7
 qEhcA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

Commit Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
introduced a few problems that this series aims to fix. Add back
device_lock() where it was correctly used (during device manipulation
operations), remove conditional locking in unregister_dax_dev() and
unregister_dax_mapping(), use non-interruptible versions of rwsem
locks when not called from a user process, and fix up a write vs.
read usage of an rwsem.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
Changes in v3:
- Rebase to v6.9-rc6
- Collect review tags (Dan)
- Reword commit message for patch 2 (Dan)
- Use plain down_write() in delete_store() (Dan)
- Link to v2: https://lore.kernel.org/r/20240416-vv-dax_abi_fixes-v2-0-d5f0c8ec162e@intel.com

Changes in v2:
- Add back valid device_lock uses (Dan)
- Remove conditional locking (Dan)
- Use non-interruptible versions of rwsem locks when not called from a
  user process (Dan)
- Fix up a write vs. read usage of an rwsem
- Link to v1: https://lore.kernel.org/r/20240402-vv-dax_abi_fixes-v1-1-c3e0fdbafba5@intel.com

---
Vishal Verma (4):
      dax/bus.c: replace WARN_ON_ONCE() with lockdep asserts
      dax/bus.c: fix locking for unregister_dax_dev / unregister_dax_mapping paths
      dax/bus.c: Don't use down_write_killable for non-user processes
      dax/bus.c: Use the right locking mode (read vs write) in size_show

 drivers/dax/bus.c | 66 +++++++++++++++----------------------------------------
 1 file changed, 18 insertions(+), 48 deletions(-)
---
base-commit: e67572cd2204894179d89bd7b984072f19313b03
change-id: 20240402-vv-dax_abi_fixes-8af3b6ff2e5a

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>


