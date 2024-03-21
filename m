Return-Path: <linux-kernel+bounces-110514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA65885FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FCF286D71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393A413173D;
	Thu, 21 Mar 2024 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BY5BgQ2n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E684A28;
	Thu, 21 Mar 2024 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043069; cv=none; b=bxe5RgrnojKXhejIzi7mWgQBHXzVWz0BZ96Edv7ybvQM9jNMgz3zoumjfhseAwzD/A64U8dO27VWkOd/Uaduj2ZkAdmqHcUQxHXrvnVNmj12xMUKOQ5bfU/6dsvXAm+P/0qoovg69f+Sg5mDcmgxio1JIKtyDqDdFLlUXAnXMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043069; c=relaxed/simple;
	bh=9bS/UCPvtpMdK1sW9IEcljYoLWk/3hdHxUQ46x96FGA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LyOvz/hxWywabRNfhJ5d6qFtMA/GlGbDsX9Oz+uar4rMwbtjhNk2R0+HxGmyrEwosO7thqdixXaYJAG85RRniZIDGyR9PsRRjs0JVWYVe/49UQxaHyqWI4xGW4LTnjGs2bY1BZehfFPM+xsAlefeTTcdSQvBxppbynkF71OfpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BY5BgQ2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726B3C433F1;
	Thu, 21 Mar 2024 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711043068;
	bh=9bS/UCPvtpMdK1sW9IEcljYoLWk/3hdHxUQ46x96FGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BY5BgQ2nAV68ulHmS4PWQLM7hYYDacnq/NTJQdc0ojwqowP9U9TRKS3Apn+lBgjPT
	 BtGbEcvJIcgF09JGaEMZdAnaqeOrGS82IGuKHnsZ4xAbrQPgFfXmG4/SgGO3T/0vBU
	 WWgbyTJ239GV+cJmh7oA+sfEUtm+BB4ShoNnQkhQ=
Date: Thu, 21 Mar 2024 10:44:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, corbet@lwn.net,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, Chris
 Zankel <chris@zankel.net>, Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu
 <herbert@gondor.apana.org.au>, Guenter Roeck <linux@roeck-us.net>, Max
 Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] Documentation: coding-style: ask function-like macros
 to evaluate parameters
Message-Id: <20240321104427.730b859087afecf5973d1c58@linux-foundation.org>
In-Reply-To: <CAGsJ_4y+1HovQ52HPis8NBDqp4-fiGRwehX+NH0New0HoEU5GQ@mail.gmail.com>
References: <20240320001656.10075-1-21cnbao@gmail.com>
	<20240320124207.0c127947@canb.auug.org.au>
	<CAGsJ_4zpXwVEhsdffoZVBVWiwT4Lw2qEMrW-X92ib=kv=9Yx9g@mail.gmail.com>
	<20240320084919.8e18adb418347feed6bfc8ae@linux-foundation.org>
	<CAGsJ_4y+1HovQ52HPis8NBDqp4-fiGRwehX+NH0New0HoEU5GQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 07:48:36 +1300 Barry Song <21cnbao@gmail.com> wrote:

> > Stronger than that please.  Just tell people not to use macros in such
> > situations.  Always code it in C.
> 
> While I appreciate the consistency of always using "static inline"
> instead of macros,
> I've noticed numerous instances of (void) macros throughout the kernel.
> 
> arch/arm64/include/asm/cpuidle.h:#define arm_cpuidle_save_irq_context(c) (void)c
> arch/arm64/include/asm/cpuidle.h:#define
> arm_cpuidle_restore_irq_context(c) (void)c
> arch/loongarch/include/asm/io.h:#define iounmap(addr) ((void)(addr))
> arch/mips/include/asm/cop2.h:#define cop2_save(r) do { (void)(r); } while (0)
> arch/mips/include/asm/cop2.h:#define cop2_restore(r) do { (void)(r); } while (0)
> arch/mips/include/asm/cop2.h:#define cop2_save(r) do { (void)(r); } while (0)
> arch/mips/include/asm/cop2.h:#define cop2_restore(r) do { (void)(r); } while (0)
> ....
> 
> I'm uncertain whether people would find it disconcerting if they completely
> deviate from the current approach.
> 
> If you believe it won't pose an issue, I can proceed with v3 to eliminate
> the first option, casting to (void).

I think so.  My overall view is that we should write things in C.  Only
use macros if the thing we're trying to do simply cannot be done in a C
function.

- inline functions don't have the "expression with side effects
  evaluated more than once" problem.

- inline functions avoid the unused-variable issue which started this thread

- inline functions look better

- for some reason, people are more inclined to document inline
  functions than macros.

