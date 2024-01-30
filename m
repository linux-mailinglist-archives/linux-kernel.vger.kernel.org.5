Return-Path: <linux-kernel+bounces-44227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57009841F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE5A2932AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1936679FF;
	Tue, 30 Jan 2024 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9QVhT1p"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C466B4F;
	Tue, 30 Jan 2024 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605997; cv=none; b=Zh5RmlBmH1gmPHwDqtE9puZhG6puaXyKuddltDxWSKDghHg/CRFfEb+pishNRM2jXGLWhfxHrpoFcgnJ6FEbfwJmyd1jQfGEq7SXLRX8XInJoUaDRSgF2aSPp3grfAxmPdE+X78YBbNe+UQWrjEaeyqKuFPT1Q02gIyGlroD1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605997; c=relaxed/simple;
	bh=SZMS+fgtkFfSzguhmeH2OmNAK1/PWSF2Bv2J0fmCKdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRn0Zu0xT8E/8xix9a160BJKVWUYExcGO33azdOm3OSvKAeoLX1p2z/+wMlm4heWjyJXYS4EFqXPy0pIf2EqwgRTpGr7Qk7054XVt6Wx//97UMKqP/D9GPV5Juh51RvPDMEnY+is6GVUGkBTOXMFntC1JaXYg9l/huEFdN7383E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9QVhT1p; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d74045c463so19587385ad.3;
        Tue, 30 Jan 2024 01:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706605995; x=1707210795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEGg3+Udn4gaw+4rcyLZgU170AVrEZ3wtyY0WMo5DU8=;
        b=c9QVhT1pxd3bmNmB+U+p5ubaGL890rEaeAjjis8At7XNsp8G0TWINd5Q8yJqIq41Ax
         ZJ+So/CC6okekogfM7pUojsI4zTfo1HdhX+/Aqjco8J+R8/8wtsSchJTbGOFCWJ5bO7g
         nbHWdKsFqynFe0GufW6TxtMjN0UVo5bTg1MRRMBjMsWAkhdjKWseU76QslUpEZKqFJmD
         7LDnIT2NoebWrwzQoHwGG3n6wp7/P5NUIwERTLM0AX/2vAOp5wDLuWXpRzGgKg75W5aB
         gr39b0ENOEBmCv7ft2NV0XwPqg/HxWdyjoDM9JVYSZopwWbzKHAzubMTEAS3/HW8yoBX
         M1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605995; x=1707210795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EEGg3+Udn4gaw+4rcyLZgU170AVrEZ3wtyY0WMo5DU8=;
        b=f0W4gItDM5eADHjjxevoL4ttJcoRO1ebsQ0IEwQ70ZsllGRN2TslwbfWtCblYBVvGk
         hS3nH3nNCh9bKZVJX7jCyCRoxtWEUQ6H3ZWOMuFprtz3i1itG1zTjFFDkMVvfpp7YqS6
         1U/QbxhU90GbhEmWz2lvjYuzjYM7K3lLl13BN9ZYZRGh+yfc6SKTrq5AF1ZeLqKz7cof
         rXdlmva6uqoqzi0WgY/ymRN9IzXJgQLK/B0eZUtresDFEJesyHjLjYOcz2/v35+NB3pw
         ZCfL371YYRAQ4Fan5gTYyXhjIcCaRAWa180A0fk6m34Ea4IuZafOdpMi0P9HRhogbmLP
         o8QA==
X-Gm-Message-State: AOJu0YwkU68C9MMZNMqlq/mM/ZEt94eAm4D6YR8b6mv51NggnnD4tCH/
	8oB4TWY7M/Cb8yb4PjX1sdh48h7kif6GV3wGTp76jNWP9cxdcotf
X-Google-Smtp-Source: AGHT+IEhz145k+wYMd2pt24Zls59HTCphqzKgGsC+jAC2Krgc2hYPa5ZJi9Znr/YRZnvFiEQHxAFow==
X-Received: by 2002:a17:902:9a0a:b0:1d8:b798:dfe3 with SMTP id v10-20020a1709029a0a00b001d8b798dfe3mr3573244plp.43.1706605995565;
        Tue, 30 Jan 2024 01:13:15 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id ki3-20020a170903068300b001d8e7db131fsm2895967plb.11.2024.01.30.01.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:13:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mpatocka@redhat.com
Cc: linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	msnitzer@redhat.com,
	ignat@cloudflare.com,
	damien.lemoal@wdc.com,
	bob.liu@oracle.com,
	houtao1@huawei.com,
	peterz@infradead.org,
	mingo@kernel.org,
	netdev@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 7/8] dm-crypt: Convert from tasklet to BH workqueue
Date: Mon, 29 Jan 2024 23:11:54 -1000
Message-ID: <20240130091300.2968534-8-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130091300.2968534-1-tj@kernel.org>
References: <20240130091300.2968534-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws. To
replace tasklets, BH workqueue support was recently added. A BH workqueue
behaves similarly to regular workqueues except that the queued work items
are executed in the BH context.

This patch converts dm-crypt from tasklet to BH workqueue.

Like a regular workqueue, a BH workqueue allows freeing the currently
executing work item. Converting from tasklet to BH workqueue removes the
need for deferring bio_endio() again to a work item, which was buggy anyway.

I tested this lightly with "--perf-no_read_workqueue
--perf-no_write_workqueue" + some code modifications, but would really
-appreciate if someone who knows the code base better could take a look.

Signed-off-by: Tejun Heo <tj@kernel.org>
Link: http://lkml.kernel.org/r/82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev
---
 drivers/md/dm-crypt.c | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 855b482cbff1..619c762d4072 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -73,11 +73,8 @@ struct dm_crypt_io {
 	struct bio *base_bio;
 	u8 *integrity_metadata;
 	bool integrity_metadata_from_pool:1;
-	bool in_tasklet:1;
 
 	struct work_struct work;
-	struct tasklet_struct tasklet;
-
 	struct convert_context ctx;
 
 	atomic_t io_pending;
@@ -1762,7 +1759,6 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
 	io->ctx.r.req = NULL;
 	io->integrity_metadata = NULL;
 	io->integrity_metadata_from_pool = false;
-	io->in_tasklet = false;
 	atomic_set(&io->io_pending, 0);
 }
 
@@ -1771,13 +1767,6 @@ static void crypt_inc_pending(struct dm_crypt_io *io)
 	atomic_inc(&io->io_pending);
 }
 
-static void kcryptd_io_bio_endio(struct work_struct *work)
-{
-	struct dm_crypt_io *io = container_of(work, struct dm_crypt_io, work);
-
-	bio_endio(io->base_bio);
-}
-
 /*
  * One of the bios was finished. Check for completion of
  * the whole request and correctly clean up the buffer.
@@ -1800,21 +1789,6 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 		kfree(io->integrity_metadata);
 
 	base_bio->bi_status = error;
-
-	/*
-	 * If we are running this function from our tasklet,
-	 * we can't call bio_endio() here, because it will call
-	 * clone_endio() from dm.c, which in turn will
-	 * free the current struct dm_crypt_io structure with
-	 * our tasklet. In this case we need to delay bio_endio()
-	 * execution to after the tasklet is done and dequeued.
-	 */
-	if (io->in_tasklet) {
-		INIT_WORK(&io->work, kcryptd_io_bio_endio);
-		queue_work(cc->io_queue, &io->work);
-		return;
-	}
-
 	bio_endio(base_bio);
 }
 
@@ -2246,11 +2220,6 @@ static void kcryptd_crypt(struct work_struct *work)
 		kcryptd_crypt_write_convert(io);
 }
 
-static void kcryptd_crypt_tasklet(unsigned long work)
-{
-	kcryptd_crypt((struct work_struct *)work);
-}
-
 static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
@@ -2263,9 +2232,8 @@ static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 		 * it is being executed with irqs disabled.
 		 */
 		if (in_hardirq() || irqs_disabled()) {
-			io->in_tasklet = true;
-			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
-			tasklet_schedule(&io->tasklet);
+			INIT_WORK(&io->work, kcryptd_crypt);
+			queue_work(system_bh_wq, &io->work);
 			return;
 		}
 
-- 
2.43.0


