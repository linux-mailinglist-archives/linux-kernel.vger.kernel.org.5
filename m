Return-Path: <linux-kernel+bounces-29357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C5E830D39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933A61C24B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E465249EE;
	Wed, 17 Jan 2024 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aoc4VMep"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6392421E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705519112; cv=none; b=YFnb+kQPkPLwXrBLiLl+aLXnODgRkXR+4uyAG3q2e2Og0TFL7KZCWjxDFQ7qyQUqHYVIGXe3qCqnDUd/sAd4HI/dHQcu7Y0aFlZk+hUpJbG+0D0BXrnOFCzmpHkTaQHj1AvSHwT1HAlYeQ7i7A1P57ftXo2lONU4kFHQouCDku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705519112; c=relaxed/simple;
	bh=KXMZLBHc65ghx6GVKoCeeaBBmQtZBXUvyYnNtgLk8Uk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent; b=fOQZp8+HukkafY+FpVzNMLdyaBGv37N2Ob6ywgVbob462qoF3RRXThRwq4P3CG031ZjQpVssOTyrZaJ1oeGhDesNRJVpB0N4XKfF8UqJBSTUgsamLm6Dx+oUtRtkkIeBlHUQqf55rTkePx6JrZzCpVSJg1vDv6cnrzNxFCWqBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aoc4VMep; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e76626170so37621695e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705519108; x=1706123908; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY9ElmoBN1yaIqWHYG7QtdZi3QcPx+E4bgcakiLYwTI=;
        b=Aoc4VMepqGSnmkwi4QUmvhiCZ0gdPanyDlHWsCNUhSXOmN1xRWt+HPA2ExAXzT5OG9
         mEkJ2hYnln70PnBAu0GlP8eSZvid3Wf/NkoIeMHgTtE0WCGxhJTJjekOpiiAOcjz5+Ch
         w0UDTOFguuVSsw5cGKCDVIz3wPrFpWI/vOlTYCgHBbQeaFa1W+RlKIkpdOM4+CRvvgQf
         xbtJkQekg+UEqHplaviHCDSYm/qE4uaJr/EwVdKFkZsZ8iU2YLzK6whRO7NlSXMQf6N9
         sUqXQTfeZ9U0l+0veTLVnz0MyT1wfGpiokjrWtNzHsVvwQhW3YsxUXYdhoHE4uWiPH/R
         Afjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705519108; x=1706123908;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY9ElmoBN1yaIqWHYG7QtdZi3QcPx+E4bgcakiLYwTI=;
        b=OFKfsskqp591eHKbOjnOgba2O6ChvkGzEAb77vaveNnd54cJNnic38lJ2lj6mBeLG9
         tnYWAs61nTepRKg8nj564lcz6d1CT9kot+JY9z8/CDs6hAoJ3nzeNPZaktP7M7SofHXh
         x0tk7LwXxjPq/RIhBYhjjxG4pqczlVzmsBDZfxy/vNJdOGIgCurt33TCaqETa2XA35ij
         xNaVYusrzWE2TYau+w8EtQyHOaeUAoCUPDOcmxqF8XzZsSWR7hBIHaBDSNtRPCYf9mrW
         7fe//ss/5rjbJLw1EU6lKnFHaVxJ4HpAI0XL9a4F69e3y/5N5Ky+/SMNFfLRJ9K1d0q6
         nSQg==
X-Gm-Message-State: AOJu0YzW56yFsfhvHvtzyjk8bbwV6wtkGp18jHyB7EtnufLZ6nbjld3C
	XQFoY8FXJfs08bUN2trDaaVf2PYl3VYY
X-Google-Smtp-Source: AGHT+IF4oL0BAsF+ha3wzXLc42eUoMZFRTm2jnAgJhUc+DjiH4e3oSAEbqgOtj+F3gpV7AEiC56wkA==
X-Received: by 2002:a7b:ca59:0:b0:40e:76f6:9613 with SMTP id m25-20020a7bca59000000b0040e76f69613mr3246094wml.8.1705519107822;
        Wed, 17 Jan 2024 11:18:27 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:e545:8ceb:c441:7541])
        by smtp.gmail.com with ESMTPSA id bi13-20020a05600c3d8d00b0040e8800fcf3sm3597189wmb.5.2024.01.17.11.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:18:27 -0800 (PST)
Date: Wed, 17 Jan 2024 20:18:21 +0100
From: Marco Elver <elver@google.com>
To: Alexander Potapenko <glider@google.com>
Cc: quic_charante@quicinc.com, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, dan.j.williams@intel.com,
	david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mgorman@techsingularity.net, osalvador@suse.de, vbabka@suse.cz,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Nicholas Miehlbradt <nicholas@linux.ibm.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
Message-ID: <Zagn_T44RU94dZa7@elver.google.com>
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
 <20240115184430.2710652-1-glider@google.com>
 <CANpmjNMP802yN0i6puHHKX5E1PZ_6_h1x9nkGHCXZ4DVabxy7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMP802yN0i6puHHKX5E1PZ_6_h1x9nkGHCXZ4DVabxy7A@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Mon, Jan 15, 2024 at 09:34PM +0100, Marco Elver wrote:
> On Mon, 15 Jan 2024 at 19:44, Alexander Potapenko <glider@google.com> wrote:
> >
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: kasan-dev@googlegroups.com
> > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > Cc: Nicholas Miehlbradt <nicholas@linux.ibm.com>
> >
> > Hi folks,
> >
> > (adding KMSAN reviewers and IBM people who are currently porting KMSAN to other
> > architectures, plus Paul for his opinion on refactoring RCU)
> >
> > this patch broke x86 KMSAN in a subtle way.
> >
> > For every memory access in the code instrumented by KMSAN we call
> > kmsan_get_metadata() to obtain the metadata for the memory being accessed. For
> > virtual memory the metadata pointers are stored in the corresponding `struct
> > page`, therefore we need to call virt_to_page() to get them.
> >
> > According to the comment in arch/x86/include/asm/page.h, virt_to_page(kaddr)
> > returns a valid pointer iff virt_addr_valid(kaddr) is true, so KMSAN needs to
> > call virt_addr_valid() as well.
> >
> > To avoid recursion, kmsan_get_metadata() must not call instrumented code,
> > therefore ./arch/x86/include/asm/kmsan.h forks parts of arch/x86/mm/physaddr.c
> > to check whether a virtual address is valid or not.
> >
> > But the introduction of rcu_read_lock() to pfn_valid() added instrumented RCU
> > API calls to virt_to_page_or_null(), which is called by kmsan_get_metadata(),
> > so there is an infinite recursion now. I do not think it is correct to stop that
> > recursion by doing kmsan_enter_runtime()/kmsan_exit_runtime() in
> > kmsan_get_metadata(): that would prevent instrumented functions called from
> > within the runtime from tracking the shadow values, which might introduce false
> > positives.
> >
> > I am currently looking into inlining __rcu_read_lock()/__rcu_read_unlock(), into
> > KMSAN code to prevent it from being instrumented, but that might require factoring
> > out parts of kernel/rcu/tree_plugin.h into a non-private header. Do you think this
> > is feasible?
> 
> __rcu_read_lock/unlock() is only outlined in PREEMPT_RCU. Not sure that helps.
> 
> Otherwise, there is rcu_read_lock_sched_notrace() which does the bare
> minimum and is static inline.
> 
> Does that help?

Hrm, rcu_read_unlock_sched_notrace() can still call
__preempt_schedule_notrace(), which is again instrumented by KMSAN.

This patch gets me a working kernel:

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4ed33b127821..2d62df462d88 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2000,6 +2000,7 @@ static inline int pfn_valid(unsigned long pfn)
 {
 	struct mem_section *ms;
 	int ret;
+	unsigned long flags;
 
 	/*
 	 * Ensure the upper PAGE_SHIFT bits are clear in the
@@ -2013,9 +2014,9 @@ static inline int pfn_valid(unsigned long pfn)
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	ms = __pfn_to_section(pfn);
-	rcu_read_lock();
+	local_irq_save(flags);
 	if (!valid_section(ms)) {
-		rcu_read_unlock();
+		local_irq_restore(flags);
 		return 0;
 	}
 	/*
@@ -2023,7 +2024,7 @@ static inline int pfn_valid(unsigned long pfn)
 	 * the entire section-sized span.
 	 */
 	ret = early_section(ms) || pfn_section_valid(ms, pfn);
-	rcu_read_unlock();
+	local_irq_restore(flags);
 
 	return ret;
 }

Disabling interrupts is a little heavy handed - it also assumes the
current RCU implementation. There is
preempt_enable_no_resched_notrace(), but that might be worse because it
breaks scheduling guarantees.

That being said, whatever we do here should be wrapped in some
rcu_read_lock/unlock_<newvariant>() helper.

Is there an existing helper we can use? If not, we need a variant that
can be used from extremely constrained contexts that can't even call
into the scheduler. And if we want pfn_valid() to switch to it, it also
should be fast.

Thanks,
-- Marco

