Return-Path: <linux-kernel+bounces-27568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 790E382F24E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280E8286C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436AB1CD10;
	Tue, 16 Jan 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKfwZdun"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF71CA80
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705422004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3OclCH75wBgs4Z0eklBI2HCm5hzhoXh5DbDkEBHEUI=;
	b=eKfwZdunjp2UEWBqVtYha196XToso2VFxyVuB1K9aj/4bOGUpZWWLDR/NQxrwzxQez368X
	2AiSRKHcXcCU399qEao2OTYa0RH5O4hVe0y7T8tOzbbF8gVOgKjrhxDQQAvigYWtQd22Ij
	EsbMyIqYFJj9r6cSdB0CEaaSV8GNXHU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-TsjjLbXOPBy1GrlyOYlZMQ-1; Tue, 16 Jan 2024 11:19:58 -0500
X-MC-Unique: TsjjLbXOPBy1GrlyOYlZMQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bd3b54e5c6so12445923b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705421994; x=1706026794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3OclCH75wBgs4Z0eklBI2HCm5hzhoXh5DbDkEBHEUI=;
        b=OunUfUUc596HfqEz9VZ148bjXWhq7QP4sFOZQ7xE/ydxFs8BGc8R7zFlKJVAi+3lDz
         bkgcdJ2u+Bozpjn/724Qb/Gs5RjDiiQuefBxxhsxl+UfbsbFN8mGVD8DmsYTcpXmw3C3
         jmy4uxQgoZRBf5wywqTSQvhWzPOWOKHIGqZBFG4O4v2EFsdPm3m8ytolClMMG2lLSXPo
         12FVkQhPZQuoIQBO4pUOCDtAMlYKXiRPeicdhEPc2Zklk9QzkiZvRCMMA6cQgoVYPhqF
         +BQtvks+9IwwwYgyC5ipYbozzFCnoihf6opRJI6pUsmX+YnTbyhuvzBOUger5EWOUB1O
         furQ==
X-Gm-Message-State: AOJu0YzbeJ+WZweYUaaiVYwV3WgMsl1mX1ZD5W6lEY92SgrVPuLXvPMc
	/UQhblGFmucwhWPb9rIbYVy0E51+vJHONiP7ErTJjsGo27gv5ULZzRWwoEJ2yiu8SNK36Wl7egu
	JuyXhHB8BoW3eLBTWPONwvkWIkRizVMxS
X-Received: by 2002:a05:6808:1a27:b0:3bc:3c49:19fd with SMTP id bk39-20020a0568081a2700b003bc3c4919fdmr9036112oib.66.1705421994698;
        Tue, 16 Jan 2024 08:19:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb3HukQl0gtK8Ztj7AXZUouxmpte7RsJYePK7/jXxYFAit9YmTaDaI5eMMzQ1huWoKywCFqA==
X-Received: by 2002:a05:6808:1a27:b0:3bc:3c49:19fd with SMTP id bk39-20020a0568081a2700b003bc3c4919fdmr9036103oib.66.1705421994466;
        Tue, 16 Jan 2024 08:19:54 -0800 (PST)
Received: from localhost.localdomain ([151.29.130.8])
        by smtp.gmail.com with ESMTPSA id fd10-20020a05622a4d0a00b00429d3257dd6sm3809166qtb.45.2024.01.16.08.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:19:54 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] tools/workqueue: Add rescuers printing to wq_dump.py
Date: Tue, 16 Jan 2024 17:19:26 +0100
Message-ID: <20240116161929.232885-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116161929.232885-1-juri.lelli@redhat.com>
References: <20240116161929.232885-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Retrieving rescuers information (e.g., affinity and name) is quite
useful when debugging workqueues configurations.

Add printing of such information to the existing wq_dump.py script.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 tools/workqueue/wq_dump.py | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index d0df5833f2c18..6da621989e210 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -175,3 +175,32 @@ for wq in list_for_each_entry('struct workqueue_struct', workqueues.address_of_(
     if wq.flags & WQ_UNBOUND:
         print(f' {wq.dfl_pwq.pool.id.value_():{max_pool_id_len}}', end='')
     print('')
+
+print('')
+print('Workqueue -> rescuer')
+print('=====================')
+print(f'wq_unbound_cpumask={cpumask_str(wq_unbound_cpumask)}')
+print('')
+print('[    workqueue     \     type            unbound_cpumask     rescuer                  pid   cpumask]')
+
+for wq in list_for_each_entry('struct workqueue_struct', workqueues.address_of_(), 'list'):
+    print(f'{wq.name.string_().decode()[-24:]:24}', end='')
+    if wq.flags & WQ_UNBOUND:
+        if wq.flags & WQ_ORDERED:
+            print(' ordered   ', end='')
+        else:
+            print(' unbound', end='')
+            if wq.unbound_attrs.affn_strict:
+                print(',S ', end='')
+            else:
+                print('   ', end='')
+        print(f' {cpumask_str(wq.unbound_attrs.cpumask):24}', end='')
+    else:
+        print(' percpu    ', end='')
+        print('                         ', end='')
+
+    if wq.flags & WQ_MEM_RECLAIM:
+        print(f' {wq.rescuer.task.comm.string_().decode()[-24:]:24}', end='')
+        print(f' {wq.rescuer.task.pid.value_():5}', end='')
+        print(f' {cpumask_str(wq.rescuer.task.cpus_ptr)}', end='')
+    print('')
-- 
2.43.0


