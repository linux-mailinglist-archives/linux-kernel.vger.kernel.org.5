Return-Path: <linux-kernel+bounces-131882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10EA898D21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3EC1C25B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA8E12F59F;
	Thu,  4 Apr 2024 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhIAgd5N"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDFD12D1ED
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712251058; cv=none; b=AAN4jgMUkGllg4SbyV5Vb1l8nrrYODfaNohAY4l3qT3C+ebamrTqfV2lfZasCd5faQrtBGFfYNXi+1DpADMaGE/obXFe0iH26M/THCNSV7XlWyjBa8IFajk1mWgCLU9iNO/PQUwKTCtp5ibGpPCee1IrnDNRBqaYmr4Z6WMf8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712251058; c=relaxed/simple;
	bh=P0jxfOjJm5k13eNfwzSHtiYITpQkPdrZsOjPaq8EqwE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hvpp0BwUnfs7+y8vOG5wwv6Mnz0JTqcTzLwec6g8Py8I5vf9qmJFxoCLYovAKrKBbbngIO9+B9YrN4tmB1tvGR51Yy3UkJHqJudXqHjdgIs2HxS0agH8hkMjUNdycqRqDVwKDnCecAc8qjvkDF/4evn1iDTgH1Tkij+SVVsd8ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhIAgd5N; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61517841a2eso21188067b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712251056; x=1712855856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2HQDqzTFjNbgMV4giF4EAYbuZ4iKPL9b9RZ9WT7F6E4=;
        b=YhIAgd5NOfj6TcRmnxtCGyV9r2JmO9XTOibvCy1b2Z1J0aEA5iHMPPZ33Q+S/Fo85u
         +RWsHZwpRRJJEbMfsecbMhP0LU+3GJoP4F20VLgoqVrdLL5fharO2gMinhZdgt0zetGn
         2HzbZn+f4g8ohs0eYzxDE8seqV5JrYgptKEHEOp5B4Q+m81jljsYajSfUbmqMBTlH9ML
         XeJXsKAK9c/tAZ8DZDztTuHRGC3yC1cVzd8c64NrL58tEpa+WusUZSWDmbwSWzFkw2mS
         vXNgWJYr5cNybo5jW3xVU8solhLuouM3tKFkT8eTzkLnuxYa/YlfKfp5cM45I3/25S5i
         LibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712251056; x=1712855856;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HQDqzTFjNbgMV4giF4EAYbuZ4iKPL9b9RZ9WT7F6E4=;
        b=edJ1HuPYHsveSaryFeNkW5WRyBcqwoaCg4cMdo4Z45PuyYiWcJEZrXQ086o7LrANmp
         MPP4VoYrhBMOyPaHpa9tjxkCQahIcw5I7vfZ/s1jZgTQMoJ3u/oWjpfFeBiUYAqCOlji
         M20FVsosiGKe3KG5tGdxb0VI2G7GS5Cw9f4tdqrnZeleEcsDNyRxYDHXHccbMb/rmQCu
         xVDijRj9V/6XTczl7Jh+Jn3GNPFg0bLWJhI4YrBSlfk51u1zFD4DEtMCBP0K8RitZfOz
         zBotAB9gu8Wwc8SfwV+3vnDuN1i4BLqxmG1rSZ0CyyVr6tRJY4IHAAiN+8EUdOWIlawh
         2yKg==
X-Forwarded-Encrypted: i=1; AJvYcCUw8n5kPRFMubA3iVTtTbQEBkwisYX0zDjqWLeWt38b1TLifc4ewv81LpGPrTR11YntdAZmP0p4SWFbde65wNriQPetCpOVO4gOeAca
X-Gm-Message-State: AOJu0YwpOK6mxZQG5riyYZjh0f/AwoPwkIwPSdRxuDKoiwAr+SE3epIP
	vIFJRJ1xgiB8DvhPPADWJKLHpVxLU+T6S3BI5DnQY3qjNzC2miNAs9pj9p5F9S3UfLpsQAe8xzd
	quC/6UZwIR3Mx7sWKU+5ryw==
X-Google-Smtp-Source: AGHT+IEj+hRLWesrgPpJFC7CIVqj9Dom65rQyl8Tl8TbY/1KOeBAJ8t7Hc5dczRRpk4ua4tLB0Z7mXt0bzzzGkbIxw==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:b773:c760:3ce4:2d5c])
 (user=lokeshgidra job=sendgmr) by 2002:a0d:cac7:0:b0:615:e53:1c1 with SMTP id
 m190-20020a0dcac7000000b006150e5301c1mr42846ywd.7.1712251055864; Thu, 04 Apr
 2024 10:17:35 -0700 (PDT)
Date: Thu,  4 Apr 2024 10:17:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404171726.2302435-1-lokeshgidra@google.com>
Subject: [PATCH] userfaultfd: change src_folio after ensuring it's unpinned in UFFDIO_MOVE
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, zhengqi.arch@bytedance.com, kaleshsingh@google.com, 
	ngeoffray@google.com, Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit d7a08838ab74 ("mm: userfaultfd: fix unexpected change to src_folio
when UFFDIO_MOVE fails") moved the src_folio->{mapping, index} changing
to after clearing the page-table and ensuring that it's not pinned. This
avoids failure of swapout+migration and possibly memory corruption.

However, the commit missed fixing it in the huge-page case.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 mm/huge_memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..89f58c7603b2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2259,9 +2259,6 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 			goto unlock_ptls;
 		}
 
-		folio_move_anon_rmap(src_folio, dst_vma);
-		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
-
 		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
 		/* Folio got pinned from under us. Put it back and fail the move. */
 		if (folio_maybe_dma_pinned(src_folio)) {
@@ -2270,6 +2267,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 			goto unlock_ptls;
 		}
 
+		folio_move_anon_rmap(src_folio, dst_vma);
+		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
+
 		_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
 		/* Follow mremap() behavior and treat the entry dirty after the move */
 		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
-- 
2.44.0.478.gd926399ef9-goog


