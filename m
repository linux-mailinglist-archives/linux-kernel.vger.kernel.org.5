Return-Path: <linux-kernel+bounces-104989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CE987D757
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805391C21131
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0CC5A4E9;
	Fri, 15 Mar 2024 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GaIkj8m+"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70D54745
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710545534; cv=none; b=MeTNyQWMolwYckEnIInqVW63j7/5/mZwBA9wQExWOPSh28Df2IWTv8eUF1rcYwp1k7VcH3p9HZ0bF0f0Z8USJPRyMuc+udAyKZpj+Rn8wQmwE65ea8GyFvJ8v8HwgI5Mb/puB+SGSqKZ6ynVkAtUOgzR+/uNy5eujuYs0Jmw65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710545534; c=relaxed/simple;
	bh=Iv1CbtxFlgKq1E50wTsvmZDkFRuYa2Hq3fbOGa1nk7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bjp7MI8BRJes1pvuMEGxU/YZofTpFJ6wZx5ImalwmNmmAikrNO/Jw3Po+gp/RnXwi4khM+rQt1b0yrFgRddcLMUrLJKrvGs+ZsEroW3PaKpZjBA5dnqosOPPuBUUb650UB62SlwdJ4Cj1Nl1OtWBy21D0BI1hN3ZPJoTi9lLiT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GaIkj8m+; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Mar 2024 16:32:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710545530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0WUwJc4LZJbBgA3QDezWvPKLvCLtaq61JXaRKTdvGs=;
	b=GaIkj8m+SLy7EnRZ1J9S8H6rL4Po81drGuqcJxes0JnnEsWCL8TsOOcFdlDGbRthf1VngX
	FDQpXoyfg4b5HbLWJCz+I1daH8XUTj+mrv1lodOjhVu3Rq7bS1WCTXaGbzGBfe6V284hRM
	Ag5p/VT+IZ2Kywkz9y2CXJxSKvSJXbg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [GIT PULL] KVM changes for Linux 6.9 merge window
Message-ID: <ZfTadCKIL7Ujxw3f@linux.dev>
References: <20240315174939.2530483-1-pbonzini@redhat.com>
 <CAHk-=whCvkhc8BbFOUf1ddOsgSGgEjwoKv77=HEY1UiVCydGqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whCvkhc8BbFOUf1ddOsgSGgEjwoKv77=HEY1UiVCydGqw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 15, 2024 at 03:28:29PM -0700, Linus Torvalds wrote:
> The immediate cause of the failure is commit b80b701d5a67 ("KVM:
> arm64: Snapshot all non-zero RES0/RES1 sysreg fields for later
> checking") but I hope it worked at *some* point. I can't see how.

Looks like commit fdd867fe9b32 ("arm64/sysreg: Add register fields for
ID_AA64DFR1_EL1") changed the register definition that tripped the
BUILD_BUG_ON().

But it'd be *wildly* unfair to blame that, the KVM assertions are added
out of fear of new register definitions breaking our sysreg emulation.

> I would guess / assume that commit cfc680bb04c5 ("arm64: sysreg: Add
> layout for ID_AA64MMFR4_EL1") is also involved, but having recoiled in
> horror from the awk script, I really can't even begin to guess at what
> is going on.
> 
> Bringing in other people who hopefully can sort this out.

At this point I'm heavily biased towards just dropping the KVM checks
for now than attempt a fix-forward. We can work things out better with
arm64 folks next release.

So unless anyone screams, I say we revert:

  99101dda29e3 ("KVM: arm64: Make build-time check of RES0/RES1 bits optional")
  891766581dea ("KVM: arm64: Add debugfs file for guest's ID registers")

and do so atomically to avoid any further breakage of bisection.

-- 
Thanks,
Oliver

