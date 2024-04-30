Return-Path: <linux-kernel+bounces-163347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C93948B69B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A222810ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EFB168A9;
	Tue, 30 Apr 2024 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma88Cy9N"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099B414AA9;
	Tue, 30 Apr 2024 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453744; cv=none; b=BxRgtwqm04nIhahP5ZL9IU0GyysCMcWxq5B9ddIQ6Ga4syKdP1nHemVD6wfiRD64AKRvE+uuRlUFEB6OpWDJeV8VMm32QwiOPvDr9cLwzEahC7WpXUH6EkZzUX5SCJH1HrDQAgKblosVcBiUqE6ErTWU2tYJi6gksK8ksm7Qj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453744; c=relaxed/simple;
	bh=CSg2VMa5g/ypx5iiHOuPvmOpBdgyb8rNj1uX/JI9C9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JS5+t6GpYSSCg+Sg0BE0alm8Y4M9DsRNBzyWqUAwPbSUdQSaLSwfzyjJjEqC1JsZAy2BMqiYHwGGZU+uFWzZ70FdJKfj9pEG89IVC+TR0A6IWhX7+fz0m0tcm0M0EJTayy+t0k3/5fuogC/DiZNTlDgLQZTnY3X4qtMEkvCII74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma88Cy9N; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed01c63657so5114681b3a.2;
        Mon, 29 Apr 2024 22:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714453742; x=1715058542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jMMnrAfTHMqJGkuKi9d3l3bjGmIWbLr+pY8N043PVx4=;
        b=Ma88Cy9NhKYwGtWCXc57D8/my0Pfz5QVJou6FcMPB+B5hPzvv9j2UoHe8lCP3vzqVT
         c81QaSWOBLZkdGo5A0JGtN20PEh5g/tj5NBWsfigEpzFz6vi8v5fTjxoqaW5mQ/i9vew
         hG8YRA8DJvKBjy0IMoNaSGIdfHApc9ZBu9gnfW3fxAR1mhaQYOTRIenufvLlwbO1iNA2
         0vdcTj1BMaOKOCLaL4504ILm51J+l6RXJ2NeNBZN55UxgbZn44pXqVXd/JJzrF3crkMT
         HAQUC7hUOq8xqArumB45gtb0LkfWQIxkWkOEQQYDp9BSTL/54/GrZD9JCEUgiGFaftoz
         iaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714453742; x=1715058542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMMnrAfTHMqJGkuKi9d3l3bjGmIWbLr+pY8N043PVx4=;
        b=qYIMNg0W25xpuNcVC+5MPAZEGDAjCkf4mrg1NsU1EkChE0bMoT1tugCymBAcLO3Lq+
         G6aV7Dk/C/TIDb6LtrK4K2am0400Xcr4+KEUy5fhpGkzoNaLJll6uSFU1mdxsHdIYIda
         M/jMOialXn8a/Es5azzy0YxOhkYyHYuEA+e5E5SXBGyx4KyNY/V4MqVINdD47NpTPb/f
         FomOo1cNRcXoyijXEHsdaMwZ09ASMVK8vKxjt25l+k0VHS1EWxYbUAsJMGeDSlXjUZus
         DZuNBU0V8UIcLXrk6hHl9Z3a7ETCsxOnZkav12PhP9GGGs6bnGEqV8i+S5P7Y4rNNLRl
         85Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUHcJmJ/zjTBDBJQbhSGuqOq+/BjYUrj8ao1N6Ksm+YZzPBzaR2KRPI3nRR+1RMrFNT15FwCQK5WU1D4Fr8EnqsViUvxZZxi8NbuUIK
X-Gm-Message-State: AOJu0YxC21x8lfhNafJq3CFD5rTHeK7gHC7nPxMBPNmD8+YO99RCM/ss
	He7vvvtXRvApPgkRxUloeybp3armbNrPgZPc1dTz9IgXg8DL5pww
X-Google-Smtp-Source: AGHT+IGpa/rz5iYGZbLP7h4toR745SNSGJZlULfPEN7H3bwEvVB+fTEoLoO1tIrHUvaYgrtd44i8dg==
X-Received: by 2002:a05:6a21:6704:b0:1af:4e95:ff3b with SMTP id wh4-20020a056a21670400b001af4e95ff3bmr4861498pzb.39.1714453742176;
        Mon, 29 Apr 2024 22:09:02 -0700 (PDT)
Received: from carrot.. (i223-218-155-26.s42.a014.ap.plala.or.jp. [223.218.155.26])
        by smtp.gmail.com with ESMTPSA id bf5-20020a170902b90500b001e7b82f33eesm21320794plb.291.2024.04.29.22.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 22:09:01 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH -mm] nilfs2: Remove calls to folio_set_error() and folio_clear_error()
Date: Tue, 30 Apr 2024 14:09:01 +0900
Message-Id: <20240430050901.3239-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Nobody checks this flag on nilfs2 folios, stop setting and clearing it.
That lets us simplify nilfs_end_folio_io() slightly.

Link: https://lkml.kernel.org/r/20240420025029.2166544-17-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Andrew, please add this to the queue for the next merge window.

This is one of Matthew's PG_error removal series, and is one that is
encouraged to be picked up by maintainers if possible.  As expected
for a cleanup patch, no issues have arisen.

Thanks,
Ryusuke Konishi

 fs/nilfs2/dir.c     | 1 -
 fs/nilfs2/segment.c | 8 +-------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index aee40db7a036..a002a44ff161 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -174,7 +174,6 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 		    dir->i_ino, (folio->index << PAGE_SHIFT) + offs,
 		    (unsigned long)le64_to_cpu(p->inode));
 fail:
-	folio_set_error(folio);
 	return false;
 }
 
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index aa5290cb7467..8654ab8ad534 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1725,14 +1725,8 @@ static void nilfs_end_folio_io(struct folio *folio, int err)
 		return;
 	}
 
-	if (!err) {
-		if (!nilfs_folio_buffers_clean(folio))
-			filemap_dirty_folio(folio->mapping, folio);
-		folio_clear_error(folio);
-	} else {
+	if (err || !nilfs_folio_buffers_clean(folio))
 		filemap_dirty_folio(folio->mapping, folio);
-		folio_set_error(folio);
-	}
 
 	folio_end_writeback(folio);
 }
-- 
2.34.1


