Return-Path: <linux-kernel+bounces-16012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8928236FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7D51F255B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD03E1D69C;
	Wed,  3 Jan 2024 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ULuat4Gp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE0E1D55C;
	Wed,  3 Jan 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 314A18E3;
	Wed,  3 Jan 2024 21:15:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 314A18E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704316531; bh=iTCY68mAXbyV0VP0uStGQCHSJwzBFZa46A9ytBmXJos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ULuat4GpO1Q13PZsUvKJRtqoma7hCUVFZ6eNuHtjCx4xQvBrpNiOqhANe5zqkkO68
	 AQVj6Z/3qB6+dyocTEv4yrF+5V9n8snj4v7Y40/2XuBsn3zSWPk/PErg0pKkOmhD+r
	 oHC5sz8U0eNjQHh/C2Kw6apsnvgEXOPQu3FRRqReOPV0kN6KbNnulI/P7EdYdfkm2N
	 /xBQ88mcKAVsy1y+rWczPwAHlQzcCamexhR3W1YIK8r5e4fUbyYZ86y6LeH+odpll0
	 bx7gLySn5FdIuUIxtYzEMFuun3QdgnKZRy2toBchTNSCVfifdfUfzJZWl6+QmqA3SK
	 F+vcrHkq2QRRQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux
 Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] ring-buffer/Documentation: Add documentation on
 buffer_percent file
In-Reply-To: <20231226130149.4685c838@gandalf.local.home>
References: <20231226130149.4685c838@gandalf.local.home>
Date: Wed, 03 Jan 2024 14:15:30 -0700
Message-ID: <87h6ju86fh.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> When the buffer_percent file was added to the kernel, the documentation
> should have been updated to document what that file does.
>
> Fixes: 03329f9939781 ("tracing: Add tracefs file buffer_percentage")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/all/20231226123525.71a6d0fb@gandalf.local.home/
>
> - Fixed some grammar issues.
>
>  Documentation/trace/ftrace.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Are you planning on shipping this one upstream, or would you like me to
pick it up?

Thanks,

jon

