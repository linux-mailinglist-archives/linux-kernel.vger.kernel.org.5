Return-Path: <linux-kernel+bounces-15701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 990A9823092
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A4BB22C26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174AF1B268;
	Wed,  3 Jan 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLq4pNgl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EDC1A731
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704295879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xi/cLbBuD7PQL0fsq9282B7IArYlzlUVvqfZqTLR3Tc=;
	b=OLq4pNglE3jSSowNIwvH4OzE0Xl/ycieyU6CKzq91ooiv1/GCImMmvmmGXg2uoZLLetHBA
	aLEdSIMajbrxrabR9Ldcqi3REKRNVISasZaR92OEc60N3X04dcH9OQzqkjCOb8XvX1i1XP
	iZnb3JBedWXNd0NdXyVc7rDAt1zLCWk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-gAIxZLBxMoy_RiQWDFCLqA-1; Wed, 03 Jan 2024 10:31:18 -0500
X-MC-Unique: gAIxZLBxMoy_RiQWDFCLqA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d410cccfc2so39943375ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 07:31:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704295877; x=1704900677;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi/cLbBuD7PQL0fsq9282B7IArYlzlUVvqfZqTLR3Tc=;
        b=Y63ZGHKCbx3PIEmmAI2vTw6e20LhHRK0v+0Vb1Tdw8lzgGMeHF7huVTFVDutDGNXir
         d0yFHGvZjFsZ3X+SBHR8KEFw6BrbVkQRfwL8lDQRXLCGh3q4AibF33Aqbo+d7xlT4lti
         2U/NjZrkerkyKWlkr/VmXUDbpuV4aDd9e+WicJLyJHIm29ESoUUfl3go7iZyNNn3jVrw
         Cr/kVzplJpY2M/i4jexngmAgJ/dIsuro9pUoQn24yRjahVhnpmbjUANVZq3K01O8JUze
         FznqXsTKHsZj8q5zjwkB3iF2a5I2XVzQ1tcUcikTH33YERtsuhtfwBSUhlCqpCy1Ta0m
         H18w==
X-Gm-Message-State: AOJu0Yx+YMKrPvOFAd1xrokPLJetOdnFLoyN1ZnSUzmAuXXmWR7K/KXL
	eTUICWQotpjSxQsLeuDxZYjSxzBSpQJYxzFNa1OFiIDg7WrLJCvQ9TlfmujPUkixrS3rkCaF9TG
	zbyUcyIhs8EboYSWQbmT7LXnKGQ/LfOvl
X-Received: by 2002:a17:902:c40e:b0:1d4:59c1:cabc with SMTP id k14-20020a170902c40e00b001d459c1cabcmr7800664plk.75.1704295877204;
        Wed, 03 Jan 2024 07:31:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFD7GdHUUbPzO0iEzmnqE5viAUZQUvfg0jqQVgtyzl0QBvUi5XEXgBeW4KujyYniYeMi94Jkg==
X-Received: by 2002:a17:902:c40e:b0:1d4:59c1:cabc with SMTP id k14-20020a170902c40e00b001d459c1cabcmr7800651plk.75.1704295876882;
        Wed, 03 Jan 2024 07:31:16 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm24093873plb.20.2024.01.03.07.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 07:31:16 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	leobras.c@gmail.com,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will@kernel.org>,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	aou@eecs.berkeley.edu,
	parri.andrea@gmail.com,
	andrzej.hajda@intel.com,
	guoren@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables of size 1 and 2
Date: Wed,  3 Jan 2024 12:31:04 -0300
Message-ID: <ZZV9uGm3VApkLHMF@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZZU/YNPMigiD/k1g@xhacker>
References: <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9> <2a4f1f47e945772b9fbb53a51e148636e0ae6e48.camel@redhat.com> <ZW_GzKUoqO4fD4Je@LeoBras> <ZZU/YNPMigiD/k1g@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 03, 2024 at 07:05:04PM +0800, Jisheng Zhang wrote:
> On Tue, Dec 05, 2023 at 09:56:44PM -0300, leobras.c@gmail.com wrote:
> > From: Leonardo Bras <leobras@redhat.com>
> > 
> > On Wed, Aug 30, 2023 at 06:59:46PM -0300, Leonardo Brás wrote:
> > > On Thu, 2023-08-10 at 09:23 -0700, Palmer Dabbelt wrote:
> > > > On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
> > > > > On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
> > > > > > On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
> > > > > > > xchg for variables of size 1-byte and 2-bytes is not yet available for
> > > > > > > riscv, even though its present in other architectures such as arm64 and
> > > > > > > x86. This could lead to not being able to implement some locking mechanisms
> > > > > > > or requiring some rework to make it work properly.
> > > > > > > 
> > > > > > > Implement 1-byte and 2-bytes xchg in order to achieve parity with other
> > > > > > > architectures.
> > > > > > > 
> > > > > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > > > 
> > > > > 
> > > > > Hello Arnd Bergmann, thanks for reviewing!
> > > > > 
> > > > > > Parity with other architectures by itself is not a reason to do this,
> > > > > > in particular the other architectures you listed have the instructions
> > > > > > in hardware while riscv does not.
> > > > > 
> > > > > Sure, I understand RISC-V don't have native support for xchg on variables of
> > > > > size < 4B. My argument is that it's nice to have even an emulated version for
> > > > > this in case any future mechanism wants to use it.
> > > > > 
> > > > > Not having it may mean we won't be able to enable given mechanism in RISC-V. 
> > > > 
> > > > IIUC the ask is to have a user within the kernel for these functions.  
> > > > That's the general thing to do, and last time this came up there was no 
> > > > in-kernel use of it -- the qspinlock stuff would, but we haven't enabled 
> > > > it yet because we're worried about the performance/fairness stuff that 
> > > > other ports have seen and nobody's got concrete benchmarks yet (though 
> > > > there's another patch set out that I haven't had time to look through, 
> > > > so that may have changed).
> > > > 
> > > > So if something uses these I'm happy to go look closer.
> > > 
> > > IIUC patches 4 & 5 will be used by qspinlock, which may not be done yet, so we
> > > don't have an use for them for the time being.
> > > 
> > > Otherwise, any comments on patches 1, 2 & 3?
> > 
> > ping
> 
> Hi,
> 
> I believe the "RFC" makes some reviewers think the series isn't ready
> for review, so could you please send a new one w/o RFC?
> 
> thanks

Sure, will do.

Thanks!
Leo

> 
> > 
> > > 
> > > > 
> > > > > > Emulating the small xchg() through cmpxchg() is particularly tricky
> > > > > > since it's easy to run into a case where this does not guarantee
> > > > > > forward progress.
> > > > > > 
> > > > > 
> > > > > Didn't get this part:
> > > > > By "emulating small xchg() through cmpxchg()", did you mean like emulating an
> > > > > xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?
> > > > > 
> > > > > If so, yeah, it's a fair point: in some extreme case we could have multiple
> > > > > threads accessing given cacheline and have sc always failing. On the other hand,
> > > > > there are 2 arguments on that:
> > > > > 
> > > > > 1 - Other architectures, (such as powerpc, arm and arm64 without LSE atomics)
> > > > > also seem to rely in this mechanism for every xchg size. Another archs like csky
> > > > > and loongarch use asm that look like mine to handle size < 4B xchg. 
> > > > >     
> > > > > 
> > > > > >  This is also something that almost no architecture
> > > > > > specific code relies on (generic qspinlock being a notable exception).
> > > > > > 
> > > > > 
> > > > > 2 - As you mentioned, there should be very little code that will actually make
> > > > > use of xchg for vars < 4B, so it should be safe to assume its fine to not
> > > > > guarantee forward progress for those rare usages (like some of above mentioned
> > > > > archs).
> > > > > 
> > > > > > I would recommend just dropping this patch from the series, at least
> > > > > > until there is a need for it.
> > > > > 
> > > > > While I agree this is a valid point, I believe its more interesting to have it
> > > > > implemented if any future mechanism wants to make use of this. 
> > > > > 
> > > > > 
> > > > > Thanks!
> > > > > Leo
> > > > 
> > > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


