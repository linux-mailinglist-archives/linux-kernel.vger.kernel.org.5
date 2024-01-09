Return-Path: <linux-kernel+bounces-20482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9A4827F89
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12433B23399
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89421B64A;
	Tue,  9 Jan 2024 07:39:51 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF6D944D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4097d3CY027446;
	Tue, 9 Jan 2024 15:39:03 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T8N153lXNz2RR7B9;
	Tue,  9 Jan 2024 15:32:09 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 9 Jan 2024
 15:39:02 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko
	<andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, wenhua lin
	<wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu
	<xiongpeng.wu@unisoc.com>
Subject: [PATCH V4 0/2] gpio: sprd: Modification of UNISOC Platform EIC Driver
Date: Tue, 9 Jan 2024 15:38:47 +0800
Message-ID: <20240109073849.10791-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 4097d3CY027446

Recently, some bugs have been discovered during use, and patch1
are bug fixes. Also, this patchset add optimization:
patch2 optimization the calculation method of eic number.

Change in V4:

-Add Fixes tag in PATCH 1/2.
-Change commit message in PATCH 1/2.
-Add clearing interrupt to debounce and latch mode in PATCH 1/2.

-Change commit message in PATCH 2/2.
-Delete SPRD_EIC_VAR_DATA macro in PATCH 2/2.

Wenhua Lin (2):
  gpio: eic-sprd: Clear interrupt after set the interrupt type
  gpio: eic-sprd: Optimize the calculation method of eic number

 drivers/gpio/gpio-eic-sprd.c | 42 +++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 10 deletions(-)

-- 
2.17.1


