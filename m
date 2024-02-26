Return-Path: <linux-kernel+bounces-80365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03907866760
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19AC28185C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B135E55F;
	Mon, 26 Feb 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icqivLWZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEC0DDBE;
	Mon, 26 Feb 2024 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708907658; cv=none; b=gBzTQ+KnTXSpvT5xVhRJ7hfUsBA55KWuxWP/dNYIU/UR3VWBXm65tYfJFSSB8z71oOvPNScypFQEJa6cW7UMf2dQLuWgpILl4AwmckTWVUnVrRVDfL/IIh4QHQ7pyI+eGeaqWWz30cjgYcYa2xWMwECL7l3QESmGt6zxIXvou5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708907658; c=relaxed/simple;
	bh=ttzOyxwp5HttIsI7+ixES73I7rKS2i2CvFelCKZ5srI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QcLAAVfHrrt4/BGDBszlXdjMoip6FvRlVaDjhIneTe47bguQpUbofRyO2ELAh+OJHH1I+kGfrzGuWB8bdy0FVC0wDkJ0/an+kA+geWPJwElCXeWFtJ/C7WcLcylWsMs/IuzvTjDi+zs11uPfaP/OPEZRPcsR/Wa43ZQO1RaIXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icqivLWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825F5C433C7;
	Mon, 26 Feb 2024 00:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708907657;
	bh=ttzOyxwp5HttIsI7+ixES73I7rKS2i2CvFelCKZ5srI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=icqivLWZoOIWcx3YpYKFRb21c/WlzzHzoecOx2qSqmbh8S8Q1lQSc5i5/7E+s6zIQ
	 q96li2GvvSNockxnelAB8veZVCKQKhWdCdtSYWIs5ga3kKML40ItzewApIO79WZU4Y
	 UjLM1XT0K6Lwm6x6wOz51bvW43SMeNJiDR2AA36d9amQqxu9Lo7N5sZse/aSFWFBIB
	 vnkIWvXJrFRZiA/IUNb6QrTY0G5I40Il+aUcD8/MdYJ4K2DpsyoWl/dvT2S0OvRR14
	 WeqKh4UMUdRYY03/MnKTMZHmYNvDPcpKz/FbIoqgKH+yCZzDpicNIdLKvJ4ZNtfko3
	 JuzTVu+ButvrA==
Date: Mon, 26 Feb 2024 09:34:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Remove second parameter to __assign_rel_str()
Message-Id: <20240226093414.0ff0276080d61be9d4b68a73@kernel.org>
In-Reply-To: <20240223162519.2beb8112@gandalf.local.home>
References: <20240223162519.2beb8112@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 16:25:19 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The second parameter of __assign_rel_str() is no longer used. It can be removed.
> 
> Note, the only real users of rel_string is user events. This code is just
> in the sample code for testing purposes.
> 
> This makes __assign_rel_str() different than __assign_str() but that's
> fine. __assign_str() is used over 700 places and has a larger impact. That
> change will come later.

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/trace/stages/stage6_event_callback.h | 2 +-
>  samples/trace_events/trace-events-sample.h   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
> index 935608971899..a0c15f67eabe 100644
> --- a/include/trace/stages/stage6_event_callback.h
> +++ b/include/trace/stages/stage6_event_callback.h
> @@ -91,7 +91,7 @@
>  #define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
>  
>  #undef __assign_rel_str
> -#define __assign_rel_str(dst, src)					\
> +#define __assign_rel_str(dst)						\
>  	do {								\
>  		char *__str__ = __get_rel_str(dst);			\
>  		int __len__ = __get_rel_dynamic_array_len(dst) - 1;	\
> diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
> index 2dfaf7fc7bfa..500981eca74d 100644
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -574,7 +574,7 @@ TRACE_EVENT(foo_rel_loc,
>  	),
>  
>  	TP_fast_assign(
> -		__assign_rel_str(foo, foo);
> +		__assign_rel_str(foo);
>  		__entry->bar = bar;
>  		__assign_rel_bitmask(bitmask, mask,
>  			BITS_PER_BYTE * sizeof(unsigned long));
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

