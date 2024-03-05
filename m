Return-Path: <linux-kernel+bounces-91579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664CB8713E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DEF1C2121D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F78C28E0D;
	Tue,  5 Mar 2024 02:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Y/KPDcFv"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9E4C94;
	Tue,  5 Mar 2024 02:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606920; cv=none; b=Z1Dk8l94bxOzmOLReCoS0oyVIIi3k7p6t+0JBb7qE9pk1QWp5+W4bI2369mZSEq2eA5hPlPglZ0sYWQMcfEYW19M95x/cNH+wInc1iexo30zW1cq38Sx7rQLO0cTM1xhU/pkGTLhaMI1SEOdNV5util+BV9ZoFoP9Dez2NiezXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606920; c=relaxed/simple;
	bh=GAWZ8UNjl6s+DAbSwGc+vclJVErm7Zx0BP2duUjGpzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kc4wQvkblvUky5ODjOmzm+9XPo52NFkyiACwKWxYpU0YQD8TzmdWvEhAsHulLyi/wbuFd5uJV57S0H+MLmjuDnFAiDKjmx/W47wOkepFbXWj64OtHYeJhIV8AuYnaC4F8YswgHSvsLTU+PGhSTiEgRBl5xCQZ0WU/g0HsVNeZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Y/KPDcFv; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709606917;
	bh=GAWZ8UNjl6s+DAbSwGc+vclJVErm7Zx0BP2duUjGpzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y/KPDcFvoghRdYr9T34mxYQHUW6r1saV2X1r9NgrpnqkmLuspKIyPoDO2lmiEqTSJ
	 GjJwojFsKRqNbP7E4ZTAbBpb8JFZN96Qr1Usrqweru4pmnd9WodRs9lp2ocDJc8Cg9
	 dLq7t8gVU/FdqLsukS3RNpC7C4bRc9/WUHswfOi0qhkElaeT2zpuRc2rFebIyngXZ5
	 BUzN2YnPPDeUZ6k3SvVsJ1rySWoYGbuAoJFdmC4ZKrpTJeFdDDPty9Y+PLhjbjMJmB
	 2YRx7GPPnqXmfgG0SaqIGLfjN1kHmilth+3vE37wx86zLSlVe3T26dySy2RKxeQNEj
	 uC+Gyk75K8qAg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tpg45376nzfMy;
	Mon,  4 Mar 2024 21:48:37 -0500 (EST)
Message-ID: <c3051fd1-2aaa-485f-b23d-d98c3579e166@efficios.com>
Date: Mon, 4 Mar 2024 21:48:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
References: <20240304192710.4c99677c@gandalf.local.home>
 <469d31a7-f358-4547-bb17-0979b3515924@efficios.com>
 <20240304203516.45b7a551@gandalf.local.home>
 <20240304204119.7503ab0b@gandalf.local.home>
 <91f27ba1-15a4-402d-8301-e2b9d23f64b0@efficios.com>
 <20240304205943.081bea96@gandalf.local.home>
 <cef0b07e-f90d-4759-ae54-0f091e87edab@efficios.com>
 <20240304213538.13fe1f3b@gandalf.local.home>
 <20240304213750.1baef01d@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240304213750.1baef01d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-04 21:37, Steven Rostedt wrote:
> On Mon, 4 Mar 2024 21:35:38 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>> And it's not for debugging, it's for validation of assumptions
>>> made about an upper bound limit defined for a compile-time
>>> check, so as the code evolves issues are caught early.
>>
>> validating is debugging.
> 
> Did Linus put you up to this? To test me to see if I'm learning how to say "No" ;-)

No, he did not. I genuinely think that validating size limits like
this either at compile time or, when they can vary at runtime like
in this case, with a dynamic check, decreases the cognitive
load on the reviewers. We can then assume that whatever limit
was put in place is actually enforced and not just wishful
thinking.

If the "header" size upper bound is not validated at runtime, there
is not much point in adding the BUILD_BUG_ON() based on that value
in the first place, and you should then just add a runtime check that
you don't overflow the output buffer before writing the output to it.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


