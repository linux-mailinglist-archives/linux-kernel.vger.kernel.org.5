Return-Path: <linux-kernel+bounces-75021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E785E1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D965C1C23BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CE180C07;
	Wed, 21 Feb 2024 15:45:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6C7FBC0;
	Wed, 21 Feb 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530328; cv=none; b=tbsJ9eUxVOiP3hAgqlIxr6sdSjo4pOf7/ciAXMFIPzppCd2tHzNf28+5dS/RWmyRgYUYd1MFSD7KfbVmgKDwIQ4IhEqFqIcjiiEms1WIoHgKAlgxPS+zOAfxZhDcxrVQ7c/KjISApcNWXJt3cn9lrzESzZ3Hsj4WpeRRu6ZnkmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530328; c=relaxed/simple;
	bh=izx0Q7NNyB7voMGWRFN3PuhM1xFPObSAyP9CPSxruuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvuUiSmpsA5mEuL1sDqHGRC9CFXvBCTBc3pw9TpcDC+B+Bg297lBAvOSpVrRWhSZeyvlDD/6d1LCTEoYE2vvGZ5My6gl6LB9Fb/iknKpv3obCbpq5LYB7icOFo6x/BFss4nMEQKmBQ7suCfVrnuwnFQC1kQC6yppiCHz4ddzonA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907D2C433C7;
	Wed, 21 Feb 2024 15:45:26 +0000 (UTC)
Date: Wed, 21 Feb 2024 10:47:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmitry Safonov <dima@arista.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Dmitry
 Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH] Documentation/ftrace: Correct wording on trace_options
 sharing
Message-ID: <20240221104714.1f7bc208@gandalf.local.home>
In-Reply-To: <1027d6bc-f4c7-4da5-bf46-3809b7c487d4@arista.com>
References: <20240220-ftrace-options-docs-v1-1-95448f535056@arista.com>
	<1027d6bc-f4c7-4da5-bf46-3809b7c487d4@arista.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 01:59:53 +0000
Dmitry Safonov <dima@arista.com> wrote:

> On 2/20/24 21:00, Dmitry Safonov wrote:
> [..]
> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > index 7e7b8ec17934..c79a6bcef3c9 100644
> > --- a/Documentation/trace/ftrace.rst
> > +++ b/Documentation/trace/ftrace.rst
> > @@ -3603,9 +3603,9 @@ The files in the new directory work just like the files with the
> >  same name in the tracing directory except the buffer that is used
> >  is a separate and new buffer. The files affect that buffer but do not
> >  affect the main buffer with the exception of trace_options. Currently,
> > -the trace_options affect all instances and the top level buffer
> > -the same, but this may change in future releases. That is, options
> > -may become specific to the instance they reside in.
> > +most of the options are specific to the instance they reside in, but
> > +trace_printk, printk-msg-only and record-cmd are affecting all instances
> > +and the top level buffer, but this may change in future releases.  
> 
> Actually, it seems that at least on -next these 3 are not shared as
> well? (if my tests aren't misbehaving)
> 
> So, just remove the part about trace_options exception?
>

In reality, if we want to be specific. It should state that all options
listed in the instance options directory are unique to the instance. If an
option only exists in the top directory, then it is global or for a tracer
that can only be used in the top directory.

-- Steve

