Return-Path: <linux-kernel+bounces-151897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202118AB579
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBFFB219EF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C05E13C905;
	Fri, 19 Apr 2024 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvsnn47s"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1E13C3F2;
	Fri, 19 Apr 2024 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554087; cv=none; b=sq0q72fBBHZjJtwi5emCTJfYiSjlWFqR2pp7eyYT9g4vVd//yzmXXHxnpXce7IojD+igE6rueaB6Ks/NO5dowytdD40FEUck9BKHB8yzJOg52eqXeY9CnnstNxITm4EQ34Fnm4MMVOl8st17kCv3X6+zyNjog9MQMBEq4FG1D2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554087; c=relaxed/simple;
	bh=0zQd6Z1nb61jyMOofmFcMVXaTEf+oph0Kg/rxSh8nuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FwZYzpMRar6280PPLHoEtFqvtA+xlBsKuUH7Vk19lhhzZDbHAa86QB960uOrWTOniK6FLdDzAJ8POx3OaXyZ5po8W6mBMgEVye9rsSYxbSp1kUo6pzUrloQRwEWU0f7lG1KZBLA9Ztci4lN1pXM987AWINRtRK3L8HWPmhLFzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bvsnn47s; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36b309dd33bso9957245ab.1;
        Fri, 19 Apr 2024 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713554085; x=1714158885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAPKT9XxoWrI/ZqTbx0y6wI55tS5z1hPfWNqmWG/4qc=;
        b=Bvsnn47sAteqmNL2/7l+4d0+M21CohZtd7ZxOSGm2YbThGRWz2JojskGlexebr5Cjq
         QTBn0Vs9IvY8HRQCaLmKliKyZdQdUUjDK6xCYPK4hNfN9owfRY32BtYcAZYq6eQgBj89
         7l6LtUJM6bK21+L+6TYkUFR+CnHm/zaSCzLyMt85Azu+NY1d08kc2FpcHEdpCiFiQES9
         ETgrVKUz5gizwrMjJ7NCUZYcY5cAj1BBWVajx0b+ZTwXy+RyKpDjIYkuEbUw7iARo05D
         CHY1jDOLOhh7W6ZyrPDgMrivBrQ4lG3mw4P2FTfqDhUGCoNP5ZsosKw6xPycKvISmUtD
         sigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713554085; x=1714158885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAPKT9XxoWrI/ZqTbx0y6wI55tS5z1hPfWNqmWG/4qc=;
        b=HzZZtrpQl/hN0TvTUe/sUJ8o4/7QJXj+t2kp0ZaWbWKX3S+EENMlC/pNckR0WIgXnI
         rDCSfSnzZHx+q2pevksSiUgPu8NwHOEAH6U+/RgTtwXAtBBZt/g0wFTmS/0XhpWwq3gF
         s2TYRfnfuA0Ft0BMaCl/2JFhIsAbuCYevsCVya0w5OKtZJC51j0pUODuUUQTW3LbuVj4
         KqiPHAO3S0NfZZn6Ja4e6J+NstmHFwPz6yjR07VhL0ds3v3vO4T+ehxYXbroaN7pfDpu
         Unmo739PuIFFIKMpsg6gZX+8af1Tqqp8iz8/TL+a2omo5QDpbZ9x3Id1SnU/L6SKUyOj
         dR7g==
X-Forwarded-Encrypted: i=1; AJvYcCUusW7D6DxxI8PrT44fc0JxbTfqZwrBuoJTCnqR+i2y/VGQJidx4mpF7jUAR5zoancG9/o5g6HF2Fnrlt36xmrBTJ0hSHCUn7AINF6jp8EBL4i9ny2oG92KNqSabq1YiSVw1A+RShfRncErU4eXcODkw/qB75jYSpnd/cmKPRy2Cg==
X-Gm-Message-State: AOJu0YxmnO2qqaNGDQsMD8+fAyARIUYTEJBkRiGGufmCvy+ofDulV4KY
	SzgqcH2X/mXYm7oIJQfCpfiwmPQS2ot38Mz9jC34zXKPecEoqGux
X-Google-Smtp-Source: AGHT+IE2fSuywdttgS08bx7aen4kWDQc2gtWFh+YU9mG7WcPz8tudbaDjYH0e/5+HCP45f045WGfdg==
X-Received: by 2002:a05:6e02:2169:b0:369:c0a3:2ad7 with SMTP id s9-20020a056e02216900b00369c0a32ad7mr4146859ilv.12.1713554085161;
        Fri, 19 Apr 2024 12:14:45 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id z25-20020a637e19000000b005f80aced5f3sm258846pgc.0.2024.04.19.12.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 12:14:44 -0700 (PDT)
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
Subject: [PATCH net,v3] net: hams: Fix deadlock caused by unsafe-irq lock in sp_get()
Date: Sat, 20 Apr 2024 04:14:38 +0900
Message-Id: <20240419191438.30724-1-aha310510@gmail.com>
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
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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

