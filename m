Return-Path: <linux-kernel+bounces-10568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2A981D652
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8786D2831E8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F52154A1;
	Sat, 23 Dec 2023 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="upMpbEHs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5AD14F62;
	Sat, 23 Dec 2023 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=e+1d/TmaI5yvT1BI/q8ClqxWJ80HInnyYu9eYV3r8v8=; b=upMpbEHstgkU4RTUMvYfbMHvGk
	33FsMpbvhYaiyEj/p47oovOBylrS4xz3TGXdFz8A7ozH/gp7s55YGbT5C5d78lgto3OmyCzFQKRZ8
	uCgVZEyo6c8ixrof0uAEQCcZDkVW0Id8Su7lIq/+dZm72mwnUOD3w44aFVmorHviJq7Y/UE2u7gev
	D1yc8aQAYY9g2/ZU0B19BI3lFiVErarrpaXLZoOlN2NV8BBlGwmC0slsR8kj4wjh8q6uAkXvgkK24
	39gWkI46zrJvS0LyoOLb+2XiyQWPBQx0OH9CgGp99t65ox9chIdjM+kVZGEL7iZlw4PTn5lJ7E/qq
	t35LOqkg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rH7hW-008O6w-1f;
	Sat, 23 Dec 2023 19:30:22 +0000
Message-ID: <f669eb1e-20af-4923-b328-f31bea4f7dbb@infradead.org>
Date: Sat, 23 Dec 2023 11:30:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/trace: Fixed typos in the ftrace FLAGS
 section
Content-Language: en-US
To: Matthew Cassell <mcassell411@gmail.com>, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, trivial@kernel.org,
 linux-kernel@vger.kernel.org
References: <20231223185845.2326-1-mcassell411@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231223185845.2326-1-mcassell411@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/23/23 10:58, Matthew Cassell wrote:
> Fixed typos in the FTRACE_OPS_FL_RECURSION flag description.
> 
> Signed-off-by: Matthew Cassell <mcassell411@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/trace/ftrace-uses.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
> index f7d98ae5b885..e198854ace79 100644
> --- a/Documentation/trace/ftrace-uses.rst
> +++ b/Documentation/trace/ftrace-uses.rst
> @@ -182,7 +182,7 @@ FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED
>  
>  FTRACE_OPS_FL_RECURSION
>  	By default, it is expected that the callback can handle recursion.
> -	But if the callback is not that worried about overehead, then
> +	But if the callback is not that worried about overhead, then
>  	setting this bit will add the recursion protection around the
>  	callback by calling a helper function that will do the recursion
>  	protection and only call the callback if it did not recurse.
> @@ -190,7 +190,7 @@ FTRACE_OPS_FL_RECURSION
>  	Note, if this flag is not set, and recursion does occur, it could
>  	cause the system to crash, and possibly reboot via a triple fault.
>  
> -	Not, if this flag is set, then the callback will always be called
> +	Note, if this flag is set, then the callback will always be called
>  	with preemption disabled. If it is not set, then it is possible
>  	(but not guaranteed) that the callback will be called in
>  	preemptable context.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

