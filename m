Return-Path: <linux-kernel+bounces-136474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA089D471
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99738284026
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E3712F5BB;
	Tue,  9 Apr 2024 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPz7Hmr+"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3A12F383
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651246; cv=none; b=trxGZ76nWFQJknYo4qa2aH8/+Zt2K+LWy+RMDrFg0TK/sixjaZ4EZVaLze9O1hSvQ/ovcvxu+SwrhozFyjT0EavMHmEVj3EhwpNNGBQP6xX6oKHh9lETYPQjpg6ZWIm226wgLfXZAMuO80TPp92ovK2/lHizjWIKG/4oeEiKddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651246; c=relaxed/simple;
	bh=NInqBO3mqli5kAaFy5yCoXoiS3x2iM4UBcvy+GAsVlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GrlFx6u2VuhOJy6Jm4QRWVmoqG3wRfgHQY21LNJn6RvPPMT0y4xsEo4C2JiZTS9aq9yKoXQn11r6OmQZcT+7RRJi0KNlSX5k5ZaPKhaLP3z4XbgOHvtsesjzEXPFKK6f2VmkhZwgkSheABJa6Rqm2AZkwRHog7GSYufziNgpCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPz7Hmr+; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa362cc2ccso1750910eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712651244; x=1713256044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvJHnREnFZ1cH5hEIu5QcKzQyYhaFholreUs1EUriRY=;
        b=hPz7Hmr+4DxDSD6V4Ax4T3+darDvLJjsik/x8oswVLk2+hxUQxcfYwRDK4pwgv67gs
         Ch3QAm+f4gr3DrtPBa9F+081nIokKqClGBQB0NXdO7KdUP+AB6yTLRAZru1pgjnoNBtW
         R9ohOkpd/ncn901W9pQENVOWkLrpXsCRAYDLWMkRGhQz232LUzQPAmZGkFZxo4T2C3pf
         ZRaOgTBhWvATd1X9zmM8q8jNF/5hgV7YaRswsTkFHyOpXLQC1sVVgTkFT9C3r5CBLVpj
         zTn8Y0SDTsqXmklGwNAYhUOP649W9teqEV3Ge7R5uZQqN37P1rrMb4TAzLa5fuYqa6tK
         +77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651244; x=1713256044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvJHnREnFZ1cH5hEIu5QcKzQyYhaFholreUs1EUriRY=;
        b=iAY6bCNJaXsJ0bL4mJW0r+0cBrXVl6XUXiQ0qHPqC/O20F3HhtTYk8v+jt5xDSp8u5
         c4x8+O0rRwoJ8mMp6r304n9xFhve96PYI4ZRW8xhKRGq/o1V8T3HlmoImvH2v+TEdxG9
         HMq1AmOa+lXVJjhX6nFOAGNLy1qF9aKhJUbiQ0INRNvbAqMD9WH4w/iTCl5ZiiYZrq6a
         QK91CYzguVph5NhxwUprOQss/itRfknHsSqVeavHCF1UNVj9NvqaIFrzdDmT8V6N2ZlM
         xBYXDkKcDdhVM4iQNCzl3UTmjeed5Yg6WssjNLOcWHxVv3lj1TNLPQnK5JvfnJIAJkOo
         urKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo0RS/DQ2lnJb8xNZgyZQ68hgR88o4CDZMnlq+4JWg4xXpQYb6SJl3A2tzSLOhr5z6H2Vr9qs4JEUAIkENK3wpTPqsfuzZndO2ZLCU
X-Gm-Message-State: AOJu0YyS52DeHbTzR+gP47r3q9cgKQWUBQXrKfeMHSNPrZk5rEoaRaxs
	IQjOUFj2ORqGY59rqSgSyccp4Z7FWVYgFKdHPQBlcKtTrJwPAUNf
X-Google-Smtp-Source: AGHT+IFBs0lnKgGergw9nSynKWYDcWV9NAHxsayy25kkPHq1gK1xpsfE+xyR/l1fPI85a7fcICPnHg==
X-Received: by 2002:a05:6358:d39f:b0:186:102b:777 with SMTP id mp31-20020a056358d39f00b00186102b0777mr9881254rwb.10.1712651243980;
        Tue, 09 Apr 2024 01:27:23 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id r16-20020a632050000000b005f05c88c149sm7594238pgm.71.2024.04.09.01.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:27:23 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] mm: add per-order mTHP swpin_refault counter
Date: Tue,  9 Apr 2024 20:26:31 +1200
Message-Id: <20240409082631.187483-6-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409082631.187483-1-21cnbao@gmail.com>
References: <20240409082631.187483-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Currently, we are handling the scenario where we've hit a
large folio in the swapcache, and the reclaiming process
for this large folio is still ongoing.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/huge_mm.h | 1 +
 mm/huge_memory.c        | 2 ++
 mm/memory.c             | 1 +
 3 files changed, 4 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c8256af83e33..b67294d5814f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -269,6 +269,7 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_ALLOC_FALLBACK,
 	MTHP_STAT_ANON_SWPOUT,
 	MTHP_STAT_ANON_SWPOUT_FALLBACK,
+	MTHP_STAT_ANON_SWPIN_REFAULT,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d8d2ed80b0bf..fb95345b0bde 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -556,12 +556,14 @@ DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(anon_swpin_refault, MTHP_STAT_ANON_SWPIN_REFAULT);
 
 static struct attribute *stats_attrs[] = {
 	&anon_alloc_attr.attr,
 	&anon_alloc_fallback_attr.attr,
 	&anon_swpout_attr.attr,
 	&anon_swpout_fallback_attr.attr,
+	&anon_swpin_refault_attr.attr,
 	NULL,
 };
 
diff --git a/mm/memory.c b/mm/memory.c
index 9818dc1893c8..acc023795a4d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4167,6 +4167,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		nr_pages = nr;
 		entry = folio->swap;
 		page = &folio->page;
+		count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);
 	}
 
 check_pte:
-- 
2.34.1


