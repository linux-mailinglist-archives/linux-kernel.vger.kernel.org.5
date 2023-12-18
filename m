Return-Path: <linux-kernel+bounces-3585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F901816E15
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B9AB21F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6A581E5D;
	Mon, 18 Dec 2023 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQ2PAozi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A943280DF5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-55330b01be0so644568a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702903255; x=1703508055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qETeNVW4T3lC++QM3orD9LTmmtp3iyUET5aUKhJnmac=;
        b=XQ2PAozi99uKDNjgZmOtT7chjQ1fFblS0lXkNUkPH6jZsHeGpfVXICRcSTX5EGfpkI
         svBipq0FRP+uQdXQCF32tREO5KRQDMmc4EchX8oIz/i32Mesz8zmLAn4bCDbfnu5uy0A
         vodMXL1m+4HF4mBPVJXwxo74KV4qwh9FA9jqjKbHdF51oPt1NUj9UiApPUO3r3mhdxzI
         c4qvodLOPfdUDji8rGmMpYAaBNDcjFx2fjoGJcdf1QGsHCsLNxnG9MpgB3oLc7rvY3rC
         vumaRyKp38iTfwpPpqb2Fp7KpDLaQpoS1l6JfuH4czRXvmvn6ly4WuIBV5Ysixbx8lOY
         5hKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702903255; x=1703508055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qETeNVW4T3lC++QM3orD9LTmmtp3iyUET5aUKhJnmac=;
        b=R3tYEGv1/y/obAUSHoJRfwwOXqHAZ/y+moldMy/aSSKWr6zBUiv1j24e00h5rzHza0
         V3DzvULljaIIZ+G0O+3JCYmEL9YC5tIdktCQOPgNBAj7lr+3I9plMPv/dMwfAjWsVSVQ
         l31YJm0WyrVZ4L0HQE3Hw5NDEea6thnAf95nCeYthuJf0MJUDso/moo15/8kqMvnhAeQ
         bfhkTpXnb4MXbKXRwlWgml23cVyYeRVwDo1P0AsdwyIcgtBCDb/x7ulvrbVx7KIHpPbN
         8gXvWSmNnoo+IBlKsZNuc5PxbW4rwGYQxRQGwTIug+shj5Y8ourtJOtM/b8RmyXmy08p
         dZyA==
X-Gm-Message-State: AOJu0Ywsgw2pVryHq5ej37mYN/JIKq3yTE/+AgAiWpMtYDtw9hR3wTTG
	o+raXVDkJON0D3YpPkl6PwrEhbl8WD0=
X-Google-Smtp-Source: AGHT+IEY9hmIS94WMO/1gQI8OpqW8L6q4Ui68LjYFEltyuc+bpHhQQF2yLnqqce6Ij7CvGAUC6mng50r1nM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:9a3f:c8e7:1395:806e])
 (user=glider job=sendgmr) by 2002:a50:ed8c:0:b0:553:7dac:75cf with SMTP id
 h12-20020a50ed8c000000b005537dac75cfmr256edr.3.1702903254957; Mon, 18 Dec
 2023 04:40:54 -0800 (PST)
Date: Mon, 18 Dec 2023 13:40:32 +0100
In-Reply-To: <20231218124033.551770-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218124033.551770-1-glider@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218124033.551770-7-glider@google.com>
Subject: [PATCH v11-mte 6/7] arm64: mte: add compression support to mteswap.c
From: Alexander Potapenko <glider@google.com>
To: glider@google.com, catalin.marinas@arm.com, will@kernel.org, 
	pcc@google.com, andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com, 
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk, yury.norov@gmail.com, 
	alexandru.elisei@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"

Update mteswap.c to perform inline compression of memory tags when
possible.

If CONFIG_ARM64_MTE_COMP is enabled, mteswap.c will attempt to compress
saved tags for a struct page and store them directly in Xarray entry
instead of wasting heap space.

Soon after booting Android, tag compression saves ~2x memory previously
spent by mteswap.c on tag allocations. On a moderately loaded device with
~20% tagged pages, this leads to saving several megabytes of kernel heap:

  # cat /sys/kernel/debug/mteswap/stats
  8 bytes:	102496 allocations,	67302 deallocations
  128 bytes:	212234 allocations,	178278 deallocations
  uncompressed tag storage size:	8851200
  compressed tag storage size:	4346368

(statistics collection is introduced in the following patch)

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

---
 v10-mte:
  - added Catalin's Reviewed-by:

 v9:
  - as requested by Yury Norov, split off statistics collection into a
    separate patch
  - minor fixes

 v8:
  - adapt to the new compression API, abandon mteswap_{no,}comp.c
  - move stats collection to mteswap.c

 v5:
  - drop a dead variable from _mte_free_saved_tags() in mteswap_comp.c
  - ensure MTE compression works with arbitrary page sizes
  - update patch description

 v4:
  - minor code simplifications suggested by Andy Shevchenko, added
    missing header dependencies
  - changed compression API names to reflect modifications made to
    memcomp.h (as suggested by Yury Norov)

 v3:
  - Addressed comments by Andy Shevchenko in another patch:
   - fixed includes order
   - replaced u64 with unsigned long
   - added MODULE_IMPORT_NS(MTECOMP)
---
 arch/arm64/mm/mteswap.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index a31833e3ddc54..70f5c8ecd640d 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -6,6 +6,8 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <asm/mte.h>
+#include <asm/mtecomp.h>
+#include "mtecomp.h"
 
 static DEFINE_XARRAY(mte_pages);
 
@@ -17,12 +19,13 @@ void *mte_allocate_tag_storage(void)
 
 void mte_free_tag_storage(char *storage)
 {
-	kfree(storage);
+	if (!mte_is_compressed(storage))
+		kfree(storage);
 }
 
 int mte_save_tags(struct page *page)
 {
-	void *tag_storage, *ret;
+	void *tag_storage, *compressed_storage, *ret;
 
 	if (!page_mte_tagged(page))
 		return 0;
@@ -32,6 +35,11 @@ int mte_save_tags(struct page *page)
 		return -ENOMEM;
 
 	mte_save_page_tags(page_address(page), tag_storage);
+	compressed_storage = mte_compress(tag_storage);
+	if (compressed_storage) {
+		mte_free_tag_storage(tag_storage);
+		tag_storage = compressed_storage;
+	}
 
 	/* lookup the swap entry.val from the page */
 	ret = xa_store(&mte_pages, page_swap_entry(page).val, tag_storage,
@@ -50,13 +58,20 @@ int mte_save_tags(struct page *page)
 void mte_restore_tags(swp_entry_t entry, struct page *page)
 {
 	void *tags = xa_load(&mte_pages, entry.val);
+	void *tag_storage = NULL;
 
 	if (!tags)
 		return;
 
 	if (try_page_mte_tagging(page)) {
+		if (mte_is_compressed(tags)) {
+			tag_storage = mte_allocate_tag_storage();
+			mte_decompress(tags, tag_storage);
+			tags = tag_storage;
+		}
 		mte_restore_page_tags(page_address(page), tags);
 		set_page_mte_tagged(page);
+		mte_free_tag_storage(tag_storage);
 	}
 }
 
-- 
2.43.0.472.g3155946c3a-goog


