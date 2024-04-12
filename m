Return-Path: <linux-kernel+bounces-142607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948D18A2DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163C0B22C52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0C455792;
	Fri, 12 Apr 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgkAQjpF"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC53FE55
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922554; cv=none; b=G26bf6H5MeolfdvjLmRvnzpEsxb1KU6wnIdNFsDKQFkOv0ATGO3sEaIBpfjWMAJsGBSsmVIB+NaENVVHVxae/u48ONzmv8w1dN8t6QgN5pdWWa2RXtAVu/+DBppYo7wCnmZybsXU0mpqG7mV8I0L45bjOCV5gY1FhH6XNgmH2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922554; c=relaxed/simple;
	bh=Q04jTko++Wm9INNsqutLi7WWutSyIiAzg8uwXlOEhBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KaSgp3xjOqKrKg0oOVSXt/3qLLnF0u+jzHO4OtsOQopzEQM4kjUFkUgwV00Eowqy4sjDs5TbUwAzv13xnYueYpCRfEnEK7vUC3SlJiCNmpVym0conKilgfIQ6/tYmhE+T2Uqtdz3+E1gEoGzkpHCjcRs7nX8S5eLV0pRh0Py2Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgkAQjpF; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5aa1bf6cb40so469045eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712922552; x=1713527352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tz5rhJc+yuuVb5lYrBOCyx724Exwzgl0iVGVIeQYh74=;
        b=EgkAQjpFF6j+ea8py1yzjS2cBfc+JncOlA20I6AhbIE7hLnIZXyzTbCnKFXy+O4zgo
         pnMGbEl3vWShToU2N3iXvI6WNefSVwm5+WmhgoLOePEeBXxtnUiP4wBkKQD8mpxpoRP9
         gGeeH5gJhk5w9lX6qX826QuMi8RbfSzKNBaoG0SYNbw3gUcBwxr02cbQgfX9PR4Q6n6F
         y4R1HAGR4fSscEOYKm/rc0ocDEW7kasbLjzaJZxVSP87cP0mL8J4EzKlLy/tqCgusptS
         T3DxPclaFKX0sgmekFowtkvxHjRyzyoeMktP0a/+FiXn0ysUlohqKOgWiTu4xr8h/nog
         HWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712922552; x=1713527352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tz5rhJc+yuuVb5lYrBOCyx724Exwzgl0iVGVIeQYh74=;
        b=RWT6IEmpbTPliXD0TtWj0tM1PqZOeRqtqn//nb2k60xUZTAbqGfiIXc4+55lvuekzz
         NxS7O2mePRSP9I6JBoBl/MQd5k7MS8C9SI98dheIDty8ZQkyiCjYCBsxnGrllpVgNzts
         OkyeFalysrJE/ErKul0frdaOi/IEaeYXKce34lJ0Q3zJD1OSOL2B5d/0tO5KtvxzihEH
         LTSwWNiG4S6cbc1WXmYKu2WdIWkSneGo90yApHssHG3EOQlXeuwAm0QxTevImlOs+OgB
         FSTrCYtHMjv0U9ehodoRB1/BRgpQn8Ij/oSAehRP+e1em5hMmxckvHTpzTjnwchw7XbG
         Gu2g==
X-Forwarded-Encrypted: i=1; AJvYcCVmvktz+Ej9VmfxS/T7Qy6natQHvrDeoqfRWuSL2QYCjeqFi/t3Bt+sgVFl43ZBwzlKNmsRBEHRJ2ulkghkavHwsJQZjPQzbrbSD/1D
X-Gm-Message-State: AOJu0Yzy0lf+Ylr6z4r/z3lid2a9nqsLL8F8GfY8Q8wy8UX1A/0IC8Th
	upJhPzgMEvrD5al38y05QSP5hRWLEC5UmLrqB/AE//dvXnSSFAclnHKV1IyG
X-Google-Smtp-Source: AGHT+IGoLlrB1/az7wzxBwzCkP/GkjJ0TQT9RFsF15NkGD4EpE8snCMsOZiPMUh4sw8oPvuY54mhig==
X-Received: by 2002:a05:6358:6914:b0:17f:87fb:5326 with SMTP id d20-20020a056358691400b0017f87fb5326mr1970254rwh.24.1712922551996;
        Fri, 12 Apr 2024 04:49:11 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id q1-20020a634301000000b005e43cce33f8sm2541048pga.88.2024.04.12.04.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:49:11 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com,
	chrisl@kernel.org,
	david@redhat.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	corbet@lwn.net
Subject: [PATCH v6 0/4] mm: add per-order mTHP alloc and swpout counters
Date: Fri, 12 Apr 2024 23:48:54 +1200
Message-Id: <20240412114858.407208-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The patchset introduces a framework to facilitate mTHP counters, starting
with the allocation and swap-out counters. Currently, only four new nodes
are appended to the stats directory for each mTHP size.

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
	anon_fault_alloc
	anon_fault_fallback
	anon_fault_fallback_charge
	anon_swpout
	anon_swpout_fallback

These nodes are crucial for us to monitor the fragmentation levels of
both the buddy system and the swap partitions. In the future, we may
consider adding additional nodes for further insights.

-v6:
  * collect reviewed-by tags for patch2/4, 3/4, 4/4, Ryan;
  * move back to static array by using MAX_PTRS_PER_PTE, Ryan;
  * move to for_each_possible_cpu to handle cpu hotplug, Ryan;
  * other minor cleanups according to Ryan;
 
-v5:
  * rename anon_alloc to anon_fault_alloc, Barry/Ryan;
  * add anon_fault_fallback_charge, Ryan;
  * move to dynamic alloc_percpu as powerpc's PMD_ORDER is not const,
    kernel test robot;
  * make anon_fault_alloc and anon_fault_fallback more consistent
    with thp_fault_alloc and thp_fault_fallback, Ryan;
  * handle cpu hotplug properly, Ryan;
  * add docs for new sysfs nodes and ABI, Andrew.
  link:
  https://lore.kernel.org/linux-mm/20240412073740.294272-1-21cnbao@gmail.com/

-v4:
  * Many thanks to David and Ryan for your patience and valuable insights
    throughout the numerous renaming efforts!
  * Guard the case order > PMD_ORDER in count func rather than in callers,
    Ryan;
  * Add swpout counters;
  * Add a helper DEFINE_MTHP_STAT_ATTR to avoid code duplication for various
    counters;
  link:
  https://lore.kernel.org/linux-mm/20240405102704.77559-1-21cnbao@gmail.com/

-v3:
  https://lore.kernel.org/linux-mm/20240403035502.71356-1-21cnbao@gmail.com/

Barry Song (4):
  mm: add per-order mTHP anon_fault_alloc and anon_fault_fallback
    counters
  mm: add per-order mTHP anon_swpout and anon_swpout_fallback counters
  mm: add docs for per-order mTHP counters and transhuge_page ABI
  mm: correct the docs for thp_fault_alloc and thp_fault_fallback

 .../sys-kernel-mm-transparent-hugepage        | 17 ++++++
 Documentation/admin-guide/mm/transhuge.rst    | 32 ++++++++++-
 include/linux/huge_mm.h                       | 23 ++++++++
 mm/huge_memory.c                              | 56 +++++++++++++++++++
 mm/memory.c                                   |  5 ++
 mm/page_io.c                                  |  1 +
 mm/vmscan.c                                   |  3 +
 7 files changed, 135 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage

-- 
2.34.1


