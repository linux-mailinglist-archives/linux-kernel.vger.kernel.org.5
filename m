Return-Path: <linux-kernel+bounces-155800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF6A8AF748
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2271F24F71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED055142659;
	Tue, 23 Apr 2024 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="no3Stq3c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DA14198A;
	Tue, 23 Apr 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900340; cv=none; b=JINXPATEN7n3DtAF1YDXD6xmprWtcBdM23INA7hk416aQEnlaSk9vClhDHki86TGtS6IJb0VbNjBZSPmAaCOKIMzIjfvUV8lF0AwbHoUCI677WKGTbb1mrx7QvH97Vy0FI+TAR8ZJd85mijAqswzFgcXUgCDX1iBanIvdbZuR+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900340; c=relaxed/simple;
	bh=2bbhNMcCCiv6N+ewcEN+Y+F2rWYZystG+A1e4eVfob8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThtvYUKjdgGumjMCkji0tXYSIhfZ32Jwa7gUXIY5rYukEpWjNg/eR5Jjz4Lllskofp42MjdrX668UN0w+GmhU7zTYC0SunnutWVspN2xdiwqACQnoeB5+a7Qi4uXTxrQ4LBnhmj/iDWahear+YUJwMFAZa48F8wx4OoLRbvs1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=no3Stq3c; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713900338; x=1745436338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2bbhNMcCCiv6N+ewcEN+Y+F2rWYZystG+A1e4eVfob8=;
  b=no3Stq3cgeoy81jDitx1CgtlNIGxYgNvlrnTSLVOt9iWRUMGaDkXvklQ
   sts1qIXE8hW1suH5hmrAx8tsm7eVVdkNFtAQ2KkmPrlx0K5yQouM9VLWx
   Nj6hbbsE6lIDgoKCJZxKdN3aGn/ong/uTg7nSDcWug0kC8tvI4z45jYP2
   XmFv+Wka6sRn/rPHLW3DKhFZN3iZOxoHRMvJq4+xePFYmkULIw7e5jN4r
   m3o8m0llCPQCRiuHczIVH214orIwCo0omXzQRJWOwOSRZwuYdvOfXogep
   xqseBiC3q9XnSsgTcKrCpoavk/xVs/IZFYBtnJTic6783Pauq1LcVgjlD
   w==;
X-CSE-ConnectionGUID: rckfaD9UQiqCju+UW++lAw==
X-CSE-MsgGUID: 2uoa6gFxRru2hHw8RY7iSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9613674"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9613674"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 12:25:36 -0700
X-CSE-ConnectionGUID: W01uJp+jRGiHboM8QSfWyA==
X-CSE-MsgGUID: +a6k97EoTvq99nzBVT7nig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24440741"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 23 Apr 2024 12:25:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B1683192; Tue, 23 Apr 2024 22:25:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Sean Young <sean@mess.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/3] kfifo: Clean up kfifo.h
Date: Tue, 23 Apr 2024 22:23:07 +0300
Message-ID: <20240423192529.3249134-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To reduce a dependency hell degree, clean up kfifo.h
(mainly getting rid of kernel.h in the global header).

In v2:
- rebased on top of v6.9-rc5 (Andrew)
- retested again with `make allyesconfig` on x86_64,
  hence first two new patches

Andy Shevchenko (3):
  media: rc: Add missing io.h
  media: stih-cec: Add missing io.h
  kfifo: Don't use "proxy" headers

 drivers/media/cec/platform/sti/stih-cec.c |  1 +
 drivers/media/rc/mtk-cir.c                |  1 +
 drivers/media/rc/serial_ir.c              |  1 +
 drivers/media/rc/st_rc.c                  |  1 +
 drivers/media/rc/sunxi-cir.c              |  1 +
 include/linux/kfifo.h                     |  9 +++++++--
 lib/kfifo.c                               | 10 +++++-----
 samples/kfifo/dma-example.c               |  3 ++-
 8 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


