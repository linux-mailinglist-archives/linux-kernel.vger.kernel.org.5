Return-Path: <linux-kernel+bounces-16205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B695823AC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD69B245DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8EA4C83;
	Thu,  4 Jan 2024 02:43:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF1185B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4042gto9001513;
	Thu, 4 Jan 2024 10:42:55 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T59gt69l3z2Qby50;
	Thu,  4 Jan 2024 10:36:10 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 4 Jan 2024
 10:42:52 +0800
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
Subject: [PATCH V3 0/4] gpio: eic-sprd: Modification of UNISOC Platform EIC Driver
Date: Thu, 4 Jan 2024 10:42:40 +0800
Message-ID: <20240104024244.12163-1-Wenhua.Lin@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 4042gto9001513

Recently, some bugs have been discovered during use, and
patch2 are bug fixes. Also, this patchset add optimization:
patch1 can support eic debouce wake-up system and
patch3 optimization the calculation method of eic number,
and patch4 Support 8 banks EIC controller.

Change in V3:
-Using thread send 4 patches 

-Change title and commit message in PATCH 1/4.
-Delete fixes tag in PATCH 1/4.

-Change commit message in PATCH 2/4.

-Move num_banks++ to the back of sprd_eic->base in PATCH 3/4.
-Delete fixes tag in PATCH 3/4.
-Modify misindented issue in PATCH 3/4.
-Preserve reversed xmas tree order in PATCH 3/4.

-Change related comments in PATCH 4/4.

Wenhua Lin (4):
  gpio: eic-sprd: Keep the clock rtc_1k on
  gpio: eic-sprd: Clear interrupt after set the interrupt type
  gpio: eic-sprd: Modify the calculation method of eic number
  gpio: eic-sprd: Support 8 banks EIC controller

 drivers/gpio/gpio-eic-sprd.c | 65 +++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 26 deletions(-)

-- 
2.17.1


