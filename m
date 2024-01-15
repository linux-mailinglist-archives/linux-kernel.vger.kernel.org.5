Return-Path: <linux-kernel+bounces-26410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E5682E036
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5671F2276E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6419018E17;
	Mon, 15 Jan 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Znq/b9en"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603E18E0A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9dacc912so10603575276.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705344275; x=1705949075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCCPLj9WIEdpIVdqzT004aXc52PF8jQhxejOjNa7h3c=;
        b=Znq/b9enri1PtLBoq2Pn5Nt7SFZS4GE7Ruk+jCT7WeCif/PrT3RGMsmyUU0CRNuURe
         6e/D0oQwq+CuLNUtoaRsjt12HOa1FRvfaJvQdVihS0P+fAaighc0h5ku+S2UnTB3/oF1
         YigNiU63kNCthc46CPaEEmkA+A8st7kdG4j181w0VLm1MVYk14QEIr+I3/q4DRN4RVDJ
         PiRLaOA5v1QtpOrm5ZI9wy2Zp9TwjWZAMzmR1eVTfc8qKQ/aKDFf6aAGu64ZS5w2eK1e
         3a5iw/4wupQosRRxpwG+p1Emez16m1/RRNfZfYoxLSGDv6S/IitzMutML3bVhCrk9NnE
         Lm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705344275; x=1705949075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCCPLj9WIEdpIVdqzT004aXc52PF8jQhxejOjNa7h3c=;
        b=krBDyvv3ISbv9YVrjYlpO0+5RPFnCxjY0Hdg3kwFwo/A07HX/j83DCc5XzpD6LFjkW
         h7esecr/tJFtFyCiSzxQwAFKBuJRcGX911eed+k8KNqG/+qVCuyO+7rc3sEBcbTordqP
         S5XdNbIWswzOxG32S9CMizVRLoZKIb0O7+TfMBGUmO1auEj6fmcSwrDKEfxkteoJqjnT
         FFRxMuoJkn0psCpU3GGCziTpWAkJNaExZ2F8EruP+0MRolt/ckxtRdHuv0rCcjGtWaTh
         kVxeOBjbPFfEvcB/5q1Tu7xVqYsgKNZXlFts8H8YPLSSUE9PTEkBkhv0sQNazvDeUpD8
         tLEw==
X-Gm-Message-State: AOJu0Yyu53DlvuCJIbuBoLbKgUMAS4mPCx5zc24Bn69/xd8KvwGTu2AQ
	I3ZluD2//wjzRsaPLl/XKkGwWNdInjs0nCHhmQ==
X-Google-Smtp-Source: AGHT+IFCJ46CqM1/C8q96wk9dmF/Gg8dE6SjoZ0eTf1WG2ltKm+jUuofZWPaIYijnmKF8B+lilmt6hSO/Lc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:c671:6fb:2d64:ae58])
 (user=glider job=sendgmr) by 2002:a25:5181:0:b0:dbe:a0c2:df25 with SMTP id
 f123-20020a255181000000b00dbea0c2df25mr268706ybb.8.1705344275329; Mon, 15 Jan
 2024 10:44:35 -0800 (PST)
Date: Mon, 15 Jan 2024 19:44:30 +0100
In-Reply-To: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240115184430.2710652-1-glider@google.com>
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
From: Alexander Potapenko <glider@google.com>
To: quic_charante@quicinc.com
Cc: akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com, 
	dan.j.williams@intel.com, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mgorman@techsingularity.net, osalvador@suse.de, 
	vbabka@suse.cz, Alexander Potapenko <glider@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Miehlbradt <nicholas@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Nicholas Miehlbradt <nicholas@linux.ibm.com>

Hi folks,

(adding KMSAN reviewers and IBM people who are currently porting KMSAN to other
architectures, plus Paul for his opinion on refactoring RCU)

this patch broke x86 KMSAN in a subtle way.

For every memory access in the code instrumented by KMSAN we call
kmsan_get_metadata() to obtain the metadata for the memory being accessed. For
virtual memory the metadata pointers are stored in the corresponding `struct
page`, therefore we need to call virt_to_page() to get them.

According to the comment in arch/x86/include/asm/page.h, virt_to_page(kaddr)
returns a valid pointer iff virt_addr_valid(kaddr) is true, so KMSAN needs to
call virt_addr_valid() as well.

To avoid recursion, kmsan_get_metadata() must not call instrumented code,
therefore ./arch/x86/include/asm/kmsan.h forks parts of arch/x86/mm/physaddr.c
to check whether a virtual address is valid or not.

But the introduction of rcu_read_lock() to pfn_valid() added instrumented RCU
API calls to virt_to_page_or_null(), which is called by kmsan_get_metadata(),
so there is an infinite recursion now. I do not think it is correct to stop that
recursion by doing kmsan_enter_runtime()/kmsan_exit_runtime() in
kmsan_get_metadata(): that would prevent instrumented functions called from
within the runtime from tracking the shadow values, which might introduce false
positives.

I am currently looking into inlining __rcu_read_lock()/__rcu_read_unlock(), into
KMSAN code to prevent it from being instrumented, but that might require factoring
out parts of kernel/rcu/tree_plugin.h into a non-private header. Do you think this
is feasible?

Another option is to cut some edges in the code calling virt_to_page(). First,
my observation is that virt_addr_valid() is quite rare in the kernel code, i.e.
not all cases of calling virt_to_page() are covered with it. Second, every
memory access to KMSAN metadata residing in virt_to_page(kaddr)->shadow always
accompanies an access to `kaddr` itself, so if there is a race on a PFN then
the access to `kaddr` will probably also trigger a fault. Third, KMSAN metadata
accesses are inherently non-atomic, and even if we ensure pfn_valid() is
returning a consistent value for a single memory access, calling it twice may
already return different results.

Considering the above, how bad would it be to drop synchronization for KMSAN's
version of pfn_valid() called from kmsan_virt_addr_valid()?

