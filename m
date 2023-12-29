Return-Path: <linux-kernel+bounces-12909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6981FC85
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B3C1C22008
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4899217C0;
	Fri, 29 Dec 2023 02:08:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF32137F;
	Fri, 29 Dec 2023 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VzPxWSp_1703815688;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VzPxWSp_1703815688)
          by smtp.aliyun-inc.com;
          Fri, 29 Dec 2023 10:08:19 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: irenic.rajneesh@gmail.com
Cc: david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] platform/x86/intel/pmc: make lnl_d3_fixup static
Date: Fri, 29 Dec 2023 10:08:08 +0800
Message-Id: <20231229020808.55840-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The lnl_d3_fixup are not used outside the file lnl.c, so the
modification is defined as static.

drivers/platform/x86/intel/pmc/lnl.c:503:6: warning: no previous prototype for ‘lnl_d3_fixup’.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7811
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/platform/x86/intel/pmc/lnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 88b35931f5df..f18fdc68fd94 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -500,7 +500,7 @@ const struct pmc_reg_map lnl_socm_reg_map = {
  * Set power state of select devices that do not have drivers to D3
  * so that they do not block Package C entry.
  */
-void lnl_d3_fixup(void)
+static void lnl_d3_fixup(void)
 {
 	pmc_core_set_device_d3(LNL_IPU_PCI_DEV);
 	pmc_core_set_device_d3(LNL_NPU_PCI_DEV);
-- 
2.20.1.7.g153144c


