Return-Path: <linux-kernel+bounces-75230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D8185E4F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342AF1C23A99
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996FF84A4C;
	Wed, 21 Feb 2024 17:52:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417283CBC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537954; cv=none; b=Z9HLDRbIhIlW9er3HZG8OUPmxMxtZfEkMivkQBLQiIHLIsoiIdFr0XI+CfOzyP8DzH8/P5MnZ7U1ASpAuYdxkOKMNkaznUJnyK1bNN13O65uxcpDoI5LEfITLrrAxTg2JzgHLT+1z5Zod7e74cEIPIt5dQIkUZVXZPVlhkJFuLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537954; c=relaxed/simple;
	bh=vGsigQuL+u0HFHNbxOC0aQw+UDlTSj//wNx9tmWe9kY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lm1j0E39MqCRnYAqEcesv4lhfx3AVl+JqU7ktURBXvgAv0LMh0522UCHkRgRbvvn2NbIrD/ytPr6DDd3aPzwTDewc76L3/pW9ckQ9UPyRiiH8A6iP49AO4qjNM65PGgMmXRUX4qszbl02dOrYgMG4F0gQNtP9x+OprmN5JAldFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCD8C433F1;
	Wed, 21 Feb 2024 17:52:32 +0000 (UTC)
Date: Wed, 21 Feb 2024 12:54:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wen Yang <wenyang.linux@foxmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@techsingularity.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Message-ID: <20240221125420.3430eae5@gandalf.local.home>
In-Reply-To: <tencent_842730EBF8FD3CA3564D50CF04654D52A40A@qq.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
	<20240217104924.GB10393@redhat.com>
	<20240219112926.77ac16f8@gandalf.local.home>
	<20240219170038.GA710@redhat.com>
	<20240219122825.31579a1e@gandalf.local.home>
	<tencent_842730EBF8FD3CA3564D50CF04654D52A40A@qq.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 00:00:55 +0800
Wen Yang <wenyang.linux@foxmail.com> wrote:

> > Honestly, if anything, it should probably be moved down right next to
> > () (I never understood why  needed its own hooks
> > and not just use tracepoints).
> >   
> 
> Perhaps it's just because perf appeared earlier, and it doesn't rely on 
> TRACEPOINTS.

tracepoints existed in 2008 and perf was added in 2009, so time frame was
not a factor.

> It is indeed reasonable to replace perf_event_exit_task() with 
> TRACEPOINT, and we are willing to try to modify it. It will require some 
> work and time.

I think that would be worth while, but I guess Peter will need to approve that.

-- Steve

