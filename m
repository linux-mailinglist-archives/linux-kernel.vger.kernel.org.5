Return-Path: <linux-kernel+bounces-67513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F31856D09
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EEA4B2A559
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E23139565;
	Thu, 15 Feb 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0rTxfC+e"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E11482EA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021696; cv=none; b=jx1JV/KkfYVvOOdGA2qOkH+xeWTU+9TjddT5IWBeo6ZKc0lSs/nITcLPzCtFPndOEGLGs4zTeN787icsnRPQ8TbOig9HGglsAUcMuV7DRZRRoqGSyGHxyCj//eUtvCONDqAjO7qRQI2yRonNi0gEO0UwbgCSIHgiQW2vj/ck+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021696; c=relaxed/simple;
	bh=LpW+SzLj8BfVDIjFaKNHL0Ok3LPjc7UMqw1W2Wqi+nY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K6H2n+QrJmcMjrlAe7YwOKNOeiyEbD+z++nfeY99JpSQjmbyh3LEqOULugB/Jwy2QiM2OTxJmjZxdLVU/8n0vrKQQpmoQBlqIYNpvnylihYcL/HK8rkOLaRoU9wHJ3W+AYt6mkFeht+fN1QbBMP7psw9RfKqKdsN4ZPwdNHoowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0rTxfC+e; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so1474663276.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708021694; x=1708626494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HDhVk/yBydR+FOGweImS2i3jLRp26hrWRjwdpWJGjA=;
        b=0rTxfC+eTBDYH3Z1M1HqIJWn7Goozw3FI73wRLEb0mMZCv227NJ6Ri02Y0Z3mA3/vY
         a/Q1gOxnf+xbG1REHzcTfer0LijnkT71tgOZVGfWDSGWqisQaHgJHjtgV/a0kRpLVrKI
         EumlOVtRD+jLj1IfQLimb/xRrYEWgEcctfFTFAb+8YyTmkdX4rlMENhpUb5xp35kvplu
         bnJcC1mYIyj48eUGY327JRxynEVLyeGjggw2YkMN1prqxqmkp5QBoS1rUtZC8axeVfR7
         dZlVHtHctDe3+lOBqhnAffys4JnLG/4t2r4fC5bNDCYGlp8T3z8hawDo0J6XUyTzbl6h
         D2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021694; x=1708626494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HDhVk/yBydR+FOGweImS2i3jLRp26hrWRjwdpWJGjA=;
        b=r4ySstuf65LmRRxf4jEAqYOrq4U/gU+Mp/oVgJtDBgafNL5WqLyPioByQGj2ZVF5nj
         jy7EEwAhNIX9oSriKCn2bPtR6IOfU9eAikaTk2kxJRYh5V9qY/QfZIO8kiSkne7PrIXc
         fywX6Z/ASCui7GZie8HLnMBAElrvveYHGgVJftrWnCPrRc+bTnX/trYsicudFA2cGt6h
         yLBhjPPQSdJm18NJA8SYQTy/mcbSI6PweFxjvNTmA9+hLyzAe+5hnIzFhnVTFB2AQj8l
         htNn5F16NhjBJeZnIrN0gkBwm17IlcNrd+2U5Hp2feB/wI7L2Le7yrbbLOONzEq02qI+
         qbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcQSXWofuXYX7TncJ6o5CkhdWc83svdgjFUunAc19qErQ+gAMFoB3oaS11VCfnui1kq64diMb8AlcCPF/tXeKSlIKHjKnYisEmTm86
X-Gm-Message-State: AOJu0Yxp8WN0ZGocthjm/+zgUNouTb4kOaPcnOmu0dPermOAQut/NreJ
	A3VnQCUfDzrOYnmnVhaZ8ZuwBDHjvlvnWEoZX+ZcwYcPDt2s5SKItlbQI2+t8BIouz4CHieO5WG
	2XM6sGpyyPIvFkHtgZQkCIg==
X-Google-Smtp-Source: AGHT+IHQ/q6hEwod6dqa91JCy+4OwG7tKpKMnghYXGTo32mJNLEG+qzCG9zHFQLNQzOb5szaIYoSCz2kHnP0FoZoZg==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:6186:87a3:6b94:9b81])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:100a:b0:dc6:c94e:fb85 with
 SMTP id w10-20020a056902100a00b00dc6c94efb85mr101286ybt.2.1708021694438; Thu,
 15 Feb 2024 10:28:14 -0800 (PST)
Date: Thu, 15 Feb 2024 10:27:55 -0800
In-Reply-To: <20240215182756.3448972-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215182756.3448972-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240215182756.3448972-4-lokeshgidra@google.com>
Subject: [PATCH v7 3/4] mm: add vma_assert_locked() for !CONFIG_PER_VMA_LOCK
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"

vma_assert_locked() is needed to replace mmap_assert_locked() once we
start using per-vma locks in userfaultfd operations.

In !CONFIG_PER_VMA_LOCK case when mm is locked, it implies that the
given VMA is locked.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3c85634b186c..5ece3ad34ef8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -781,6 +781,11 @@ static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	return NULL;
 }
 
+static inline void vma_assert_locked(struct vm_area_struct *vma)
+{
+	mmap_assert_locked(vma->vm_mm);
+}
+
 static inline void release_fault_lock(struct vm_fault *vmf)
 {
 	mmap_read_unlock(vmf->vma->vm_mm);
-- 
2.43.0.687.g38aa6559b0-goog


