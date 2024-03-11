Return-Path: <linux-kernel+bounces-99474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A448788F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF154281CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C9A55783;
	Mon, 11 Mar 2024 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AtSFm+ip"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE254FA5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185536; cv=none; b=GjTkX/ph8NW/gKWGdsIxxwwCVdhoVy6L0FXeTtGUd91+u+LP7eWNIwgp3zNZC6KDYT8GgWDl3FEWBseg6E9otX5eKZPl1S4DE5kzvKqn2Rzfksz+fdhUF3y9P9NIEKbwldiCnjRS9APIhdVTLsDvW9WRE6FjCbHzadN5y/F2PwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185536; c=relaxed/simple;
	bh=5XOgiov6HGrbYoimuGWW2ttA0UInE++nXPAoQbGWlBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hzTE7mLW7LHrkrzjkt450EC152HPPwVTxtTd56MqwQFYXZGPm2Zr/HSVGEgWtGJVLFgpx5wdJ0hcCjvVROMEXzNAif3PVAdiu0p8/I1XcoRddrAUHk9ToU7uXqxqRqpj1iY55P9vLzTg0+Tlh1s/Y0iPX6vVe0AM29UZMharxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AtSFm+ip; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=al2BeY7F3MvEo+q4vRxj8v8pOQ0OOeW+T6MKcDYMKXM=; b=AtSFm+iprDE9NWh0ucDbEU2QwY
	lVfmHy0oRdNyjRo8WqR6iS0stl/f4tLRpwThMbQtaEmCA9e9Pc9us4Za+oAG+neeSz49fhH78JwE+
	Bgk4kh4fZUQ+IwZ9Tj9XArj5pUSbpb7ejgpdp+sbfyjXRrfGueEyg6xdVwUQnuahuWqPd5oCdjJFF
	BbRKvC0GWvGzZWrEWbeGXDeVCmtv3w01xk+D5QIV4o9byiQtuMeuSyNAL/PLeI6Ch/+A9IT6eudZm
	aYILmFdZABeDwpn9yy+WbL1cM0Dq2sY3omOBrb0cq5lN0gmhsIVRvrzEmSKLCRv2BhSpB637Zht9Q
	0TfGuAEQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjlNb-00000002woS-0ya6;
	Mon, 11 Mar 2024 19:32:11 +0000
Message-ID: <4f77c04b-5fe3-4618-aaaf-7bcc6058591e@infradead.org>
Date: Mon, 11 Mar 2024 12:32:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 10/14] fork: Dynamic Kernel Stacks
Content-Language: en-US
To: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de,
 brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
 dave.hansen@linux.intel.com, dianders@chromium.org,
 dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
 hch@infradead.org, hpa@zytor.com, jacob.jun.pan@linux.intel.com,
 jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com,
 kent.overstreet@linux.dev, kinseyho@google.com,
 kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org,
 mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com,
 mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com,
 peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com,
 rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de,
 urezki@gmail.com, vincent.guittot@linaro.org, vschneid@redhat.com
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-11-pasha.tatashin@soleen.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240311164638.2015063-11-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

just typos etc.

On 3/11/24 09:46, Pasha Tatashin wrote:
> The core implementation of dynamic kernel stacks.
> 

..

> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/Kconfig                     |  34 +++++
>  include/linux/sched.h            |   2 +-
>  include/linux/sched/task_stack.h |  41 +++++-
>  kernel/fork.c                    | 239 +++++++++++++++++++++++++++++++
>  kernel/sched/core.c              |   1 +
>  5 files changed, 315 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index a5af0edd3eb8..da3df347b069 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1241,6 +1241,40 @@ config VMAP_STACK
>  	  backing virtual mappings with real shadow memory, and KASAN_VMALLOC
>  	  must be enabled.
>  
> +config HAVE_ARCH_DYNAMIC_STACK
> +	def_bool n
> +	help
> +	  An arch should select this symbol if it can support kernel stacks
> +	  dynamic growth.
> +
> +	  - Arch must have support for HAVE_ARCH_VMAP_STACK, in order to handle
> +	    stack related page faults

	    stack-related

> +
> +	  - Arch must be able to faults from interrupt context.

	                         fault

> +	  - Arch must allows the kernel to handle stack faults gracefully, even

	              allow

> +	    during interrupt handling.
> +
> +	  - Exceptions such as no pages available should be handled the same

	                                                    handled in the same

> +	    in the consitent and predictable way. I.e. the exception should be

	    consistent

> +	    handled the same as when stack overflow occurs when guard pages are
> +	    touched with extra information about the allocation error.
> +
> +config DYNAMIC_STACK
> +	default y
> +	bool "Dynamically grow kernel stacks"
> +	depends on THREAD_INFO_IN_TASK
> +	depends on HAVE_ARCH_DYNAMIC_STACK
> +	depends on VMAP_STACK
> +	depends on !KASAN
> +	depends on !DEBUG_STACK_USAGE
> +	depends on !STACK_GROWSUP
> +	help
> +	  Dynamic kernel stacks allow to save memory on machines with a lot of
> +	  threads by starting with small stacks, and grow them only when needed.
> +	  On workloads where most of the stack depth do not reach over one page

	                                             does

> +	  the memory saving can be subsentantial. The feature requires virtually

	                           substantial.

> +	  mapped kernel stacks in order to handle page faults.
> +
>  config HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	def_bool n
>  	help



> +/*
> + * This flag is used to pass information from fault handler to refill about
> + * which pages were allocated, and should be charged to memcg.
> + */
> +#define DYNAMIC_STACK_PAGE_AQUIRED_FLAG	0x1

                              ACQUIRED
please



-- 
#Randy

