Return-Path: <linux-kernel+bounces-108908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4D68811C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C171F23F04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6301F3FE23;
	Wed, 20 Mar 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HViyvrjp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E09F4C63;
	Wed, 20 Mar 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938476; cv=none; b=uI1ffeqr36ikBFhe/7bLPhWuIEbhaihg0hLna2C8JDb3UGrQa0udw+9AWCUUd7F3KiVH4F4LszcKU5+GOj7vkFSzpeOl9jiYz7UcZ+D52zBn1EGNO4KgVT3g5fa2JlruxdtvIO37+Rtgn9WByVdFRHh9YdsTMrNlCeRlh8XHMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938476; c=relaxed/simple;
	bh=vnKuUeEoXYqV/fSDad4apteK1Y1+cY5KlsBtoY1K6a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uA0tBWBzXVCtS+w1TcrmLXWWe7ANj4I9Hv4UcciiDq+d9zSF/qYzr2wvYU4Y6E/732IWEb5K9JDp0G2i2cP9iVrBiiPhhgb3/Q0kHQaQxM5RJBnY2tUzpXfXbg6CcRpEseJz9XVC7Vr9OCRlaxg/ai857bxJ8D4jE7tloO04nfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HViyvrjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B1CC43390;
	Wed, 20 Mar 2024 12:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710938476;
	bh=vnKuUeEoXYqV/fSDad4apteK1Y1+cY5KlsBtoY1K6a8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HViyvrjp+OdBLONZAXNxmFTM7cjLT6CO7aD/YtTzx5k4pCy5gSJNGO5uj7UyCjVMQ
	 CVex1+md5VnPIgwQTnLF+glj6I6nP40gFrNY7YOquNjYBAlCm7Wssrm64GxdB+xJYq
	 brpIBS5x7Y3xWYm3XBm7/1j8UcgauP7h57nKlukMXhnL8xDqFD9bx4HyP4Q+TAjD/N
	 D9gXnenJ9/cK6ZmSI15Fac/i0TwPYGhz2mG2l//y4YSm/AOhu2UD62xPah/PjyDZX5
	 7k9zEUGd0gggr3Jfv6sclhfhautSVpSVkq86xyQ9oMcCY7ABsDaufnJoXrg+hl8tYh
	 AncnnXvTEXYbA==
Message-ID: <20f9d90e-454e-448c-989d-84900d380561@kernel.org>
Date: Wed, 20 Mar 2024 13:41:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tracing/tools: Updates for 6.9
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20240318174116.420584-1-bristot@kernel.org>
 <20240319190259.0086706f@gandalf.local.home>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240319190259.0086706f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/24 00:02, Steven Rostedt wrote:
> On Mon, 18 Mar 2024 18:41:13 +0100
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> Steven,
>>
>> Tracing tooling updates for 6.9
>>
>> Tracing:
>>         - Update makefiles for latency-collector and RTLA,
>>           using tools/build/ makefiles like perf does, inheriting
>>           its benefits. For example, having a proper way to
>>           handle dependencies.
>>
>>         - The timerlat tracer has an interface for any tool to use.
>>           rtla timerlat tool uses this interface dispatching its
>>           own threads as workload. But, rtla timerlat could also be
>>           used for any other process. So, add 'rtla timerlat -U'
>>           option, allowing the timerlat tool to measure the latency of
>>           any task using the timerlat tracer interface.
>>
>> Verification:
>>         - Update makefiles for verification/rv, using tools/build/
>>           makefiles like perf does, inheriting its benefits.
>>           For example, having a proper way to handle dependencies.
>>
>>
>> Please pull the latest trace-tools-v6.9 tree, which can be found at:
>>
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git
>> trace-tools-v6.9
> 
> Looks like you just built on top of a random commit from Linus's tree:

yeah :-/

> commit f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
> Merge: 906a93befec8 8f06fb458539
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Mar 17 16:59:33 2024 -0700
> 
>     Merge tag 'i3c/for-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux
> 
> Linus prefers basing off of real tags or previous pulls from us.

Ack, took note. I will do on top v6.8 tag.

> Can you rebase your changes on v6.8 and resend?
> 
>   $ git checkout v6.8
>   $ git cherry-pick f6cef5f8c37f58a3bc95b3754c3ae98e086631ca..trace-tools-v6.9
> 
> Appears to work fine.

questions: when something go wrong in a pull request....

	- Should I keep the old tag, and then do another one with -2
	  (it seems you do like this), or delete the old tag and send it again
	  with the same name?

	- Should I resend the PULL request with something in the log or
	  at the Subject saying it is a v2 of the pull request?

I could ask via chat, but I think it is good for the community to
have access to these info.

Thanks!
-- Daniel

> Thanks!
> 
> -- Steve

