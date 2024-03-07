Return-Path: <linux-kernel+bounces-96234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 392D6875907
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEC728648D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E653013A27E;
	Thu,  7 Mar 2024 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+Qzm+kt"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F22139571
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845722; cv=none; b=gsnqsgiKv13yKrytSkCiiQmPu3ZkmfhxWCeJO7QDBh8uAojEv4gArhqx13eLAHme2L+g/y/hK4dv/DkLvUagsRR6FUainHgihBQqvVG11+Q40Tkbx/Ya/d8nvvU4xghG+wH+F0fcHquz8JhS91z6khLrb0HgiLBZsdwTj+NXvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845722; c=relaxed/simple;
	bh=aIGrHMc8nEXV762RYgmf6psYNjOmJ7E0sR106giI5AU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KBEPeuMfX/zN5KtcTRRHKwWJlp1rG9kITVy+Ju+WGnaSvTfFgloSIQmnzMvfQ//4bqy/swygII+PYzm5bLE2VnlXtVp2j+J8EHs1xqcAfG13VR1yQC7G+CSZYfHcv2EUGdngUw+2nV8h0b99qfIm4QB4N6UyQqHT83R4zFQtAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+Qzm+kt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so418194276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 13:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709845719; x=1710450519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6XyYC8At6iwQoZ2KZhBPWiG6rvVOkTpXpe7DpTJpPr4=;
        b=3+Qzm+ktbi3E8EkFMYnd6EHPZTFsN476rUJkL+YKDWKGXA+WqHVII1L21ozgsOF6ta
         ncAM3eBvmuIyzQa/2EjV//awEwIRJgYMKe1idXH1zIt2bVNYt0LStg1dunYzoyFgNiTF
         dvatwfap2qob0ta62yGB5drnZ/DjlSe8s9VgwNbhEEULeKyG2rdFtyOkYkNLP/wHJIU5
         jNHYwjcjJ8GUjDIUD3fRpX+JE8seOgdpomWAFSdRXe6HlSrq/wZc4ujWiA3wNgdYwjTO
         pwYUw782jEiAapb3Mc8uBC7MZJU8qM1Zs9DBK/7WygEzU2ZduOD6v4j/8Isw7Ay0lR0K
         oj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709845719; x=1710450519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XyYC8At6iwQoZ2KZhBPWiG6rvVOkTpXpe7DpTJpPr4=;
        b=dZFV0sxa1ChgkO1+3GHIGQUGo7j+R4CGOcXQlJjsON/PGdNjJ/KbJIpRN3nG9GfSxt
         SZcIROlsbgr0/gbbtF1jlei+rQWaVCZq7uLdnhdgWhX/Bf5unX3d2Eweoo0hWnjbnsgI
         2EYLzidGOMy7O7wnjsZg5WvJDICg0aHPgnwFWLMo8t8VS8pV1bxiRE8G0bvfdGM4uZSN
         jP7TU5w9Corp+tx3s9oLILzEuvNr6VQck8CAgfk5WTJCtfEjomEskatDzANvqV0A3Rrq
         xOSoE1fV9/5IO4Iqlg5dEkTra3SiItVQbze028TkeJ+WTR1XN4cmSs1olWbciePGTaAt
         GEow==
X-Forwarded-Encrypted: i=1; AJvYcCWrec2515xkPzZ4e6p1wXnDiR9+30GQebMYLmvqVtDiX+NGK3s51IBaUNGMOamGHGU/EJrdNyplSaUt2hXJ70Jipol7JKhyDenaUy++
X-Gm-Message-State: AOJu0YwFoGE/YyvYoT6nvmKs9HYuUyl3E5g7I6BoGtQYyg3N8YaYevOq
	SmikwPVLHM0gOhrpYhXheDTL2s9gkF66ZIvoUWVrclxnZhwONRhk2FYi4D+zdBH9kJFnvSCB1Ub
	rULQSkuTb1cWU2eQfog==
X-Google-Smtp-Source: AGHT+IGEbtocHNRLjCCD7YOLDaguhaYk3Rz2sIBTQC6DEUXQQHBbgH/L4++AntHYM2n+UBcTHJ2Q0TjAK8fSrzN0
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:260f:0:b0:dcc:f01f:65e1 with SMTP
 id m15-20020a25260f000000b00dccf01f65e1mr4901464ybm.8.1709845719696; Thu, 07
 Mar 2024 13:08:39 -0800 (PST)
Date: Thu, 7 Mar 2024 21:08:37 +0000
In-Reply-To: <034466a4-0917-47c4-934b-9549c3076624@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com> <tvbgstojgmb5jerhrdwbhknuhhbwmq2pqkb4lxyo3htdynioee@poos2yt52xg2>
 <034466a4-0917-47c4-934b-9549c3076624@intel.com>
Message-ID: <Zeos1arCH11X_sXv@google.com>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
From: Yosry Ahmed <yosryahmed@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, x86@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024 at 09:56:07AM -0800, Dave Hansen wrote:
> On 3/7/24 09:29, Kirill A. Shutemov wrote:
> > On Thu, Mar 07, 2024 at 01:39:15PM +0000, Yosry Ahmed wrote:
> >> During context switching, if we are not switching to new mm and no TLB
> >> flush is needed, we do not write CR3. However, it is possible that a
> >> user thread enables LAM while a kthread is running on a different CPU
> >> with the old LAM CR3 mask. If the kthread context switches into any
> >> thread of that user process, it may not write CR3 with the new LAM mask,
> >> which would cause the user thread to run with a misconfigured CR3 that
> >> disables LAM on the CPU.
> > I don't think it is possible. As I said we can only enable LAM when the
> > process has single thread. If it enables LAM concurrently with kernel
> > thread and kernel thread gets control on the same CPU after the userspace
> > thread of the same process LAM is already going to be enabled. No need in
> > special handling.
> 
> I think it's something logically like this:
> 
> 						// main thread
> 	kthread_use_mm()
> 	cr3 |= mm->lam_cr3_mask;
> 						mm->lam_cr3_mask = foo;
> 	cpu_tlbstate.lam = mm->lam_cr3_mask;

IIUC it doesn't have to be through kthread_use_mm(). If we context
switch directly from the user thread to a kthread, the kthread will keep
using the user thread's mm AFAICT.

> 
> Obviously the kthread's LAM state is going to be random.  It's
> fundamentally racing with the enabling thread.  That part is fine.
> 
> The main pickle is the fact that CR3 and cpu_tlbstate.lam are out of
> sync.  That seems worth fixing.

That's what is fixed by patch 1, specifically a race between
switch_mm_irqs_off() and LAM being enabled. This patch is fixing a
different problem:

CPU 1                                   CPU 2
/* user thread running */
context_switch() /* to kthread */
                                        /* user thread enables LAM */
                                        context_switch()
context_switch() /* to user thread */

In this case, there are no races, but the second context switch on CPU 1
may not write CR3 (if TLB is up-to-date), in which case we will run the
user thread with CR3 having the wrong LAM mask. This could cause bigger
problems, right?

> 
> Or is there something else that keeps this whole thing from racing in
> the first place?

+1 that would be good to know, but I didn't find anything.

