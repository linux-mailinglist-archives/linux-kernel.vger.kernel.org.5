Return-Path: <linux-kernel+bounces-53808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A637784A6CA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2597B29FA7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB9F55C06;
	Mon,  5 Feb 2024 19:19:00 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799754BCA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160740; cv=none; b=US4kHOK3UPTW91Fz1UtHEh2MVCJqzEGytuHg146/beN4p838fNNSzXPJmkWVRvbdXPnmUsXEbrvpfD65bdOmAAy2j49cLaYZ3ud+2ssXC+rYcBBts8S9ZEGzIskzsVQQQstlMrtR6gtuTo5OB2k1bcqrcEnDoRp3J8w4adGdb7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160740; c=relaxed/simple;
	bh=L6H/Zl7UOveGSW+zhT0TTKjxWKJLOO7cOjOFFqFmsoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pA5+RITxDhssENKesrt4AWrBR3Eew3iErFZylFrxWMnjSpQl9AX4bFc3a9SMHGmt882vwSenkHCN84sk+LEH6Jekqw0cnMocqvplwgDeYfA6BxzpXAIWBXu3h7TSrZ7W/ze17kK1fMdifbw8dEOoCsjNOtrTMlYwJsWDw/bcAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a37ce4b2b23so124953366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707160736; x=1707765536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWo//23UNgHLh4YlpYiYx7hMvmjaebYbXFXXNlcC930=;
        b=kBoLwMhZnU4t4TjoEikWn4Wo6K++EN2noYiyc1agaHvR4unyUzb6om+JAfnaSwk2YY
         ry9e/ie3PySUs5bn1SLWve3V07d5L0YfSzAW7d4x0iCZclAb4zBz/sm04f9T4/0f+BbJ
         6Dqr/q6X8Pg1ZTvwFxUYy+vCzAAPXsEwIVtkhBO0PhHof2i8YVQ3ez70P7TK8TdobBs5
         BGP4+j/K7lTMK9gvoCuBNGMl35VR7PGxgO+Sk1KoifuS3/5m5bAB2t3/XzBOSz4laNTn
         0nFcsq6FGJ365dCTg2nNzeyENtNZyGwdpPsm8SWq25Kw1Ycc0QLZ30thzNAHvfJ/K9fI
         J7fg==
X-Gm-Message-State: AOJu0Yx0vZ3h8UuahoaprlI+q+ovPesmPzc7nApOJa3yda3ol9984Imq
	agXnnUv14dB+N48Zkrz4kcSJUIp3AkP0a8BJ952saJ0hNwUlyo7W
X-Google-Smtp-Source: AGHT+IFJVJGFgzRP+JaCEmQBc6TWhCiJzh1skkZ70pPkTz2uMwB7wUZVtWtShQrHjEG7KDUUk9q3Dg==
X-Received: by 2002:a17:907:2cd8:b0:a37:2c8f:f605 with SMTP id hg24-20020a1709072cd800b00a372c8ff605mr226983ejc.75.1707160736219;
        Mon, 05 Feb 2024 11:18:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVZvlIdAv+MhPs4qzcEzvnoVUzK7+u6M9FOC1fvWg/yZXEkctPC5uNwEIjIvbUvI/Hi7sDpAqGoU9cdH3EKVPoNRrSiqW5qINM/IFETVsbD+uEJRV7E59I45wG40opcJiWt1JtNkea+Hh5e/VjLrAGGQsyFDCttvU/Q60KcVmm/zdQgiZfH9EvXSOHTkq+0wgUI6dzJz+QkVn/EhHRJ+sWwmYBIRd3+mgyjWn7umFJ0C5MouDVD9eTfcWEKZEREaRaAR+NmCO47rcSy0/3xgr3JLEcs39ayGC/AKq1qzU/QzQo20IvtG5Ij
Received: from localhost (fwdproxy-cln-119.fbsv.net. [2a03:2880:31ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id c1-20020a170906d18100b00a367cf97b40sm156860ejz.131.2024.02.05.11.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:18:55 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: mike.kravetz@oracle.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev
Cc: lstoakes@gmail.com,
	willy@infradead.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm/hugetlb: Restore the reservation
Date: Mon,  5 Feb 2024 11:18:40 -0800
Message-Id: <20240205191843.4009640-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a fix for a case where a backing huge page could stolen after
madvise(MADV_DONTNEED).

A full reproducer is in selftest. See
https://lore.kernel.org/all/20240105155419.1939484-1-leitao@debian.org/

v1:
  * https://lore.kernel.org/all/20240117171058.2192286-1-leitao@debian.org/
v2:
  * In version 1, there was a lockdep dependency detected by syzbot.
	* https://lore.kernel.org/all/00000000000050a2fb060fdc478c@google.com/
	* The lockdep dependency was caused because `vma_add_reservation()` was
	  called with the pte lock. This is fixed now by deferring the
	  vma_add_reservation() to after the spinlock.
  * Version 2 fixes the problem above by setting the restore_reserve bit
    inside the ptl, but, calling vma_add_reservation() later, after the
    lock is released.
	* Reported by a test done by Ryan Roberts.

In order to test this patch, I instrumented the kernel with LOCKDEP and
KASAN, and run the following tests, without any regression:
  * The self test that reproduces the problem
  * All mm hugetlb selftests
	SUMMARY: PASS=9 SKIP=0 FAIL=0
  * All libhugetlbfs tests
	PASS:     0     86
	FAIL:     0      0

Breno Leitao (2):
  mm/hugetlb: Restore the reservation if needed
  selftests/mm: run_vmtests.sh: add hugetlb_madv_vs_map

 mm/hugetlb.c                              | 25 +++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh |  1 +
 2 files changed, 26 insertions(+)

-- 
2.34.1


