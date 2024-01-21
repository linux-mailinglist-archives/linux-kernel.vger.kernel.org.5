Return-Path: <linux-kernel+bounces-32168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 007BC83579B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C981C21410
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26714383A2;
	Sun, 21 Jan 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkcwroMG"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA138397
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705866606; cv=none; b=r8CFHVPezFcWHyST/8P4AjnwiFUic1wENo1LJ8C5nV+9bbwYBjvXLpXKnlLqdG15qkMPSw8zrJR9XBHeMXxe/FE+bXMF98SPSIcyv6QuyaCuKkT37fJQtuvBoQZEXOWrm5LYUnPJyhyOS+xTfwhYCKCrnI+9tm3zEknLw213r2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705866606; c=relaxed/simple;
	bh=GOOCVAz86NeqG0sk6twx3bAlnr0uXcQviDLTcHcui5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCMPZDlumK7Ow/jFGijr4fXZhQpQBsnz+QNG876hoIUXttngIoqlLpXYuBC7UvYNNPLTtOjWEPucupZPzyVRLnxPSKbNBfaQnC/xPEJlMoApu4bjyIWhpPyDSOCsAi+HemWZtAhV1n4hZ0AewUP5OEW3l3yHcI1dlvkhXMUtK3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkcwroMG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ffcb478512so4054507b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 11:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705866604; x=1706471404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZcQJlxOQWK9UNRnwX6ulR5fm9lMNehBcKbqGyP7gRU=;
        b=NkcwroMGcOgj+hZgD3I0KdgmQDeDLhwVGvszUcmBbYq5kyBZYhyLIkU5jbDnn4LVEA
         IpyiK2Jpj9kiokIYsIo4/MXnkBkDMmeoVidThUB/vmPMJkaUsO7I88ZJgvcDuzHG4tm5
         2AMS7MOiqwn10CufEg9Q77SwWASD/lVXGY7lEkP/S4Xg4HEjMk00ut2UHzvzdr+A194k
         DDVRdRTOX2vjtX55XOiqNqPY1UYJy4aQy9gycE7AUEjgFFypPawkzRgAogVsffoPtIr8
         rNaD3jseU4etf6ulFT6ATW9AzqKhETzRVsazw/4A5LDCSpMhdlatJ7W6bgkpfXs00QMP
         +C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705866604; x=1706471404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZcQJlxOQWK9UNRnwX6ulR5fm9lMNehBcKbqGyP7gRU=;
        b=sSaCZ0RUleX2MfPJvBdCLg0Vu6do8LDSrTElNq9ux6mvlasV8aPVLhm8eDKPzGd+VI
         g3swKJh35qrFZ4RmTgei9NCuWED372xR5P+uNE0lUfrK2G9odCpRSwC1uUKmqcUNqHFe
         Q5j9EhlKzbBbp4pDiZJYl2OwQ7a/6xKDYEdjOXzV5BUecFTwLrBHT6MzvfI9y6bz+HKl
         OI1EttLvFzyHGBlohWuYjr+ySrdPyr5jo9cKRyBN91Us2C4xoFx8sW0WVzNhd0Uy9I5N
         smRR7AFT44xZTLUms4gbUINxNCR/DlS//wXpb7gXG8YBqxt8YuZGLudIotUOfAlsEqqI
         eNQg==
X-Gm-Message-State: AOJu0YyF6cbyrX3dpDXmvMmmDon3vCUlc/TzmzoO+um94gfE37zSOANP
	KQJqzEjMMPowb1mGTHHGA3CaAyd/DLoSCr8tIFvwcNXqO6Fw4r/l
X-Google-Smtp-Source: AGHT+IF+jEzVeZsZ/nk/u9cVp8uUtAdyRek06pEIiStUaDlWoL/CSOelK9i/4L6WPxXBs1tj6o6XoQ==
X-Received: by 2002:a81:6cd3:0:b0:5f6:83fd:5097 with SMTP id h202-20020a816cd3000000b005f683fd5097mr2238479ywc.7.1705866603881;
        Sun, 21 Jan 2024 11:50:03 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:723b:dc5d:8680:45e5])
        by smtp.gmail.com with ESMTPSA id ci24-20020a05690c0a9800b005f93cc31ff0sm8897149ywb.72.2024.01.21.11.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 11:50:03 -0800 (PST)
Date: Sun, 21 Jan 2024 11:50:02 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH 1/9] cpumask: introduce for_each_cpu_and_from()
Message-ID: <Za11asdkTrKzrL8e@yury-ThinkPad>
References: <20240120025053.684838-1-yury.norov@gmail.com>
 <20240120025053.684838-2-yury.norov@gmail.com>
 <Zas4CeVG6mlfiUM9@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zas4CeVG6mlfiUM9@fedora>

On Sat, Jan 20, 2024 at 11:03:37AM +0800, Ming Lei wrote:
> On Fri, Jan 19, 2024 at 06:50:45PM -0800, Yury Norov wrote:
> > Similarly to for_each_cpu_and(), introduce a for_each_cpu_and_from(),
> > which is handy when it's needed to traverse 2 cpumasks or bitmaps,
> > starting from a given position.
> 
> The new helper is useless, see
> 
> https://lore.kernel.org/lkml/ZZNgDb6bzOscrNmk@fedora/

Let's consider the following configuration.

CPUs: 0b1111
Sibling groups: 0b0011 and 0b1100
nmsk: 0b1111

As the complexity measure we take the number of accesses to nmsk in
the outer loop, and to (nmsk & sibl) in the inner loop in search
routines, so that

	cpumask_first(1111)

requires 1 access to find the first set bit, and

	cpumask_first(1000)

requires 4 such accesses.

Actual find_bit() ops work better than this by using __ffs(), but on long
bitmaps the performance will be as described above.

Now, look at the code. This is yours:

  static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
                                  unsigned int cpus_per_grp)
  {
          const struct cpumask *siblmsk;
          int cpu, sibl;
  
          for ( ; cpus_per_grp > 0; ) {
                  cpu = cpumask_first(nmsk);
  
                  /* Should not happen, but I'm too lazy to think about it */
                  if (cpu >= nr_cpu_ids)
                          return;
  
                  cpumask_clear_cpu(cpu, nmsk);
                  cpumask_set_cpu(cpu, irqmsk);
                  cpus_per_grp--;
  
                  /* If the cpu has siblings, use them first */
                  siblmsk = topology_sibling_cpumask(cpu);
                  for (sibl = -1; cpus_per_grp > 0; ) {
                          sibl = cpumask_next(sibl, siblmsk);
                          if (sibl >= nr_cpu_ids)
                                  break;
                          if (!cpumask_test_and_clear_cpu(sibl, nmsk))
                                  continue;
                          cpumask_set_cpu(sibl, irqmsk);
                          cpus_per_grp--;
                  }
          }
  }

This is your code step-by-step:

#	loop	cpu	match	siblmsk	nmsk	irqmsk
 0	outer	0	yes 		1110	0001
 1	inner	0	no  		1110	0001
 2	inner	1	yes 	0011	1100	0011
 3	inner	2	no 		1100	0011
 4	inner	3	no 		1100	0011
 5	outer	0	no	 	1100	0011
 6	outer	1	no	 	1100	0011
 7	outer	2	yes	 	1000	0111
 8	inner	0	no 	1100	1000	0111
 9	inner	1	no 	1100	1000	0111
10	inner	2	no 	1100	1000	0111
11	inner	3	yes	1100	0000	1111
12	outer	0	no	 	0000	1111
13	outer	1	no	 	0000	1111
14	outer	2	no	 	0000	1111
15	outer	3	no	 	0000	1111

This is mine:

  static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
                                  unsigned int cpus_per_grp)
  {
          const struct cpumask *siblmsk;
          int cpu, sibl;
  
          for_each_cpu(cpu, nmsk) {
                  if (cpus_per_grp-- == 0)
                          return;
  
                  /*
                   * If a caller wants to spread IRQa on offline CPUs, we need to
                   * take care of it explicitly because those offline CPUS are not
                   * included in siblings cpumask.
                   */
                  __cpumask_clear_cpu(cpu, nmsk);
                  __cpumask_set_cpu(cpu, irqmsk);
  
                  /* If the cpu has siblings, use them first */
                  siblmsk = topology_sibling_cpumask(cpu);
                  sibl = cpu + 1;
  
                  for_each_cpu_and_from(sibl, siblmsk, nmsk) {
                          if (cpus_per_grp-- == 0)
                                  return;
  
                          __cpumask_clear_cpu(sibl, nmsk);
                          __cpumask_set_cpu(sibl, irqmsk);
                          cpu = sibl + 1;
                  }
          }
  }

Step-by-step:

#	loop	cpu	match	siblmsk	nmsk	irqmsk
 0	outer	0	yes 		1110	0001
 1	inner	1	yes 	0011	1100	0011
 2	inner	2	no 	0011	1100	0011
 3	inner	3	no 	0011	1100	0011
 4	outer	2	yes	 	1000	0111
 5	inner	3	yes	1100	0000	1111

Your code works worse because it's a Schlemiel the Painter's algorithm.
I mentioned it twice in the commit messages and at least 3 times in
replies to your comments.

Here I'll stop and will not reply to your emails, including the rest of
that Friday's night mailbombing, unless you at least admit you're wrong
in this case and for_each_cpu_and_from() is useful here. 

I'd also recommend you to learn more about atomic operations basics and
revoke your NAK from the patch #3.

Thanks,
	Yury

PS: There's a typo in the series name, I meant that the series makes the
function O(N) of course. But even that is overly optimistic. It's O(N*S),
where S is the number of sibling groups. A couple more patches needed to
make it a true O(N). Still, much better.

