Return-Path: <linux-kernel+bounces-25136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34CE82C859
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014861C22239
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF35010A27;
	Sat, 13 Jan 2024 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds8yEuL7"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C7EAEB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5988e377264so2335527eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105767; x=1705710567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IigtoQAGDe/uXYhPgD4R1a4twxloCeSuwyTiD+5/+1U=;
        b=ds8yEuL7tJgzATYiq2f34Q06E9XumFHHzOmobzGlgNDKHvjXHLUH9XO7MQzUYgV6Ab
         A4pDdCwgVKQIyc6YO9GSwfSD1D2jAeKFdjPwAgBbig6U3b6gCoSkpuCS3yFfaGgc3FBK
         sqIZ0RYordEt1dt8aubxlJ5cP5CoZczSDcb2JW+g73fCr2S0w9y9FWgkCkKaIgdC2jyn
         VFbj5Ks17YJkqiSXdKKYCjg0pFXPP3siABPaovVVEQuduaVqGLNPjdP2Hws5jHkUAT1Y
         ednkI3U6fEILDDPVr/IikzvmVvMp0BlPLHSUdQ/T42yHQqKFT+g16GOC1QNgDvrwUU9S
         ot5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105767; x=1705710567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IigtoQAGDe/uXYhPgD4R1a4twxloCeSuwyTiD+5/+1U=;
        b=fRZwGy/wuZwphSVDNSyyWx9IGFL2NeND4JnxFrRU3ZcBm74soEsCmdXByu2sp16ZPs
         ZQSsqsv7X4PMcBe9qOFjNaL1ULPq3/26pJ66zt57FowzqE0iaKDa7umTGZlTeuLg9s5t
         s/YeRiWLN5OSEjPbEIrQKQzJMQCjCTaHKVHSFkQhxnzLbcumG2+HxZcWq0lWRn90Pd8x
         qI5Vp7sIAKK8fXqjpxVD6KUS8wzw6HloK6bkO0xBgXhQ16lBxXYOF3zFR6T4Tr+Xls0h
         64dh/baFE3w0J/Z2l7uSjZbxxJzq8wqZTFJr4mcc5LhoigoSCfJzadNi+IOpMsmeUkx3
         6Eww==
X-Gm-Message-State: AOJu0YxrTrq/e+TmNvQSvW5yeAtzIEWLdzlWQuTw5buXjRPd5KFTuecW
	p4Ahbn7b/+Hve6TJhp4np6M=
X-Google-Smtp-Source: AGHT+IEzxzQ1yJ5vkfn55xTxLoMRpL+F8Niffpe9ixVxI2K3XKDUVy/E+4NM2e2ZgkKo/5XW/T0WmA==
X-Received: by 2002:a05:6359:3509:b0:175:abbe:58b9 with SMTP id un9-20020a056359350900b00175abbe58b9mr1680114rwb.64.1705105766602;
        Fri, 12 Jan 2024 16:29:26 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id db11-20020a17090ad64b00b00286da7407f2sm7192864pjb.7.2024.01.12.16.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:29:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/9] workqueue: Move pwq_dec_nr_in_flight() to the end of work item handling
Date: Fri, 12 Jan 2024 14:28:51 -1000
Message-ID: <20240113002911.406791-8-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113002911.406791-1-tj@kernel.org>
References: <20240113002911.406791-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The planned shared nr_active handling for unbound workqueues will make
pwq_dec_nr_active() sometimes drop the pool lock temporarily to acquire
other pool locks, which is necessary as retirement of an nr_active count
from one pool may need kick off an inactive work item in another pool.

This patch moves pwq_dec_nr_in_flight() call in try_to_grab_pending() to the
end of work item handling so that work item state changes stay atomic.
process_one_work() which is the other user of pwq_dec_nr_in_flight() already
calls it at the end of work item handling. Comments are added to both call
sites and pwq_dec_nr_in_flight().

This shouldn't cause any behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3f45baa96d51..522ef63088de 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1566,6 +1566,11 @@ static void pwq_dec_nr_active(struct pool_workqueue *pwq)
  * A work either has completed or is removed from pending queue,
  * decrement nr_in_flight of its pwq and handle workqueue flushing.
  *
+ * NOTE:
+ * For unbound workqueues, this function may temporarily drop @pwq->pool->lock
+ * and thus should be called after all other state updates for the in-flight
+ * work item is complete.
+ *
  * CONTEXT:
  * raw_spin_lock_irq(pool->lock).
  */
@@ -1690,11 +1695,13 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		pwq_activate_work(pwq, work);
 
 		list_del_init(&work->entry);
-		pwq_dec_nr_in_flight(pwq, *work_data_bits(work));
 
 		/* work->data points to pwq iff queued, point to pool */
 		set_work_pool_and_keep_pending(work, pool->id);
 
+		/* must be the last step, see the function comment */
+		pwq_dec_nr_in_flight(pwq, *work_data_bits(work));
+
 		raw_spin_unlock(&pool->lock);
 		rcu_read_unlock();
 		return 1;
@@ -2759,6 +2766,8 @@ __acquires(&pool->lock)
 	worker->current_func = NULL;
 	worker->current_pwq = NULL;
 	worker->current_color = INT_MAX;
+
+	/* must be the last step, see the function comment */
 	pwq_dec_nr_in_flight(pwq, work_data);
 }
 
-- 
2.43.0


