Return-Path: <linux-kernel+bounces-91464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939D68711E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F996282E47
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8680C6110;
	Tue,  5 Mar 2024 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="06WqZyJD"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA446A0;
	Tue,  5 Mar 2024 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599432; cv=none; b=TvlgZieEbT1wZrV3m5JY8yPeBVOIpewntIa1/L/ozar809JEG+OF4NxDDwseSWo8vWsAwYX/FNr+JhTTXS/8JW8COVfknFUpXtQdOjVnyeblxYahvB8B8Z7ZyAgTmZRKWaR9rruX00vM0hn5ygi2wTEpGRALbULDgQ9BtIw9an0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599432; c=relaxed/simple;
	bh=sLNA+WUpbHvwjwTNEbjFW09PC+UWKmO+1c0w4EX9cQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUxM918EGjhA/QAUDEFmV3cNLOh2sf2C+dSQERp6ru3TzTxTQJ9USJBSmu9nFiaTqxreRvVsklQ4a05XUIYZp2YmBh5HUqgM38efiwkYmfAF5uMYUQCIQsb7ovrEbC4WRUwSQh9NxsYzPNepT27Lx0tE8vIpVyFaeYGqGHF4P88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=06WqZyJD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=mrNHejpABW2qV0pTfb65sdG5Bs9DxgQoXhT9qzQvG8k=; b=06WqZyJDiLi03sa1Xbf3MQfh60
	vxIy33b5+UJO9HD6XWmczEzGRrj47NcF15+p2Iz7UoVzx6k8Rx+PwqLs17Pq2UvbWkXGki/jSkcJx
	2tCxAuHrEevf7Ky0MbeWEaSt+8aQafD4BP5ZBydpTo64QOjLkTi/pFLIfHcZB+5lGNV7+Dxt98WuP
	xzN1a2Wvs9cq0gNT2aUPoyxmqnRTBIlD7uo5FdDW1IIejmGLV8GucR/DVrUc8rfyTNRXwI+/Kjgij
	MQcsMNLiopVhqJeKxe87D7ZFx4JsgWWgvSJMbb7Soa8CVqDt4m1zQJZsJZxiJoblu6TVGyvbs4MWB
	Vb+3R8Dg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhIuK-0000000BGNW-1Gi5;
	Tue, 05 Mar 2024 00:43:48 +0000
Message-ID: <fa113c5c-07c7-417b-8287-c9bf5f9b42a1@infradead.org>
Date: Mon, 4 Mar 2024 16:43:46 -0800
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
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
References: <20240304192710.4c99677c@gandalf.local.home>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240304192710.4c99677c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8198bfc54b58..d68544aef65f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7320,6 +7320,17 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  	if ((ssize_t)cnt < 0)
>  		return -EINVAL;
>  
> +	/*
> +	 * TRACE_SEQ_SIZE is the total size of trace_seq buffer used
> +	 * for output. As the print event outputs more than just
> +	 * the string written, keep it smaller than the trace_seq
> +	 * as it could drop the event if the extra data makes it bigger
> +	 * than what the trace_seq can hold. Half he TRACE_SEQ_SIZE

	                                          the

> +	 * is more than enough.
> +	 */
> +	if (cnt > TRACE_SEQ_SIZE / 2)
> +		cnt = TRACE_SEQ_SIZE / 2;
> +
>  	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
>   again:
>  	size = cnt + meta_size;


-- 
#Randy

