Return-Path: <linux-kernel+bounces-31730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A38833313
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61C31C219B6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B29720F8;
	Sat, 20 Jan 2024 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE4hRSVH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477C91FBC;
	Sat, 20 Jan 2024 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705734938; cv=none; b=mocxzOmD6/GRuHIlmI54Rwak1iXtyII9ytDHY1pA/y3oeudAldzItY3mzyhxH29b+DSV5OXcWKa+hcg/MQ/nMtyJEZGJLYPJGsoEtMgFqrchHL04MYUKi0V+R1rvIjsrvkjlu32tpHZSrO+hJTzeIRqxVWNLVQ5g/1Y8h64jLbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705734938; c=relaxed/simple;
	bh=kJlxpyi6rD96l+Bi4Wy6SH3EegE19JOXMpaIOnFYDeY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N8eNaZqAM07YZEMaSf78d2VWFpu1KFp80siFbNqER+BOVap+bF6pN2Rr1b963nthD00JGiu0JC8mqK1U/6198KMttI2JBidm5F8TO1rsB8ypciaYLXVeqQQYhU4xGt05JHdtrVsGYE8Ols6zdv6CtZL3ce4XI1ihF/Ej6hn0OOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE4hRSVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0E2C433F1;
	Sat, 20 Jan 2024 07:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705734937;
	bh=kJlxpyi6rD96l+Bi4Wy6SH3EegE19JOXMpaIOnFYDeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mE4hRSVHfKss+PpdivIFQ97gHjDH72mFlX3wIEdgc0oE6lME5u28LWopQEIVBj5AU
	 eJoA2fJ0JXGMSxusxkUI3Pnt11bcxw+scKJ378+LSvU0UObW3dtdTUjFSQTz4QKIeK
	 3Y6QTQbgVdLqI5Ioh/2gA1HEBNOHAmhHaltkUEtdmb/Ft45z+1SHRI+SWeP2jna1g5
	 7hklQtAH9l8AFzUzf7gTb/YtnazOwPlIELtbk1xp0LKLXOrLjfnq251vKr3tcYdviz
	 MBb9yXsM+sphBeuTY9xQOHFNT/By3i5Vd+SiTQfG644fL6dt1LPsjhwon9TRWB5TFz
	 yP6bhUVcPZEpg==
Date: Sat, 20 Jan 2024 16:15:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ye Bin <yebin10@huawei.com>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] support '%pd' and '%pD' for print file name
Message-Id: <20240120161532.f56ee5ed2ab65927a3176402@kernel.org>
In-Reply-To: <20240119105243.05082e5b@gandalf.local.home>
References: <20240119013848.3111364-1-yebin10@huawei.com>
	<20240119234356.1598e760edbfa58f5440a941@kernel.org>
	<20240119105243.05082e5b@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 10:52:43 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 19 Jan 2024 23:43:56 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Thanks for your proposal!
> > 
> > Generically, I think this type of hack is not good for the tracing
> > because there are already some ways to do that. e.g.
> >  - Use perf probe to specify dentry->name:string or file->name:string 
> >  - Use BTF to specify in the same way (but only for function entry)
> > And those are more obvious what it does.
> > 
> > However, if this is implemented in more generic syntax, it will be
> > acceptable.
> > For example, type specifying with "arg1:printfmt(%pD)" will be
> > more generic because it is apparently one of the printfmt and output
> > string. Or, maybe we can just allow to use ":%pD" as a fetch type
> > (start with '%' means the printfmt)
> 
> Yes, I like this idea a lot. Please add the '%' keyword/token to change how
> to display this in the print format.
> 
> We may need to add more than one token though. Is that supported?
> 
>   $arg1:u32:%08x
> 
> or that could also be:
> 
>   $arg1:%08x:u32

No, not yet. But I rather like comma separated.

$arg1:u32,%08x

Hm, this needs more changes, like a new type parser. And it will be
a option of the default type.

Thank you, 

> 
> That is, the order should not be important.
> 
> Thoughts?
> 
> -- Steve
> 
> 
> > 
> > Also, could you update readme_msg[] in kernel/trace/trace.c if
> > you add a type, and add a testcase of selftests/ftrace, for this
> > feature? Documentation should also be updated with more syntax
> > information.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

