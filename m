Return-Path: <linux-kernel+bounces-117571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886E88ACB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99D11C3DBEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0F185626;
	Mon, 25 Mar 2024 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Eh09a9Cg"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14265102F;
	Mon, 25 Mar 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387254; cv=none; b=ktz24xKksvVbWZyd87lo/DSlTz7oYD3cAtl6XcDNK4wryyAEauQ6YL1GVK+AHtj4iJBz4VDqznyojnqavIyJOXxI/r0qMVERvgrqhEGC2bYWmSK82qGsb33PqNbv79oT9Amd6YIdw3UlqIk43JVx6pOEJi7BVWawNTIUplHk9wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387254; c=relaxed/simple;
	bh=+4mYsDwEIK4ZWqyyDgyiPzXKtR3LJEx4RZaVrdGLE0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOY8Rx3YjpX0E1WrqIDbsd4A7lgUi43ynSg2IXUrfqE63Pw9X4wkxcvwqrrp8tSWSCuTBBmBspPSSAUa8wv2aqoxHOJI5xl/zA+sHk3bh4ELRBWJ0KiJbn0xakbrzbHhhuqpOEPgoDJZfKlOfVfbKdX29gr0aPYo5ntrBYgAVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Eh09a9Cg; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKm5I013563;
	Mon, 25 Mar 2024 12:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387248;
	bh=LRIF3E/X3Th7qLH/f1ml5/H5LIqNgItmvNfm9KSSj1I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Eh09a9CgZ4YG5hY6r/Y/R5YZV9ihv7PSOP6pwUit23ctN+JHUo6yqWFGdMRlGlwwn
	 2Ylv3/V/LfSjLr0n57n+oRt6Ht7f3ZhArLQF2LlcPj/tBwJs8aUbBFPVAWD/4niS5I
	 jvx34+mxTmAynVdjl6WeRJVf5jcr+DfZgErtaqTA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHKmLn042957
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:20:48 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:20:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:20:48 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKkYa075282;
	Mon, 25 Mar 2024 12:20:47 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 04/13] mailbox: omap: Move fifo size check to point of use
Date: Mon, 25 Mar 2024 12:20:36 -0500
Message-ID: <20240325172045.113047-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325172045.113047-1-afd@ti.com>
References: <20240325172045.113047-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The mbox_kfifo_size can be changed at runtime, the sanity
check on it's value should be done when it is used, not
only once at init time.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index c083734b6954c..167348fb1b33b 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -310,6 +310,7 @@ static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
 					void (*work)(struct work_struct *))
 {
 	struct omap_mbox_queue *mq;
+	unsigned int size;
 
 	if (!work)
 		return NULL;
@@ -320,7 +321,10 @@ static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
 
 	spin_lock_init(&mq->lock);
 
-	if (kfifo_alloc(&mq->fifo, mbox_kfifo_size, GFP_KERNEL))
+	/* kfifo size sanity check: alignment and minimal size */
+	size = ALIGN(mbox_kfifo_size, sizeof(u32));
+	size = max_t(unsigned int, size, sizeof(u32));
+	if (kfifo_alloc(&mq->fifo, size, GFP_KERNEL))
 		goto error;
 
 	INIT_WORK(&mq->work, work);
@@ -838,10 +842,6 @@ static int __init omap_mbox_init(void)
 	if (err)
 		return err;
 
-	/* kfifo size sanity check: alignment and minimal size */
-	mbox_kfifo_size = ALIGN(mbox_kfifo_size, sizeof(u32));
-	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size, sizeof(u32));
-
 	err = platform_driver_register(&omap_mbox_driver);
 	if (err)
 		class_unregister(&omap_mbox_class);
-- 
2.39.2


