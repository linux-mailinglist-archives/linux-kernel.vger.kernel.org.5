Return-Path: <linux-kernel+bounces-88092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D64C86DD43
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2E8281B92
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95D46A348;
	Fri,  1 Mar 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HTEBLvZM"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025346997D;
	Fri,  1 Mar 2024 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282430; cv=none; b=Pq9gpSVT5X7n5OFxElQOQRI4mMbenS4gaZrqMCFKuhHXeS3jebG0FOP+MRyuI07vTzkOpaptAqHMUhFQFL7SnYtiYeec4gDOTf0BiYFER88ZJxwnlzxkQTgfozagsDecjMMhn7pjNfgsF2/pQ4wgs+XWH42BD901hwwg1ad2pd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282430; c=relaxed/simple;
	bh=JpANkCjtetYRdF5bevCopBm1xT0VWZ4TSa3drrOENZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nEGjxr5ImZlJexoKT+CVzA3jZNyP7A39K53Z1CKgDDMc6LI4ddAr7491SYly0dS8QST/TgGySzWFvqgVxzgTBqhU2c3qVzWtRJboz++zQ7MJINrXGBnMyO7DAXAgvmljsImvg95h3wD6zeKhMjAMe8kRp9gsirJg00YDkGCmshw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HTEBLvZM; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709282419; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/fhMqxBCkmmn8CH6FRiUPSq20rCPOyTNVQl0VCwCg98=;
	b=HTEBLvZMpm15fEpSEOj7Iez298xUmJH8SlSBwNfdgmz9VdNsz8AMCVRqBn3/W4q9g0cDxkOrLcvWrnAg8vYg40JU6O3VL2JUqk0zz7MeeHBIKtpYKQES71TxVrz9qlObMPI3NJUw0BsyAR+WSay0WnvPHslgJ67azXwAvEfsb+A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1a.nJe_1709282417;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W1a.nJe_1709282417)
          by smtp.aliyun-inc.com;
          Fri, 01 Mar 2024 16:40:18 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: daniel.lezcano@kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] powercap: dtpm: Fix kernel-doc for dtpm_create_hierarchy function
Date: Fri,  1 Mar 2024 16:18:02 +0800
Message-Id: <20240301081802.114308-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing comment block above the dtpm_create_hierarchy function
does not conform to the kernel-doc standard. This patch fixes the
documentation to match the expected kernel-doc format, which includes
a structured documentation header with param and return value.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/powercap/dtpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index ce920f17f45f..f390665743c4 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -522,7 +522,7 @@ static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
 
 /**
  * dtpm_create_hierarchy - Create the dtpm hierarchy
- * @hierarchy: An array of struct dtpm_node describing the hierarchy
+ * @dtpm_match_table: Pointer to the array of device ID structures
  *
  * The function is called by the platform specific code with the
  * description of the different node in the hierarchy. It creates the
-- 
2.20.1.7.g153144c


