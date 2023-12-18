Return-Path: <linux-kernel+bounces-3041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B6E81667C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC3C28260F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83D6FB2;
	Mon, 18 Dec 2023 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="5AOlFKkU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89EEC8F3;
	Mon, 18 Dec 2023 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yd59uGEg1d9Q50uiK6BFpTRDUTndrVdBp8wWSlMKviQ=; b=5AOlFKkUY8zEhGiMEqCk5zyVrm
	r3BRHXeoTHeGuUqiY/9fn1/ofA4PB7aaMiJD1lDdoTtZA4sRZZDv3RnK9l97Ale3paO2uJhW7PmK7
	dK1UXiKyaCiOaJSK3SP1aslqPZU6RKTpanulUKu0Ib6Vs6beQSdN4QgPpT5GZUr4v5AfgTfqDgcTT
	j59jUnKfw/B/VCda1hLjKd8nxoOR/Q0gSzJrZ+JWdTXsfBKhZpnL+TnK6hKcMqmHdpsjS38BZDLZe
	cDrzB02JiSSHOw+xGEHrp1mJDKBs2pmi/lzkLapvQMbK7qRJB2LnA7uqijm+O7SSVkT/gbwoSpo6N
	xrdVOZ0w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rF75g-009DcO-0k;
	Mon, 18 Dec 2023 06:27:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Michael Shych <michaelsh@nvidia.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: mlx_wdt: fix all kernel-doc warnings
Date: Sun, 17 Dec 2023 22:26:59 -0800
Message-ID: <20231218062659.26916-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct kernel-doc warnings as reported by kernel test robot:

mlx_wdt.c:56: warning: Function parameter or member 'wdt_type' not described in 'mlxreg_wdt'
mlx_wdt.c:56: warning: Excess struct member 'device' description in 'mlxreg_wdt'
mlx_wdt.c:56: warning: Excess struct member 'timeout' description in 'mlxreg_wdt'
mlx_wdt.c:56: warning: Excess struct member 'wd_type' description in 'mlxreg_wdt'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312171701.xNkzdgdi-lkp@intel.com/
Cc: Michael Shych <michaelsh@nvidia.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/mlx_wdt.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff -- a/drivers/watchdog/mlx_wdt.c b/drivers/watchdog/mlx_wdt.c
--- a/drivers/watchdog/mlx_wdt.c
+++ b/drivers/watchdog/mlx_wdt.c
@@ -30,17 +30,15 @@
  * struct mlxreg_wdt - wd private data:
  *
  * @wdd:	watchdog device;
- * @device:	basic device;
  * @pdata:	data received from platform driver;
  * @regmap:	register map of parent device;
- * @timeout:	defined timeout in sec.;
  * @action_idx:	index for direct access to action register;
  * @timeout_idx:index for direct access to TO register;
  * @tleft_idx:	index for direct access to time left register;
  * @ping_idx:	index for direct access to ping register;
  * @reset_idx:	index for direct access to reset cause register;
  * @regmap_val_sz: size of value in register map;
- * @wd_type:	watchdog HW type;
+ * @wdt_type:	watchdog HW type;
  */
 struct mlxreg_wdt {
 	struct watchdog_device wdd;

