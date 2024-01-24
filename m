Return-Path: <linux-kernel+bounces-36439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2468183A0C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DA11F2C988
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BF9F51C;
	Wed, 24 Jan 2024 04:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oMSZ9i9z"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59690DDAF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706071881; cv=none; b=qFWt/9gSvueG22nt8wBueMdQJEkcyAXPSk1Hmivv+fh0Im6X534sNZlCxzeoH+O9N3+fH5tds2bpc22zxbpr+Fy4CE/WcWBghFQ+0XYTVU+6iWk3cxbEmgLvkAWIdK6R9NIQX5CkaRK46ysP7/VRsz5w5lbx8rQaEtJ0ubicSVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706071881; c=relaxed/simple;
	bh=oojZa1iMptE5sMnL+2TXHHLFHCC7HlS7H7JRK1lQHt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ua/EWrNOI8mw5oiYgqTPdVSFyvf92B3za7FORITxwmmqVNuN8f1IPHn1qhH4nG2VhZd9AblpqjYDdzhOW2NIThhqTX8Cl3ImGvl0kVNeFLxA+cglKBPQtsySf9Hff0a6XfXrBsc9ruoKKSMbkQ9az4ukmoT+tNR202wp/WUTBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oMSZ9i9z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc24eb13fecso6293098276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706071879; x=1706676679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkuiKBs8Z3LCxzx9sFvb10Ddko8C8l9RPXC0zaKu0yw=;
        b=oMSZ9i9zYwT1EZ4nJrQgaraSMGz5CuSrQxQDKodNHA/qfvRF4sXHw+SmCzdJY9Yzr3
         FLTE3RuF038TPNsaVQUCkkt+Bm0+8g40EIu7EJha9PsXNbjFxtFL2+fNVKDh9WUAqlAM
         zShT5JQKCE/XWCwXIHW4Fk1KbDeynsbmFzmFFu5uueacIjAkfhQIxHbrcWfuAONpjGrP
         MkL3BDFtUszSURW9bAnezB8siXGCRrDBQxGDCKtXLzl7KGjm4BoUYCBWwGcLh4LSVD1X
         2cvb2KtQmkGXUGVeUkTro4wRt+JArIuEwYM9IylXH9Oo35NZTXWmcCcgBH0eE17uarx2
         eZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706071879; x=1706676679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkuiKBs8Z3LCxzx9sFvb10Ddko8C8l9RPXC0zaKu0yw=;
        b=Uj2iK86aM5c+ISBQnO1NOc5urwVeNevfejS+eHRJIuzglzAiJ+ld1JMrydHiYU0NG6
         hvtwaTMgqsd9GeQopP+lWrUpcl3ACsK4drvX5fTG1p4P41kHSF9iLp1zBaYW0TPfilmn
         tGha5pFyyalofst1aOzaIKaePEv3vr3xUXAM6Vy6FAHvVLtRtU9jymYmmlbQg03OBgP4
         OLqqiuteX9dJAQRX0gxtappfzDoh1qR07pzpiY6jDAF9YnGNEba/PgdsctWXwPTZdr/v
         sjksW5h3BX0owr9Pw/EBEih+gVKpztu0zYyLrLhcAHkNn5nG/CIKbYSgRdnFAWLyDeVt
         5DYg==
X-Gm-Message-State: AOJu0YyWhbQe39AisBhLt1xa+KdT+AwMrTSBxqS41YZy/WMriFd7aZJd
	7PJq5Sfbl6thhnyX4902JQHiIut36MlcBOYeZjRJ6kERAe3ib7xRlY6Zw2VhcBRk4kmYP3GkZ+O
	hf7xDjDvPW1ZvVRKuhQ==
X-Google-Smtp-Source: AGHT+IHUBuTswzf59MXI254TJk24hUrp1Y6H9iQqapqBpe212J3nM0SfBnTsOF5kbITCa8mamWqtFQowkAG0He9g
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:a82:b0:dc3:6b67:9342 with SMTP
 id cd2-20020a0569020a8200b00dc36b679342mr126270ybb.4.1706071879410; Tue, 23
 Jan 2024 20:51:19 -0800 (PST)
Date: Wed, 24 Jan 2024 04:51:12 +0000
In-Reply-To: <20240124045113.415378-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124045113.415378-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124045113.415378-3-yosryahmed@google.com>
Subject: [PATCH v2 2/2] mm: zswap: remove unnecessary trees cleanups in zswap_swapoff()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

During swapoff, try_to_unuse() makes sure that zswap_invalidate() is
called for all swap entries before zswap_swapoff() is called. This means
that all zswap entries should already be removed from the tree. Simplify
zswap_swapoff() by removing the trees cleanup code, and leave an
assertion in its place.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index dcdd5ecfedb09..78df16d307aa8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1808,19 +1808,9 @@ void zswap_swapoff(int type)
 	if (!trees)
 		return;
 
-	for (i = 0; i < nr_zswap_trees[type]; i++) {
-		struct zswap_tree *tree = trees + i;
-		struct zswap_entry *entry, *n;
-
-		/* walk the tree and free everything */
-		spin_lock(&tree->lock);
-		rbtree_postorder_for_each_entry_safe(entry, n,
-						     &tree->rbroot,
-						     rbnode)
-			zswap_free_entry(entry);
-		tree->rbroot = RB_ROOT;
-		spin_unlock(&tree->lock);
-	}
+	/* try_to_unuse() invalidated all the entries already */
+	for (i = 0; i < nr_zswap_trees[type]; i++)
+		WARN_ON_ONCE(!RB_EMPTY_ROOT(&trees[i].rbroot));
 
 	kvfree(trees);
 	nr_zswap_trees[type] = 0;
-- 
2.43.0.429.g432eaa2c6b-goog


