Return-Path: <linux-kernel+bounces-165124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26858B885C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33F81C23241
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35E2524D4;
	Wed,  1 May 2024 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF3cYT1z"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C0A3A1A2
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557986; cv=none; b=WGyxSszY6+XhM+iYDGwl3YE4a1+vF2daLSU/vVLFm81fq0mDZ2G6KKcmGCfdqspgd1K4iHDqSXyWh9oxFF6yATKiceMkwnlBXG5rAhiqFMt5NzDmM4wzysEUqOHvxoMm/VBVf/uUurSLw8zUpyOFGv5KOhh2I7iHkPdQQCXan/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557986; c=relaxed/simple;
	bh=yDBigECR8uRqx0iFvunrwK4XDnUZo3sk3xaYfpJBSN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o07VZX/texxHcbrgqzVx7bERwSYsKE7VjfvQsJ08ugbw8eu+kr9XxiFjvWzSHLodyBBKvLKBU+u7FJK8IfCGLvktIu0yiKPm3qh+Eg7DpcJdY18W9hRKcD00ej7ZWQErd/QDPF6klKn2ITERKKbVmopZOSx1O0v9pIXVhU1CrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF3cYT1z; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7dee0dfd57aso65519439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714557984; x=1715162784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZXj7eSXaYk4dnuJO+pveEloK4TRrLjEqP5dYE5AFqs=;
        b=kF3cYT1zjLN/EmYOIKNFOoanC9ITuuLDm06Y11o+9DENerzgswimcTasWo4kHEYdHN
         VQTs+0SPDeB6tD+IQYfOjoFwrYfgmtPIO7XB/Wj34SYgDPFts71RnLT8+8qvlze8IDdF
         r9aN1e8FGk4rwopXWTvyKajKt0bvb0vmhUuVjk7nzAdcUw1vRx4nAjB1sMmJiz4q+bvG
         RmyRUaWah8K/hUkV3LVH0PzFQpYHuziU+YslKFz9t/veH53qWtLesp6c0qKiQmjRFENg
         v0CbMOk4vmdg3vVUZjqj5cxfb5YhVc7t2C/1/vDksasdywhRHm7y/NGtcdLuZLevxv/B
         Sn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714557984; x=1715162784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZXj7eSXaYk4dnuJO+pveEloK4TRrLjEqP5dYE5AFqs=;
        b=ndkEtF7mZjKsvArO94LQSDk5IQ31bWkeB6zy8Xp0zgJm8XsOiafBo5ERnjLEF0PYw2
         e3OUXT90NVXvnbM0nLdSjhgLW0ZajVhm5vtakMos47GTgmgiTEV/8RlQTQbaXzYsP732
         i0MPTFq+KREVH9KEfRovUFfsRtfZoueV73PjNwNENAan4QwU1SIJg3B4BKM+0GyPCcWX
         +GfHd5LUjxp5avk1GLZpO1WGEY82GSRYR9CvZFnWsLY9wTygn4rp7ygvEo4YG7Ou1fmk
         aOLKxE2H2nE940BOEEBRRGMn5kPffGOgIMRhh5+inLIfcDnU/oCBorbcbDbisFsvhynr
         4afw==
X-Forwarded-Encrypted: i=1; AJvYcCU6gnOVLqunILmB00xZa8Oubiktvel0/2Q417PF36hVB2+JkP1+9ILW05oQ0ueWmlC6JPHbNTPtq09yAP8dUgh7Z74lBPObk7AADgOP
X-Gm-Message-State: AOJu0Yz6vQr/RQUrbSpWDfk2YVxjcXfrfQ5R2q5VQbDne7vaubKwLrP4
	wDrAu9nF18quoazE4cEJiA4H6UlvtuYUck/ZUqK+Uvq8vqgfhOj1
X-Google-Smtp-Source: AGHT+IGz3sbaWmwjulc7e9dH0JVoaE5oOGqhdC7ibfj8fH/kLwaWmYw78sJP+BwnveLNdrhWz4WE8A==
X-Received: by 2002:a05:6602:13d5:b0:7d5:e089:fb97 with SMTP id o21-20020a05660213d500b007d5e089fb97mr3216788iov.19.1714557983792;
        Wed, 01 May 2024 03:06:23 -0700 (PDT)
Received: from localhost (fwdproxy-nao-011.fbsv.net. [2a03:2880:23ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id du12-20020a056638604c00b00482b2dc023esm8523357jab.18.2024.05.01.03.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 03:06:23 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] selftests: cgroup: remove redundant addition of memory controller
Date: Wed,  1 May 2024 11:06:20 +0100
Message-ID: <20240501100620.1461685-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is already done in main.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index fe0e7221525c..22cf586d2438 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -445,8 +445,6 @@ static int test_no_kmem_bypass(const char *root)
 	trigger_allocation_size = sys_info.totalram / 20;
 
 	/* Set up test memcg */
-	if (cg_write(root, "cgroup.subtree_control", "+memory"))
-		goto out;
 	test_group = cg_name(root, "kmem_bypass_test");
 	if (!test_group)
 		goto out;
-- 
2.43.0


