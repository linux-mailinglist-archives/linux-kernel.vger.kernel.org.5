Return-Path: <linux-kernel+bounces-6388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26941819847
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4752281F53
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01F916406;
	Wed, 20 Dec 2023 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HS+CDUdZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60B116403
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e7ac088580so22390487b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703050887; x=1703655687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CnjYMOrzwkCbD0FGgIKrRfe2ITqCmTOHmPVslRt7U1U=;
        b=HS+CDUdZeDvyphojZBYpr2D8RITQloFkZRj3XXp63pPsK+NhZqu9BAqTByqTfg9p9j
         /CDtOjHW7j4swTIDi5v1UAiDD3Bdx9nu/Fosz4u5N8q4YNxk1vgVH2woXEP7p/W65Jd0
         xbGHDNmiaGVoZ4ld2v+IhFJJpb+8578+huk9eTztQlHrq/X92yEzwIgCSD+jMgUhu6U+
         l8mN5cKnXgrMdDXARJxdfWp6cKpSiuU2L+ZkvSBSwIQgB1+weHtOQZqd3EXs5/staRj8
         EzACWcgvndsKSorq47m1WJCCqkm8/+qEKkq5MBwh7XFfpKrzeTb6aXwY7TYJQZwbP1SI
         s6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703050887; x=1703655687;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnjYMOrzwkCbD0FGgIKrRfe2ITqCmTOHmPVslRt7U1U=;
        b=vFC6qnrRBpcYqx7SietATNLlm56dAwUHkmdLQduVElMcEqH00aRy4gvfJIshDuXGfT
         vAnZ0e+eTwZm3L5RCZMMnAyrRuSYkNHedS3h5Lyj54OFsIIySmtopNc4t7+sFm0eBmgd
         4YAnORb2zLSatEtQ1+rTBMO6fTRM2JKVycANOqzoFCTbrqvQoEYBnPJdvZI6UFUhS8Qw
         hnXReB4ykZ/Nmnb7yZxgtZ9lpvhTnknvl0wQGmYUO2RjFkNkgvTksNMLWSw27TOyVqxe
         NfpqT7RC88XVHovDp4Ih72DnTfu5ctae+O4TgvEbPyMhX5U2Zw08c2Eyz8NcmKiQsQXF
         q3Sg==
X-Gm-Message-State: AOJu0YzxSSIM39rMrTUgDKaTE4m3G+F+7CSpIpH4M6wGNyvdZ1FJwyk4
	g32qaDcVLnYDkLgOjvqSWEXxPrjIbC3s
X-Google-Smtp-Source: AGHT+IGsueOMSkzfT0nYUCSgWkoGnWUStrlsrh8rK9jGlSMZG6/vJuqKWRaSppbB0sEpgT9yBQPAGcTvvfka
X-Received: from maskray.svl.corp.google.com ([2620:15c:2d3:205:405:b62:49a3:2869])
 (user=maskray job=sendgmr) by 2002:a05:690c:841:b0:5e8:3e57:68e3 with SMTP id
 bz1-20020a05690c084100b005e83e5768e3mr537282ywb.10.1703050886884; Tue, 19 Dec
 2023 21:41:26 -0800 (PST)
Date: Tue, 19 Dec 2023 21:41:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <20231220054123.1266001-1-maskray@google.com>
Subject: [PATCH] mm: remove VM_EXEC requirement for THP eligibility
From: Fangrui Song <maskray@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Song Liu <songliubraving@fb.com>, Yang Shi <shy828301@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org, 
	Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit e6be37b2e7bd ("mm/huge_memory.c: add missing read-only THP
checking in transparent_hugepage_enabled()") introduced the VM_EXEC
requirement, which is not strictly needed.

lld's default --rosegment option and GNU ld's -z separate-code option
(default on Linux/x86 since binutils 2.31) create a read-only PT_LOAD
segment without the PF_X flag, which should be eligible for THP.

Certain architectures support medium and large code models, where
.lrodata may be placed in a separate read-only PT_LOAD segment, which
should be eligible for THP as well.

Signed-off-by: Fangrui Song <maskray@google.com>
---
 include/linux/huge_mm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fa0350b0812a..4c9e67e9000f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -126,7 +126,6 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 	inode = vma->vm_file->f_inode;
 
 	return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) &&
-	       (vma->vm_flags & VM_EXEC) &&
 	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
 }
 
-- 
2.43.0.472.g3155946c3a-goog


