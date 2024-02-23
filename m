Return-Path: <linux-kernel+bounces-78772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4C68618A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2681E1C24DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84E412A151;
	Fri, 23 Feb 2024 17:01:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB7186A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707690; cv=none; b=WLFv/Pyn29hDPgBi+CdnjAZPS1bfmD+OxSHse2hyiJx1F0hl+SvUvHlj0z+jY8ZaNjd6Dbd5xWtGAM+JdxaVDYRO7j6W/kIvALdXaX8wXsDsY5YTmANCnq9f9jjxe9fdGPLL5QWWKrPAav/5gJZK9eTFA5Bt7L7w1s0dwRkSEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707690; c=relaxed/simple;
	bh=R+Lq1HBcs/IxbVCcxtbDjsQ3/cKw8Qf3hrN+jIJXGCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7V9ZhZeH4qeOK/5gEcaaLH+4rw0eiD3REiX6VwcfiJu42SHWoQ9JLWDowCx4zTuapVPS0NjAIegM3SQGhIBvmpFuCoUnoOiCmBZatnHhTESKYLA51xvjV1EBvLDxrTNjSeAc6KqbITqScHxDECWMa1eb65slJm7dTnE2rZKQ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEE6C433F1;
	Fri, 23 Feb 2024 17:01:28 +0000 (UTC)
Date: Fri, 23 Feb 2024 12:03:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Oleg Nesterov <oleg@redhat.com>, wenyang.linux@foxmail.com, Masami
 Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Mel Gorman
 <mgorman@techsingularity.net>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, lttng-dev <lttng-dev@lists.lttng.org>, Karim
 Yaghmour <karim.yaghmour@opersys.com>, Matthew Khouzam
 <matthew.khouzam@ericsson.com>
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Message-ID: <20240223120321.66b0d5d7@gandalf.local.home>
In-Reply-To: <c9427e40-10b1-49eb-9baa-dde1364e8fe5@efficios.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
	<20240217104924.GB10393@redhat.com>
	<20240219112926.77ac16f8@gandalf.local.home>
	<20240219170038.GA710@redhat.com>
	<20240219122825.31579a1e@gandalf.local.home>
	<776b842b-b19f-44bf-bc34-ac756fce7466@efficios.com>
	<20240223092630.49b9d367@gandalf.local.home>
	<c9427e40-10b1-49eb-9baa-dde1364e8fe5@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 11:54:30 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> So this sched_process_exit placement was actually decided
> by Karim Yaghmour back in the LTT days (2001). I don't think
> he will mind us moving it around some 23 years later. ;)

And I wonder how many people are involved in this that are younger than
that change :-p

I'm starting to feel really old.

-- Steve

