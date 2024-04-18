Return-Path: <linux-kernel+bounces-149401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F3D8A90A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A42282563
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1721F3D54C;
	Thu, 18 Apr 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2uvgwyA"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3071E4B3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403724; cv=none; b=jSZghPEB+tsvS0p3DJGSO122GxsmRR1hnsFEWV99Aoxp25jcGvEUck1SFaa4uiENkeVXlxgfsS1xI15uyQv3YWM2yrwkGJdVk+Nc19piWX/drS9SxoB4WerllLqKiCZY/UGblMh3W2dguTcQukGMtGg4nSVPHzi0ZSvFtHF+MOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403724; c=relaxed/simple;
	bh=8J7Bs9WvE9cal/eAWsXQV05lJs/Vf57kuuuUUAVlu/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jok5BChOCUFmoJTcAtbGbnvPCgJZdr7DHzL2H0+RKuuPj9dMsLV5kU+G6VMJ0IoUSF4RknDqiYsNDA7svp4rZp253swy1+5EbxBQLUA2Z1VsFSYvLtBfop9uwnfaa5ni1z79NBHNp4NCStw4SSAnmy2+xKH1H9SkUexINMKWhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2uvgwyA; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so791783276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713403722; x=1714008522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IocH4dK3cU7wr7fT/1eXbTtilS5jPEYt4JFcTK0tuc=;
        b=A2uvgwyAjh538UhIo8N5EsQpg4E2gSzxOL+JmDyg/c/V+AQM+LCjHEh89+Ju59zAmn
         xQRcBhduCG4GEFfnqZSbPUz+0i/Q/KaVpVK2BiHTKqKQ8j21JjnOQyHr5zixtcivxMPj
         fS+9fGgbDnp4ycMh3WgjGbjayFwMKF+3GEA38bH1RDgdn44AFisMIXCgr+S5e5p3R+v5
         8Y2Y/LTuPKpb05EXHPG+XyvMuYztGJbmR1y/jw/t3oiKrNbdcjOjscU804PE7+0++wyl
         hb/M1TNGsBV/KK5+v+NYdyKkWNr0HR6Mrxh773ldK+2cS9m+fmSJrEKaTahbsfc8q1oC
         IDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713403722; x=1714008522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IocH4dK3cU7wr7fT/1eXbTtilS5jPEYt4JFcTK0tuc=;
        b=CFX7X9RjCXU/WbHDLlGHgYvaDLqQmdXiciolWmXfbc2jOP+duIcvW1y7k27axIAyef
         Q9yAD/9lVE4L7Vc1BTrYo/pz+EMBkHO/NTyWtcvNjUEVIZx9yJ7gkLvKkmxw0en9FMcB
         ZRFtEBrnlcGpj8e4b7oc1f7bBQQsVrsvuobINZiWvSn9+VoSFyiWwUhK49P1QjV1JnoQ
         5TYtOfxN7p+Gl5rtGzb1bI9FAS2HvCGLJ/MTGEly+1zkfy9UKJnQsw47b7SrdO+xBHar
         qLL/H3KwRhoYuZeoXhP0e1ANfaR3H30Orf87NLGrPfsoqY/5EfF39HlsYegKIjojDq65
         iUzA==
X-Forwarded-Encrypted: i=1; AJvYcCVPyYgDZmqQAdS+u5vp90NZBYRtmKR9MfENDKiOGtMq7UQYukIztFvlzLt/eUIjbyiq9aQucVNEC7mhO+BzL7XFK1vLN/kUrdQYbG1o
X-Gm-Message-State: AOJu0YyCzjIr0wK5KHWmlvAspCu0rJOOYtJLtiCzHmc5IoH9deLkaUOZ
	Ty+6p+VU705JCCFh5GwBDUNxRhKBVlqA7QidtaFz3xP9+yp3oKAGm3GCfG2Y80S52Y5K+ZQo71V
	dFEC5fooZYcc+kWdO9A==
X-Google-Smtp-Source: AGHT+IHSfSOAwqPT5+RVg+FkCynH2REwXQqip28l12UA6TCmdrVfJ3C58BqU4WK+J+oNidSiUh15Dp0ZWHsFTsRk
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:704:b0:dc6:e1ed:bd1a with SMTP
 id k4-20020a056902070400b00dc6e1edbd1amr320570ybt.2.1713403721892; Wed, 17
 Apr 2024 18:28:41 -0700 (PDT)
Date: Thu, 18 Apr 2024 01:28:35 +0000
In-Reply-To: <20240418012835.3360429-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418012835.3360429-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418012835.3360429-3-yosryahmed@google.com>
Subject: [PATCH tip:x86/mm v3 3/3] x86/mm: Cleanup prctl_enable_tagged_addr()
 nr_bits error checking
From: Yosry Ahmed <yosryahmed@google.com>
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/process_64.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index cda2918f88f99..baded5b4907c9 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -831,17 +831,13 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
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
2.44.0.683.g7961c838ac-goog


