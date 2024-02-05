Return-Path: <linux-kernel+bounces-51964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8081984920A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21271C21275
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880EC29A2;
	Mon,  5 Feb 2024 00:32:04 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3C10F2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.52.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707093124; cv=none; b=Wfd3fDxXFoas+7S1MRgHWZkM/BL51+wdHgmOWE4YOh5eTRusyI9OiCbMu86QclmfUINQjSdvLINq5/IyRy/ZzqmQVXk+BSJQMlhWX37lRNStvozKnxuHSu1eOXKLdlECuMnCGD8S/xOYbj1VovUtc29W50reUn52fNx5+YMd+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707093124; c=relaxed/simple;
	bh=1qbKEaSNMO2n0mf7DI5qoI45pWyC3c7BUurSZcwcCh0=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M3msTO33D+r0gBRVLXk2rS+3YBbXMRC+zPnXBSKdDxl8uUKpWaFhZ8QK902sy4eR/i+ZZO7lwh/hogWpFvHLSAVPsTxXwFrfmvTyrblndCClbbfulHqHYrwZZvOtM5RoekSfbJ10NOnaIDOBqBkmW9n2u/RnifIWnKUN2oeViOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4TSnP719j6zB1MnQ;
	Mon,  5 Feb 2024 08:31:23 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 5 Feb
 2024 08:31:53 +0800
Date: Mon, 5 Feb 2024 08:31:52 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	<linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH] workqueue: fix a typo in comment
Message-ID: <202402050831+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

There should be three, fix it.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed892..236fd78587e0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6856,7 +6856,7 @@ static bool __init cpus_share_numa(int cpu0, int cpu1)
 /**
  * workqueue_init_topology - initialize CPU pods for unbound workqueues
  *
- * This is the third step of there-staged workqueue subsystem initialization and
+ * This is the third step of three-staged workqueue subsystem initialization and
  * invoked after SMP and topology information are fully initialized. It
  * initializes the unbound CPU pods accordingly.
  */
-- 
2.40.0


