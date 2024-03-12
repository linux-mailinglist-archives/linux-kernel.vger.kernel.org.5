Return-Path: <linux-kernel+bounces-99808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F97878DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8E11C21770
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73476111AC;
	Tue, 12 Mar 2024 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ueph0Upu"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FADBA39
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710215999; cv=none; b=kHjU/stPT3JZuBNbXCVhjcduW7QCKiZfqhljwUC1EOl1A1NY9pgACjXJERlHWyzUGl2ClNs7J4wXKYIugA3AdFFvrp21fXC96o4c5/n3o5fjp5GjMKAfKpeyzX1z3wNMl23OJr8W8GD/IAaoWfRAOfjPs2yG66V8Z0ZBEuG0KQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710215999; c=relaxed/simple;
	bh=ii5uJKIR1GUQaXN/wXyriaRdctB7IViTNGsZQo615/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J8sSntCS+gtFuT6B3I/zPViuMVvcAvgOa9/C6uwsZDYzv+O2AgncDfsWk0xhbbJdJK+dVrUq4ditG/PQKgcj2SQxOaQWDo8kJjnfsdO52KOMAE+iyK3NymyLVVMvNQFdvd2rlKLY2Dz2Ddc3Fr0RoOqwm6B9/7FcVgw5XZvJUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ueph0Upu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso10008187276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710215997; x=1710820797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAJ+3ue8h2GtGeMmVF7aptze9cHfLRbMGaK/pSc8DQk=;
        b=Ueph0Upu0fPJpwsOU9xMB6/rfyQTv8vvQSQQmteEjjm1T0c/q73aDg1ODnRG4bpz8u
         IDfQljVtnlj4NnpUzVeUVFiTzx1qAUoif8InLJj2tOpYM1yQnLDXiO2bjp7f2fJUd0iE
         H6Hy0VbC57cnCmW6vFdS70Y9QxC0ZbwlSW4XFtSJ9uh3il7XwTFDfceBynGZJmuPF0JW
         o1+hwbYM2LEDImZ+3bj8m3hovP0Kf8S5teuKDR7vj706MLhu33UIctcf7tMLRclxVg5/
         mbp6ex3Q6LEJViwyWX7j3ORr01znmGmEcb9vkahTGZiBGo5mqfWBWG7VAVzOm+jICzXn
         /v0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710215997; x=1710820797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAJ+3ue8h2GtGeMmVF7aptze9cHfLRbMGaK/pSc8DQk=;
        b=eS5OHFLjY79PteTjywraJN1lAbXPYfR07iYgAnYGTo2KrNWRrnGOHXM8wWKikBh4Gh
         e82KoARoH4auW75KXgYbW8hQBwvVOXi/cz0xGL1k9heV9ZIgez/LDb0fWIC7ePeluk3C
         qu8QbanYV9QAXtl3EiLzsrwzUDnkYY7FjecBZF688NJBuiiHULeiOYziG3t61d/GRYcy
         oYAEztxNqjzWxMqd8ck4T4FQWiMBR3ExVPCoxI16y4HpMk+sod3ZdTYoCFTEoIlE6Ag+
         CCmT0HhN5SYvR/FvvciBnO3etvAhwPP4IZWFlvnWH1a7yIW8CmH2Px+gLnEOF07nnYtF
         qQxg==
X-Forwarded-Encrypted: i=1; AJvYcCVEbw7DIHL9bNMTFUxyHBQV7cFE2PfvLlDbh73e86zOI499wFFGjg6k2Cc9+5U7mGKVJ21KO8abvgOd+NkmS6axVjdSc7ftBwiIrD49
X-Gm-Message-State: AOJu0YyZnYsiAkt8Ia5j0ir8X7aKbqCbGY9RIbuBqB8lreJO7c7Aeel6
	pr+m7VOImUgG4MQDscO7F0tqNMcvY4yLB9hoTPfcPru6RHX/IITIKS/vQi2HDDCxQSyp4pB/GpE
	FGdHJp58aIYH8Zs8nyg==
X-Google-Smtp-Source: AGHT+IHHHQjD/GEWT164UF9qNBAO6Zdv0oaS7UwIqMuvXE4Wlv6Tn55WWEmKnE3lYPTXnbsqaib7icEdWoIEAoBS
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:98c5:0:b0:dc6:e884:2342 with SMTP
 id m5-20020a2598c5000000b00dc6e8842342mr2710694ybo.5.1710215997281; Mon, 11
 Mar 2024 20:59:57 -0700 (PDT)
Date: Tue, 12 Mar 2024 03:59:51 +0000
In-Reply-To: <20240312035951.3535980-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240312035951.3535980-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240312035951.3535980-3-yosryahmed@google.com>
Subject: [PATCH 3/3] x86/mm: Cleanup prctl_enable_tagged_addr() nr_bits error checking
From: Yosry Ahmed <yosryahmed@google.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

There are two separate checks in prctl_enable_tagged_addr() that nr_bits
is in the correct range. The checks are arranged such the correct case
is sandwiched between both error cases, which do exactly the same thing.

Simplify the if condition and pull the correct case outside with the
rest of the success code path.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/kernel/process_64.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 748d2b3bdb985..0608c4df4e95d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -783,17 +783,13 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		return -EBUSY;
 	}
 
-	if (!nr_bits) {
-		mmap_write_unlock(mm);
-		return -EINVAL;
-	} else if (nr_bits <= LAM_U57_BITS) {
-		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
-		mm->context.untag_mask =  ~GENMASK(62, 57);
-	} else {
+	if (!nr_bits || nr_bits > LAM_U57_BITS) {
 		mmap_write_unlock(mm);
 		return -EINVAL;
 	}
 
+	mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
+	mm->context.untag_mask =  ~GENMASK(62, 57);
 	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
 	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
 
-- 
2.44.0.278.ge034bb2e1d-goog


