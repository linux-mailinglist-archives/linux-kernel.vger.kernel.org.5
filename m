Return-Path: <linux-kernel+bounces-51038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C61E848571
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA848288A6B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 12:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EF5D902;
	Sat,  3 Feb 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DtiXvBGz"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0F5D72C
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706961931; cv=none; b=q+F2d3e0KSFDBP/Nc0l/LTKA9lvNbn+UEJ6ixc3i7qWXYFOsrUpwSndoj6Oz0ZWGAJ7iBwXxD0bAPEFb/seSD9FFaTX+19NTfFEW+IYRe/z37Z0koOKnD+AzGB2Nj2T+7wDHwr50Dzt87TOc5V3d/bpCsoR9ZzjnVl2EAz552AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706961931; c=relaxed/simple;
	bh=L7J4BtlzFMnw9DdI6YfXQugI7y6JrV+u8xRZY8+4iN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H61ArIQ19M3ZaEegf2MfqXbjHkbpaBEtWX+Khyf2xKyZkm8SiJIuvwWr6/BtLtS2XtZqRyQy0+YlQT4Yr0hB9s7mw17zwLFP3RJ3+V5oeATegT0GRlj7x7vfHZU4OzA64bC6gN+Jt2IuAMJ6Kex88LhbUa+F3S4BgEdxEDGcHw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DtiXvBGz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U6K8i0MaCEnq6aAWU9nsKRYoHgfyqur22ObbnL0HdxE=; b=DtiXvBGzv2N12Yp7Wv/UHDVpax
	13XxhpO1rYsH3gsG4haH+HDZ1g6Rhxbtfp3z1KNYSvsen0y9quegcSJcSoUU5PlBq0YhcvrfNSAgK
	TGhjw0OqTiFAku6Tg9ZTi+gutGcCjolsjWqDT61d8PZDcE1cNENJ+Xkod35MxVysVQssiiVHrsMo1
	4mMtZUUJ6+0QBJr/s1kkeQ0sJX1VzwrO7ZPXUJF/Vj9ZQOZdCaexDYLJ5TCwWNwtIQhEKgQOJQboH
	Xgo1g8nueqpUOI1BP2LLpUmIET7ztJCGMAQYlTOwIEIQG8Y7tQ7+NPBYhhiT/41YsSb0rqzaPF6o6
	SudOuV2w==;
Received: from [187.90.178.235] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rWElm-00DHeR-3d; Sat, 03 Feb 2024 13:05:14 +0100
Message-ID: <d8d97bbe-b57d-fcae-93ff-76fd0381187a@igalia.com>
Date: Sat, 3 Feb 2024 09:05:08 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] panic: add option to dump blocked tasks in panic_print
Content-Language: en-US
To: Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20240202132042.3609657-1-feng.tang@intel.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240202132042.3609657-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 10:20, Feng Tang wrote:
> For debugging kernel panic and other bugs, there is already option of
> panic_print to dump all tasks' call stacks. On today's large servers
> running many containers, there could be thousands of tasks or more,
> and it will print out huge amount of call stacks, and take a lot of
> time (for serial console which is main target user case of panic_print).
> 
> And in many cases, only those several tasks being blocked is key for
> the panic, so add an option to only dump blocked tasks' call stack.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> [...]

Thank you Feng Tang, this is an interesting and useful idea!
I've just tested the patch and works fine - also no code issues from my
side. So, feel free to add:


Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>


Cheers!

 ---
>  Documentation/admin-guide/kernel-parameters.txt | 1 +
>  Documentation/admin-guide/sysctl/kernel.rst     | 1 +
>  kernel/panic.c                                  | 4 ++++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 31b3a25680d0..0f2369e87175 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4182,6 +4182,7 @@
>  			bit 4: print ftrace buffer
>  			bit 5: print all printk messages in buffer
>  			bit 6: print all CPUs backtrace (if available in the arch)
> +			bit 7: print tasks in uninterruptible (blocked) state
>  			*Be aware* that this option may print a _lot_ of lines,
>  			so there are risks of losing older messages in the log.
>  			Use this option carefully, maybe worth to setup a
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 6584a1f9bfe3..e066a16b35d5 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -850,6 +850,7 @@ bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
>  bit 4  print ftrace buffer
>  bit 5  print all printk messages in buffer
>  bit 6  print all CPUs backtrace (if available in the arch)
> +bit 7  print tasks in uninterruptible (blocked) state
>  =====  ============================================
>  
>  So for example to print tasks and memory info on panic, user can::
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 2807639aab51..aa17ae0897c0 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -73,6 +73,7 @@ EXPORT_SYMBOL_GPL(panic_timeout);
>  #define PANIC_PRINT_FTRACE_INFO		0x00000010
>  #define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
>  #define PANIC_PRINT_ALL_CPU_BT		0x00000040
> +#define PANIC_PRINT_BLOCKED_TASKS	0x00000080
>  unsigned long panic_print;
>  
>  ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> @@ -227,6 +228,9 @@ static void panic_print_sys_info(bool console_flush)
>  
>  	if (panic_print & PANIC_PRINT_FTRACE_INFO)
>  		ftrace_dump(DUMP_ALL);
> +
> +	if (panic_print & PANIC_PRINT_BLOCKED_TASKS)
> +		show_state_filter(TASK_UNINTERRUPTIBLE);
>  }
>  
>  void check_panic_on_warn(const char *origin)

