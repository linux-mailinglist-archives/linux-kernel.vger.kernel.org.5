Return-Path: <linux-kernel+bounces-157958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 753678B194E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287CF1F23124
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2D51C6B9;
	Thu, 25 Apr 2024 03:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuzZu7Sc"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B8F513
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014964; cv=none; b=qs3oD3n555tc/CaOFzTWM1JOW0RDNW6mLdNsTUusNLHfy9b5VsTpOQSuiEPCDaAIArX2Lob90xX6feBeB4I0SQEOIeAm+WSDW/m3EeWm6/jTfU/EcKjpO3PisTzsMiZ5x3dl4HxQe/h9LxU2Rc0AcZIdG19c4kYGc3Y45GptrZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014964; c=relaxed/simple;
	bh=UHDcHhg2SVBsQ5unx72cY0vVFjQtl+lWV7o9LLkDLu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqBiSTGCYRQ+kcStB8fN56EuRFv90xuKTA8LymEnp/HwvU1A7bR1BdqO6zreIkTLJ2PAXcy096q0SXT6NXXiV6q7c+EMtr76ecxHr7RGrGkvBNsU8RFm2njEj0FzXhRnx/rsI+nt3Nl7pW5jQxuXUSVzfyEeP1K08fGTDcww32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuzZu7Sc; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c66b093b86so1256913a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714014963; x=1714619763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Q1Itnlmg8Ted0k+oi1/NBrIkOL2DiHn2J/5DR1ybvM=;
        b=KuzZu7SczdzFVqGAdEjKzyAELi6g33S+4oIUmVjkCfgLGjSOQiNgKRY6ehQMa8+dKk
         UXmEp7cpS8BUBpFz3L7XoyA38ZrzDpCPG5A7ij7tCZREuWBENDhQdR1lF71TP/DPXz1f
         a70D/TnVud8PR3j67eTeV/c55eus2aNHG2rfWOGajz7rzC8vlyqwIpgcs3EPmdjig9rt
         LU/aOeyLiCjMkmM4hfHFgkm9Wk7I5H2fpULRwqtqv2bwztKoyGd955T4YFXz2S3uDt00
         qPJQleOKqVESUhaFa0/BOqJ2HD4LCefKvHgX2YYUgsBpvV5HRat7XCjRe+k7QUpueds8
         QsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014963; x=1714619763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Q1Itnlmg8Ted0k+oi1/NBrIkOL2DiHn2J/5DR1ybvM=;
        b=d4irJneRTltdJGQG9APhlUcnxMsCTXSV4w2G/7vVbojriv83cIgEwsHYTqgP024tJ/
         QaBker9HgeFb4GBTtUixsbHV+Y95OnglwPH6UgrMmoqz3Vb53hhkAq+n7NOif4YUAD0F
         Uve/8pr3YO4j7RuevXt8f0KvXbPeyaskfi7sLISU8zCQKio4JgUF4nBO5zkZnNroLBLq
         Z5DidnmXc5ZmRp0lloHQ3CulNqYKQX37OhwGZ6IugHoLLyIc1v6M7/wIDA4rQYLdb3z2
         O5s3rqDsZjn2qa56VGzcgLfS/NocJWgjGFqzBXT4FIS8TTSQYcCuITAJUd4NQbtnUEKS
         9e3g==
X-Gm-Message-State: AOJu0YwXs6hbgYl05hHFh3fLU81DXOFSSrAuRL0F5yNuyIdZe6euRUzW
	aDZx/zrFvJ/hS7KSyQUGLpzUdxi4Z/k+5FFrH8l9bPg3JP4PZ+j8zyZaQR0LJH8=
X-Google-Smtp-Source: AGHT+IGe3ovjFBruF0blZy2Fd4eNgPm9f9jSAj/9qlNJ9vt6+lGlcGjQvYUiiB0xbPRtSFYhA03A2w==
X-Received: by 2002:a17:90a:17a5:b0:29b:fb23:863e with SMTP id q34-20020a17090a17a500b0029bfb23863emr2326730pja.17.1714014962515;
        Wed, 24 Apr 2024 20:16:02 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090a668e00b002a6e67e197dsm11926206pjj.45.2024.04.24.20.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 20:16:02 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diFree
Date: Thu, 25 Apr 2024 12:15:58 +0900
Message-Id: <20240425031558.6181-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000000866ea0616cb082c@google.com>
References: <0000000000000866ea0616cb082c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test array-index-out-of-bounds in diFree

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master

---
 fs/jfs/jfs_dmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..773b9263e497 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -206,6 +206,7 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
+	printk(KERN_DEBUG "dmMount : %d\n",bmp->db_agl2size);
 	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
 	    bmp->db_agl2size < 0) {
 		err = -EINVAL;
@@ -316,6 +317,7 @@ int dbSync(struct inode *ipbmap)
 	dbmp_le->dn_agwidth = cpu_to_le32(bmp->db_agwidth);
 	dbmp_le->dn_agstart = cpu_to_le32(bmp->db_agstart);
 	dbmp_le->dn_agl2size = cpu_to_le32(bmp->db_agl2size);
+	printk(KERN_DEBUG "dbSync : %d\n",bmp->db_agl2size);
 	for (i = 0; i < MAXAG; i++)
 		dbmp_le->dn_agfree[i] = cpu_to_le64(bmp->db_agfree[i]);
 	dbmp_le->dn_agsize = cpu_to_le64(bmp->db_agsize);
@@ -3393,7 +3395,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 
 	bmp->db_agl2size = l2agsize;
 	bmp->db_agsize = 1 << l2agsize;
-
+	printk(KERN_DEBUG "dbExtendFS : %d\n",bmp->db_agl2size);
 	/* compute new number of AG */
 	agno = bmp->db_numag;
 	bmp->db_numag = newsize >> l2agsize;
-- 
2.34.1

