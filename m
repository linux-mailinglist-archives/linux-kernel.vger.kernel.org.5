Return-Path: <linux-kernel+bounces-96327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381D9875A4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF901F22A77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55C313F00A;
	Thu,  7 Mar 2024 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Phxz4kMv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD960130AD0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850574; cv=none; b=MOIBpbnEpNbM9/VrbgFAJIepxX5zd1x3vOywfIFgAkhCrA+0QMXwvpg6BaLZX61M1buM/Ek6rCGfimOJQwqkS8iPUrIMbbQ2dh5jFmKlpDHppsWu4SHbbV94XybkIXTI4I++ltyWnaJnwtGwXyhr+6ca5qmZA2zY+eCqTvMbx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850574; c=relaxed/simple;
	bh=UzIQYpvi08z5bH3M/h4tHbUssGMu7BM4yagFRVruwyM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vDUGWUuCdoYo8aQEFn57JGsCrpD/fGDGCbmQeJZZGXpoQucneS1W121rm0+ImKRvkgRofJ48f02Vggdg5EmGZP9JyH7eNDaoxNIpamanKq4YyiRVcDlUv/UZyfHDBOX6+873u+IWWH34IUlioVHos9546BAA1HnqA+h7MNtBoAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Phxz4kMv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so2399935276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 14:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709850572; x=1710455372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDRTlWsJQzO9MrOpDvjMSk7xOJu//0tU48E07HkojKw=;
        b=Phxz4kMv+YEuyQu0hgx+WTf1Qq5o8q7PUChISJhLP0iqnEYgX/itxTow/lo1aov2nk
         PoVbLmLgbJhMfzRgC1VuPkqJ9IB7dRqasH7UTvJysDcsfbZE0NeR8UEKfZkGZoxgap01
         eYEzWIZDfPrkOKew3V15t9mciA22iNeKHjMkMoGENngjTEjIhkFnq5RJ/Gf8MJ2RDDV4
         QqHmNPfRAuI1tVGU/s4wbnMOJH/s+iabUgDDQCK8QMDwg3r4ST/ijrkMt6+lomCqqbr+
         zLH4TOp5NaJpRlo2v399YoUNEO/e8vQK6Rj5Ufek1TPnr0Yxc5oesC1jVaPVbhw0vln4
         6+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709850572; x=1710455372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDRTlWsJQzO9MrOpDvjMSk7xOJu//0tU48E07HkojKw=;
        b=OmTI/eonShA3zBtCnb1hq1BAx2cCC2TvSdg56VMm3Bwg6hswL2CXC8GoPkFFZ03ATA
         DpJLgbXykxGDrb2COQ0HCJWCNn0uUuoWWgwIDOtnMEbllJT8YKZBj1DjVm5sITSr8kvq
         dKX8T6JCh1SZp64PUU3Ww4tg2Bz+AZ7iQLu0rsOoYn1vOcIOgWnGxRv/caJuOjefiCcC
         iEa6oWXbth6NvHxQSdGY0uYTIDC0fhEbJ+TS0eyDpepA/aKkcLv/5K14Q0U8DLpM4ftz
         pI0DrT7YHxO8yKGqgLiUX5SSZjGcaOiNuTtChPle4XBjZ83NI9ttfVS9fL5g2C0SMaee
         kvdg==
X-Forwarded-Encrypted: i=1; AJvYcCXwwj25a5Xm72VJBVUYE7+1glKAkPm7yDnJcNzPzstyNUWZ45D/b3pXd7LAVP4WqF4lcxlfQ+8TR5ZcN3761aecp5oSLJrsbGMPRbWk
X-Gm-Message-State: AOJu0YxMuqN0HPd3yYrwvr/Sd2KWhDO499/00ChzL3b6x4SBAnPhBMw7
	GHVM4fg2NJbQ7oBgMfGJM626cPe5tlRNRSa0BwFxrFg0YOlZWPqVRsxRcO2/UeR/FZKA4JFmTnd
	gmk8U5uBtxKx3jyR18w==
X-Google-Smtp-Source: AGHT+IHDwl1ajC/sq4yCjvIzRdBW2muKHXy32tYYhISNYzdVAaFxNZRfi+kW14+7gtR/JD5yznJEicQhSCKjcM/p
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1741:b0:dc7:5c0d:f177 with
 SMTP id bz1-20020a056902174100b00dc75c0df177mr4870186ybb.6.1709850571847;
 Thu, 07 Mar 2024 14:29:31 -0800 (PST)
Date: Thu, 7 Mar 2024 22:29:29 +0000
In-Reply-To: <cb1aaac1-4800-4cae-8aea-acba6353971c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com> <83b019e2-1b84-491a-b0b9-beb02e45d80c@intel.com>
 <Zeor4DIGj0u6LNIw@google.com> <cb1aaac1-4800-4cae-8aea-acba6353971c@intel.com>
Message-ID: <Zeo_yUTdGKVed7ff@google.com>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
From: Yosry Ahmed <yosryahmed@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024 at 01:39:53PM -0800, Dave Hansen wrote:
> On 3/7/24 13:04, Yosry Ahmed wrote:
> > I thought about doing inc_mm_tlb_gen() when LAM is updated, but it felt
> > hacky and more importantly doesn't make it clear in switch_mm_irqs_off()
> > that we correctly handle LAM updates. We can certainly add a comment,
> > but I think an explicit check for CPU LAM vs. mm LAM is much clearer.
> > 
> > WDYT?
> 
> The mm generations are literally there so that if the mm changes that
> all the CPUs know they need an update.  Changing LAM enabling is 100%
> consistent with telling other CPUs that they need an update.
> 
> I'd be curious of Andy feels differently though.

The mm generations are TLB-specific and all the code using them implies
as such (e.g. look at the checks in switch_mm_irqs_off() when prev ==
next). We can go around and update comments and/or function names to
make them more generic, but this seems excessive. If we don't, the code
becomes less clear imo.

I agree that the use case here is essentially the same (let other
CPUs know they need to write CR3), but I still think that since the LAM
case is just a simple one-time enablement, an explicit check in
switch_mm_irqs_off() would be clearer.

Just my 2c, let me know what you prefer :)

> 
> >> Considering how fun this code path is, a little effort at an actual
> >> reproduction would be really appreciated.
> > 
> > I tried reproducing it but gave up quickly. We need a certain sequence
> > of events to happen:
> > 
> > CPU 1					CPU 2
> > kthread_use_mm()
> > 					/* user thread enables LAM */
> > 					context_switch()
> > context_switch() /* to user thread */
> 
> First, it would be fine to either create a new kthread for reproduction
> purposes or to hack an existing one.  For instance, have have the LAM
> prctl() take an extra ref on the mm and stick it in a global variable:
> 
> 	mmgrab(current->mm);
> 	global_mm = current->mm;
> 
> Then in the kthread, grab the mm and use it:
> 
> 	while (!global_mm);
> 	kthread_use_mm(global_mm);
> 	... check for the race
> 	mmdrop(global_mm);
> 
> You can also hackily wait for thread to move with a stupid spin loop:
> 
> 	while (smp_processor_id() != 1);
> 
> and then actually move it with sched_setaffinity() from userspace.  That
> can make it easier to get that series of events to happen in lockstep.

I will take a stab at doing something similar and let you know, thanks.

