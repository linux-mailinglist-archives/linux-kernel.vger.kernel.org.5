Return-Path: <linux-kernel+bounces-75683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0842485ED5F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22BA1F24274
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7EB12D763;
	Wed, 21 Feb 2024 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VepxDnJb"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0312AAE4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559401; cv=none; b=Se3/iLlXuOMPVfLBMd1yJ13xpS12txZI0EUk3WRN7UFjfQBZP7uRaI6Kwbs0qrLB2KX7d+swZWujBqkauUjMJtU4JE71b2a0/KLeHi8c6vOGWsAquh4GnWzsBv/IQ/imCCzFwLaDfWyA3Q+dX3JQt/7nNlmudRicQSZ/9TU7zYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559401; c=relaxed/simple;
	bh=JKcwE0zsOsh6vK/ygPXzv/3swhs7TMsE30/0uIhDBZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tiz+M1AER47ov5W57qdxzLzCpjZvpkxdalygLIBw0j+MaQzD0/2X+INeIKt0igRSxpGBAaWhMdA0sJIKzBzw2BsPLrNnxwtdK/sieG/Ckblnl9ysJ3gagJ4/G9ZWhEVwTMDUj3GzSaZm5vSV6PIvzl2VbRFOdMIGIvV6dzuoYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VepxDnJb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc49b00bdbso1657645ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708559399; x=1709164199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9r0dNhUKJEdGKYYdAqMzZgO1joAP6x5GpmEzjGgfls=;
        b=VepxDnJb5Wn21JYy7a5rspPJkOkKNAQJ0mtJISEP01l+ggPObyMNOkup+EMs0d9ZCO
         LW/pc+4VsmVRUzU4GyNdOQ/J3JqDd4jm3aaJqxPM8s12MjbAE75uB5ZSRsiXqozI+/Ye
         gQuJLV2WD45Prl1An458gg+8foQ+lqTzCkA9hHEnwnBY2F8nTTf2RSM9nD7Gt8D+Cozv
         Sawe8pd3xatPCZnL4lSnxRr7gMYQv5e11ec1zrPS11LFah1yaiYcfdrrYHvQa007AbV5
         5Q2TAXtPj/efQDdo8OtFZKpkH3YoOu58yBtq1flEXwaHzxyYyy4NipL0lXOSG82QodKB
         qxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559399; x=1709164199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9r0dNhUKJEdGKYYdAqMzZgO1joAP6x5GpmEzjGgfls=;
        b=AuTDxqwO0ZKcjrZVmaFAFWxejW3cQ5lLtAqBu6RCAvKgUCJ0QZ33A4USZdvpJpVAyZ
         uHSoO7/kW5eR/xoCYPQo9hN+2Jb68AhblHG7KkxI5FnxfQhmp18HCux/NmxckMiLFPA6
         T9rRlK04exl2aRSNfSSINZypdlWM99BSyq1pyE9BIMMaydkJuVqHiOir6mP6nQXAFDSF
         rrc82xripODiSCgrR92f/BswQFYXgo6Xm/gpnevr8VNRL2VffHI85iKt1n+Hx1NWvxKB
         au83j23BapzJPB03PV8eF6WZnhIdLq71WZW8/NZ2Ak91hgcvtYyqp167k7ZeMFf82NDY
         1FRA==
X-Gm-Message-State: AOJu0Yy3OJJiy+VDRq+wFlCx64JBesOI6ZBK3kJQsbdIqkDG+vzSB2te
	FLdVtsBomTDdRLrPWqmIhqhBIbgzacizmKBSZjBf7eO91g1aZFxa3sSIxxu5
X-Google-Smtp-Source: AGHT+IFr5csdbedkdbc7gfWNEnT4VGUpgBUjTFBU/uVZRy4b5xVJHZlEkUhQBpB/fS9dWQPuHu1AWQ==
X-Received: by 2002:a17:902:d4c6:b0:1db:d2f7:68a4 with SMTP id o6-20020a170902d4c600b001dbd2f768a4mr14329598plg.24.1708559399353;
        Wed, 21 Feb 2024 15:49:59 -0800 (PST)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id jx3-20020a170903138300b001d752c4f36asm8657794plb.78.2024.02.21.15.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 15:49:58 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 1/5] mm/memory: Change vmf_anon_prepare() to be non-static
Date: Wed, 21 Feb 2024 15:47:28 -0800
Message-ID: <20240221234732.187629-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221234732.187629-1-vishal.moola@gmail.com>
References: <20240221234732.187629-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to handle hugetlb faults under the VMA lock, hugetlb can use
vmf_anon_prepare() to ensure we can safely prepare an anon_vma. Change
it to be a non-static function so it can be used within hugetlb as well.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/internal.h | 1 +
 mm/memory.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..b9b6b2bc1663 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -103,6 +103,7 @@ static inline void wake_throttle_isolated(pg_data_t *pgdat)
 		wake_up(wqh);
 }
 
+vm_fault_t vmf_anon_prepare(struct vm_fault *vmf);
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
diff --git a/mm/memory.c b/mm/memory.c
index 89bcae0b224d..c93b058adfb2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3081,7 +3081,7 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
 	return VM_FAULT_RETRY;
 }
 
-static vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
+vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
-- 
2.43.0


