Return-Path: <linux-kernel+bounces-14733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2674082214D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD9D1F218B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2664915E9B;
	Tue,  2 Jan 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOxsg8N0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CEA15AD4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e7dd8bce8so6873239e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221199; x=1704825999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX7TcFMuiFXtsjOyyf3a39fplMDkCgu6S97Vy7SNSKo=;
        b=ZOxsg8N0TsGN/pQkciU6mluz34KMi9OYuVTieW6qWnpNTuzV5DfpDWyCKnVA7yiAXi
         DicU88Q1BgtSbNLVYi2ST3VXA6aB3/oiOvZVzt0rHO869XozGWWlL3RJ+oyXxxcKtBpJ
         z7aY6BgyE3fpOaLybNh/egsswZizY9Vsodz4AApWIQx1dpeRogehgmBUpPGsh81XBzmo
         bGAvPjuj7+befTOkUGSiM20AMlrMPNP7Y/6Y7/cFWUPDTdXj25VCgrsPC39tlD03pKbC
         69DsbxShGCWSqKq/sUBxO7PqdrxyChMl0FGshSgb6FYdtl5xE1EFRbQq3cJeaIx3wBnz
         0e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221199; x=1704825999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX7TcFMuiFXtsjOyyf3a39fplMDkCgu6S97Vy7SNSKo=;
        b=BbB318DQ+9wvyjNT7Oxx+5Ql7gu5frn+BCugUVBdgluf59YUidxhcC3PQp8nm640Qa
         TdJWW5oF52OkglnHn+d2kN7wgLQI2mBfUX6L2dDFTACAhACfNqeQ83a405ZpkRVzf8pi
         YbGF8AzPUXSMVjAXSLnOT96bg7nEH6LQQFFvVlYYOhSOKVibcErJsPQPkawYiCpm2tCq
         SmRgmhZg5fggUcPuYZb45n1gBMf/Sq3/t47swOOpXbXC/kGYqJ4oGQlH6K/yNKZsfw4n
         KC9KCyAuVzHgaRrINPU4SygTsnKmwlHEqqC47GszwgqvNnJDmbsfqkdlOhCm3bQEH/Y/
         hkrw==
X-Gm-Message-State: AOJu0YwV7h7lWhumf1T5F0CgzB9+nRS44/4wORgCJ7invV+TLGRHxtHg
	rKG8iceXnfsBfUjGFgDkYCc=
X-Google-Smtp-Source: AGHT+IFb3oZclXd0Au63TOx+OSB0Wz5akV/2lKhF4t3qWVHWtcMSu2kZ5bT7p0eryTowoUB4TO5dpw==
X-Received: by 2002:a05:6512:78d:b0:50e:7a91:7e93 with SMTP id x13-20020a056512078d00b0050e7a917e93mr5221292lfr.44.1704221198527;
        Tue, 02 Jan 2024 10:46:38 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q1-20020ac246e1000000b0050e7be886d9sm2592656lfo.56.2024.01.02.10.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:46:38 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 02/11] mm: vmalloc: Rename adjust_va_to_fit_type() function
Date: Tue,  2 Jan 2024 19:46:24 +0100
Message-Id: <20240102184633.748113-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102184633.748113-1-urezki@gmail.com>
References: <20240102184633.748113-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch renames the adjust_va_to_fit_type() function
to va_clip() which is shorter and more expressive.

There is no a functional change as a result of this patch.

Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 739401a9eafc..10f289e86512 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1382,9 +1382,9 @@ classify_va_fit_type(struct vmap_area *va,
 }
 
 static __always_inline int
-adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
-		      struct vmap_area *va, unsigned long nva_start_addr,
-		      unsigned long size)
+va_clip(struct rb_root *root, struct list_head *head,
+		struct vmap_area *va, unsigned long nva_start_addr,
+		unsigned long size)
 {
 	struct vmap_area *lva = NULL;
 	enum fit_type type = classify_va_fit_type(va, nva_start_addr, size);
@@ -1500,7 +1500,7 @@ va_alloc(struct vmap_area *va,
 		return vend;
 
 	/* Update the free vmap_area. */
-	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
+	ret = va_clip(root, head, va, nva_start_addr, size);
 	if (WARN_ON_ONCE(ret))
 		return vend;
 
@@ -4155,9 +4155,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 			/* It is a BUG(), but trigger recovery instead. */
 			goto recovery;
 
-		ret = adjust_va_to_fit_type(&free_vmap_area_root,
-					    &free_vmap_area_list,
-					    va, start, size);
+		ret = va_clip(&free_vmap_area_root,
+			&free_vmap_area_list, va, start, size);
 		if (WARN_ON_ONCE(unlikely(ret)))
 			/* It is a BUG(), but trigger recovery instead. */
 			goto recovery;
-- 
2.39.2


