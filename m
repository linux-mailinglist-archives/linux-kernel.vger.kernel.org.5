Return-Path: <linux-kernel+bounces-125328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4D8892429
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BACB2222B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEE913341C;
	Fri, 29 Mar 2024 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQf0mqXw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B063D0AD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740415; cv=none; b=AKaBf9QmmkfDSOUPloXxmajYiGi07QfoN2IN8M6oKa3R+j3EzDJOFPQZPx54otFn9CxgvwKsbScEPJqZcP5xK/1V+QJpfRO0fDaxt3pqbPxJ6eU5dV6trgTai6wzg7cF17MrOa5gJK/Dqvo1K/i8XsGI14IYGIgeKXLsQ9irtL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740415; c=relaxed/simple;
	bh=QDSHyVvXwKqJ8O8bqyywWUeosVF+l6dokYgeu6N4UH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUvVknp5dFuF69QHvAnc9PnBZYlOpXEKZzjlwf81A+Lo3sdoM9uwpqP5FoKC6E1qG7zWezy+Ucjp6qWcFtnqChXd4g7MG8MhyD0hMEKynW5HBbSslq1y3OxYdImkgGuowP0rOlkUiKGF+sIrLssoPcLp3wZ5F1ocAyp9XDhZBr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQf0mqXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5286BC433F1;
	Fri, 29 Mar 2024 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740414;
	bh=QDSHyVvXwKqJ8O8bqyywWUeosVF+l6dokYgeu6N4UH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XQf0mqXw49r8j2ILb2jf5mExVoi+CZkPYc/7R8h+61A/gYVZ39lKKuaLCHgpylgpE
	 B7YLDobP8kCuOq4zS+A3atDTTQaGJ3rK+ACzDVRszgNn1Q04cryzTP/xtYF5aFZ2fg
	 /q9pta5LLfrs8NW/Vuzc0a5sVzTLAZ1iq8M4Uir/jeJmmm/gs/mrYqohVhG/YaW64y
	 5OB1imo24mycE0JIwKAo2OObRKbDPA8gKXAtYu+CpPIXKHjJxfBEl2ZIjYM5YVKQ1I
	 WdZvvoLKejjzU1Lnjvr0Mgnr1rrap2VreKtwBzPfu4plJhhwDZVgewr33AXpNojWcZ
	 Ic3r3pDfB6Ptg==
Message-ID: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
Date: Fri, 29 Mar 2024 12:26:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] ARC: Fix typos
To: Bjorn Helgaas <helgaas@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@kernel.org>, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-snps-arc@lists.infradead.org
References: <20240104190247.GA1823635@bhelgaas>
Content-Language: en-US
From: Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20240104190247.GA1823635@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/4/24 11:02, Bjorn Helgaas wrote:
>>> diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
>>> index 0b3bb529d246..5414d9f5c40c 100644
>>> --- a/arch/arc/kernel/signal.c
>>> +++ b/arch/arc/kernel/signal.c
>>> @@ -9,7 +9,7 @@
>>>   * vineetg: Nov 2009 (Everything needed for TIF_RESTORE_SIGMASK)
>>>   *  -do_signal() supports TIF_RESTORE_SIGMASK
>>>   *  -do_signal() no loner needs oldset, required by OLD sys_sigsuspend
>>> - *  -sys_rt_sigsuspend() now comes from generic code, so discard arch implemen
>>> + *  -sys_rt_sigsuspend() now comes from generic code, so discard arch implement
>>                               
> Thanks again.
>
> Added these and a couple other ones to my local copy in case there's a
> v2:

Sorry this slipped thru cracks. I don't see it upstream and given some
pending fixes for Linus can pick this up.
So I take v1 + the fixlet below or do you have any more local changes
and prefer respin/resending ?

Thx,
-Vineet

>
> diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
> index f8f85c04d7a8..8ebec1b21d24 100644
> --- a/arch/arc/include/asm/pgtable-bits-arcv2.h
> +++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
> @@ -66,7 +66,7 @@
>   * Other rules which cause the divergence from 1:1 mapping
>   *
>   *  1. Although ARC700 can do exclusive execute/write protection (meaning R
> - *     can be tracked independent of X/W unlike some other CPUs), still to
> + *     can be tracked independently of X/W unlike some other CPUs), still to
>   *     keep things consistent with other archs:
>   *      -Write implies Read:   W => R
>   *      -Execute implies Read: X => R
> diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
> index 5414d9f5c40c..3490d005e6d4 100644
> --- a/arch/arc/kernel/signal.c
> +++ b/arch/arc/kernel/signal.c
> @@ -8,15 +8,16 @@
>   *
>   * vineetg: Nov 2009 (Everything needed for TIF_RESTORE_SIGMASK)
>   *  -do_signal() supports TIF_RESTORE_SIGMASK
> - *  -do_signal() no loner needs oldset, required by OLD sys_sigsuspend
> - *  -sys_rt_sigsuspend() now comes from generic code, so discard arch implement
> + *  -do_signal() no longer needs oldset, required by OLD sys_sigsuspend
> + *  -sys_rt_sigsuspend() now comes from generic code, so discard arch
> + *   implementation
>   *  -sys_sigsuspend() no longer needs to fudge ptregs, hence that arg removed
>   *  -sys_sigsuspend() no longer loops for do_signal(), sets TIF_xxx and leaves
>   *   the job to do_signal()
>   *
>   * vineetg: July 2009
>   *  -Modified Code to support the uClibc provided userland sigreturn stub
> - *   to avoid kernel synthesing it on user stack at runtime, costing TLB
> + *   to avoid kernel synthesizing it on user stack at runtime, costing TLB
>   *   probes and Cache line flushes.
>   *
>   * vineetg: July 2009


