Return-Path: <linux-kernel+bounces-163745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650938B6F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C9A1F23FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1341292F2;
	Tue, 30 Apr 2024 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ExSriAwm"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B875DFC02
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471690; cv=none; b=P7ycZNSMLYDBCEN1S+V1oN7Wd9MSUB4GJvDJC3dUo11iWfY0mHWUTeIWfIPuvRELn4UdZPTrk6DelGEf13X5ZcE/ChgNbYIUgYoM6a8SIjqG9KjdJ3qpmvggcO5I5hjyA15hbbZGQpK1N1jA2aDN06oNyoLQRQ6Un/pJ2UtwxZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471690; c=relaxed/simple;
	bh=GNwi9c3XEet0n/g190xTW6uc3yCjHSUElUE3/b7GvwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N2U4mELUsGcsw+wJYkCWgAkBWyBnznLrX0eoYCaX13PnnXcZwPgjuM0oerV0goZnolq1dlFsNza5WxYmBHShl6kt7RY8xi1rp9f1oDsWbKAjtVQpXjIH2gxk9Sw41BfPNyNsLDvgZR8oQFblvnpPIvHQJbqCUmO/br41tCqCD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ExSriAwm; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714471680; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9zobJ2rQTtIS2TqrWVEPphL69LbeUpn9huSTiklowK4=;
	b=ExSriAwmqXyN80ND1G3ze1LI+AO6QzoZTUjpiTirrPgCYeRXAjGD9WYXd324YOlfIrom3mAWk7R424HOsJOvSJ0PY7Atf+M8ier28+wEssH5zuKr+X/7VluVrDVS9nSrBjGFIJ0wbZ9Gm1xFbpBLCUWMbx+IEH6EczIwsnYjIxU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W5bwVuT_1714471678;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W5bwVuT_1714471678)
          by smtp.aliyun-inc.com;
          Tue, 30 Apr 2024 18:07:59 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: alexander.shishkin@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH-next] intel_th: Fix kernel-doc param for intel_th_alloc
Date: Tue, 30 Apr 2024 18:07:57 +0800
Message-Id: <20240430100757.121364-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function intel_th_alloc.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/hwtracing/intel_th/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 86c8efecd7c2..7f85d69fc8a3 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -857,8 +857,9 @@ static irqreturn_t intel_th_irq(int irq, void *data)
 /**
  * intel_th_alloc() - allocate a new Intel TH device and its subdevices
  * @dev:	parent device
+ * @drvdata:	driver-specific data
  * @devres:	resources indexed by th_mmio_idx
- * @irq:	irq number
+ * @ndevres:	Number of device resources.
  */
 struct intel_th *
 intel_th_alloc(struct device *dev, const struct intel_th_drvdata *drvdata,
-- 
2.20.1.7.g153144c


