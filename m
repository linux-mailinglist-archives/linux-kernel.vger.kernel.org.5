Return-Path: <linux-kernel+bounces-91520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 468AC871289
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB996B2446C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCCF17C9E;
	Tue,  5 Mar 2024 01:57:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA217C72;
	Tue,  5 Mar 2024 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709603876; cv=none; b=BY/XNKviHOub/eUR95CCtlTCO8NOVD/JsQVcNwEcTYf5OXB2nIc1Lz76BxmpL6E6A2ITqw2p3Ex13LoczQmfp8lgnuccbc55Let+yL6Fh1/IqIIFiNmLDiDKQz+kpwdgI5xKkhBiC4Z8r/mJGyfcfzENXatg9eaqgdVt5a9OUWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709603876; c=relaxed/simple;
	bh=hmq5mCGZoJ0YIHNnaTlSf7OVVEmARXsu0lrLlQrXUIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWXcbXvF1pdGm54hYD/6YXUpR+9EQGxRAI75KUKZWfSvrdPtfRREtBzs9eSVTdiNj2KFeArH9iIqR7KKoSpuXAlwRhaBWnMYXdMaHlIxm1J9P58ujFYnk+DbBfCYX9FQHdH2BW94s1d0bK9lyxWdOVQA8fFv6nxS5k/ZKPWTggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4640C433F1;
	Tue,  5 Mar 2024 01:57:54 +0000 (UTC)
Date: Mon, 4 Mar 2024 20:59:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Message-ID: <20240304205943.081bea96@gandalf.local.home>
In-Reply-To: <91f27ba1-15a4-402d-8301-e2b9d23f64b0@efficios.com>
References: <20240304192710.4c99677c@gandalf.local.home>
	<469d31a7-f358-4547-bb17-0979b3515924@efficios.com>
	<20240304203516.45b7a551@gandalf.local.home>
	<20240304204119.7503ab0b@gandalf.local.home>
	<91f27ba1-15a4-402d-8301-e2b9d23f64b0@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 20:42:39 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> #define TRACE_OUTPUT_META_DATA_MAX_LEN		80
> 
> and a runtime check in the code generating this header.
> 
> This would avoid adding an unchecked upper limit.

That would be a lot of complex code that is for debugging something that
has never happened in the past 16 years and Linus has already reprimanded
me on doing such things.

-- Steve

