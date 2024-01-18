Return-Path: <linux-kernel+bounces-30037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C42831835
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA1B1C24C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974E624B47;
	Thu, 18 Jan 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDhrubko"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31DB20B1C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576294; cv=none; b=ouFaID1an1gpGFRElCfyyiZBpJUXHvhVwW1bOb5o/oFjngYxgqt+8/3UUv+qyivcJpYmbXs6Hlroz+rIMDdMGR3o+ICfL/M1XL/EQsDhOlP/yE2nRiu6EdvrMi86ZuT2uGjXqcvJp46dCi2hExOwlz0E4KjhMFC3K0HAQDeYuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576294; c=relaxed/simple;
	bh=W8f0NHx3Q000IPONH4BGK4nCqN6LfRPEfKrciV5t9a8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=CA16hygBrZArJwSYhgW8oJUKooXngzmcEnQeoIY57oQh3XrWWNXfjNke94P4vTAi+oHj1/yuAclUgKlbzdtsG+nsY7NDlyRNp76LsAkzH8WnZXJPsXum0M2oETg1LdzBCJDl6PpLSK3ulleMMN60AsZYlXXqiUorYO1zpctsui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDhrubko; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6db786df38dso3845147b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705576293; x=1706181093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrbTbn/Co4xZrxsx5gjY1Btb4+PFsZ1QZ40ExDZVluk=;
        b=lDhrubkoyTi2uAetPFp5DK+6HMUBjSh+L10SoBkZqz8LPj+BC+/oDSy2qLbpDdxj+z
         a0opjwTtHywfW7yevk8cO9FMR1CKSsRaKiCqTMeWFQ1TpgwJ1gXToh2USeDSE6RNbTS1
         7YEyqYEXciBIJ2w9MdPkiIMvew4nfU9qRya8/N4Db5crr2CuW7cKm58n0UasS9URLbDK
         8Q1wdghAzbGHyiuAPEh4qEkpqW7Ow0bwAeNRXZwsO/bcB3Sy1Apz9gxTXu3J+4UgvhGy
         +06CTOT9uVREgl28HSdXTgSGiE0b5AQu52ibpMGrGfLa5T6rc63PujDLJMNY28ujMIJ9
         cE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576293; x=1706181093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrbTbn/Co4xZrxsx5gjY1Btb4+PFsZ1QZ40ExDZVluk=;
        b=uwe36LMprAQ16yn5+CtSRXD5YjgrJcS7cuLR2Xe9DAKw9wm5MlpChYyLhyqA3Re7MQ
         8K1J3/canxBNtpIUzK0nH24Zm6hBma9REaTc0WCxkNvQ0lkkZPklsc4W43CTArLOmFR4
         d6Yv3j7KKDEaQ2cOhDhrazhY5zUlGiz4PKloG8a9p2bc8tQfpx3G5Cu0SHUQqMvS0nhA
         Zbs+LKbDf0ziCQ04akT8d+E2UhM3cnPV0f3TCkMQL3HC3KW4oNq2qReVticcXD0FM7Si
         /g5m4X9dkGFH1ZldFmdBCNQ2re0jBbmf+7ILZysOUogvvA1OlVE8TWp0pRSIcG0qYvXF
         Q5UQ==
X-Gm-Message-State: AOJu0Yw3NkiCHb+4nW2Rtk/tFl7xloTx0E3y+2ZXaGL8Oyk30rg175K8
	1zguir9AC0eirLN/VHOAvyY3GW3fIHX6oYGdz6mcLkNtk/3Ixq5L
X-Google-Smtp-Source: AGHT+IF12opuNoryR9vVFMwwLQb6LE2P/B1s8ZwHCzxtTLJ9aOUfJO5mW5VC3XFfJkko5dyhT2a0+g==
X-Received: by 2002:a05:6a00:174e:b0:6d9:bd63:e3e5 with SMTP id j14-20020a056a00174e00b006d9bd63e3e5mr689678pfc.26.1705576292986;
        Thu, 18 Jan 2024 03:11:32 -0800 (PST)
Received: from barry-desktop.. (143.122.224.49.dyn.cust.vf.net.nz. [49.224.122.143])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a0021d300b006d9be753ac7sm3039107pfj.108.2024.01.18.03.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:11:32 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	surenb@google.com,
	steven.price@arm.com,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC 2/6] mm: swap: introduce swap_nr_free() for batched swap_free()
Date: Fri, 19 Jan 2024 00:10:32 +1300
Message-Id: <20240118111036.72641-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118111036.72641-1-21cnbao@gmail.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20240118111036.72641-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

While swapping in a large folio, we need to free swaps related to the whole
folio. To avoid frequently acquiring and releasing swap locks, it is better
to introduce an API for batched free.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/swap.h |  6 ++++++
 mm/swapfile.c        | 29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4db00ddad261..31a4ee2dcd1c 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -478,6 +478,7 @@ extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
 extern void swap_free(swp_entry_t);
+extern void swap_nr_free(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern int free_swap_and_cache(swp_entry_t);
 int swap_type_of(dev_t device, sector_t offset);
@@ -553,6 +554,11 @@ static inline void swap_free(swp_entry_t swp)
 {
 }
 
+void swap_nr_free(swp_entry_t entry, int nr_pages)
+{
+
+}
+
 static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
 {
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 556ff7347d5f..6321bda96b77 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1335,6 +1335,35 @@ void swap_free(swp_entry_t entry)
 		__swap_entry_free(p, entry);
 }
 
+void swap_nr_free(swp_entry_t entry, int nr_pages)
+{
+	int i;
+	struct swap_cluster_info *ci;
+	struct swap_info_struct *p;
+	unsigned type = swp_type(entry);
+	unsigned long offset = swp_offset(entry);
+	DECLARE_BITMAP(usage, SWAPFILE_CLUSTER) = { 0 };
+
+	VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTER);
+
+	if (nr_pages == 1) {
+		swap_free(entry);
+		return;
+	}
+
+	p = _swap_info_get(entry);
+
+	ci = lock_cluster(p, offset);
+	for (i = 0; i < nr_pages; i++) {
+		if (__swap_entry_free_locked(p, offset + i, 1))
+			__bitmap_set(usage, i, 1);
+	}
+	unlock_cluster(ci);
+
+	for_each_clear_bit(i, usage, nr_pages)
+		free_swap_slot(swp_entry(type, offset + i));
+}
+
 /*
  * Called after dropping swapcache to decrease refcnt to swap entries.
  */
-- 
2.34.1


