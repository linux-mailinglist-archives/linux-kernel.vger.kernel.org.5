Return-Path: <linux-kernel+bounces-109527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E15881A89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7163B1F21E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C281C2E;
	Thu, 21 Mar 2024 01:01:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B27EC;
	Thu, 21 Mar 2024 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710982885; cv=none; b=kcZGwGfv8DzRMOFiebtBkmMBKo58atgQQwIlAPE2y8XbjfjAmp8A+vomsHEi87z8lFl+ecr97zonHjmB17jRwf3ZvkC5FPfBI2CyBXzwjjVlcBGvwH+MjoKVJo2aoTMZbEtJKIhy7D/WGTXv2W9YzzPwtBSTif+geZtM4RuLvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710982885; c=relaxed/simple;
	bh=o0lplZfwjud6cBPxVpG/cJOFDhTyW/8M34WdGFKdPUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0/pNHUw32gTgEUV/vYuuveHw8mzU+Wd/YLkyNt6hkv1JxL9qhvvXT8llgeFklgpKFIcj2sjouu/p2eOwbx8oEyub+WCy+gR+fLbKQC28uJzTC35z5VpX7CoZ2LX5CKluN/6fEsmJE/XF+xbQfn6JqjL14z0TODVgHtFWbY3v/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF76C433F1;
	Thu, 21 Mar 2024 01:01:23 +0000 (UTC)
Date: Wed, 20 Mar 2024 21:03:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <longman@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC][PATCH] tracing: Introduce restart_critical_timings()
Message-ID: <20240320210349.7ccfeea1@gandalf.local.home>
In-Reply-To: <39bb4123-cf1d-4846-b82e-95195ccec5d8@redhat.com>
References: <20240320122012.2c1f461f@gandalf.local.home>
	<39bb4123-cf1d-4846-b82e-95195ccec5d8@redhat.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 20:46:11 -0400
Waiman Long <longman@redhat.com> wrote:

> I have no objection to that. However, there are now 2 function call 
> overhead in each iteration if either CONFIG_IRQSOFF_TRACER or 
> CONFIG_PREEMPT_TRACER is on. Is it possible to do it with just one 
> function call? IOW, make restart_critical_timings() a real function.

Yeah, I could do that.

-- Steve

