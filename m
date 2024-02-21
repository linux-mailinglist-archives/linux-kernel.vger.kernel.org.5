Return-Path: <linux-kernel+bounces-73900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2945485CD61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E081C2295D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949F63D8E;
	Wed, 21 Feb 2024 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MqnGrAKx"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995317D5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478387; cv=none; b=Nz2ig2kmjjtjLE/ynBzGycpzPo/++dYz6eFtuR2002EEnLyrxfvaRZI0mnSM/UdUGhlIxlipTeMd0f6iUwktpWaewTFIaLJ6IAoB5z6RwtyunLJ96BpU4fogF13B7izjX/rczzNsBHciXErMqaZTTR3jj4bwifHCXgfvJK4JU6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478387; c=relaxed/simple;
	bh=6/glKGzu8sXwIj1QlUBVmHL7r5uiHVi11vfem8VTVAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpLQakAbxuKnzcZw2v6c6V51iYy4t0NsjpHeG3eST6rd8uJ7W1dABsxCH5RMqS0wTGBzoYFwvKXuMGR2zMgrn1SgiBhTcqiXVAyCwECVOapvXFWS1A85qLffFEEYbsGub4i7M1+laz8LPOaamovVozRMH0+OaFDLv7QR10+96vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=MqnGrAKx; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1708478377;
	bh=6/glKGzu8sXwIj1QlUBVmHL7r5uiHVi11vfem8VTVAo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MqnGrAKxw02ElTuPckcNMGH2zFdCapZj+mIvup+h/lfcG7qBQYltRoy5sFyz1vm0G
	 WVjlAk2AX4DXnFxDb1zR0vpCB8g3UwCJHyc32CcgBwCIOzp1hDAKOHxK2eZlyEsLGl
	 CTw30XKB8qrWKSnAwTJRRP4A2pvNb0icC0Tq3mqoktoQyYLy5Hf2Wbp/aJO1o0ZJKo
	 Fu+SAE8ymQAtWBX9cMBaDWYS6TsYvDtnCnwWLT8XCDpf72/79Hr14HpA8rUETk46pr
	 tOUeSbp3ZTrnStDt8vup89GXTAMyGrf/OUca8X6QDtkgcGOE/Y1LIm/pLX5BGHL7+N
	 jKjOH+D2Qp8Yg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TfdjP4Jrdzclm;
	Tue, 20 Feb 2024 20:19:37 -0500 (EST)
Message-ID: <182553e4-a2e2-46f6-8c50-2de6f8effee7@efficios.com>
Date: Tue, 20 Feb 2024 20:19:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/clock: Make local_clock() notrace
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
References: <20240220202002.38fec245@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240220202002.38fec245@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-20 20:20, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The "perf" clock in /sys/kernel/tracing/trace_clock enables local_clock(),
> where on machines that have CONFIG_HAVE_UNSTABLE_SCHED_CLOCK set is a
> normal function. This function can be traced.
> 
> I found that enabling the "perf" clock on some debug configs and running
> function tracer can live lock the machine. That is, it goes so slow that
> nothing moves forward.

And I bet this is why the try_cmpxchg for reservation was
looping endlessly. ;)

Thanks,

Mathieu

> 
> Cc: stable@vger.kernel.org
> Fixes: fb7d4948c4da2 ("sched/clock: Provide local_clock_noinstr()")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   kernel/sched/clock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index 3c6193de9cde..af8b698dee8c 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -308,7 +308,7 @@ noinstr u64 local_clock_noinstr(void)
>   	return clock;
>   }
>   
> -u64 local_clock(void)
> +notrace u64 local_clock(void)
>   {
>   	u64 now;
>   	preempt_disable_notrace();

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


