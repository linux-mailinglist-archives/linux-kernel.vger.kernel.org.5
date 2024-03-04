Return-Path: <linux-kernel+bounces-90178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1910E86FB6D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E752EB21B01
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9473B171AF;
	Mon,  4 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6e/S3c4"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC617BA9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540085; cv=none; b=A0cfFhy2sHYMMhrmWxmIj0KOuAhTqQfP7/6Fs+3yI1AEBc/e7ArnQlvS8MVUVW1QyrekqV7vQoCWdCLxCnKYxabV+lo6OXJYPuZvevbzkDAjW/slBz0L3tkyZrrrb0PDcinIcroBvV0/2jldytAxt2RJsc0mJA7svUjEhmdHa/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540085; c=relaxed/simple;
	bh=97XECp6ImGl0bxcVjD9vOm2RDIYctvChEeuK0x7tRrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjXKh7u9f6mE3BKorRqm2wB8s1/702yXd7n19NGJ44qIu2rN/BP1cVE5qpxI9opx9YRUjLUXGS8H2hJtcfd18TI8hpSlGOBEGhm9t3fCQmIR6ZqSBJrUQNNEKgO0xP1Vo5a2RgmBl7yD9Vqup7477vecYC3bObBFH5jXzjfZI2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6e/S3c4; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bed9fb159fso259233639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709540083; x=1710144883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPNnhD7u3Mm6wgXrNGhON5/bGI4wy7Z421ED7ypUMCI=;
        b=H6e/S3c4QDzprosK/gcKxHAuMi17BoaNAUBWA6yvutonMR1hjZ5quIM9q4ydHdLUPK
         mYYbkKOxbGEFGRTYqRxYbtfbBZL/qEwNff4sjuBQNIUP1yRI3WbKTegaRgzMLwLjJv2Y
         4sSItnarMVwRUXPEaiqugCursDRdZxQ5ahWFyO+UaU5pTyqpPKe7ruadjtpADL/kVsyi
         tsUCduR+85/UgU2pMH1nTdXEgWWgr6ovWgues7skBZ5GmhLxuzv1OCgXHUqVzKrx9Jvf
         JVvLKCS43ny1UPy4xp40fe77dG/bh9EtjkjSBMy4IE2upl2CMU8Bq/JtGaDtIdWZCbl/
         IxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540083; x=1710144883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPNnhD7u3Mm6wgXrNGhON5/bGI4wy7Z421ED7ypUMCI=;
        b=W34g+PakdrWOj+2qyCDgX8wGJbZ34QopM9PVrGA536bR0WnMrDZ9zIiGEi3VUx8oly
         ck8dodIdviikGtywI78uLcIrbCfSoBCP+Ozgl1L+99s3aSKfBmXeXXDvKWIBa8rW6yY3
         VZznoOLTdR78k/YoiflUrathnNFcENJtMnfPErPeAUzUzdpTolG0GLQ0AT7Z+vG9+YDT
         4JVBJTgsDlcdahEVeI1f1xgXuG7dvnKzWm2bhqBnZee/vn4W7i1EGrw4821YiYX2zXBp
         wAKG8tQ7NAqrMHzprLG3A6YzdgUfGjBuUo3d29diYrZRtkkscaOxTu5ae7a2R6cOwRDz
         aqQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMluaJzmg6eulZth0Fq3eX1YgGR6TMQzG+PkQIM9/T2c7dkEXLyMwr1nMurTZ0x24xAKuNbGMWe8SmeSml2RU0+DeUc2PZ408XK1C2
X-Gm-Message-State: AOJu0YxWi2WNjsV9KCUiRJmqQspwSKVIEn4jB4RIhm3qoduoyMQkb6UP
	AfKiHptdCycclF1p6dPo8KLOGIOnHqyODNEZW08YrtRn5NmOD01V
X-Google-Smtp-Source: AGHT+IGUq+bnojeKaoe2OXAEqxwKRkmXLSREbs2hTuKe5Xt3pOS0+qxiK9Mn4Apyji0BmRbt8d2UYg==
X-Received: by 2002:a05:6e02:1567:b0:365:f8d:50c3 with SMTP id k7-20020a056e02156700b003650f8d50c3mr11150779ilu.21.1709540083664;
        Mon, 04 Mar 2024 00:14:43 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id ka42-20020a056a0093aa00b006e558a67374sm6686387pfb.0.2024.03.04.00.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:14:43 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com
Cc: chengming.zhou@linux.dev,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	nphamcs@gmail.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [RFC PATCH v3 3/5] mm: swap: make should_try_to_free_swap() support large-folio
Date: Mon,  4 Mar 2024 21:13:46 +1300
Message-Id: <20240304081348.197341-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304081348.197341-1-21cnbao@gmail.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

should_try_to_free_swap() works with an assumption that swap-in is always done
at normal page granularity, aka, folio_nr_pages = 1. To support large folio
swap-in, this patch removes the assumption.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Chris Li <chrisl@kernel.org>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index abd4f33d62c9..e0d34d705e07 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3837,7 +3837,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
 	 * reference only in case it's likely that we'll be the exlusive user.
 	 */
 	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
-		folio_ref_count(folio) == 2;
+		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
 }
 
 static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
-- 
2.34.1


