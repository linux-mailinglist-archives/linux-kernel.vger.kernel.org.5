Return-Path: <linux-kernel+bounces-91404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D6E871105
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D93286A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D8B7CF03;
	Mon,  4 Mar 2024 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Lq7A1dKK"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8B1E4A2;
	Mon,  4 Mar 2024 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709594628; cv=none; b=sehKkGC+GJmECeU56ZGtXKY7XL8BG/hV4hiYDYyQkVeggNYJ8akuESQYAchhuJx02Tipj0eMTLU8X5aefYgzHfgj4Zypuh/iBkbd1juxCf1r3w82zgQVTjEQvSQODX3iB79ZnEs3rvcn8N0vRvYHBUFlUAQRfHIBS69EBrPhnsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709594628; c=relaxed/simple;
	bh=HEq5kgUP1ZPh6+iesZI1t0ZbH0sGN6VXjzGiLV0x70g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbhMGMGmbAfARnsnmyCHObqOnEVAf3YlWw9cB5vMDtBWRhvFCt9I7g2OPvzd6xjZhIyF8SGUQbsuEX7RddI0oFazSgVL+2k0j0kXaCM/A5GJQTbzNat8V5TorfcKn+apUNJb7G/NVV28V9ViY/U6/QdjzqoPG29LcrMOIUH949Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Lq7A1dKK; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709594617;
	bh=HEq5kgUP1ZPh6+iesZI1t0ZbH0sGN6VXjzGiLV0x70g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lq7A1dKKdKHYGgVerwIPoaMP/oem/Sw4zYJEeh3Uh0vap4ivUuxdZdZ5MeZVpqtPY
	 wzoZ5eF4Idl6zq4reEmNAnIlgTlle9lqOoHFdlGds7COD/U7SVktHdbzXjucH4FhTf
	 ImtK22+NAE9igHG64k7rlYVaih1s2h8qU/iOQTBbD2F0fKUAOCWhOJwlzvf1ZwGYw4
	 Tj0NBrVVr6sAg7uvFTAixQ78RTim+yHupOvNfgbuHWzsMOBLnOcNJZeG6TmWqvLd2x
	 rw+dBL7d9aJ/dwTyhFBUX2mw5hbKe8LZGJ4dMK6FIIdIMu3zS8zki4/gLHd6Xp5kZu
	 BFfMWQFryfsWQ==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TpZWY0lJBzfcS;
	Mon,  4 Mar 2024 18:23:37 -0500 (EST)
Message-ID: <b3803989-8465-4656-8ca3-678a92f9a140@efficios.com>
Date: Mon, 4 Mar 2024 18:23:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Remove precision vsnprintf() check from print
 event
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
References: <20240304174341.2a561d9f@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240304174341.2a561d9f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-04 17:43, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> This reverts 60be76eeabb3d ("tracing: Add size check when printing
> trace_marker output"). The only reason the precision check was added
> was because of a bug that miscalculated the write size of the string into
> the ring buffer and it truncated it removing the terminating nul byte. On
> reading the trace it crashed the kernel. But this was due to the bug in
> the code that happened during development and should never happen in
> practice. If anything, the precision can hide bugs where the string in the
> ring buffer isn't nul terminated and it will not be checked.
> 
> Link: https://lore.kernel.org/all/C7E7AF1A-D30F-4D18-B8E5-AF1EF58004F5@linux.ibm.com/
> Link: https://lore.kernel.org/linux-trace-kernel/20240227125706.04279ac2@gandalf.local.home
> Link: https://lore.kernel.org/all/20240302111244.3a1674be@gandalf.local.home/
> 
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Fixes: 60be76eeabb3d ("tracing: Add size check when printing trace_marker output")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This is a step in the right direction IMHO.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Just out of curiosity, is there anything to prevent trace_marker from
writing a huge string into the ring buffer in the first place ? Is this
limit implicit and based on the page size of the architecture or is it
a known fixed limit ? (e.g. 4kB strings).

It appears to currently be limited by

#define TRACE_SEQ_BUFFER_SIZE   (PAGE_SIZE * 2 - \
         (sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))

checked within tracing_mark_write().

I would have hoped for a simpler limit (e.g. 4kB) consistent across
architectures. But that would belong to a separate change.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


