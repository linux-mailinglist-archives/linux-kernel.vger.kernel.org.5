Return-Path: <linux-kernel+bounces-81436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 976C98675EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961231C24CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340CF8002A;
	Mon, 26 Feb 2024 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QVfrsWSK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3mFp5V+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774A5A7B9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952595; cv=none; b=b3TlbAaS8SPPo3Kmj160C+FpMYQ5Rn/wUt9y2TdNsZPYaAEIwBVqXf20692gt1pyyeQl4vqkSyg44dcn0bJ0rPMcFWKWtWdn7H99Z/i8RUM3F7j03MrnbheV++4hjfa1Vif9zx7BMv8+KENdaaqjxNq2r6S4UuM3zaKFUNdsc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952595; c=relaxed/simple;
	bh=HIrEsdXsBYKVzEMqvaaTbk4nndRfnsAXSaCAYIPAUS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ADF2TTJQ0YL1kPZhv/ASXdsU+fVT5DVXEieaR/60d7bs8s3FKVcFu9xq5dJzwkCC/3CQBY8oq2dQKSYrXcTfkHKszeN9yVcGYFXY0gAmmMZ94J8vXNYUginI7V+ndeJj0PNSugAIwDU7jaVLsjeHUXsZETGnZH5xhAWoYTI4PtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QVfrsWSK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r3mFp5V+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708952589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AvZgz/eqbdExfSVQsfAaABe1V1JJXqW2EkI3XcjeC/A=;
	b=QVfrsWSKBgu5rrxR6F4rTjRqBVgVX74fqKQb2ESyjQWwUC+aF3216s6wRtmvMRAYEK/YZP
	lSLCWb/UD4vWkuOPinSV2bFZeb17GIOoQk8A1+dwtb0G/hZ+fZg6Dd+euz1qLqzKBAyUwR
	4JfakK+3lU5gmKjDD4I0or+CCvayQ9pt+MqRN/1SYuz35l2vS6ih4uFdTBjWXCd9v5tC+k
	tBIKoQNgyMa+xppCKAravED38SfEdWcXVBc0jcsnkusUfH7b3RLDTJOevN+fphS2Dgxk11
	VpAVqZKaPc9kgTF5LzS8a5qpN8xbGnr1dJZ0igR7/XGzmIltPY9xwRaV+1YNzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708952589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AvZgz/eqbdExfSVQsfAaABe1V1JJXqW2EkI3XcjeC/A=;
	b=r3mFp5V+dd3HkC0KI4iPhPFpaLhky4EZlD/nCh0tipqqC1woRHEH8oWe322Zk4Z3WfEQk5
	4vaAoSK1RELZI+BA==
To: Mukesh Ojha <quic_mojha@quicinc.com>, pmladek@suse.com,
 rostedt@goodmis.org, senozhatsky@chromium.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Update @console_may_schedule in
 console_trylock_spinning()
In-Reply-To: <44648e78-d117-2f6a-8ecd-f0a29327fa4f@quicinc.com>
References: <20240222090538.23017-1-quic_mojha@quicinc.com>
 <87plwo5z4k.fsf@jogness.linutronix.de>
 <e5474801-53c1-6bbb-8781-e5cee42d6a90@quicinc.com>
 <875xybmo2z.fsf@jogness.linutronix.de>
 <44648e78-d117-2f6a-8ecd-f0a29327fa4f@quicinc.com>
Date: Mon, 26 Feb 2024 14:08:40 +0106
Message-ID: <8734tfml8v.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-26, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> what if console_trylock_spinning() gets the lock which makes 
> console_may_schedule =1 and it is still schedulable ?

I am afraid I do not understand the question.

console_trylock_spinning() is only called from the printk caller
context. In this context, console_may_schedule is always set to 0.

Only if another context acquires the console lock per sleeping wait,
console_lock(), can console_may_schedule be set to 1.

Note that the value of console_may_schedule is only relevant for the
console lock owner when console_unlock() is called. That is why its
value is set when locking the console (or, with this patch, when
transferring console lock ownerhip).

John

