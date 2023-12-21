Return-Path: <linux-kernel+bounces-21314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1737828D6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EDC1F25F5D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C6B3D57C;
	Tue,  9 Jan 2024 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5zsyK8K"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50F63D540
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d99980b2e0so2894519b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704828716; x=1705433516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boBDnUGC8eDAyWfJkqoTtfypKbl4pabOXDd3nFFPUqc=;
        b=X5zsyK8KYeGlffhodOWhOgK7mNXrS8rtSWu2P/kN/9iLrxCXLtZLRCFsNU93KYMyg1
         YgCfTE6us/SDYjaVWD3BEfZKgq3klWd9egwpiAz4ZJS06F9USCyXz7+myktIrgqkHYMV
         Wu8dA9LJZiPgys7XX4sPJh49jpS1qcelLiB9/BrFuYWhra7SicsvPlP74jV5k26W1hoJ
         BqJ8Usko7QuP009aQUrrXa6MaPeEfg+d1DwiW3aUFi2T3NREKqbi/kbiC3Guhntf6rT8
         bhQV0gbhIXFv406/NrKQ1I4BRvWpBhVlU/nPrUOMHH0KdzrClaiEJ8MzbydOnl8SA5Cl
         zlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704828716; x=1705433516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boBDnUGC8eDAyWfJkqoTtfypKbl4pabOXDd3nFFPUqc=;
        b=fOwnVTmDbC4brAHhXqCAW6kdR2EGki22l7qgHQqKxF8Br9wI07PurLQMy9BDoG5CRg
         YmXwSskJmwYXzb4duKY6FiDczWQEOX/pH1H536JcjrII1WRI4+KYjmBbCwQXxHykOKDR
         v8NAhN77xjrK4hNCtpRjLffBc99YjKxcVoqE9Os4mP/fF18gnqPvXrznIQVKeQNRasZ4
         l+0YPkHgp1xQzkT+teQJ2vDkeMCHdgE6MO7y4mQU55grxPrb6shN5KqWRH+g2gFR713h
         q5x3HApadj32TudqBkSlP5YXQws7cWsHRrZ7WOQmzMi175vV6TJwfhBHYxGpGDzqCRN3
         b5Rg==
X-Gm-Message-State: AOJu0YyK0pbRz3T/sStFPORTcyUNjbZRWQphLmqs0fBx+gQjmSXstQV2
	6VT/aX8w/DKIab3CQp/G4Ho=
X-Google-Smtp-Source: AGHT+IEtvrNm37Vvvl0827rIgbrDG58I/0qQbKIDWzn9TwkPcvUu7DXuRPZOfZnXdYNEvE1ghK989w==
X-Received: by 2002:a05:6a00:80f4:b0:6d9:bf35:768f with SMTP id ei52-20020a056a0080f400b006d9bf35768fmr5370598pfb.46.1704828716163;
        Tue, 09 Jan 2024 11:31:56 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id w2-20020a62c702000000b006d9a0059a9asm2173490pfg.172.2024.01.09.11.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:31:55 -0800 (PST)
From: Yang Shi <shy828301@gmail.com>
To: oliver.sang@intel.com,
	riel@surriel.com,
	fengwei.yin@intel.com,
	willy@infradead.org,
	cl@linux.com,
	ying.huang@intel.com,
	akpm@linux-foundation.org
Cc: shy828301@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE
Date: Wed, 20 Dec 2023 22:59:43 -0800
Message-Id: <20231221065943.2803551-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231221065943.2803551-1-shy828301@gmail.com>
References: <20231221065943.2803551-1-shy828301@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Shi <yang@os.amperecomputing.com>

The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
boundaries") incured regression for stress-ng pthread benchmark [1].
It is because THP get allocated to pthread's stack area much more possible
than before.  Pthread's stack area is allocated by mmap without VM_GROWSDOWN
or VM_GROWSUP flag, so kernel can't tell whether it is a stack area or not.

The MAP_STACK flag is used to mark the stack area, but it is a no-op on
Linux.  Mapping MAP_STACK to VM_NOHUGEPAGE to prevent from allocating
THP for such stack area.

With this change the stack area looks like:

fffd18e10000-fffd19610000 rw-p 00000000 00:00 0
Size:               8192 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  12 kB
Pss:                  12 kB
Pss_Dirty:            12 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        12 kB
Referenced:           12 kB
Anonymous:            12 kB
KSM:                   0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:           0
VmFlags: rd wr mr mw me ac nh

The "nh" flag is set.

[1] https://lore.kernel.org/linux-mm/202312192310.56367035-oliver.sang@intel.com/

Reported-by: kernel test robot <oliver.sang@intel.com>
Tested-by: Oliver Sang <oliver.sang@intel.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christopher Lameter <cl@linux.com>
Cc: Huang, Ying <ying.huang@intel.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 include/linux/mman.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index 40d94411d492..dc7048824be8 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
+	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
 	       arch_calc_vm_flag_bits(flags);
 }
 
-- 
2.41.0


