Return-Path: <linux-kernel+bounces-78478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D088613EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2FA1F24656
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F688061F;
	Fri, 23 Feb 2024 14:24:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DF7FBC5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698279; cv=none; b=SXHcn3ep+xx68Q9hmbZSJnwJ/cyUHmxWda4kDcrDdP8Kiwhcg9DBMVm2/Q49fr+KGcKXvCnxL+dcM7Mjefrum57HIgfO0IAQ6OY8VRzj0eEoUgaKcvX+hv7BlOeOF+jrETVXnmHEjjiIpDkkosUfg0Pjt3ODh7YDwvbqRyPhnJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698279; c=relaxed/simple;
	bh=vU/gHBg0qpmT0iQuaGkMnmP+a+3sqFwnNDs8zgNBfOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAqgzWLnVLESk+AztEtTxdSMhVJnO/m6eZzydgNiRZqrxN4/OxvH5uub+dfw2IwbtLBqy9pjGepVU4LJ+a5EFzK30X7hd8h1eAqHLi4YpkdqCJlYFarIDE1cXAoMTJgx82Tb7UfwOAwwQi1Df5qbjV/gC5ZDQiKl9YsaY9IGwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19786C433F1;
	Fri, 23 Feb 2024 14:24:38 +0000 (UTC)
Date: Fri, 23 Feb 2024 09:26:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Oleg Nesterov <oleg@redhat.com>, wenyang.linux@foxmail.com, Masami
 Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Mel Gorman
 <mgorman@techsingularity.net>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Message-ID: <20240223092630.49b9d367@gandalf.local.home>
In-Reply-To: <776b842b-b19f-44bf-bc34-ac756fce7466@efficios.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
	<20240217104924.GB10393@redhat.com>
	<20240219112926.77ac16f8@gandalf.local.home>
	<20240219170038.GA710@redhat.com>
	<20240219122825.31579a1e@gandalf.local.home>
	<776b842b-b19f-44bf-bc34-ac756fce7466@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 13:01:16 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Between "sched_process_exit" and "sched_process_free", the task can still be
> observed by a trace analysis looking at sched and signal events: it's a zombie at
> that stage.

Looking at the history of this tracepoint, it was added in 2008 by commit
0a16b60758433 ("tracing, sched: LTTng instrumentation - scheduler").
Hmm, LLTng? I wonder who the author was?

  Author: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

 :-D

Mathieu, I would say it's your call on where the tracepoint can be located.
You added it, you own it!

-- Steve

