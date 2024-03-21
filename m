Return-Path: <linux-kernel+bounces-110809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198A888642C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77143283DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC331758;
	Thu, 21 Mar 2024 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+Qm0+MX"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65A3232
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065534; cv=none; b=au8us82teGf8Xyk5doCi+4H4Zn9PlqUMvIgj+ux49T9dK2Nz4VMnQufTyUjNMXtpPp3Q1dO6e4HY1O12AEtNNhO//9c7pt0k5mkOIN5Zex6egP0trONNKjRhJCl99VltZkEQhpkqjTnrwKunIpsJ4j27wshKcmIwtuRfJarxX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065534; c=relaxed/simple;
	bh=8nbkEqhd/vBfRpPciXf+JT8wfltNf7kk1s9bqURoRSs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sQ0atZMYfb1xHVWvziYR4W+jlLHbmnyQGVGQ9vVkfNKj3Mr4WvzoBDtzUpToCm0FH01qUmo4BvJl+QL64RwyAGIkAAhpIBXJ49BWkOSNNFnT25SMS8bVHaQAQx/CPfd6rVe90VEVvI9okP9iUg4XJuZjD+VcVHuaVN9kK5zW1jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M+Qm0+MX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso3175034276.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711065532; x=1711670332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fmSJvTjKWQ/lDEEZq7naAdjUKZ5uUte+jjmtdEJKA+c=;
        b=M+Qm0+MXeR0xjtrlgsD04EmDqHLst8otg/c/tboL7mSlRAo85L2Qr1pdrSLucxV3JG
         6x1zZ7jzZwA4dHLDq3CG0NikQECS3RUhJhUjroE4XkUdNC4iZ/68YS0c3rqY9UFghQaO
         09oylPC6ljcq/I+gudexd6stJkW1DnPPo0QjMnsw33e3UpK35InE+JdXtNINYeAFwwpE
         hEYphCsEwAxhQw+NfKta1okWXXnaQ9RcfaeCR+uoJeH3f33z7e6nwpuoYs/HEu1/8VLI
         7fn3QCneu3vPfRtWjJr6at7okTr8ChL2VzMf+XWdh1fy/X6lRupmxroJiNUXzMS00/FB
         VRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711065532; x=1711670332;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmSJvTjKWQ/lDEEZq7naAdjUKZ5uUte+jjmtdEJKA+c=;
        b=lZej4mc4QWf/ArzeHd2dCrJkHmwlEb014OGsv3Ln3G78fnPrk6Fea2iC1vd957cCLP
         0O2eTTuXAAjTM/HcFL1r/1kpU9vRZ0tSuU3ekQELmsci9cnoAy3s8fKzLQyiNgA/Mewd
         31OFMwn5j6ZFv3B0JSWovZgjmLh0JsAOtdLTp/+IIqHeFowTycKySBFboF9qmWobh6tr
         bzEDqEu73Im+vRovm/LJ51yepsJXsAk8S/TbCDUN1zKqE3CjArN5VG3u0r2aJ7Rku6+b
         uxkU47IeWXMrOyaM7WsBPJ8h12/3qzMePrGNDwYZtXBJ9xiBQRUSFyKGrZ4Ev5gIMQ4a
         ysbg==
X-Forwarded-Encrypted: i=1; AJvYcCWUG+v1zic6v/15mTjdWkVjruMnxtZYGU+i7dnYMnRN8LdX2LHFoXm9IvsjDNvcABNIWokArhRBRLTpfphyu7H8D9EdHCFtPKwYzkhl
X-Gm-Message-State: AOJu0Ywb/2JosYQp5Zqx4lRxDlFOngtkYNYLidWzOiDS5fWzrk+3igrx
	QfcHqeoaHoIHvYeevksNUzUXLrkvAqLa1MsFpVCwCiOS6CxfVxd/DcWLzQhA8hj5ukmmgW+RMN2
	3xPpCaYrSrvFJlAv3U8JeOA==
X-Google-Smtp-Source: AGHT+IH/44T7pDVbCTgRrnprZHIpkc7j3j1o4LejbcRZVsN8iGdForUW4J4MldVKxpqvGpDiBnX2lKmIGee/jRnQcg==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:9e9f:e486:fb60:db25])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:248f:b0:dbd:b4e8:1565 with
 SMTP id ds15-20020a056902248f00b00dbdb4e81565mr132094ybb.4.1711065531867;
 Thu, 21 Mar 2024 16:58:51 -0700 (PDT)
Date: Thu, 21 Mar 2024 16:58:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240321235818.125118-1-lokeshgidra@google.com>
Subject: [PATCH] userfaultfd: fix deadlock warning when locking src and dst VMAs
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	rppt@kernel.org, hdanton@sina.com, Lokesh Gidra <lokeshgidra@google.com>, 
	syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Use down_read_nested() to avoid the warning.

Reported-by: syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 mm/userfaultfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 712160cd41ec..3c3539c573e7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1444,7 +1444,8 @@ static int uffd_move_lock(struct mm_struct *mm,
 		 */
 		down_read(&(*dst_vmap)->vm_lock->lock);
 		if (*dst_vmap != *src_vmap)
-			down_read(&(*src_vmap)->vm_lock->lock);
+			down_read_nested(&(*src_vmap)->vm_lock->lock,
+					 SINGLE_DEPTH_NESTING);
 	}
 	mmap_read_unlock(mm);
 	return err;
-- 
2.44.0.396.g6e790dbe36-goog


