Return-Path: <linux-kernel+bounces-9151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD3F81C1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E291C24E21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5146F78E9F;
	Thu, 21 Dec 2023 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZyBoOTbs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AEF745E6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so1513443276.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703200269; x=1703805069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+yOLP80MSa9iKNeNSW+2YmDpottMY5fEPpejkDDUSHQ=;
        b=ZyBoOTbsw2ZOI1SOlOCfE1eZykTdoR2Vm90Os+2VU4Uj1Zntoekyh7r7RsxRninv/3
         7U3eyIGffPVQIoF7N3QIyXL3Fe3bmgbNRruzkTn5rE6LF82SxOtXQ+Ij5QLl7ee7/mwn
         xmaTBpliubJcAmBjxhjYj8SGBhiOqvf9RTqYTME4AEUCzKkEsidkw89AqCWXXhp2ClkV
         CxYn865VJgKANC3d+OyZk5CZafBzJZR7GcTQNyheMUBDHVp7oZg3bSFgvviUR4ELKj8V
         3oHoFwrCY9TqDFSd9QrYZlAH7oOudSm/OsEJEF1UJByBzo0DYsWtJK7B1hwLC0dWtWmL
         j/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703200269; x=1703805069;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yOLP80MSa9iKNeNSW+2YmDpottMY5fEPpejkDDUSHQ=;
        b=qfFAUDE4KknXUEpl0yMzb+Gs+7UqW2DKI0e5s6ELzD7EXhqe3vSr3eQO7sO2vVIbmj
         n8JWpiE7cWugGbYTrSUU/C6A4cuVzeHKIecX9jZEuEej7+ocm2fPbKTY7UNF0CEfEWWV
         YDa4Fe8PKxNHoXD1leBFy3YN7BG97eafFF2jAy7US6l5xu2+9vzcgfp9xZ3Q8HmwGFts
         0UNxwvE3VuwpbgfQZjy3cQOZ+W06X/4OXkMIdLzwK+2XLyl7lF0/yXkYXStjcGafjBct
         sk9+hT1PDqRyo6BRuhO90hIV4mKtvzbUQRn9YNYEpyrw9aL44uDIy+7oXTPMYOPa8Gb7
         0i9Q==
X-Gm-Message-State: AOJu0Yw4ZlvaT4HY5DUmKLdao0qjY2GGp6Rk3HbwqIBrPzXlcfJPukvN
	K4H6Lo1ZGTgyNYn3OXNJYRVSg5H8aIIU31l9qq8=
X-Google-Smtp-Source: AGHT+IH6mmiklx10ZZqi3bnaIQdND8Xn32ZNvnrJuQf0gyxQ1P5XAiJO5gLEdmiM51ZMieviFKMDBGG/5HS6
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:6902:541:b0:dbd:716d:3102 with SMTP id
 z1-20020a056902054100b00dbd716d3102mr13608ybs.0.1703200269346; Thu, 21 Dec
 2023 15:11:09 -0800 (PST)
Date: Thu, 21 Dec 2023 23:11:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAATGhGUC/x3MMQqAMAxA0auUzBZMVBCvIg6liZrBKg2IULy7x
 fEP7xcwySoGkyuQ5VbTM9XAxkHcQ9rEK9cGaqlDIvTBjk1SRfEOzNkjD7GPjDRKB1VdWVZ9/uO 8vO8HFFOnUWEAAAA=
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703200267; l=935;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=OFfC6lpIaC3E+xjFYayuCYFLYBCLF7zqmJeV59imeT4=; b=+3+zWFxZ1NzSTGoxze6B8DcKskn9MEQFJE4P9hc+slQVT5dQG/GGHTrNeRJ8g2IC+NEjkW7aQ
 oQSi8QcoDq+Avax3TRqrT1zcNDo456c/GZ6hGPNGA/POyxZJBnEkgDZ
X-Mailer: b4 0.12.4
Message-ID: <20231221-asmgenericvaddr-v1-1-742b170c914e@google.com>
Subject: [PATCH] mm/damon/vaddr: changed asm-generic/mman-common.h to linux/mman.h
From: Tanzir Hasan <tanzirh@google.com>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

asm-generic/mman-common.h can be replaced by linux/mman.h and the file
will still build correctly. It is an asm-generic file which should be
avoided if possible.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 mm/damon/vaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index a4d1f63c5b23..1741e0751e01 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -7,9 +7,9 @@
 
 #define pr_fmt(fmt) "damon-va: " fmt
 
-#include <asm-generic/mman-common.h>
 #include <linux/highmem.h>
 #include <linux/hugetlb.h>
+#include <linux/mman.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/pagewalk.h>

---
base-commit: 9a6b294ab496650e9f270123730df37030911b55
change-id: 20231221-asmgenericvaddr-1d5c4cd128e3

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


