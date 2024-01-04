Return-Path: <linux-kernel+bounces-17036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D8F82476D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDB2B25373
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0458528DD4;
	Thu,  4 Jan 2024 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2VtJhetl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DA82557C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cde2b113e7so420700a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 09:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704389138; x=1704993938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJb3XXC8q3g+6tXPhMxO+vJHUZX9WNbrN0ps04n6FVc=;
        b=2VtJhetlOet7TIeTKVMOu/WcJ2hgdoSNYeUyvNJJgoaG9Xu2zXzf8XGdTkzHa17LQC
         vmMzDUKs/EaUQh2Mx8U0DCZC2WlfD+mHsB8zA32/ERiz6uQ8DCYxzKXZnEjJYQnsp5rq
         amsvOhHLqW+/kfvxtFhZLdneCcT3r97B9JJYq4kCcOaKqZl70p2RiQxHK9uxLevKjTo5
         /syEV+Z6sSWFirdpWERd5NiyIs0fhlqXGzC2bYCz3Ba9ppl8Bo9uE08cGClUoL02NDD3
         ufOeNSmILCnmgdRzLZ0Nec0sfVtm6pG12ILkNr/ghjFUpy0R2VOXu0JmHFBQkCA26HfT
         XoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389138; x=1704993938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJb3XXC8q3g+6tXPhMxO+vJHUZX9WNbrN0ps04n6FVc=;
        b=VQj7smdqWNaUls9IiSKZ+YM+kkgak/f5G/ySj0HSNJ0ojbRHU/5bVefWsgyk1Cr6+W
         iAVrE26oXpabE3MPFc7MOIRTqZhwItIkquvKZ4fViOiKLeXW4y9/X4dDixZKpxU+GLfZ
         garu1E3/ffjiZLIfxAeqy50OSVuWB+ys/Tje0ld7OhPbVxg6t2NNsEN/JFEBF7awOqTF
         GmpiuL5S3GSEleBePfbrh2bwqraRayZDpfVzVEKtIbHIiyTSIByKp/79A/1fd01Np/zD
         jp94bfF6xE4YOsH8Y19V3G+NAQHpHBTE/bbwYTeez8238fJzLbXEI0etYJ2YtRui4/Tz
         qRCA==
X-Gm-Message-State: AOJu0YwIfzc/DyVLlX4q9quCVvNs3SyRcRlWdJH0W/y+kfQJTghUd9IJ
	rPrWKM5IEyBabHiy4HQ61BmJytpRQ5iJ1sfd6Q==
X-Google-Smtp-Source: AGHT+IGpjKYoYnovb4KpBjlwOvzKTsbKtS1OkjG+MYKimlevQSouppzqYOT0D/JiDpCYFh3Zij/ojr5FuiY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6a46:0:b0:5ce:a561:8868 with SMTP id
 o6-20020a656a46000000b005cea5618868mr6011pgu.4.1704389138519; Thu, 04 Jan
 2024 09:25:38 -0800 (PST)
Date: Thu, 4 Jan 2024 09:25:37 -0800
In-Reply-To: <b327b546-4a5f-462d-baeb-804a33bd3f6a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <3d8f5987-e09c-4dd2-a9c0-8ba22c9e948a@paulmck-laptop>
 <88f49775-2b56-48cc-81b8-651a940b7d6b@paulmck-laptop> <ZZX6pkHnZP777DVi@google.com>
 <77d7a3e3-f35e-4507-82c2-488405b25fa4@paulmck-laptop> <c6d5dd6e-2dec-423c-af39-213f17b1a9db@paulmck-laptop>
 <CABgObfYG-ZwiRiFeGbAgctLfj7+PSmgauN9RwGMvZRfxvmD_XQ@mail.gmail.com>
 <b2775ea5-20c9-4dff-b4b1-bbb212065a22@paulmck-laptop> <b327b546-4a5f-462d-baeb-804a33bd3f6a@redhat.com>
Message-ID: <ZZbqEYNIlwNwtEx5@google.com>
Subject: Re: [BUG] Guest OSes die simultaneously (bisected)
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: paulmck@kernel.org, Like Xu <like.xu@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Luwei Kang <luwei.kang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 04, 2024, Paolo Bonzini wrote:
> On 1/4/24 17:06, Paul E. McKenney wrote:
> > Instead, the point I am trying to make is that carefully
> > constructed tests can serve as tireless and accurate code reviewers.
> > This won't ever replace actual code review, but my experience indicates
> > that it will help find more bugs more quickly and more easily.
> 
> TBH this (conflict between virtual addresses on the host and the guest
> leading to corruption of the guest) is probably not the kind of adversarial
> test that one would have written or suggested right off the bat.

I disagree.  The flaws with PEBS using a virtual address is blatantly obvious to
anyone that has spent any time dealing with the cross-section of PMU and VMX.
Intel even explicitly added "isolation" functionality to ensure PEBS can't overrun
VM-Enter and generate host records in the guest.  Not to mention that Intel
specifically addressed the virtual addressing issue in the design of Processor
Trace (PT, a.k.a. RTIT).

In other words, we *knew* exactly what would break *and* there had been breakage
in the past.  Chalk it up to messed up priorities, poor test infrastructure, or
anything along those lines.  But we shouldn't pretend that this was some obscure
edge case that didn't warrant a dedicated test from the get-go.

