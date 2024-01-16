Return-Path: <linux-kernel+bounces-27566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDBB82F24C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741DB1F24124
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D0F1CAA5;
	Tue, 16 Jan 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBgXbVQI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4F91CA8C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705421998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGenYj0c7lCcQP9RiIc1lnECi134uIaPUzH+TIc7bto=;
	b=YBgXbVQIHGN40zrb4fS+EZkFMqQHSigSSK2l1P3eP9/mWvXucyKT4QeoE4HPzYPJVNWAI+
	uaLuO7oDftVToqOK20FeHbAec7T+NA4Ut+RrnsorNBjT2knTMKAlsHF+r6vbsfnRxmSIwg
	D1bHtztkTB49/c9JfhDsJhdeZuAB8h4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-k752fPfFOJ2HbSqLvYfSng-1; Tue, 16 Jan 2024 11:19:56 -0500
X-MC-Unique: k752fPfFOJ2HbSqLvYfSng-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-429d02a63baso67020381cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705421996; x=1706026796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGenYj0c7lCcQP9RiIc1lnECi134uIaPUzH+TIc7bto=;
        b=SX/7tlWK+y8cZncZSwXDQMfN17KzY8d1viCEAhaTv2PnN+Qp98E0xqy1cwnSaBx1vA
         BIJPa5LeUcSu//9EzTnyrsYKn1e0PALZOhJ8pb6xGJXXQvvdZbYvW29MZd49JD0MmEDy
         Ya53FL+9wTv6n/3scFJHeUJQp5QvxlSl/BMV+MKt3Bzpf8WQ4WAeWkhUxHUokxpqK1wh
         fCPum+CFHMa2K7y2X6CSEceFRIaeG0H4zQqj3u+ILA4e9fb7/oKnGIU4j6++tgoJXZOQ
         YGzQAv8nv7vRh6+9FwEH1LhsWe/LeIYi5q/qls1nM71dFeKyxE26kZVtL7kY5oMnI9lo
         zSaw==
X-Gm-Message-State: AOJu0YyyQ5MMjTc6rXmgMa9+xqdkglYcqL7r47Xvr/OaMWXAe6USs17n
	tyDNATO1s7Czqgd5FOjxG5Z+U7WCYynU6LPRoN6TK43trbWLRPhEO3jlLcHey8n6bxJ22ncxGYl
	9BfWos1KqdqgvMWUHfyqPWuAi0GrlYPWv
X-Received: by 2002:ac8:5f4d:0:b0:429:c7ce:46a1 with SMTP id y13-20020ac85f4d000000b00429c7ce46a1mr10150572qta.119.1705421996379;
        Tue, 16 Jan 2024 08:19:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZpmEMBkevA76baoXYyTIPcDO+YN3y2uqC0AiAi4Ab7dR3JvcV2B+BgkzjR1VlXBtGw9M9sw==
X-Received: by 2002:ac8:5f4d:0:b0:429:c7ce:46a1 with SMTP id y13-20020ac85f4d000000b00429c7ce46a1mr10150561qta.119.1705421996127;
        Tue, 16 Jan 2024 08:19:56 -0800 (PST)
Received: from localhost.localdomain ([151.29.130.8])
        by smtp.gmail.com with ESMTPSA id fd10-20020a05622a4d0a00b00429d3257dd6sm3809166qtb.45.2024.01.16.08.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:19:55 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] kernel/workqueue: Bind rescuer to unbound cpumask for WQ_UNBOUND
Date: Tue, 16 Jan 2024 17:19:27 +0100
Message-ID: <20240116161929.232885-3-juri.lelli@redhat.com>
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

At the time they are created unbound workqueues rescuers currently use
cpu_possible_mask as their affinity, but this can be too wide in case a
workqueue unbound mask has been set as a subset of cpu_possible_mask.

Make new rescuers use their associated workqueue unbound cpumask from
the start.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/workqueue.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed8923..3a1d5a67bd66a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4652,7 +4652,10 @@ static int init_rescuer(struct workqueue_struct *wq)
 	}
 
 	wq->rescuer = rescuer;
-	kthread_bind_mask(rescuer->task, cpu_possible_mask);
+	if (wq->flags & WQ_UNBOUND)
+		kthread_bind_mask(rescuer->task, wq->unbound_attrs->cpumask);
+	else
+		kthread_bind_mask(rescuer->task, cpu_possible_mask);
 	wake_up_process(rescuer->task);
 
 	return 0;
-- 
2.43.0


