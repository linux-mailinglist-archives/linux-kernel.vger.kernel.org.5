Return-Path: <linux-kernel+bounces-91562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DFF8713A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036511F21EA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EFC28684;
	Tue,  5 Mar 2024 02:36:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ECB24B52;
	Tue,  5 Mar 2024 02:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606163; cv=none; b=q7gbMDjbpY7S8bNiDbQWzILXIgSQsNo03fOOkSa3FDcMPpAlPm+1PnLYGa+Z+8/oFIVg0aXCmhd6Wk8qfrux49WwiyTYovoI38TpkNUI/E3FS+2S70QEWvgG/+atkiDIsfFWvwerjuKztjnSUts50Zh6vO4edXEDht7mSLxTqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606163; c=relaxed/simple;
	bh=OgetymQFWcrQWomR2DuOcOkumdtTsMgfuV8vRpuiNy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvWddHzOE3AnI4duDspvnxuqLUknKK2JZPVpjjrIeHcB4cCQufL/zgER1dV/PKpLPZhpGmI96Um+gak+o4J3oaEad1lFkBCmY3eWnFCxadpV70TbJNcLbgiu5qs+btrW71UxR22QE1H9YgxScfr0BQw0FVxL0nn6nV/D9fwpj7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBD3C433F1;
	Tue,  5 Mar 2024 02:36:02 +0000 (UTC)
Date: Mon, 4 Mar 2024 21:37:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Message-ID: <20240304213750.1baef01d@gandalf.local.home>
In-Reply-To: <20240304213538.13fe1f3b@gandalf.local.home>
References: <20240304192710.4c99677c@gandalf.local.home>
	<469d31a7-f358-4547-bb17-0979b3515924@efficios.com>
	<20240304203516.45b7a551@gandalf.local.home>
	<20240304204119.7503ab0b@gandalf.local.home>
	<91f27ba1-15a4-402d-8301-e2b9d23f64b0@efficios.com>
	<20240304205943.081bea96@gandalf.local.home>
	<cef0b07e-f90d-4759-ae54-0f091e87edab@efficios.com>
	<20240304213538.13fe1f3b@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 21:35:38 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > And it's not for debugging, it's for validation of assumptions
> > made about an upper bound limit defined for a compile-time
> > check, so as the code evolves issues are caught early.  
> 
> validating is debugging.

Did Linus put you up to this? To test me to see if I'm learning how to say "No" ;-)

-- Steve

