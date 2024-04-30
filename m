Return-Path: <linux-kernel+bounces-163513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A308B6C59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8000A283F23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF0975810;
	Tue, 30 Apr 2024 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/SFkQGx"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E23FE51;
	Tue, 30 Apr 2024 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464013; cv=none; b=KSUaVzNOXJIZ+mlPtEyPIwrKywi4vCKvC1i2BN2Pg36BpOhv2z6/rHGxPxh+zQrfZ6k/dFdRu/6nKaQQ0BVmhMDE4A9+JuUJI33c7S1su40+M0IgXOujS/ga/kmCUwb/bBj61hyUBQJZZ0/DsgzjYy+jpZ6te+0gf2Ik2bVjDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464013; c=relaxed/simple;
	bh=Xr3ka3wR8U78ItCs1qwBo9x2xAzK1TP584262NiYwaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CGzcoLzEBUCMZvZezVOJRpoArMU7rQtQTmpev8AMvHulGfsVeF69UMTnkuCKk/z7hW+V6KGDKkxXc3tpdIaxr4Wyn1/L01fSQQ6i1r30rkdEDe1KBHB5/O7Jdna1Aa1CQweFeGdvMnfxLjd8NDpRej+C7D4PhP/rnIY/VaZ6LFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/SFkQGx; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5f807d941c4so4191974a12.0;
        Tue, 30 Apr 2024 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714464011; x=1715068811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9ApYN3kJSKRtnVhiFwLFlEQiT5pNLKKbrHISKk7OtE=;
        b=Y/SFkQGx2nZNXEflVwmqOs/hcAxN7OcBxzqj4Wr9ZdzmtyW8cJW4m9UBhkFMubihkX
         nNwv0Vm0tIEXY0nR88NtGjQ0XQKmBa/1TNgHEzhdnaMOJ8j0oCjbWk9JELZBUHylQh1b
         M6gfloLHiKypYgKdSB6QnBQVbLBoapi0ZU5iefaoMMw9+ko+H72EnsRl+ZIcZcBEdNt8
         ROi4LsH+4de6yB2gDp15XpiFRsBLdIzyQl8wUNJ5tamnQO47Y2Q4ZKH/HsaY+rP/Ya22
         YZ4Xbcul8mSFQuuK+cVJeLd+C2iEpU3UkXyxmPlGiOVQPtqtlw4HZvQtuNSOiEc4a9v6
         teVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714464011; x=1715068811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9ApYN3kJSKRtnVhiFwLFlEQiT5pNLKKbrHISKk7OtE=;
        b=d+l+2xy24/CXDZNlRWsU/WnqrErb6oWBXI/4/Qo12vpAqMKPutM3VTmV0tupeK+67v
         xDG84wIqYon82WNAWt71Jd7mPO+wegL2uDY03ggbLz8W9zXraUt1E5IC5LrD5Ckltczt
         HfDPP7FwAvqUDDPwmalLRQpcxsOrlFTjInv5g+LR+lFxvGLxY09zzjhk6qaMVFPdlfBv
         5CdIviutTPtUX5D+pZeuWZYYijlxsm4PdcVnHPG3AUpEk4N0hC6j+LYFxbIEHMODaZHZ
         4KWFWGIh6XA7PfWGTcZ0EFB91q5jxXiPJMsO7OO4sliHC5RfnBUdkfQK8MED8+qOhmtD
         bfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXXRKZ41xAjHDyDV2PNvnF+freJfMH2r07/RpdQS81VfVjPU4t9IayCxxB8IdM4Ff+RFjDIae2tDPay++hjGgvmWiW7Z/O8gQaDs43
X-Gm-Message-State: AOJu0Yydroh85kZ0wXThxK5mzxC67+1UOQ0O7AscpQRXkixQVNDWvzkm
	ryMhKK3i3Smv+Sf+G9grxFk/gHd0j7E9Sp/Af3mP9uu8k7QWMXhB
X-Google-Smtp-Source: AGHT+IFV5yuJ2HwljC2oOPm7t0XepjMJZE84IAleZVTlOo9Eq7IfA8Ud84drzVBPTf3T+96GpgncrA==
X-Received: by 2002:a05:6a20:1047:b0:1a3:c43c:9ccd with SMTP id gt7-20020a056a20104700b001a3c43c9ccdmr13905075pzc.42.1714464011272;
        Tue, 30 Apr 2024 01:00:11 -0700 (PDT)
Received: from carrot.. (i223-218-155-26.s42.a014.ap.plala.or.jp. [223.218.155.26])
        by smtp.gmail.com with ESMTPSA id i6-20020aa787c6000000b006e6b52eb59asm20461760pfo.126.2024.04.30.01.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:00:09 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH -mm 2/2] nilfs2: make superblock data array index computation sparse friendly
Date: Tue, 30 Apr 2024 17:00:19 +0900
Message-Id: <20240430080019.4242-3-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430080019.4242-1-konishi.ryusuke@gmail.com>
References: <20240430080019.4242-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon running sparse, "warning: dubious: x & !y" is output at an array
index calculation within nilfs_load_super_block().

The calculation is not wrong, but to eliminate the sparse warning,
replace it with an equivalent calculation.

Also, add a comment to make it easier to understand what the unintuitive
array index calculation is doing and whether it's correct.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Fixes: e339ad31f599 ("nilfs2: introduce secondary super block")
---
 fs/nilfs2/the_nilfs.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index db322068678f..f41d7b6d432c 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -592,7 +592,7 @@ static int nilfs_load_super_block(struct the_nilfs *nilfs,
 	struct nilfs_super_block **sbp = nilfs->ns_sbp;
 	struct buffer_head **sbh = nilfs->ns_sbh;
 	u64 sb2off, devsize = bdev_nr_bytes(nilfs->ns_bdev);
-	int valid[2], swp = 0;
+	int valid[2], swp = 0, older;
 
 	if (devsize < NILFS_SEG_MIN_BLOCKS * NILFS_MIN_BLOCK_SIZE + 4096) {
 		nilfs_err(sb, "device size too small");
@@ -648,9 +648,25 @@ static int nilfs_load_super_block(struct the_nilfs *nilfs,
 	if (swp)
 		nilfs_swap_super_block(nilfs);
 
+	/*
+	 * Calculate the array index of the older superblock data.
+	 * If one has been dropped, set index 0 pointing to the remaining one,
+	 * otherwise set index 1 pointing to the old one (including if both
+	 * are the same).
+	 *
+	 *  Divided case             valid[0]  valid[1]  swp  ->  older
+	 *  -------------------------------------------------------------
+	 *  Both SBs are invalid        0         0       N/A (Error)
+	 *  SB1 is invalid              0         1       1         0
+	 *  SB2 is invalid              1         0       0         0
+	 *  SB2 is newer                1         1       1         0
+	 *  SB2 is older or the same    1         1       0         1
+	 */
+	older = valid[1] ^ swp;
+
 	nilfs->ns_sbwcount = 0;
 	nilfs->ns_sbwtime = le64_to_cpu(sbp[0]->s_wtime);
-	nilfs->ns_prot_seq = le64_to_cpu(sbp[valid[1] & !swp]->s_last_seq);
+	nilfs->ns_prot_seq = le64_to_cpu(sbp[older]->s_last_seq);
 	*sbpp = sbp[0];
 	return 0;
 }
-- 
2.34.1


