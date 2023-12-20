Return-Path: <linux-kernel+bounces-6478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E728819971
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE181F22854
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346AC20B39;
	Wed, 20 Dec 2023 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfv/c0MD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C834320B05
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cd84c5442cso334279a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057158; x=1703661958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cyt8fyY3M3PuPjx+3e8Kh5Okr3yi3QH0LqEk2PE6p64=;
        b=kfv/c0MD9KNvO79u7ZDtLO/8HcOiq0EL1ExwiMicfIaJbTUXDPKWpIDj5Icyvq4VGj
         ZZ8BWevJR19zF1FoPVuoE9a9XaRYVPGs/7wLGDkb/94FB6zjcFE/OdP5QtmVAijLM/ZK
         53CWsbkh1eMhzwkrPZUoG3YZhxeV5tjOHQx3hr0bcuM07Mt4CiBAhJ6DsUcuWX8w9JlP
         /ahKt6xQYToLETdHEUzL74NgY1IGGedkBAzQDnd1/mOKcRgAEX1I2n92OqdDsNmBYiPq
         ebXZ26BojYEbkw3raAjLAq12PAhDZr1rg/Hm54ywkjr0YBT2X3uVUnf9CUKbKryHPa99
         6T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057158; x=1703661958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cyt8fyY3M3PuPjx+3e8Kh5Okr3yi3QH0LqEk2PE6p64=;
        b=VGkfIrf4FhkEitTnaleP5a34fBQlOcZcChxfKFWoZM/vRU57mS9P/xV4w8+bPCKkpG
         OIb3z7bo71ueeaDM3sh8/tI+XRjmXs2cTHRiqsD+7mVnTU8iSMwmeecAySG9hmjUliCv
         Ikv6mIAUsIH/rB0NBL3IumSCVtKQGBhsNun0WrZeo4ucgdEuLxnY77oAkJNoHKBFpj/p
         YPTJf76xmUIFA+C3iywxfv2PVPPtpryWZ1Fl3Jb9OU1DLK2gjIf+5Gy5lger8iQX6bG3
         zpFqlzLBvWP79luV1zOVJ7k2DdXPg2u2bfJw9D2Xu2URE5tzPCuQOjeUz3G166aX+Tn3
         pgqQ==
X-Gm-Message-State: AOJu0YwgYSIo7D08hx7OJenvvt2j1gjcdeM4O43GcrNuqTltk8/3cF87
	Mc8JmckAEX3YmcJkL2/deXk=
X-Google-Smtp-Source: AGHT+IGU22d9j8DT1a+GULWJ/Y1ycN2B/xuHpfnuhYmY0L//M5q+w3z/CjoAQAQQmvij4abr4XBFzw==
X-Received: by 2002:a17:90b:408e:b0:286:6cc0:62a6 with SMTP id jb14-20020a17090b408e00b002866cc062a6mr3304050pjb.37.1703057157987;
        Tue, 19 Dec 2023 23:25:57 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090a154a00b0028b96c9424dsm3081395pja.1.2023.12.19.23.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:25:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/10] workqueue: Move pwq_dec_nr_in_flight() to the end of work item handling
Date: Wed, 20 Dec 2023 16:24:38 +0900
Message-ID: <20231220072529.1036099-8-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220072529.1036099-1-tj@kernel.org>
References: <20231220072529.1036099-1-tj@kernel.org>
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
index a9f63cd61454..9982c63470e5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1557,6 +1557,11 @@ static void pwq_dec_nr_active(struct pool_workqueue *pwq)
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
@@ -1681,11 +1686,13 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
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
@@ -2745,6 +2752,8 @@ __acquires(&pool->lock)
 	worker->current_func = NULL;
 	worker->current_pwq = NULL;
 	worker->current_color = INT_MAX;
+
+	/* must be the last step, see the function comment */
 	pwq_dec_nr_in_flight(pwq, work_data);
 }
 
-- 
2.43.0


