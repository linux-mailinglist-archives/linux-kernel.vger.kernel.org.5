Return-Path: <linux-kernel+bounces-158010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D38B1A17
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA88D28397A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F2539FD8;
	Thu, 25 Apr 2024 05:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrFPrU8W"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47A38398
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714021200; cv=none; b=q3d0u87XDFFudz06bhzz2SBYjg6N9mWVmeQq8gNr/9tYrMkXaArwEXeUqxGF6msqPrfw5+YhMCqaJuN/BUwac1vdo14L8egnYoMM6xInqKbFLUt1UqDYRK38nU8YYO+deEyrnrBPmJXG+9BQnldERuZb58TLJotHKwQGUUtbQFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714021200; c=relaxed/simple;
	bh=/Idzeob/3VgiaD8N/eZMjeY2vkHnL1zemb4/6yGRVA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faN8H0sLNkv+kjinQXAjHEPvKnFXJof/n0IwViVN7NOiXqT+FF3Z2eh40vSIlZLPbI2G3EOfpqtIgDxpA23tmVcPPe3lkhDv534FZxsMdgOaST2FxkDIRKEWaR0054sVmE1Jj43TnxNWkkzIiDFUrbRRGVaFU2xbEQxb5Km/SDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrFPrU8W; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ee0642f718so1274577b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714021198; x=1714625998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPqD64kC179CYiaasLh/j7lz8sMbAVUurPZoGZX691U=;
        b=PrFPrU8Wl9DRUgP+DsmEg6BlfbzPmB8xfuyZxAK63updgjfy7iyh32pGhw2g/hb1hR
         ELoBwtiriCouccjue6YxzmIugzz4RW3us6umvDVg12iOvQM+gs1SCxwy8YlG67D3Q0SJ
         qiXhgN3lFDITgw8kGx1lrDK/eyXAQnYCRW6e/HPQVpAnol70oZhpvL738My/U5am16wk
         fy8aRsLHM0O5eiGdolumWVjaIDAxCzwSaebLUzGuKTMpNccgFI4xpBChPZv14pHsBzto
         D9sQY5slWazd1O91+TBjkV5CzF90KL2EeXVmux3EGooCFF03yAjr9IYb49WWsHwPkYfl
         MbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714021198; x=1714625998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPqD64kC179CYiaasLh/j7lz8sMbAVUurPZoGZX691U=;
        b=uSrXe5vdiSkKnFnDqQ6ACT1H2NwdJIja0R0dvqcITydjA4Kbv7cTPwUvtilG2fliqV
         zsdORH4iuMMSWUrEaG7qf1NTjBXcqJg2AmEqUxtJW6ajN1y3m8sMSvum2S/vYbvLZRHg
         wOsD19G7ANEf7jBQunvxHgj7+eMiKY2TXvujs4WuvKB4gCdZzuB4qsRTtHfMw4GtIbCn
         T7iraiXoF5X9J0iKJld1CY1/rlonDq55pi2VCNW09vY4ei6KnJMv1/ZFq2cs2VR2mgw7
         /D/CHXBp0wxBVyCljlIOGZ21laxsW0aLLYBIdZ3AZ5Uj9m+PGEOqBTlxt70g+rSFFswA
         vosg==
X-Gm-Message-State: AOJu0YxnQ2VIyWdV25O4qV4tc1syOJJcJ0e4SEqqeTmprnp+s+m/ei2h
	MJf80LWd6IXOlQBQVezotieR+iQTlukiSyAvbdC6Q6NtDVCYQdtNIhg8Iqei8HY=
X-Google-Smtp-Source: AGHT+IHRMb2o3vW7c223M+RfZSC4DS1dGnW7fRYIZ/r4b/rjzqjPMFQHjLRKYMXApqLT9UNpjp1j2w==
X-Received: by 2002:a05:6a20:d48f:b0:1a7:48de:b2a4 with SMTP id im15-20020a056a20d48f00b001a748deb2a4mr3321649pzb.6.1714021198031;
        Wed, 24 Apr 2024 21:59:58 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id j19-20020aa783d3000000b006eaf3fd91a1sm12314258pfn.62.2024.04.24.21.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 21:59:57 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diFree
Date: Thu, 25 Apr 2024 13:59:53 +0900
Message-Id: <20240425045953.6360-1-aha310510@gmail.com>
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
+	printk("dmMount : %d\n",bmp->db_agl2size);
 	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
 	    bmp->db_agl2size < 0) {
 		err = -EINVAL;
@@ -316,6 +317,7 @@ int dbSync(struct inode *ipbmap)
 	dbmp_le->dn_agwidth = cpu_to_le32(bmp->db_agwidth);
 	dbmp_le->dn_agstart = cpu_to_le32(bmp->db_agstart);
 	dbmp_le->dn_agl2size = cpu_to_le32(bmp->db_agl2size);
+	printk("dbSync : %d\n",bmp->db_agl2size);
 	for (i = 0; i < MAXAG; i++)
 		dbmp_le->dn_agfree[i] = cpu_to_le64(bmp->db_agfree[i]);
 	dbmp_le->dn_agsize = cpu_to_le64(bmp->db_agsize);
@@ -3393,7 +3395,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 
 	bmp->db_agl2size = l2agsize;
 	bmp->db_agsize = 1 << l2agsize;
-
+	printk("dbExtendFS : %d\n",bmp->db_agl2size);
 	/* compute new number of AG */
 	agno = bmp->db_numag;
 	bmp->db_numag = newsize >> l2agsize;
-- 
2.34.1

