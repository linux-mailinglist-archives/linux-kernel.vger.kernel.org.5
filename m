Return-Path: <linux-kernel+bounces-58895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7BD84EE3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F400B21851
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E7D568A;
	Fri,  9 Feb 2024 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdUYUC0E"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4745673
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707437660; cv=none; b=O7LIJLfs+Y6CKlN9BnM2JqgmPKTntuVvi78sD2ZwptxPUK2YgumIszK7V9FPjuYaDjPMpPVsakJjH3414DLl1X8HYDZuWg0lL04PGdcC4eASlYPjZSe4TtDtjDZCBRIg3qFRQ6q18JnXErg8EgW3aWnhvjKQWQcl/minW9DOJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707437660; c=relaxed/simple;
	bh=2MO5ems9wmxxF4Q2y59hV3zfphUYzla6prAAb/Rg5js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ7fwf7aO+xjeYR+7EmvhAOR0UuF90OC94t3m7piPTpFQ2eeR3sfejcPnjg1YqpZLx9MzQpjWEOjUVeSSiXJIEKDrSt2mUcOVmuzSEA86AQvQMYmdpwqZfSl4t/WZgNTi3ELqigIREfRGXCkukOiDdQXM2S1mGpBt+vRK+S8nbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdUYUC0E; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso10679185ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 16:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707437658; x=1708042458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnfYxv6e7qTli+BXi1Z+qdjTd9GL+skcxMsHzG17xFo=;
        b=SdUYUC0EYE9eCVx2tx8YRuHzMy9b1XR11aLlhMnCV/OwY8zoBcFPj/6ejNqQUvik7v
         yDRkhRjuHiata8sGtsbxaPURgvh0N0tPwLSKxuwPZbzo1sKCtZBHgVo/r2wUZCC5dbGM
         WqLwbeo9OL6KBWLel8LBvb27HbFjsUeHugIy+LzmVv+KtBRA4wGan6YXGCQ6SLsIzU0n
         CD7JuaKNrLxM7DU77bvygoP8DgfAK/uA7tzqneIP/c3g9y0Q5IZNMPCR/ut2GB1qTkoX
         IbVUFdLtEkdYYcn7H5+4PHEUlwSMVkcCOV/zaK+q601XeEFgW74ZxLRbUBUzX+DLKuKY
         RpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707437658; x=1708042458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnfYxv6e7qTli+BXi1Z+qdjTd9GL+skcxMsHzG17xFo=;
        b=M6Zy8ttgvoj8sIQEJgBJr3JpzwtqvB3ydjTBxQUEYgvcJCZMZIHhwAbZdAORNkVUwl
         4qKh1TISwK/XFsNEwHa8H7VkN+diFG3GCmWGKwHsXo2op3wTLF/dkH51NJXAf4qeVA8r
         Xx4DlS4vRuKn2QN3YoLMEuGWxvxlTOENpOOy1W45/1uyYp/S3StAjf5Zt0nuUtwBw6sT
         oM+4zhEaFyg5PCnYKgNPWNGviq6yo35qtAcRzzYvOxHq5MmB2htgQJd4hS3X+mUPk1Az
         27SXvYMFbW2nfBZFzw/Hc2iZ2X7PyuWp+icjo3Cqu5sSd+iaDjhccqLFt+pEtfDBXjzM
         cLxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg/r1OST5U26aAlGRW+/34aNzaZW4De84b2tE8Tf6Zb873r3S+2t7sHpvC7M/raesmYLIOhJtXM6VhxX8qDcbd7aSnbYtIPshipMti
X-Gm-Message-State: AOJu0YzzFfbAkBIlMyUZzgvmNTGTCNPEBaPYoO9BXAIbAozVdgip1WTg
	PR3iu3jiSseKMFeSPSTBh243XzIIxPAnxLtUIqchUmYIC+m04pDb
X-Google-Smtp-Source: AGHT+IEdYXZqEdDj9oeC0DLZoZCOJo1uDWcUM2LAIlvzqPpnKH//Ig9GUTedAWD1Jsg66SczPrl1Ag==
X-Received: by 2002:a17:902:e5c3:b0:1d9:aa5d:a54 with SMTP id u3-20020a170902e5c300b001d9aa5d0a54mr1810769plf.32.1707437658135;
        Thu, 08 Feb 2024 16:14:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUm/tl70d+wNfM0y2qWN9wYaDXrucVK6WJwWQ7kjztJnir4PaLrk3j8VZ0SU9WEPSwcSAVkutgHc7GM25WV2CLJsCWZnXfJ29t2Nn/4to58NehB28ujjAjB+Hn8t0NwDFBnwYWFVrEGtZ9GXZdlO3cxs9x2bPd5
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id mp6-20020a170902fd0600b001d5f1005096sm351403plb.55.2024.02.08.16.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 16:14:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2024 14:14:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 2/2 wq/for-6.9] async: Use a dedicated unbound workqueue with
 raised min_active
Message-ID: <ZcVuWLKN8OHRQuRx@slm.duckdns.org>
References: <ZcVtzJvJCRV5OLM-@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcVtzJvJCRV5OLM-@slm.duckdns.org>

Async can schedule a number of interdependent work items. However, since
5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for
unbound workqueues"), unbound workqueues have separate min_active which sets
the number of interdependent work items that can be handled. This default
value is 8 which isn't sufficient for async and can lead to stalls during
resume from suspend in some cases.

Let's use a dedicated unbound workqueue with raised min_active.

Signed-off-by: Tejun Heo <tj@kernel.org>
Link: http://lkml.kernel.org/r/708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
---
Hello,

Marek, can you please see whether this solves the hang while resuming? If it
does and Rafael is okay with it, I'll route this patch through wq/for-6.9.

Thanks.

 include/linux/async.h |    1 +
 init/main.c           |    1 +
 kernel/async.c        |   17 ++++++++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

--- a/include/linux/async.h
+++ b/include/linux/async.h
@@ -120,4 +120,5 @@ extern void async_synchronize_cookie(asy
 extern void async_synchronize_cookie_domain(async_cookie_t cookie,
 					    struct async_domain *domain);
 extern bool current_is_async(void);
+extern void async_init(void);
 #endif
--- a/init/main.c
+++ b/init/main.c
@@ -1545,6 +1545,7 @@ static noinline void __init kernel_init_
 	sched_init_smp();
 
 	workqueue_init_topology();
+	async_init();
 	padata_init();
 	page_alloc_init_late();
 
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -64,6 +64,7 @@ static async_cookie_t next_cookie = 1;
 static LIST_HEAD(async_global_pending);	/* pending from all registered doms */
 static ASYNC_DOMAIN(async_dfl_domain);
 static DEFINE_SPINLOCK(async_lock);
+static struct workqueue_struct *async_wq;
 
 struct async_entry {
 	struct list_head	domain_list;
@@ -174,7 +175,7 @@ static async_cookie_t __async_schedule_n
 	spin_unlock_irqrestore(&async_lock, flags);
 
 	/* schedule for execution */
-	queue_work_node(node, system_unbound_wq, &entry->work);
+	queue_work_node(node, async_wq, &entry->work);
 
 	return newcookie;
 }
@@ -345,3 +346,17 @@ bool current_is_async(void)
 	return worker && worker->current_func == async_run_entry_fn;
 }
 EXPORT_SYMBOL_GPL(current_is_async);
+
+void __init async_init(void)
+{
+	/*
+	 * Async can schedule a number of interdependent work items. However,
+	 * unbound workqueues can handle only upto min_active interdependent
+	 * work items. The default min_active of 8 isn't sufficient for async
+	 * and can lead to stalls. Let's use a dedicated workqueue with raised
+	 * min_active.
+	 */
+	async_wq = alloc_workqueue("async", WQ_UNBOUND, 0);
+	BUG_ON(!async_wq);
+	workqueue_set_min_active(async_wq, WQ_DFL_ACTIVE);
+}

