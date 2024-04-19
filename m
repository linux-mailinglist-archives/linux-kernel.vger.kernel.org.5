Return-Path: <linux-kernel+bounces-151830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AE98AB484
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08095B218DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FF113B284;
	Fri, 19 Apr 2024 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEKH5txJ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80741386C0;
	Fri, 19 Apr 2024 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713548647; cv=none; b=HvVZFu44QLp80Osg8gifSV4gEX33hR7dRsHvgCwD+X6Vk3BfccVFYjWz5RWZnAr2oEktUjbhbaBojUjJKBdqwlDj+hHz0KweG5ISz4vuUKxJCtAnLMPVZSwneFGixKCHZWVn9+A1wRkDEF4nsl+6xGseo5+SzPKGQtCpdkFfkeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713548647; c=relaxed/simple;
	bh=85Ii+8WtZG4Na/S19N75HT4zm3QuIWPvSPHzheuGau4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BT1nYa0TrtRlq6KctoGk11i86L96FmXu0fectLb7/rjXpy/iyToXtD4dKcjMy0Ifb8UgdgfMG+mlR5YWV17Gr82RBKqqIJ5bxbyUaztngZhuEJ3Cr2jjC8vyqOOxoR2OgTaOxsljCo6yFuY84f1WFadHPAIZCLs2aivptRaZHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEKH5txJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso1251113b3a.2;
        Fri, 19 Apr 2024 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713548645; x=1714153445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYge8k8yiQNLUXp9tI3nUecGn5nWrAEYfDqzby5J/0Y=;
        b=FEKH5txJss8CPw5ZWRmwZF8z3UTWV/WTIy78QDtN8iu//7kDRD9+H+k65mMwnytCbY
         JhA4bofg9SgY+qPrKgKCfdz9xvymRXoHr2Pg4PqwDGIS6mpRZFgPnT8lxFqthwQQ+L1w
         758MHaDbM7uv14uiZWMMFGYCQWqloBKt6UR6DqukviTXmEbhhxLnWYL7YyTiWUTZYHuL
         UYtJyRDyvgY4RRpWBVZPJOj1qxuCQx/TvFLqod95v/PL1+CaPYAOb8mJ+R5GLRmOs5al
         YVk0U46XEoqkmC7dPUolR2sf4+3ApCj0ygwSIBHrZf5GZGi8sYBUY1gmBuCB8YTRDbUn
         YpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713548645; x=1714153445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYge8k8yiQNLUXp9tI3nUecGn5nWrAEYfDqzby5J/0Y=;
        b=jkdKOHJHNmU4jKFvkCoHsP1KBXiCsWaR8k4p7YdwhIgJ9StbTaYRClBgUyxiC7y7Fg
         5OXbC2aKDkM3s/SF3URbkhzE8wauf1GHowFMWcZIW8sZvJmkOZFCOi0hLPqrljbj/LgS
         Nv8JOXZy9EsnDQt3SoAS2NxOvWNzsgU/8JEaCmINFbsr/VuitzIgqEclbJ1YNCYmcBf1
         YAyUV/1f9/G7qM/rkdqgHu5gUzQbHeP4Ou7QK7QwAMWNdOIJTkk/vzcTrxGIKz+iKdAx
         U4pRd6Ah7EUWKq9TTy6ENIqyDCDmZLbbTtuo1YB1WkGU64/RPjLigDHFz4ZsfxIvjaes
         6Aog==
X-Forwarded-Encrypted: i=1; AJvYcCXWabY4uw6090c8Nnjz4JHH5pqiW6vvnlbd9znnUv90NMM11BMsZ0ISPi9S2ywbVR90ZRM6M/Nf1f60wukRPHRfpculXLwUAJJaFMRL9w2bbgWGg9dxW1wZCweKeMZvx6VylrcZ8Gdj1YMRqERNkwNsMMP3tkOA92EUhRCXEYyskg==
X-Gm-Message-State: AOJu0Yw78XJHlmnv9pZfKnjPp6QFUXvWjfplcID+sgYGkgCJ9simcq+e
	Mdq608+3Q2Evux6JCpHLiUYrIvLp7Qx+3WxI8eZbZva0KA/q1EA9
X-Google-Smtp-Source: AGHT+IFKGFRUI0+Gv23iQkL5gzsAanvmwGAZnj6jAcNoHux3oyFG9MjAtMJWpluphkxTU2lIlPl3Cg==
X-Received: by 2002:a05:6a00:3a1e:b0:6ed:5f66:602 with SMTP id fj30-20020a056a003a1e00b006ed5f660602mr3382726pfb.9.1713548644806;
        Fri, 19 Apr 2024 10:44:04 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id n56-20020a056a000d7800b006e6b7124b33sm3491511pfv.209.2024.04.19.10.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:44:04 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com
Cc: ajk@comnets.uni-bremen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] net: hams: Fix deadlock caused by unsafe-irq lock in sp_get()
Date: Sat, 20 Apr 2024 02:43:21 +0900
Message-Id: <20240419174319.28528-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000005e18f00615207de6@google.com>
References: <0000000000005e18f00615207de6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


read_lock() present in sp_get() is interrupt-vulnerable, so the function needs to be modified.


Reported-by: syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/hamradio/6pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 6ed38a3cdd73..fee583b1e59a 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -373,11 +373,11 @@ static struct sixpack *sp_get(struct tty_struct *tty)
 {
 	struct sixpack *sp;
 
-	read_lock(&disc_data_lock);
+	read_lock_irq(&disc_data_lock);
 	sp = tty->disc_data;
 	if (sp)
 		refcount_inc(&sp->refcnt);
-	read_unlock(&disc_data_lock);
+	read_unlock_irq(&disc_data_lock);
 
 	return sp;
 }
-- 
2.34.1

