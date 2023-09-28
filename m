Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CDA7B17A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjI1Jjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjI1JjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:39:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F544CE4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:39:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31f71b25a99so12548643f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1695893943; x=1696498743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGK+HdR6obbUDfw8jsEAQzDJzPR9njsPrKQpwnxwsJU=;
        b=CqtslHtvLU9LFCqlrfUd8D6vR4EEvquMYBMfTlzM+JGw3xd5NV2y4H4zwhnEnz3GG+
         2Tw5ofJnuzip07M358UcS+zxTMKSr2oY3KbLZp6Val9ykb+FbeZrUYov7AZpXgTI9Y17
         uc4O4H7AQZ0ADkg4zWABOoMJ/z1RRl3Vy8vA1QiBlB7OWIwAB/R8YnGDSYLNMkWaS7Uv
         YutChMpHRTqTzF6vsx0jrzq3unt9bYEa5+cj5ugFAU+DjlwlwIFaZ3/lahk8JCb64msG
         zI7cGndBSMP9EntXlkrdyZWIADvqo1ReoFx19qzhXB9dnNbbmIJd13XW2emhwZlybltg
         gWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695893943; x=1696498743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGK+HdR6obbUDfw8jsEAQzDJzPR9njsPrKQpwnxwsJU=;
        b=NQKASgou4+UWemEBCjC3A4bVa8dbyMmqflH2W9sNR7aH21D0EXScvvzYAGZqnDSv2O
         sA+lLjb0LFyYcLfZD/hCzEpgt3zZydi9CWR0WlQCfmQHf48T6Pl5WOxOSrtex5cPSkpV
         aW6MjE7uiwRtViiHbGr1eaJkfMgJSVlCzWbyoqTgAdH/D9g7Z7o8EoPt7g9ysGN/cjAd
         mEzHl+8oyQnMzQzO7NJc96O2wy8ZxhyUmuIhBZJOPxn0zAT4wcfdJVHGcrRdoLYbCAPk
         HRNvswiQ1+IGUmqf/ojiS7gOQbxOYbeq8XEZ3ZDQUel3Fk6xvF19JOOA5WifkM1jHx1d
         6hSw==
X-Gm-Message-State: AOJu0Yy/etv0IoaUaWP0nNct8NUGeQPkq+I1UcnZ+AhpP6VcDCv2DtfO
        NjnvPjKsOHQBqJE3RZgqzbNydg==
X-Google-Smtp-Source: AGHT+IEs9yBVflEyi8aWeeB2xlHf8uw7cl5KRIXN78um42kIokcnqkm/4b1KHILhnLQXF/9X9WINbA==
X-Received: by 2002:adf:d0cc:0:b0:31d:da10:e471 with SMTP id z12-20020adfd0cc000000b0031dda10e471mr696646wrh.69.1695893943541;
        Thu, 28 Sep 2023 02:39:03 -0700 (PDT)
Received: from localhost.localdomain (213-225-13-130.nat.highway.a1.net. [213.225.13.130])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d50c4000000b0031fa870d4b3sm18931449wrt.60.2023.09.28.02.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:39:03 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Joel Colledge <joel.colledge@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 4/5] drbd: Keep connection threads running while connection is up only
Date:   Thu, 28 Sep 2023 11:38:51 +0200
Message-ID: <20230928093852.676786-5-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
References: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Connection independent work has been moved from the connection "sender" to the
resource "worker", so there no longer is a need to keep the "sender" running
when the connection is down.

Originally-from: Andreas Gruenbacher <agruen@kernel.org>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c    |  6 +-----
 drivers/block/drbd/drbd_state.c | 21 ---------------------
 drivers/block/drbd/drbd_state.h |  1 -
 3 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 9d9ced46f968..85ab6f0f9d87 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1361,8 +1361,7 @@ static void conn_reconfig_done(struct drbd_connection *connection)
 {
 	bool stop_threads;
 	spin_lock_irq(&connection->resource->req_lock);
-	stop_threads = conn_all_vols_unconf(connection) &&
-		connection->cstate == C_STANDALONE;
+	stop_threads = connection->cstate == C_STANDALONE;
 	spin_unlock_irq(&connection->resource->req_lock);
 	if (stop_threads) {
 		/* ack_receiver thread and ack_sender workqueue are implicitly
@@ -1749,7 +1748,6 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	peer_device = first_peer_device(device);
 	connection = peer_device->connection;
-	conn_reconfig_start(connection);
 
 	/* if you want to reconfigure, please tear down first */
 	if (device->state.disk > D_DISKLESS) {
@@ -2117,7 +2115,6 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 
 	kobject_uevent(&disk_to_dev(device->vdisk)->kobj, KOBJ_CHANGE);
 	put_ldev(device);
-	conn_reconfig_done(connection);
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -2128,7 +2125,6 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	drbd_force_state(device, NS(disk, D_DISKLESS));
 	drbd_md_sync(device);
  fail:
-	conn_reconfig_done(connection);
 	if (nbc) {
 		close_backing_dev(device, nbc->md_bdev,
 			  nbc->disk_conf->meta_dev_idx < 0 ?
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index c623769abc1a..0a901e5aca0a 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -291,27 +291,6 @@ static inline bool is_susp(union drbd_state s)
         return s.susp || s.susp_nod || s.susp_fen;
 }
 
-bool conn_all_vols_unconf(struct drbd_connection *connection)
-{
-	struct drbd_peer_device *peer_device;
-	bool rv = true;
-	int vnr;
-
-	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
-		struct drbd_device *device = peer_device->device;
-		if (device->state.disk != D_DISKLESS ||
-		    device->state.conn != C_STANDALONE ||
-		    device->state.role != R_SECONDARY) {
-			rv = false;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return rv;
-}
-
 /* Unfortunately the states where not correctly ordered, when
    they where defined. therefore can not use max_t() here. */
 static enum drbd_role max_role(enum drbd_role role1, enum drbd_role role2)
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index cbaeb8018dbf..67371bd563e4 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -142,7 +142,6 @@ conn_request_state(struct drbd_connection *connection, union drbd_state mask, un
 		   enum chg_state_flags flags);
 
 extern void drbd_resume_al(struct drbd_device *device);
-extern bool conn_all_vols_unconf(struct drbd_connection *connection);
 
 /**
  * drbd_request_state() - Request a state change
-- 
2.41.0

