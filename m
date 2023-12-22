Return-Path: <linux-kernel+bounces-9394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32D681C4F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B17EB21398
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB498C1F;
	Fri, 22 Dec 2023 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G0sodgLJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DCE6FC2;
	Fri, 22 Dec 2023 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=H/1i8yuFGfbcX5ybZ7dpr8kd0kCwVEfZQgnUatjDRZI=; b=G0sodgLJjLbicjRPugj4eCiRke
	R8ULCFUCOnRiBQ0XzWSu8Yi7tAHPo5iqBuUpmnYz5zTSvru9CDket87q7V5pIGfWtcGzdCq+2/9Z2
	5/xYrjR/URe1mC6KY/UAiGBQJK2h0DsUqGx3wvJAiCBCOtAbVFD9HZV6j44n87rOCtUBGlb/KKsWy
	xuNcYBXTf8nBWu54K9cUec/L0RofketFiNrnHkAhLTo4BtxHARW1SsGu/6k7rYhJNo3xTHSjRbZHN
	8Jl58mYONiXMfP+vR22oggIYZSD8qHXoBZUeG3VetknuNU5f+vT7RZIyRYRGHc1ALdpieB98Dg7Cw
	TXsJZFpg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGYsI-0053dC-0D;
	Fri, 22 Dec 2023 06:19:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	drbd-dev@lists.linbit.com,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] drbd: actlog: fix kernel-doc warnings and spelling
Date: Thu, 21 Dec 2023 22:19:08 -0800
Message-ID: <20231222061909.8791-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix all kernel-doc warnings in drbd_actlog.c:

drbd_actlog.c:963: warning: No description found for return value of 'drbd_rs_begin_io'
drbd_actlog.c:1015: warning: Function parameter or member 'peer_device' not described in 'drbd_try_rs_begin_io'
drbd_actlog.c:1015: warning: Excess function parameter 'device' description in 'drbd_try_rs_begin_io'
drbd_actlog.c:1015: warning: No description found for return value of 'drbd_try_rs_begin_io'
drbd_actlog.c:1197: warning: No description found for return value of 'drbd_rs_del_all'

Fix one spelling error (s/ore/or/).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 drivers/block/drbd/drbd_actlog.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff -- a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -838,8 +838,8 @@ static bool plausible_request_size(int s
 }
 
 /* clear the bit corresponding to the piece of storage in question:
- * size byte of data starting from sector.  Only clear a bits of the affected
- * one ore more _aligned_ BM_BLOCK_SIZE blocks.
+ * size byte of data starting from sector.  Only clear bits of the affected
+ * one or more _aligned_ BM_BLOCK_SIZE blocks.
  *
  * called by worker on C_SYNC_TARGET and receiver on SyncSource.
  *
@@ -957,7 +957,9 @@ static int _is_in_al(struct drbd_device
  * @device:	DRBD device.
  * @sector:	The sector number.
  *
- * This functions sleeps on al_wait. Returns 0 on success, -EINTR if interrupted.
+ * This functions sleeps on al_wait.
+ *
+ * Returns: %0 on success, -EINTR if interrupted.
  */
 int drbd_rs_begin_io(struct drbd_device *device, sector_t sector)
 {
@@ -1004,11 +1006,13 @@ retry:
 
 /**
  * drbd_try_rs_begin_io() - Gets an extent in the resync LRU cache, does not sleep
- * @device:	DRBD device.
+ * @peer_device: DRBD device.
  * @sector:	The sector number.
  *
  * Gets an extent in the resync LRU cache, sets it to BME_NO_WRITES, then
- * tries to set it to BME_LOCKED. Returns 0 upon success, and -EAGAIN
+ * tries to set it to BME_LOCKED.
+ *
+ * Returns: %0 upon success, and -EAGAIN
  * if there is still application IO going on in this area.
  */
 int drbd_try_rs_begin_io(struct drbd_peer_device *peer_device, sector_t sector)
@@ -1190,7 +1194,7 @@ void drbd_rs_cancel_all(struct drbd_devi
  * drbd_rs_del_all() - Gracefully remove all extents from the resync LRU
  * @device:	DRBD device.
  *
- * Returns 0 upon success, -EAGAIN if at least one reference count was
+ * Returns: %0 upon success, -EAGAIN if at least one reference count was
  * not zero.
  */
 int drbd_rs_del_all(struct drbd_device *device)

