Return-Path: <linux-kernel+bounces-122751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E588FC97
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927F1B25121
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0D57C0BF;
	Thu, 28 Mar 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="CHiHibRU"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DBD7C09F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620681; cv=none; b=b/TeTNOGbuIvRGbbXX9UEv+Bq2WqwfQAGADzDKEhlhTHlRolYDgabdEShbH3T08dpMnmai4hr9YuVD8tBgwBy56EPkpZ22yIxMaketo6Jh+FAIlln9PngdO00jyfyoXknyz4OeBb4dCP/UcRGJQvOSoJUtolVFTgrW8D2yMY+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620681; c=relaxed/simple;
	bh=C+OHzgMMTlkfKu9+9+LnzpQ2RCBLRn5U5X50rle8ZCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pCvkiyeBUhy40wmWj77clkWUsufDxQkB1W5+w7gWe4J5f0Kuxo4VwlQP0ef5Cx7yJ31pE3+U/NfLYpfIAki2RsYMnvmDFIsUbXbgK2KjpuSMxcSlTrNYE68p0a7Hl0hwlpWJSw1OcndWE3Io4aGqqOY2bBcPv82ctxH3lvpp5UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=CHiHibRU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41488f9708fso5249075e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711620678; x=1712225478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78gF2QTKafbwEQPCBNf5ByBjg43bvDB3DC82wT/Gr4c=;
        b=CHiHibRUPyi2So3KXPn+EHT76UaSE86oXP/ecqUvcFpSpziAzcrEsIMlkHPp96tIQ8
         ejZdIabCAjETn73xIYBUiUbSdm7lKDzekGW30sbXIZ941QjhAizjRPh5V0nUlHA/4tHa
         vOVMJ1rHD53DUOohe4aIw4AAwLq1O8cMJj4aKmp0Zo6YjeRp5DZxdAGT3H2BcZYc7NSe
         5WHG+JQ4YXxAIkOqEg26iaeP3xT2KsYA+4kyBrBbJZ2xT+GuVFiBKMbWQk2XFciRJExs
         Fc4E+lhLXM4Ysz27eeHHDezYFuf7L+kd6yRGy0UYa+Rq1l4/sSMowhy+fcaiO2uv2jzE
         iv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711620678; x=1712225478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78gF2QTKafbwEQPCBNf5ByBjg43bvDB3DC82wT/Gr4c=;
        b=KAPGGqk2vu7fZzSedBkLjub7MNuYIUdaGww/8k1zH7GSpI8W7DKqNDr3BT/0qgxwBt
         tQ3ekVHt5H/pdrWhMpf7e7Y47QUWcCEMwKhXYWUC9C1gIi6JfhpXkcB62co6Q+bZIrD7
         HJcINl4qYcYUmYb7Q7lp6/XhLKi6uO1iHhyeH/KXw/L3g1BvxR33veWk//+IE2kb1qj4
         47tdknXMHSlVeZ5RTSLErQXuUmh4i2DKoDYEFT2tS5dbfUP9I/5GF1PCVJ0FGLdrUmnl
         aod88ADj5+U/tvZfPZslw5OwU2GjVsin4RTKX+bk2sSGbAGvUbnFMYFNkNGqZ5ncesJZ
         /+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAjUhpFvl6hq/uwrbja3LSWC2YUOv40s+c4CUA4Zj7+KCUCyqOsd6RVfA/hOhWXqY1kTkBcjKLbGM+CTYKB9sqveTOBrpEnSc8KwqP
X-Gm-Message-State: AOJu0Yw+i2OelC5cDzme81M5kvXrSMBNMyBp+cW9Mu/hFRGTK//AtK3V
	+6CPMt22VozMFKUXh4LQQeqM4AeeNmTHN5r+PmETBzkkPTiU5AITj+dpZcqUSt8=
X-Google-Smtp-Source: AGHT+IGhJncJKuIMVHyrnNLH2MLnJ0743tdkIVvOCDryY1iQq/OA/D/cN2xrG7/OF93KfuEt+QwdRA==
X-Received: by 2002:a05:6000:1544:b0:33e:7333:d459 with SMTP id 4-20020a056000154400b0033e7333d459mr2328093wry.49.1711620678158;
        Thu, 28 Mar 2024 03:11:18 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id bt30-20020a056000081e00b0034183537986sm1364604wrb.23.2024.03.28.03.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 03:11:17 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] lockdep: Use str_plural() to fix Coccinelle warning
Date: Thu, 28 Mar 2024 11:09:54 +0100
Message-ID: <20240328100952.200379-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(depth)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..31d7720c9b8d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -786,7 +786,7 @@ static void lockdep_print_held_locks(struct task_struct *p)
 		printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
 	else
 		printk("%d lock%s held by %s/%d:\n", depth,
-		       depth > 1 ? "s" : "", p->comm, task_pid_nr(p));
+		       str_plural(depth), p->comm, task_pid_nr(p));
 	/*
 	 * It's not reliable to print a task's held locks if it's not sleeping
 	 * and it's not the current task.
-- 
2.44.0


