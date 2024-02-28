Return-Path: <linux-kernel+bounces-85794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2993686BAD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6F21C2123B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C85E70053;
	Wed, 28 Feb 2024 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kYxz469G"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D21361A4;
	Wed, 28 Feb 2024 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160257; cv=none; b=LZI6dhR+b8aeCZ0bC0S71rWwRdzRWxkrLHWnPEOR0juBh0zSeLfjMnTWV/Zywr51LP/oCXDEZlUOLY3jDmRS3tq5dmQV16uILdeCdEiIQSdv1fDPGccs0X/aI0ac8tO6v27sI2OQ+beNr2TqAGcho5g7duF5TVwZXaPDmOlht1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160257; c=relaxed/simple;
	bh=sFfSQI8H9anZqbz5zbNOIZk5SSnIblghGOAsPyjilNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ne3z+051HVH0UdirKSHAyebv8m/M9HiGWrLPLDMzZRaP0gB61PuDj2M+yaiNLXOpG/O+4zFygq+hjJbAOGItLNYGPm7rK8/OTACi4hYKOKsfFlhoWEUDdnByJigIR+7OalSO7wcY0QajxvzXnqmgXVsgOUgDq5QAHNDcZF3wsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kYxz469G; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 564AE418B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709160255; bh=bPfj70haa25vAmOOxEZhbdceUi0BE5fJTxAq5LIhQMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kYxz469GMvwqL0TDa/2gg7OCU9jAQKhQ8VcBrE+zyB5gecIQq/mj3QxaEdLrIpWhw
	 1aaX3Pr/8HF+7bTXppbjQBZAV9YgC4PiwZRJaAVD212OJzzUhs+XoNjGDnO3ZRkvo0
	 MCDmAxdXfrWzmtNPNVAdVnr0OEtkWyG77D+Cx0PhMrLsDEha1DF+/PVJrU1/xu2SS5
	 VoInppWoPPAk1xBAXS9o2lX1AJVm3d+MgrMMd8CiqyHJT1ffONOw/ktr0LcqhN0p3o
	 dc9g32owRJIMB7tyzLPj4tHeGLozLuulr702Mvqb2vX3bDDasQPx22gZlML6f2nFYF
	 3VXNYM8tnqhTg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 564AE418B5;
	Wed, 28 Feb 2024 22:44:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: mingo@kernel.org, chrubis@suse.cz, zhangqiao22@huawei.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/Documentation: Add RT_RUNTIME_SHARE documentation
In-Reply-To: <20240131123238.2332064-1-zhangqiao22@huawei.com>
References: <20240131123238.2332064-1-zhangqiao22@huawei.com>
Date: Wed, 28 Feb 2024 15:44:14 -0700
Message-ID: <875xy8p5tt.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zhang Qiao <zhangqiao22@huawei.com> writes:

> RT_RUNTIME_SHARE is an important strategy for rt bandwidth, and
> we should document this sched feature.
>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
>  Documentation/scheduler/sched-rt-group.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
> index d685609ed3d7..4d8eceb71f5e 100644
> --- a/Documentation/scheduler/sched-rt-group.rst
> +++ b/Documentation/scheduler/sched-rt-group.rst
> @@ -12,6 +12,7 @@ Real-Time group scheduling
>       2.1 System-wide settings
>       2.2 Default behaviour
>       2.3 Basis for grouping tasks
> +     2.4 RT_RUNTIME_SHARE sched feature
>     3. Future plans
>  
>  
> @@ -146,6 +147,16 @@ For now, this can be simplified to just the following (but see Future plans):
>  
>     \Sum_{i} runtime_{i} <= global_runtime
>  
> +2.4 RT_RUNTIME_SHARE sched feature
> +----------------------------
> +
> +RT_RUNTIME_SHARE allows a cpu borrows rt-runtime from other cpus if it runs
> +out of its own rt-runtime.
> +
> +With this feature enabled, a rt-task probably hits 100% cpu usage and starves
> +per-cpu tasks like kworkers, as a result, it may hang up the whole system.
> +Therefore, in order to avoid such exception, recommand to disable this feature
> +by default unless you really know what you're up to.

So this doesn't appear to have been picked up by anybody...should I
carry it in docs, or is there some other reason why it hasn't gone in?

Thanks,

jon

