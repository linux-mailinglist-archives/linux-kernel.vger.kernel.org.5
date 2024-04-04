Return-Path: <linux-kernel+bounces-131494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7718988A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427F21F22A9F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E56F127B40;
	Thu,  4 Apr 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="henlqqgp"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B422433A8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236785; cv=none; b=BLl5POVnVGzFq0mlbYf7QM4LU19FMhIH9dyOcF9WVHqfGCqgYwtfVnLvthzmWVHAUqx7+JQsw7lfAOGN1mCp6H89dgT+tegYarVGSlehO17MvyW8OIwIWay0gywDzxhRkPIuBhW3Dfr4GpMuMTo8/IDjebvm2o0g2EiPQEffWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236785; c=relaxed/simple;
	bh=IeoKAWNWo38K8IL0PVPAWG7KkgiEw6V5EUpqvFfDi+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyURWozH6HkWgpPWaTyXNpBYJKjdM75bm39qkLB/JPJgqJ0GfzBifqxi+Ny9YTNZtAxTITLCPLO3R4WhKOt3GJB9vVH3rrsKzOfEX4vI0lU+xP/fSUo6k3P3n1Dmm5FVv2B0d9y5e4QMHMR0viFzK3XeDjRO7Wk88/K0/1ZiDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=henlqqgp; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e2119cffeso606451a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712236782; x=1712841582; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0GjkWFp3ApOurs5n8Si7/xNCJaddk/YxQVfZe4wLlwY=;
        b=henlqqgpF/2EsTkqPC60/lPuhbF0BZmqmq1p4vG1EN+roSgIxi0ZqGKZBLeNRZHbnZ
         EqfN3Vml7oBtMPD4Cpd1Rl/kff0k68unDQZPU+eNoB8ejHfc4FVZ8+ZqrLtnlP2Vcdr1
         6JnnfUQBtBdYnP0oVasGU2gxaCfzz1RMnHYzXkpxsStFrWPo5DqH52d2snOFwkOZ365D
         3wv02ssH7u3vI909QLNvICUYf+YiklLJc0w1gCUM165WDwjLSMVz2xOJ52TbfU+IzZ4W
         R1kjRRNu99/vIIvVI9KFQEGbEINc/sJcvWteRIxDs5ySsueyKQWp4w8C8HiWxqaMMsST
         JQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712236782; x=1712841582;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GjkWFp3ApOurs5n8Si7/xNCJaddk/YxQVfZe4wLlwY=;
        b=AwaWeA6bAdXAKXRbvOtFWTETb47G8jmSHgUKXF5VS8nK3hHPt+1C9s4Q3K6j44t7Nj
         2QWaJh6AApFlZqMgLZ9XSoID/6Os+cfxsiqvd3yBB4gZXgd2m8wnj0g7NKrGuxfnVXIB
         8RZJWrPkj4Q4ff264joKjRPgK65qeB4Q2bt8QVoUkDOpBut6aEffTJ0Sh/Mi7YbympGn
         6LG3EOgo8Z+L3jPBFt2E9D3+K0214n4pym/nBkbSf7LhltAU8B6czAaR0rMRet43mqlo
         b0mbmL+OSqEBK+yGVbXxbWzaITvtJYoehX/fEU3QCWnrbxNxdKiAgXFe7RY4z7iJ65H8
         vz0g==
X-Forwarded-Encrypted: i=1; AJvYcCXjfVIheuzt5lJ06ugLsFH4nDYUkbSvXEHWhzS8axkkkJ5Maben128WhJ3YddeVIeolb/pRD79KZsrgKTaBVwZ3IQuC8kZwuqfLy8Kt
X-Gm-Message-State: AOJu0YzVBBQodz8ApTtpV3Nz4p43cd9ub4+fsUn9FQjDxSPvCZipCK9W
	sUdzBYG1NqFZFdsqkEoLLEKcBcrFDbqGe/gcIk0OQqN1BkOI2SCWclyjY7n9IQA=
X-Google-Smtp-Source: AGHT+IGJsfjeRV8JN7BFQhANoFqMbTK9dha2lq1Z2/LpaV5C6zDTl7nzvlfIm+foWwn07Yd8JQ0d1g==
X-Received: by 2002:a17:906:e0da:b0:a4e:9b06:db52 with SMTP id gl26-20020a170906e0da00b00a4e9b06db52mr1574450ejb.45.1712236782551;
        Thu, 04 Apr 2024 06:19:42 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id eb16-20020a170907281000b00a4e0df9e793sm9062928ejc.136.2024.04.04.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 06:19:42 -0700 (PDT)
Date: Thu, 4 Apr 2024 15:19:41 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org, 
	Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 08/15] RISC-V: KVM: Implement SBI PMU Snapshot feature
Message-ID: <20240404-0eb0261d56c48ac9472dfe5a@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-9-atishp@rivosinc.com>
 <20240302-6ae8fe37b90f127bc9be737f@orel>
 <CAOnJCUKjZWnS_SaR78Fy5AUOxrd+4gBx=_YrA=FQCa20iwifNQ@mail.gmail.com>
 <a75fa96e-2f26-49a7-a7f7-4a397c4a4513@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a75fa96e-2f26-49a7-a7f7-4a397c4a4513@rivosinc.com>

On Wed, Apr 03, 2024 at 12:36:41AM -0700, Atish Patra wrote:
> On 4/1/24 15:36, Atish Patra wrote:
> > On Sat, Mar 2, 2024 at 1:49 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> > > 
> > > On Wed, Feb 28, 2024 at 05:01:23PM -0800, Atish Patra wrote:
..
> > > > +
> > > >                if (flags & SBI_PMU_STOP_FLAG_RESET) {
> > > >                        pmc->event_idx = SBI_PMU_EVENT_IDX_INVALID;
> > > >                        clear_bit(pmc_index, kvpmu->pmc_in_use);
> > > > +                     if (snap_flag_set) {
> > > > +                             /* Clear the snapshot area for the upcoming deletion event */
> > > > +                             kvpmu->sdata->ctr_values[i] = 0;
> > > > +                             kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
> > > > +                                                  sizeof(struct riscv_pmu_snapshot_data));
> > > 
> > > The spec isn't clear on this (so we should clarify it), but I'd expect
> > > that a caller who set both the reset and the snapshot flag would want
> > > the snapshot from before the reset when this call completes and then
> > > assume that when they start counting again, and look at the snapshot
> > > again, that those new counts would be from the reset values. Or maybe
> > > not :-) Maybe they want to do a reset and take a snapshot in order to
> > > look at the snapshot and confirm the reset happened? Either way, it
> > > seems we should only do one of the two here. Either update the snapshot
> > > before resetting, and not again after reset, or reset and then update
> > > the snapshot (with no need to update before).
> > > 
> > 
> > The reset call should happen when the event is deleted by the perf
> > framework in supervisor.
> > If we don't clear the values, the shared memory may have stale data of
> > last read counters
> > which is not ideal. That's why, I am clearing it upon resetting.
> 
> Thinking about it more, I think having stale values in the shared memory
> would be similar expected behavior to hardware counters after reset. We
> don't need to clear the shared memory during the reset.
> 
> If both SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT and SBI_PMU_STOP_FLAG_RESET are set,
> may be we should just write it to the shared memory again without assuming
> the intention of the caller ?
>

Either way, we just need to ensure it's clear in the spec.

Thanks,
drew

