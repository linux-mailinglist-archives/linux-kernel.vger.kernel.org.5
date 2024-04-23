Return-Path: <linux-kernel+bounces-155851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF588AF800
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8476289895
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7B1428EA;
	Tue, 23 Apr 2024 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACZd+Dop"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA3142627
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904083; cv=none; b=YJg0C18ctP1XzlZSn4wSRQtqX2hFcCEbYvQj45NgD3TYDHyNKG5x1Jjc8xKXsuNRpVu5ZWnDPj48dOEEHkY15HGjuepoxrNc4ko1UiTwFvayaoHLogIIecgq3YcnQkv/lpcX7uBwN8E/Z5bp41NHgsnXGLhGmqBtM4hv12pKsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904083; c=relaxed/simple;
	bh=LKOCXLLr/y3TN06EgdAIxsEOgf88ap7dIaMwSVb7eNc=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O1ALdXyFrhpZbYWarXivE6EnSDtQ23WwWASpFkBW+9F2SrefMUB5wsde+gI3hvzJm7tdzvlXyzy8nts0maXp52oSWUxWWOHN7UT3LJhJkpfa9fpPI7IN2qL/8/kPgY9BcLZKHM3bER/IyBNPK/1EFzb7OVyxgNlAC5o9WxaNxVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACZd+Dop; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e411e339b8so47144465ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713904081; x=1714508881; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElhCcl6G0G6HIdkPF7nDaOrRESp4EOPhN/nwWmH0P0Q=;
        b=ACZd+DopEisoZurmOVD3pzhvqZIB95C0Qc1MYg66cSEiUUvgGolpcefR7+UZO0VSG3
         wtb4kPVv5JOYdyKPPT6Iu+2No7HPGUZScM+Pbj2094Grqy0LpqkowKnCT5dUFPVA41Dg
         DPEZSXH1Zabwi7ZlUX6jjY6kEvCaFRnEJYRJBIBTT1EECNLTfAFBug5HSbvZXJakTgeM
         0f6LMYCMsiUBdykQmKZOZ3gDJfxqItN7/cPD4WFNzn6N0fhHpkuT4eL25MJnLkIPLaN6
         sscKpLVlYbTUu8F6in8+CgGdZt72/UQosxG3dhw2vmt+HrhtJGzYZvYnMdYB5hYQB3qr
         k00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713904081; x=1714508881;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElhCcl6G0G6HIdkPF7nDaOrRESp4EOPhN/nwWmH0P0Q=;
        b=HUwRKxRUut95h3yJ7AsfH64CPofPVOg4TN2gOq7PBRvQVngcIY76Dy36Bx9+r/MrmK
         SYp9w3jVlycdNzme21QMfMNuEeXBEWXqeL9PDB2B14bKkQdwr8gIO0CjXjru2nmyK1k2
         WIoH+h+/FEKeCrjLPZernhvmUZKezgWIziDEZWU3eqCZoo7ueN6RsDJPBk7wHduZYEgH
         H3uRll/6vglhrRSDsN31BYUmk5wUdo4okGOOcfam8AKMjOPSmH0ZAE1WTHJRe++csiBm
         nC8Y6p3pmMrS5NiyYULsvF3QjAsgM7iUACQZJEUrSsiUdWjWgwO6DNxI7fhgUorQkU7c
         Lrsg==
X-Forwarded-Encrypted: i=1; AJvYcCW2OgWeNV077qrw5iHjP5NVtbETQfCWwpR59tkB2iCkcgYeizgbhhcphJpnMtS1wH3hXd3CfkVxR++3yroZMzxjlY0r3NqcOR7wWzz2
X-Gm-Message-State: AOJu0Yydz7lFqmGCJeFTIiqqGFLlQ0dR7NsHgKsc4kkIbzi7FoGE0DMe
	sLdOIlEKKUWlZIVNbEnz/Owd6JUO56kyynPslYYDblIIeNj7yUJpN2EGit9N
X-Google-Smtp-Source: AGHT+IH/UowfwTLVFs7FG4s/SVPC+n97N3bee3Xwzw64RB1SiFJYQWQyRrmColfNlVAQBwl36yRc3g==
X-Received: by 2002:a17:902:fc86:b0:1e5:963d:963 with SMTP id mf6-20020a170902fc8600b001e5963d0963mr664625plb.68.1713904080938;
        Tue, 23 Apr 2024 13:28:00 -0700 (PDT)
Received: from localhost ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001e435350a7bsm10424717plp.259.2024.04.23.13.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:28:00 -0700 (PDT)
From: arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 23 Apr 2024 17:27:57 -0300
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Noah Goldstein <goldstein.w.n@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] tools lib rbtree: Pick some improvements from the kernel
 rbtree code
Message-ID: <ZigZzeFoukzRKG1Q@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The tools/lib/rbtree.c code came from the kernel, removing the
EXPORT_SYMBOL() that make sense only there, unfortunately it is not
being checked with tools/perf/check_headers.sh, will try to remedy this,
till then pick the improvements from:

  b0687c1119b4e8c8 ("lib/rbtree: use '+' instead of '|' for setting color.")

That I noticed by doing:

  diff -u tools/lib/rbtree.c lib/rbtree.c
  diff -u tools/include/linux/rbtree_augmented.h include/linux/rbtree_augmented.h

There is one other cases, but lets pick it in separate patches.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Noah Goldstein <goldstein.w.n@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/rbtree_augmented.h | 4 ++--
 tools/lib/rbtree.c                     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/linux/rbtree_augmented.h b/tools/include/linux/rbtree_augmented.h
index 570bb9794421b975..95483c7d81df74fb 100644
--- a/tools/include/linux/rbtree_augmented.h
+++ b/tools/include/linux/rbtree_augmented.h
@@ -158,13 +158,13 @@ RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,					      \
 
 static inline void rb_set_parent(struct rb_node *rb, struct rb_node *p)
 {
-	rb->__rb_parent_color = rb_color(rb) | (unsigned long)p;
+	rb->__rb_parent_color = rb_color(rb) + (unsigned long)p;
 }
 
 static inline void rb_set_parent_color(struct rb_node *rb,
 				       struct rb_node *p, int color)
 {
-	rb->__rb_parent_color = (unsigned long)p | color;
+	rb->__rb_parent_color = (unsigned long)p + color;
 }
 
 static inline void
diff --git a/tools/lib/rbtree.c b/tools/lib/rbtree.c
index 727396de6be54f20..9e7307186b7f4123 100644
--- a/tools/lib/rbtree.c
+++ b/tools/lib/rbtree.c
@@ -58,7 +58,7 @@
 
 static inline void rb_set_black(struct rb_node *rb)
 {
-	rb->__rb_parent_color |= RB_BLACK;
+	rb->__rb_parent_color += RB_BLACK;
 }
 
 static inline struct rb_node *rb_red_parent(struct rb_node *red)
-- 
2.44.0


