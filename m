Return-Path: <linux-kernel+bounces-106751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAEE87F318
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260E1B210BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59C05A11C;
	Mon, 18 Mar 2024 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngg+ryjw"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ACA5A0E5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800856; cv=none; b=S2guQyYTDeQqafG0NKdGiaNAfmXWHtd7OpxjNTFmZ9t6ZuGd1Dt0BtW5FRuCVPu/kpHwz0tgGveXDaRp4fTRAC4Sl8Es03ZPMeCm54yXf4c1+u5Wo+WZw4YQl9mKdzP6HUx63TjS4rPA0de06dzrVJVwMPqxI2tbQyjCQr6lAWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800856; c=relaxed/simple;
	bh=94LsfgbN1Sfy3yGmkskJgCjkYV5jSwAENV2gNr7Lzwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=upOf0Ycg8N+eOtB0ONAVvvrHkDog7b8IA4JfzIBqSjh0NbQofek4oNoeXOGweboZTHhBDtWtmnfDEHySMia7sscypoLkDVZNRGPstZcLlQFwyum2oLZrkLHGEgN8sq8vja8OgQhs0MBeZfgKJqgL8PbRBhv0xJKyHTR4Nh/E6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngg+ryjw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1def59b537cso21780705ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710800854; x=1711405654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwWkU8lgVBm7GfNdi57Ea5vfTMMbO/0kw3dtIaZC8Is=;
        b=Ngg+ryjwmgGi30z9X13c1aPIQWG+lLtwdrreqCXuN0V0o5Cx74Bq1GrvJe7Kz7sCvc
         QRT9dhP7ruk9kSwXoyr5hy9MxIZo9bLUEMG0aQaw3mmMcFr3e8899Lwd88DHzLmeFqM2
         tU8bo4N4Hfpwph3/TcobekvWBs/spwVrPVxKniA6tOAUSXXUGyWESv8XpR69Yltx08Lk
         7Q8izR7ePgSg6Yl+/7KRDyECvm7I0CFCNNU15eGsvI8sRehuIh6h5EM9hUcIWbOvDtu1
         umzayWB8p8cZ/VyguPG6OgVTLt86iQfd0/j+dHDoJBnHy0xsHs0F6+m03s0Zjg48HRub
         qdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710800854; x=1711405654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwWkU8lgVBm7GfNdi57Ea5vfTMMbO/0kw3dtIaZC8Is=;
        b=oF5nvEqM7tQ4Pv1xn8Hx1lLoURcercXysGUcA5IclvM4rqEIcKDyR1ywtioGJgCACf
         6dDNGwzbx3h9YzV76bgdCshuqY1+auMHUfKPqld2KVku08TtZqi6EpQlKntMHs/EjL6R
         M57kVY5BdI2UBHfZkyGPN4T9YSYXZhP5G1evYqHBxPKtoGSRL5r7tCwxFS2NJ4KBOnbV
         wNWM0GvrpzCutV5bch/ND4ZCBkOKNYonMrqq/hOpoemBbiy6KeU80SIl0YrWVM2xIeEb
         CpbUW7lETnuJGf2UyIOmGJBpwSlLVdJc6ilQAMvifC6VUdo6N3xgsEFYmdcB2kgP4OcY
         j6yg==
X-Forwarded-Encrypted: i=1; AJvYcCWVEpXaiISvBUNxOAh+s1+8EeTvc0c4qxyg+ery693iuO9JmRx0PxGdMJ0BK/0OZ9/ufEu4HlEBgfpnogbmbO7qbSxZ3eFbzwRxDupQ
X-Gm-Message-State: AOJu0YzyGR7Nkvb+LS7f14nctnX5G3y2aLRWxaWQOOaFGO65QYZ2eTjs
	rKWy0QOvlCIrSdGb7GxFfLSXJNziwxopYt6kr8n9TkX+ZZBRzr0p
X-Google-Smtp-Source: AGHT+IG6hhx5i/qrmjLWaWWDMuYJHbPbaHZ0eKWQm0hdxSqcnjN/F78ReNMMizTbAWTH9kp3nP/aUA==
X-Received: by 2002:a17:902:ecc7:b0:1de:faa3:755 with SMTP id a7-20020a170902ecc700b001defaa30755mr13364190plh.37.1710800854078;
        Mon, 18 Mar 2024 15:27:34 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902d2d200b001dee0e175c1sm9124586plc.118.2024.03.18.15.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 15:27:33 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	syzkaller-bugs@googlegroups.com,
	yosryahmed@google.com
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
Date: Tue, 19 Mar 2024 11:27:15 +1300
Message-Id: <20240318222715.86329-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000009221d60613f58726@google.com>
References: <0000000000009221d60613f58726@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in __kmap_to_page
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3529 at mm/highmem.c:167 __kmap_to_page+0x100/0x194 mm/highmem.c:167
> Modules linked in:
> Kernel panic - not syncing: kernel: panic_on_warn set ...
> 

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e5eb28f6d1afebed4bb7d740a797d0390bd3a357

diff --git a/mm/zswap.c b/mm/zswap.c
index 9dec853647c8..17bf6d87b274 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1080,7 +1080,8 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
-	if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
+	if ((acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) ||
+	    !virt_addr_valid(src)) {
 		memcpy(acomp_ctx->buffer, src, entry->length);
 		src = acomp_ctx->buffer;
 		zpool_unmap_handle(zpool, entry->handle);
@@ -1094,7 +1095,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
 	mutex_unlock(&acomp_ctx->mutex);
 
-	if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
+	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
 }

