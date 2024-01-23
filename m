Return-Path: <linux-kernel+bounces-35314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F9838F66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3028B1F22B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5BD5F846;
	Tue, 23 Jan 2024 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojTbrOL5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE05F57C;
	Tue, 23 Jan 2024 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015257; cv=none; b=qJct2z8SsTqBE0V9BCAq0PqBVqYUqyoukQeZ2U4GUe/gYO3dBHVd8TTua3LepNzkqqFwk4P896wut8A9v9tZaa7x83NoeRTA1Ex6LkOpNVgQfDUqEA5mboy11QjMViB5b0BauT9YS2ecbtUvJdB+JWVI1+HqnO+rU9FPlUiQMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015257; c=relaxed/simple;
	bh=QIawHl6UH5nEOFBUuWe4QbZg3ju5mdjdvopEqLdJLp4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u/oFT9gJAp9oIp78sYQvvRLyhAkrSL2nWjOHB0dQJb/44GkPCvAURGxocUpOWbg/R3Atpcoskbzv/N77MF6pelJ6RRqXn53hq7B4VUPlZZMpY1XW4XW3/Liezn3pE4+YYLluytogAqfUFmwhkoxQJviEcIVn1cp9WPiZtEoQOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojTbrOL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8BCC43390;
	Tue, 23 Jan 2024 13:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706015256;
	bh=QIawHl6UH5nEOFBUuWe4QbZg3ju5mdjdvopEqLdJLp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ojTbrOL5OBHDkS/yeaqsAIFGdyFYDAUzU2FpmWlKum/Q+F683nNs7z40AF1AeMXmQ
	 Cx85aS4IwWebfAKWgZiznCfgpS1gc7M/yAF2/Usp4adbNURkPYKZL5+hmhOmuu6BXP
	 3bNiJzHI6Z7/dL/5PvFmEQBDnXNyXg/JXHnvqipf4yfJdcZfXt8grEAliBrDQOGXBG
	 B1dUFD65+4iBBERxwu9W8P+5uB0KjaSjNjz630tR3En4oflw2HufH8GQiCyUAKvpLX
	 DQbbZF5K4Q6QdiVOBzF9pknP26i5b1wabNU5K1rJpFDSOidJ7+CY9pE0EhO0z1Km2F
	 Cm+cEh+chJouQ==
Date: Tue, 23 Jan 2024 22:07:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/7] Documentation: tracing: add new type '%pd' and
 '%pD' for kprobe
Message-Id: <20240123220732.79d810aa183b3ddfd2b2a4ab@kernel.org>
In-Reply-To: <20240123092139.3698375-7-yebin10@huawei.com>
References: <20240123092139.3698375-1-yebin10@huawei.com>
	<20240123092139.3698375-7-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 17:21:38 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Similar to printk() '%pd' is for fetch dentry's name from struct dentry's
> pointer, and '%pD' is for fetch file's name from struct file's pointer.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  Documentation/trace/kprobetrace.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> index bf9cecb69fc9..a1d12d65a8dc 100644
> --- a/Documentation/trace/kprobetrace.rst
> +++ b/Documentation/trace/kprobetrace.rst
> @@ -58,7 +58,8 @@ Synopsis of kprobe_events
>    NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
>    FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
>  		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> -		  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
> +		  (x8/x16/x32/x64), VFS layer common type(%pd/%pD) for print
> +                  file name, "char", "string", "ustring", "symbol", "symstr"

Could you remove the "for print file name" here?  Since this is not the place
where such precise information describes. I think following hunk is enough to
explain it.

Thank you,

>                    and bitfield are supported.
>  
>    (\*1) only for the probe on function entry (offs == 0). Note, this argument access
> @@ -113,6 +114,9 @@ With 'symstr' type, you can filter the event with wildcard pattern of the
>  symbols, and you don't need to solve symbol name by yourself.
>  For $comm, the default type is "string"; any other type is invalid.
>  
> +VFS layer common type(%pd/%pD) is a special type, which fetches dentry's or
> +file's name from struct dentry's pointer or struct file's pointer.
> +
>  .. _user_mem_access:
>  
>  User Memory Access
> -- 
> 2.31.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

