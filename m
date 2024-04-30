Return-Path: <linux-kernel+bounces-163512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E908B6C57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC151C22026
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22BE14AB7;
	Tue, 30 Apr 2024 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC599OAc"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E531141740;
	Tue, 30 Apr 2024 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464010; cv=none; b=vASSM4b1K0Qe+6WV2NhvzyiCsz4vliNkl6QMnDWaci+K06qG4GEWHH0B4lRBu7WwTGjUGJgEZNVNZvsW40TSQRUvZUsQCXJcocGZZ74yJCN2vUa9mU15yhQ+JEkch2uaM5WpWGomUtfiwdsfMG41caFIXG/IXPqszoVvuVFbFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464010; c=relaxed/simple;
	bh=HuZwhZM5yck4T5u11BK3BtPUCDX+Xupo0EFAfsebFTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+1N1A5B1QzoacUkJQHnWyjbukYFg7l4yk95o1nyTWpPhS7SxSI/X+3liJBHTQSBDd1gpEWaJ+3Q44Pd2eQZGn4ih9fezFv20pVI+e4jlt3aUCFQUWsDb79iUpy/o2sfXUGVDj70wF8qbTgF/1CtmppjC5oO7oCa2UDCgprWddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC599OAc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ece8991654so4986883b3a.3;
        Tue, 30 Apr 2024 01:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714464008; x=1715068808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSQZSsatdTLv5L0P1VDLHMa52bOa1G8TehUtWhtaoWc=;
        b=HC599OAciwPEavKCNqR/uizwh+IKGwjzzd8mNvwgxcqi11+Zgi2ZCKlXhZWLkOBe25
         Z2fHijs//5Um4rMTTnykjv6GhYEh7bx6Om4QOU3pHDKXmzRABJK2DgJJEFn9Sb7JdtVW
         TasTAKjx+HfbVdMP6p+2E8FhmqoJfU5ba+9ZcTxba/o3ElRC33QkfaB5IdGdoSq1taD/
         CtrjNCOEql1nhhaKgAJO41dOD9asdo63ovutIXnGpl4ngyjVpKUNX93o2OyU42PXLa6M
         XGMX1MmN+uFH4evbQPyeiusn7hBOnCgZziT5NPy5ayYGtVqXtlNTSwMfdXbuesgxiAlr
         TZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714464008; x=1715068808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSQZSsatdTLv5L0P1VDLHMa52bOa1G8TehUtWhtaoWc=;
        b=SIBFma7O2YIkKDXmZefieHpeQvLrXF7lTHV0lvVKngwHSmptXhBOK/wVWpOkunEna8
         f9L/ZZd7Y8mZ3AYagoMKszC14s8U3i+YmvtQpad9kTCmBGJS/FkWlHn/6AZqfojB0MyZ
         AFcJVUKnH8wDcGYEqqgxGL5uEc2ZtzRCagfbynJDJ2DRS6xN8T+TsEb2lqBe8GoQaMBW
         SeE/NTORMp47V1pnHHS1g8uIvqdy7LooQmvpMHscQN1KXq2to5ykgOQoEG6lT8hVP26n
         SGqVox/n1gcgcDc4VloiF6YEk9ghdY4NxvnjcuJv54YI8s+MZ5WmTOyGVtpgJTR6ST4l
         YkAg==
X-Forwarded-Encrypted: i=1; AJvYcCX+Hv34ZupjOqzJGgItavhxS1DEVwLi9n35aWIL3aN2Lbj9K23T9tgTFTBw4z8ZZDPFg2VyHlLZzFz/zs/A6kMyJf7ENb5zBtNEENlu
X-Gm-Message-State: AOJu0Yw2GqzjZPhjgjpGhGtyBoTp5hzh206awhjxb8AS8QC6f0wmeSIo
	CNa1XiiuVc8qwhlqEZnJEXY/tIMQgNosoVEJynvVbVFcWXIQpx0P3jEwIRjH
X-Google-Smtp-Source: AGHT+IEu91iFYfQ/76dpY1Q+cGboqNolZWfeWfK92CE+ySmHLuw9mbzdvgafA7I4ZZdDrqorSxvzhA==
X-Received: by 2002:a05:6a00:1810:b0:6eb:3c2d:76e0 with SMTP id y16-20020a056a00181000b006eb3c2d76e0mr19521858pfa.11.1714464008051;
        Tue, 30 Apr 2024 01:00:08 -0700 (PDT)
Received: from carrot.. (i223-218-155-26.s42.a014.ap.plala.or.jp. [223.218.155.26])
        by smtp.gmail.com with ESMTPSA id i6-20020aa787c6000000b006e6b52eb59asm20461760pfo.126.2024.04.30.01.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:00:06 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH -mm 1/2] nilfs2: use integer type instead of enum req_op for event tracing header
Date: Tue, 30 Apr 2024 17:00:18 +0900
Message-Id: <20240430080019.4242-2-konishi.ryusuke@gmail.com>
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

The sparse check with "make C=1" outputs warnings regarding references
to the header file "include/trace/events/nilfs2.h" for event tracing:

 fs/nilfs2/segment.c: note: in included file (through
   include/trace/trace_events.h, include/trace/define_trace.h,
   include/trace/events/nilfs2.h):
 ./include/trace/events/nilfs2.h:191:1: warning: cast to restricted
   blk_opf_t
 ./include/trace/events/nilfs2.h:191:1: warning: restricted blk_opf_t
   degrades to integer
 ./include/trace/events/nilfs2.h:191:1: warning: restricted blk_opf_t
   degrades to integer

Fix this issue by reverting the type of the parameter related to the
bio operation mode in the event tracing definition from "enum req_op"
to "int".

In order to prevent sparse warnings on the caller side (where
trace_nilfs2_mdt_submit_block() is used), also add a typecast to an
argument passed to the tracepoint.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401092241.I4mm9OWl-lkp@intel.com/
Fixes: ed4512590bd5 ("fs/nilfs2: Use the enum req_op and blk_opf_t types")
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 fs/nilfs2/mdt.c               | 2 +-
 include/trace/events/nilfs2.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 4f792a0ad0f0..323eb8442e0a 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -152,7 +152,7 @@ nilfs_mdt_submit_block(struct inode *inode, unsigned long blkoff, blk_opf_t opf,
 	ret = 0;
 
 	trace_nilfs2_mdt_submit_block(inode, inode->i_ino, blkoff,
-				      opf & REQ_OP_MASK);
+				      (__force int)(opf & REQ_OP_MASK));
  out:
 	get_bh(bh);
 	*out_bh = bh;
diff --git a/include/trace/events/nilfs2.h b/include/trace/events/nilfs2.h
index 8efc6236f57c..84ee31fc04cc 100644
--- a/include/trace/events/nilfs2.h
+++ b/include/trace/events/nilfs2.h
@@ -192,7 +192,7 @@ TRACE_EVENT(nilfs2_mdt_submit_block,
 	    TP_PROTO(struct inode *inode,
 		     unsigned long ino,
 		     unsigned long blkoff,
-		     enum req_op mode),
+		     int mode),
 
 	    TP_ARGS(inode, ino, blkoff, mode),
 
@@ -200,7 +200,7 @@ TRACE_EVENT(nilfs2_mdt_submit_block,
 		    __field(struct inode *, inode)
 		    __field(unsigned long, ino)
 		    __field(unsigned long, blkoff)
-		    __field(enum req_op, mode)
+		    __field(int, mode)
 	    ),
 
 	    TP_fast_assign(
-- 
2.34.1


