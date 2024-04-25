Return-Path: <linux-kernel+bounces-158222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB58B1D29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18B81F218E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DDE80611;
	Thu, 25 Apr 2024 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0LrOlYX"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F21DFE1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035420; cv=none; b=C5UHj9UpEhNKIXSV7f+BIYG/JXkb6puDCSCVxnbOzCaLmI/M0faLtmYpYk6kVMrVvH1Lu5eKEUMSE2Zx+qdpi35672DmqEhmT9+S8ATGPfkGKdHf+ULM34+sh9sq0EbKaw/Y2WuNVR5Nifllg84X19Q8yor4F3k0ujz3M/mJCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035420; c=relaxed/simple;
	bh=on8rRT8rMY6gATS+tExFOpawaAVnjFYUdZ/CCHFPpGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XDWe4g20DESWdM27zs3VTaEBzhx8THo9cd0AE+DkuDNVDSnzfkZnWs2nGSF86V3FWCnIF+AoLq2qGv/2rwIcHzvXydP2u3SU+YFDc1iQwxwb/gfHkCMalukdvQZBDgeof0bERvOtVDLhWL+nXfn2/7TRQwMVaP//jH1NCQhdYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0LrOlYX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3ff14f249so5895085ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714035418; x=1714640218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHSLuFLizRd4+tmfCItUcblIOCsQpklxapzLMa2vQ8U=;
        b=Q0LrOlYXdnaambgXodGjz65mpcf21CzXCy4kjrD09vxSUxWSf6uCDYb+GtvgBew/oo
         c5sa37iQUBkvs4+WlVJ+l7OY8cVLZniPyasEoUfwMwxoPLMcfzwu6hX5JEEwqCQpWbWQ
         gCQ3mdc9KfpRsZqLb9wRga0jdAUKEM8NVrzSSiBRnUzscx/H4aPf230zYJIgbmDGx2GT
         ChGohaIE+a5TbFpdG7y3WI/Nk2NUhQgsMJIM+0JUiHaOtRxlm3f+mrVri2AQ20xq7zgn
         dsgBclrQf3QGsD/hz2xu4dHEcK01Q+Rkqf0pgNXZrlVQwm7OK+26vtm0XXjuqXxMd2M7
         ZmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714035418; x=1714640218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHSLuFLizRd4+tmfCItUcblIOCsQpklxapzLMa2vQ8U=;
        b=ezcesHXSGVmJtgA+Moi9VIcWu6Qiepim9oDUeUSBwhCq4I0VfnVjwC+Gi1oAgib8D0
         7frQekvQcdmDFIpTF+XGHELiTNndwgocUHP8aTyAp5SAUwljvs93OOrnddruVnrV9Elc
         sowk5U72B+39gydJoxvhc8GsL20ukSi96WXp+1vOVAYL0RBYmHRIZaxUVctuyXqD2iix
         09SmSZEgL3uaNJ34iFpqIpV9B0HZq3aLy7NxB5Z6AI7aurEYADIQ0wRzYpoeB8vcxM9G
         c3QrdEiabM0D7CjDk8Kt+EuhKUEKjjRCmq4EWthoHi/KYmqHrhl3M0x/aZ0Ppz+IxOl0
         ujPg==
X-Gm-Message-State: AOJu0YzjwhnlhwLhqs4fNRCuAauZipt2s1bF2Lhbo0sG1P3hPAeSVzuL
	IEfSyDG1HPr58JSyrkJ3qrusnwQycQPsGShkehEdkN5j6Kw25dnf/2KqvVxkfCQ=
X-Google-Smtp-Source: AGHT+IGFDPYxnNqVb0uxeIDsq0YU6Hv8MVh/1e7FD1DD6Xdu7piImLiN2dc6hRRTJ4XpQ0f9IhN88w==
X-Received: by 2002:a17:902:f945:b0:1e0:bc64:a37a with SMTP id kx5-20020a170902f94500b001e0bc64a37amr2398111plb.8.1714035417912;
        Thu, 25 Apr 2024 01:56:57 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id s27-20020a63525b000000b006008ee7e805sm6309811pgl.30.2024.04.25.01.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 01:56:57 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diFree
Date: Thu, 25 Apr 2024 17:56:54 +0900
Message-Id: <20240425085654.10967-1-aha310510@gmail.com>
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
 fs/jfs/jfs_imap.c | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..6681a6272ae7 100644
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
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 2ec35889ad24..c39f7685aa97 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -339,7 +339,7 @@ int diRead(struct inode *ip)
 
 	/* get the ag for the iag */
 	agstart = le64_to_cpu(iagp->agstart);
-
+	printk("diRead : %ld\n",agstart);
 	release_metapage(mp);
 
 	rel_inode = (ino & (INOSPERPAGE - 1));
@@ -881,6 +881,8 @@ int diFree(struct inode *ip)
 	 */
 	agno = BLKTOAG(JFS_IP(ip)->agstart, JFS_SBI(ip->i_sb));
 
+	printk("%lu %d %d",JFS_IP(ip)->agstart, JFS_SBI(ip->i_sb)->bmap->db_agl2size, agno);
+
 	/* Lock the AG specific inode map information
 	 */
 	AG_LOCK(imap, agno);
@@ -1298,6 +1300,7 @@ diInitInode(struct inode *ip, int iagno, int ino, int extno, struct iag * iagp)
 	jfs_ip->ixpxd = iagp->inoext[extno];
 	jfs_ip->agstart = le64_to_cpu(iagp->agstart);
 	jfs_ip->active_ag = -1;
+	printk("diInitInode : %lu",jfs_ip->agstart);
 }
 
 
@@ -1908,6 +1911,7 @@ static int diAllocExt(struct inomap * imap, int agno, struct inode *ip)
 		 */
 		iagp->agstart =
 		    cpu_to_le64(AGTOBLK(agno, imap->im_ipimap));
+		printk("diAllocExt : %lu\n",iagp->agstart);
 	} else {
 		/* read the iag.
 		 */
@@ -2898,7 +2902,7 @@ int diExtendFS(struct inode *ipimap, struct inode *ipbmap)
 		agstart = le64_to_cpu(iagp->agstart);
 		n = agstart >> mp->db_agl2size;
 		iagp->agstart = cpu_to_le64((s64)n << mp->db_agl2size);
-
+		printk("diExtendFs : %lu %d\n",agstart, mp->db_agl2size);
 		/* compute backed inodes */
 		numinos = (EXTSPERIAG - le32_to_cpu(iagp->nfreeexts))
 		    << L2INOSPEREXT;
-- 
2.34.1

