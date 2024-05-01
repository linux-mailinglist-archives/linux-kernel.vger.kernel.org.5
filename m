Return-Path: <linux-kernel+bounces-165725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E68B903F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE4A2832D8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709CB16133C;
	Wed,  1 May 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDI21BXC"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEFF14A8B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593081; cv=none; b=m2tSayatnk0bsfsa1/V9KAa/i4wf5xT2qi3HoLFT/SJR1W/8+uG1NeC5Mqx+d117lDmamYGuuPiStRmYykEh/LiSaH4evjJ7UmADiNIUZ2f9nbgyKqniFbG6ngHDShqRQEBEoUc2B3JRYvmNoHa8eZtWG4mt6pnJqcRkifIGpaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593081; c=relaxed/simple;
	bh=GkObCUITKdr9RhCq2jDAsceModZcdkprHTA7AZ6PtSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Si13nKNrFoEjcfDvhcsmR4w47xJysHYZTbLRulfy+BnzXIDCiAa1zQ75A+S2LWWw02R6I/0I8i7hhGg3tu57QXz5zrGUcCYM3pE5i2TNVbpbQFduhbH+pL+atO5QZcyqaavN+3CpA6mQjzEHer+olPRi6Og/5kOfEmAOUwWbDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDI21BXC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-349545c3eb8so4622805f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714593078; x=1715197878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RGgVA0uaJ+u00171aAWEQYeSgT0x3gMmjEz5WTHpZk=;
        b=XDI21BXCCehlyaG6T+Juiv9zWPdXbjmPVjafboCggEcF/vDBlc1R+W/6ShtrfIUJNY
         xrxZjIDsm8h45IDzabQLQgXBu6gdJQkif75RE3EK1vz5xDoOUaGRMzYiSiQkn7Ipunq0
         7DuFHbgiVUlK44Ekj1w/FZSqjBY0FYKfK3HuDhREO1lEghP/Ie2jteTIw5X8z1iCiu/F
         qhRJSF/YecCORYVMnnTZjWNtIM/e47KnmK7TK8LWm9pBt8LcykyYpeeAGpa3h9boe1Ru
         2MW7TDte1HGgH8aJePv5D5s8Yh18iefGx7ax3EYY+ul6wudAJmMk7SIfDZOVeFgDLwWs
         blJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714593078; x=1715197878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RGgVA0uaJ+u00171aAWEQYeSgT0x3gMmjEz5WTHpZk=;
        b=M1iGwaLGGK14N22uKDFZx/DKVyNNTaIVkJXz7OzgdUqNLgRt6BO7oRoc/ZYbiYldP3
         P+ojJKV78QUoRNEjcg8CO/VyfEO8Hpn901oGcHEQIeQGLr7o60/RZpQuzOJopONrqMaA
         p4jLZhTDzkMyThdubU/ibfc9Mg1Wr9N80QND8fZAQ6hhZiM3OiuftD/KB/E5LERwg5Ye
         qtsBkM/rI8mwbnQdPaGk+xls6Eh35eq4dl8ZTNbMptX2bSXdbvky8L0FrB9KTm7M7DMO
         0w6JRGVPRj7CijygKXISnfzXZVXbQ8AWtmjMRXn/aoxALMyPTGJlG7SqN6+s1VWB+ive
         cTeg==
X-Gm-Message-State: AOJu0YzRKkLcgZKD7jBB3naR/nQ2L+Z6dpiZ36xR+GoIuny1bUunJfRD
	DZo+B6b0QzMxbxZidCPrxJsYWmsSxnjcWPVBkuPlGVmwL9Muw9/m
X-Google-Smtp-Source: AGHT+IGVdUPn4F5Eo3DjG1sC4XVT/3I3Y2RIqyUpMPBSwKUZGcBAcVWFHzcYKgdzZ01xwkNWSAnGZw==
X-Received: by 2002:adf:ef08:0:b0:346:47d6:5d17 with SMTP id e8-20020adfef08000000b0034647d65d17mr2704258wro.57.1714593078343;
        Wed, 01 May 2024 12:51:18 -0700 (PDT)
Received: from localhost.localdomain (host86-151-98-16.range86-151.btcentralplus.com. [86.151.98.16])
        by smtp.gmail.com with ESMTPSA id h15-20020adfe98f000000b0034c926ef66csm315045wrm.51.2024.05.01.12.51.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 May 2024 12:51:17 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] time/timgr: Fix wrong reference when level 0 group allocation failed
Date: Wed,  1 May 2024 20:51:16 +0100
Message-ID: <20240501195116.62669-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tmigr_setup_groups() failed level 0 group allocation,
next do while loop refers wrong local stack array location.

Changing group init do while loop with while loop to fix this problem.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 kernel/time/timer_migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index ccba875d2234..84413114db5c 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1596,7 +1596,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 	} while (i < tmigr_hierarchy_levels);
 
-	do {
+	while (i > 0) {
 		group = stack[--i];
 
 		if (err < 0) {
@@ -1645,7 +1645,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 				tmigr_connect_child_parent(child, group);
 			}
 		}
-	} while (i > 0);
+	}
 
 	kfree(stack);
 
-- 
2.41.0


