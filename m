Return-Path: <linux-kernel+bounces-97748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34094876ECA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF191C20F18
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F7520B00;
	Sat,  9 Mar 2024 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqMlNUMi"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70BD33FE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709950764; cv=none; b=oetxv6CaLPuTXzF4g2pcF3FrlSAH27UaABsXmTR346IEMoHViwkZK0OeADyK3nhZWRB2nvx3T07NCBjW/W+n2taBqHSkWxZO6z5g7jt+6pzwYvJh2VyzLUMUcliUdnjc4j6oH5H79VjDizMGZWYNVuHJV3hlhrfNRlBY0iglZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709950764; c=relaxed/simple;
	bh=nnIfdBiDWZV692o+dlpjd1PcGE5J1RmUoWoDN5EVOn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T2EyveFDxaog2cKM7JKEdI2qHGdyKjRahtPErjgt2wLzffvatgfdasK3bpZHpx0K7DrQM3d4cKe43VSfKSJOk30TQjV93298vv1a0S7V5rIzmOyiaZh/gSrckqTtUizKBchJN7cTt67BJdLXVJWcgkSZB5fX2t/0RBvwpErVH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqMlNUMi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a015ca1c5so28563967b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 18:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709950761; x=1710555561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQYhZoz7SpBOGR+3G/7N8yPJRQiuzCkFrb6/L7sC9O0=;
        b=rqMlNUMiTB/ZSHm18UGmfST+SeExIeTxbv1Fo/bkqC5j4qBbzpipbm3Q/N0yoVXUCR
         112t8ddw2zfpKjItO42aK3CR0Fiisqi5CnRIBMPNSsQi+/0q39F1BYWRSGFpbJaYbUri
         KhwJBBerRNoxhP3Sr28JYvxMPvKwrOmztwvLRINwyXUhraIBcNQemUvyJGPwayfPn6lr
         WltUTlw4MCNHBqAP77ssmLqvdN29j9MY/oRLSzmjhurOrXBKi1qmxZPnDFcNdO5i8IuF
         L6NfaaKJsdjrMqjxBDriSRTAhOMYLtA7XU0F1683xpkPIJZanukI8k8oiiyZ4rIc6r0l
         5e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709950761; x=1710555561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQYhZoz7SpBOGR+3G/7N8yPJRQiuzCkFrb6/L7sC9O0=;
        b=vPYH4Pww3ujVc7xefiEjD+YyUdy/eJXZmoUKnkZD6m4k9zKKYKOP1jjHz0qqsMTEk8
         CSqBEQMFyIIlvKigpsp1cQmx+3nt8zy3crxM0fpxedYCzH63BVekXlRVEM7f4aLulJSt
         wpsM3cmthg9LVrqdh3swznvCrqiinHn+IO1Ye7LYbtV5FEtqiVqCsUrjZm6p5Kh/KwZp
         N1QfP59bU5oue9p11BtTY1V4lpauLav3BB2gOUIJQcavYl3pu03UPDMArWqUSxDHjeMb
         bf6yivoAMe+A0GXsx3UGi6rD90hgWyoh7s7eI9KldX0bmJWBv5KSxGZC/3e9/mJIRcni
         QvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ27GvF6N9+NSU7kO4/cmV7g+IiXOEXDSe3RAuluXXSkduKbDnDvtJDm50Z+6a98z+gAZyO/fmtnuE18WSRBwuxITMyy1ad+/oxKVh
X-Gm-Message-State: AOJu0YxlgssX0mdSW4I2ivdv7JhhFKJ0bft3yvceyRJASxEqNxHoCcJw
	liOp+Qhz3HBJrLXG+5BJFoUz/dAvCANprKQPttqIxVaAAE5pNs+jSHg5d+S5e5X5r8pkTtbvUWN
	0KETexJxgVgYOqxyfvQ==
X-Google-Smtp-Source: AGHT+IFMwveIVMUrOovocNj61UNOQCcJqfm8adIbbc+JT16kdYXLBkLZVCN3460E7Ul9r8VrXyU+CNAy4r3p8608
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:f0d:b0:60a:1705:b286 with SMTP
 id dc13-20020a05690c0f0d00b0060a1705b286mr109921ywb.1.1709950761719; Fri, 08
 Mar 2024 18:19:21 -0800 (PST)
Date: Sat, 9 Mar 2024 02:19:19 +0000
In-Reply-To: <35b670e2-9ef5-4d3a-b6ea-f8016dfa088d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com> <420fcb06-c3c3-4e8f-a82d-be2fb2ef444d@app.fastmail.com>
 <35b670e2-9ef5-4d3a-b6ea-f8016dfa088d@intel.com>
Message-ID: <ZevHJ5o3G00_nBha@google.com>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
From: Yosry Ahmed <yosryahmed@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>, linux-mm@kvack.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 08, 2024 at 07:23:58AM -0800, Dave Hansen wrote:
> On 3/7/24 17:34, Andy Lutomirski wrote:
> >> Fix this by making sure we write a new CR3 if LAM is not
> >> up-to-date. No problems were observed in practice, this was found
> >> by code inspection.
> > I think it should be fixed with a much bigger hammer: explicit IPIs.
> > Just don't ever let it get out of date, like install_ldt().
> I guess it matters whether the thing that matters is having a persistent
> inconsistency or a temporary one.  IPIs will definitely turn a permanent
> one into a temporary one.
> 
> But this is all easier to reason about if we can get rid of even the
> temporary inconsistency.
> 
> Wouldn't this be even simpler than IPIs?
> 
> static inline unsigned long set_tlbstate_lam_mode(struct mm_struct *mm)
> {
> 	unsigned long lam = READ_ONCE(mm->context.lam_cr3_mask);
> 
> +	/* LAM is for userspace only.  Ignore it for kernel threads: */
> +	if (tsk->flags & PF_KTHREAD)
> +		return 0;
> 
> 	this_cpu_write(cpu_tlbstate.lam, lam >> X86_CR3_LAM_U57_BIT);
>  	this_cpu_write(tlbstate_untag_mask, mm->context.untag_mask);
> 	return lam;
> }

Hmm I don't see how this fixes the problem addressed by this patch. I
think this fixes the problem addressed by patch 1, where CR3 and
cpu_tlbstate.lam may get out of sync if LAM enablement races with
switch_mm_irqs_off().

However, this patch is fixing a deeper problem (an actual bug).
Precisely this situation:

CPU 1					CPU 2
/* kthread */
kthread_use_mm()
					/* user thread */
					prctl_enable_tagged_addr()
					/* LAM enabled */
					context_switch() /* to CPU 1 */
switch_mm_irqs_off()
/* user thread */
---> LAM is disabled here <---


When switch_mm_irqs_off() runs on CPU 1 to switch from the kthread to
the user thread, because the mm is not actually changing, we may not
write CR3. In this case, the user thread runs on CPU 1 with LAM
disabled, right?

The IPI would fix this problem because prctl_enable_tagged_addr() will
make sure that CPU 1 enables LAM before it returns to userspace.
Alternatively, this patch fixes the problem by making sure we write CR3
in switch_mm_irqs_off() if LAM is out-of-date.

I don't see how skipping set_tlbstate_lam_mode() for kthreads fixes this
problem. Do you mind elaborating?
					

