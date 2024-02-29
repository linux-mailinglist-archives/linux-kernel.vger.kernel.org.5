Return-Path: <linux-kernel+bounces-85928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ECF86BCE3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341001F24F86
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A41E364CD;
	Thu, 29 Feb 2024 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpfQZsm4"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A10364C0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167130; cv=none; b=mM40AqSpPtWWLpbAnEI85VluNRTZKcEZzG346xEk5Yv+XpdlVYMylLnBClPuy3G76DLyaAb7KuJ2ngdt3KdPjKViE5/hpO51mbmjIkMElUVamAMv7tptgRlUC0NJ19icfXYuHCY6k1nFXx1FrnGTQgE0513JrAYkZjvI7GW1MoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167130; c=relaxed/simple;
	bh=R3LQ+u6f5MkP7av2fnteoi3gqkMKiE8GmMQ/DN9Lv0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7/8eZU/er2MctVF5j71NszMlSzBAgCPlX5IbCCvokWD3BbGnuUWAiueZ45KI/JoF5FUqQVjFjY/HSJ15osGGf834OOd/2zw2mi26/gkDUuNZfe5DKNDz7ur3PhilzAGtsn7HqMkvvfMtjnGyLjiyPOfFq33LAiWvqaEG2J9nXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpfQZsm4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso3566845ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709167129; x=1709771929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdVUS/tLhNyeqOoyodd3YqCiZJm0fvc/nLmJZ8OGUGI=;
        b=hpfQZsm4+tKvYyiJMwjnLFJ/YGTBuZHJO4Bqpl148QvmW190VP5m9KbJ9+bvi1wRkv
         CBM6H3DbhKHcCLsOgC+rJqORZsd5l/oncm9rkifxx5MxV8gKbX/E6qfivqC21hEbp3DE
         zTkj96cKDRd58enbq9Yqa+QECiwUz5PzzeLZLHqSJQkmBc/JyV7LSLWYS0RYUxWfY+SI
         D29bae7OM2AT9zoYJ7ljVZE6sFmZf7Ud+r9u5Mx+e+l4/iX5zGvWeBmpEMAeheILzTFN
         6SGxMz5elTz+o8mKTHnU4E2r86BKO8k1zp/THkpXjy8ZtPdslPVm2vWgsEKf+of9IlV8
         3PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167129; x=1709771929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdVUS/tLhNyeqOoyodd3YqCiZJm0fvc/nLmJZ8OGUGI=;
        b=wMvRGrKtX/XnB1TEO57VU9FnqZfT90fXpw0KOPvm1lI9SOK6op/4b5jpYt/khGrp7h
         sQu5Lecc9b269OukRwP1OdymkAF5d3c+MX/TIgrOUZW96dxnGzg8UnmZ0PTEe7i85CQM
         6UYFfBd08damz2ySeO9uDyCHN0LkZW7l1Q2N+esOFD5tgq/bmqRhbJXFmk0JrvlX6pre
         +egRDakaveWhX7u721Z0MeS5BhjDg1sfWBHedZVkbzSzxIzeO1LRyL9AMp4cEXkMkWJZ
         A9IXz8fUq14yEwbqLe9atFQ7osARVHQRBO2xrldFiD5rZZqBc1I4cKAXdupJshv2un45
         pEhg==
X-Forwarded-Encrypted: i=1; AJvYcCUuhZYt3B6YLiDPQUOv2XbPhonhw/VOs//oXv7hpV49CxtF/vaazAiyp6d+kySE5y/Xqz/CYrZ2BY621hbMzPcY1rACbIjAaJJOL2PT
X-Gm-Message-State: AOJu0Yw3WegEadmVYpnqmhlKJsYyYlSOVzv3uYmdgE3371W2c77sBmrs
	x8P65XmPw0F68h2to4FhY9aZRdsmP8voLsFgxywAr3V8o6A37dO9
X-Google-Smtp-Source: AGHT+IEuGt8EvEpQqxAVqcPMvnU0WfE0nNgN4CSstXtrAZpJfq6DmLPZKApzsi42Su3R2d3MnQpTcA==
X-Received: by 2002:a17:902:7d82:b0:1dc:b320:9475 with SMTP id a2-20020a1709027d8200b001dcb3209475mr648542plm.13.1709167128925;
        Wed, 28 Feb 2024 16:38:48 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:5158:ed66:78b3:7fda])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001d9641003cfsm62647pll.142.2024.02.28.16.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:38:48 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	chrisl@kernel.org
Cc: 21cnbao@gmail.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	kasong@tencent.com,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	hannes@cmpxchg.org,
	linux-arm-kernel@lists.infradead.org,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC v2 3/5] mm: swap: make should_try_to_free_swap() support large-folio
Date: Thu, 29 Feb 2024 13:37:51 +1300
Message-Id: <20240229003753.134193-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229003753.134193-1-21cnbao@gmail.com>
References: <20240229003753.134193-1-21cnbao@gmail.com>
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
index 319b3be05e75..90b08b7cbaac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3904,7 +3904,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
 	 * reference only in case it's likely that we'll be the exlusive user.
 	 */
 	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
-		folio_ref_count(folio) == 2;
+		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
 }
 
 static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
-- 
2.34.1


