Return-Path: <linux-kernel+bounces-79880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2998627E0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 375AEB212CC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04154D131;
	Sat, 24 Feb 2024 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXycU5pK"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF54317B;
	Sat, 24 Feb 2024 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708811443; cv=none; b=C6VOuARGVJBrUiD1MqhDehyZOjLYwubPYrQvZXv66//sd4HgeZLeTvfsqVIevAdKUeLPmjqDXl0n2LPCBGNWIRo8zCnczfxZfRgSjQZ7wp9X0o14b/Nq4JTRGjVFM/SJ1mNgYAyciTJxj1zqlyBNyoYLbNeV6gK/sOzYkybI3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708811443; c=relaxed/simple;
	bh=4BPgwLpKQTq/0vxcQXG57XBxOy8tRWhOr/7YSpHpNIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rb6iGGb0plh92Sl6GZ5/+XL9XZlgETMBvgT7r2pXEgIlUqaWAVPFUGcn5Mk6Nk+5J4SrYOdjqQ0BYG0M2CtHVCPFrQYl0dmVvdnT8niUlC/pgjjUX95O9gw2/T4ySmHGaHfnMS9axvzbleb981q9+Mtkfl3RYTc8fwhPPfo60Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXycU5pK; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e48e42a350so478054a34.1;
        Sat, 24 Feb 2024 13:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708811441; x=1709416241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ydh9YpZ5plBfJp+BJ1ZlCj0CTUl0s4YGZgmpPJqLx+E=;
        b=TXycU5pKDv/TsuTt59MUGQfQpxXtqiaJGkmVKq6wBP7k9ouN5muAJf0fYHHqilQIZ6
         JeJL8IW7zYfLAETQX9yqFYDQYqAgpCpUY3/CDM6g24jFotZaXJL05se37zLtAqUq8REy
         ZrnBvZzT8i97q12CXWv/QxE+aM9ndQfgs4zo5NGlZvvx0TFf15NGGjk9Yc7TmRBtQ+rm
         wxwPrnauDqXEUuZ9eZ4SGHPnLV5xQRFwujFRf3IwX4YtXY6W8zw9XkgjW8y63uKQUzur
         0HxTp4NI8C33s1rg4Ace3x/Jc2ekuBqXzD5dZexpPssVHvm3PmvSkjh8mrCIev9umZOi
         mXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708811441; x=1709416241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydh9YpZ5plBfJp+BJ1ZlCj0CTUl0s4YGZgmpPJqLx+E=;
        b=wBroVYs8X6nnhtnGFiTOlP91DxuE4WHZXnlH0kNIb4Xa78g+F/q6J4I8+33a2CrZJr
         SfTXzfOwgRou68o8qMz8j5kyFaJGRjbug1pqwgNEVxcpebiS9VzzT8WtF6dCK4k6vbuA
         V8nW4B7E1drD7B2hpS9Y8p/jChbw+RWNQC1aZIQLp+Pti7vQEQZOf8T6Oh3z/tHmzOcp
         zr6lfcMo7VKWLSM2FThJ5yq4JysbjzE/mDtYhYpODybro9tyI/Og9nJWXFzQgxZVjYDs
         LeErN5VuSnTuZVTjO46fC9G9gF9drKbe4u58RRnvnhzAslzHBNrPBXgsQNTCYk3IqJf6
         kKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9ZbrwYx5xtjn81JuDKFyL4mopX+//bBx5yfKNyZ3gaOsgyzAss73Oe2NvBLqTb32PUlXKRFk42gv2OtqW7aHGu4Fopg2+j/A8
X-Gm-Message-State: AOJu0YwN9MsOzGhFMnjJhboweCQwbAEsBgVcjsvWjyslULW8dQkGCLEe
	v9GQNnrYhDg7RwmoqYMBwMBluCzOaXUbFwfzWLcStY3e0PaLIhOp
X-Google-Smtp-Source: AGHT+IFibMKAm7HJ/s6TRaLHq4riuHRV1LaOYrAXiM9s7Vh3AFlvSPBPKaMqLJjA0MKvOhsC6rc4jw==
X-Received: by 2002:a05:6830:4414:b0:6e4:82a4:742e with SMTP id q20-20020a056830441400b006e482a4742emr4515589otv.0.1708811440809;
        Sat, 24 Feb 2024 13:50:40 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:fae4:3bff:fecb:410])
        by smtp.gmail.com with ESMTPSA id du15-20020a056a002b4f00b006e4bcdcff43sm1509866pfb.78.2024.02.24.13.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 13:50:40 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: corbet@lwn.net,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	SeongJae Park <sj@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH] Docs/mm/damon/design: describe the differences for pageout's virtual address and physcial address
Date: Sun, 25 Feb 2024 10:50:23 +1300
Message-Id: <20240224215023.5271-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The doc needs update. As only in the case of virtual address, we are
calling madvise() with MADV_PAGEOUT; but in the case of physical
address, we are actually calling reclaim_pages() directly. And
madvise() with MADV_PAGEOUT is much more aggresive on reclamation
compared to reclaim_pages() on paddr.

Cc: SeongJae Park <sj@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/mm/damon/design.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8c89d26f0baa..6c50743552f5 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -315,7 +315,13 @@ that supports each action are as below.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
  - ``cold``: Call ``madvise()`` for the region with ``MADV_COLD``.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
- - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``.
+ - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT`` if
+   the region is using virtual address; otherwise, call ``reclaim_pages()``
+   for the region if physical address is used.
+   ``madvise()``  with ``MADV_PAGEOUT``  is aggressively reclaiming memory
+   when pages are not shared by multiple processes. Differently, paddr's
+   pageout  will do the best-effort reclamation by scanning PTEs to figure
+   out if pages are young, if not, pages are reclaimed.
    Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
  - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
-- 
2.34.1


