Return-Path: <linux-kernel+bounces-165771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592278B911B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2F41F22EB3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F18165FC6;
	Wed,  1 May 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ByewqnLA"
Received: from msa.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C891D1474B9;
	Wed,  1 May 2024 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714599565; cv=none; b=k9cU46AVX9iwV+ROodLZy4ePKlXIZ+88JlRC4dVGVYHf9WDy9Q/7fVvrZiDkJhpGt29ZmWf37LM8+1yWoTRTIrsh3UUxL/LCn5yueugCCGJO41OdNN1S33ql61slGbePbPWmLlgvWHufyi1FrNFGhXXsTlY281X+FnjE5WqELYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714599565; c=relaxed/simple;
	bh=xCX7DN4ArF6BjEHpKxCUjLo/sTx+uQ/UYj/ZWCCrQdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fz74hdWVBMWm/KuNlK12gy9cqHsSEcnt6padWPV9nl5kiKzOYFgVMmYqJIfy4fbOz/k2VQtnE455bRqHxHYuTwbVOU/yqWxcubkX9b3oESxZgSLvhJiO2YvlCUAcAACiYDQvXSsdVqPDVbFAbNPUQslmTkHBZWzJ3VkF0zhmdQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ByewqnLA; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 2HfZsx4ATpDee2HfZs0ZRe; Wed, 01 May 2024 23:39:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714599559;
	bh=b/uendQadFoqJ6JUcsRVTxUOv2sgr+9vrXfQIk/X5eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ByewqnLAT2Hq/nsspQoWd1u5FHIvkZeGSt1pmJ2Wx5+rjP6Fx8/kvAQCMQO72OAqj
	 MNJaRSHWXELm6vkDaxlTbPyeqQ9EaPPxTm8IQp+IxNZVmtZkOmilhhAdOTF4+kGb3Q
	 dyg8HzRbYOIBftXHuyiuPCG4DNLX+RTzxyLZtmtloV/fti9bBu/+7kBDexWti99G+Z
	 i6xaugiME0GA3nvrQz33lS62KFGKyDIV4gLm5LmstkcbkIkLcV8eALveny6aUWpDRh
	 bib6knrZ1DqxDy3YbRxqaoETm2rbM+YB/fmlbzPwO5PFe+YXZsdq4CTzZSQJyn1rvE
	 KxE3i/ZZOxbew==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 May 2024 23:39:19 +0200
X-ME-IP: 86.243.17.157
Message-ID: <7cdc63b3-31cc-442c-8c2e-75adb2c76b52@wanadoo.fr>
Date: Wed, 1 May 2024 23:39:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] printk: cleanup deprecated uses of strncpy/strcpy
To: Justin Stitt <justinstitt@google.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 30/04/2024 à 01:06, Justin Stitt a écrit :
> Cleanup some deprecated uses of strncpy() and strcpy() [1].
> 
> There doesn't seem to be any bugs with the current code but the
> readability of this code could benefit from a quick makeover while
> removing some deprecated stuff as a benefit.
> 
> The most interesting replacement made in this patch involves
> concatenating "ttyS" with a digit-led user-supplied string. Instead of
> doing two distinct string copies with carefully managed offsets and
> lengths, let's use the more robust and self-explanatory scnprintf().
> scnprintf will 1) respect the bounds of @buf, 2) null-terminate @buf, 3)
> do the concatenation. This allows us to drop the manual NUL-byte assignment.
> 
> Also, since isdigit() is used about a dozen lines after the open-coded
> version we'll replace it for uniformity's sake.
> 
> All the strcpy() --> strscpy() replacements are trivial as the source
> strings are literals and much smaller than the destination size. No
> behavioral change here.
> 
> Use the new 2-argument version of strscpy() introduced in Commit
> e6584c3964f2f ("string: Allow 2-argument strscpy()"). However, to make
> this work fully (since the size must be known at compile time), also
> update the extern-qualified declaration to have the proper size
> information.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [3]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> ---
>   include/linux/printk.h |  2 +-
>   kernel/printk/printk.c | 20 +++++++++-----------
>   2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 955e31860095..b3a29c27abe9 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -71,7 +71,7 @@ extern void console_verbose(void);
>   
>   /* strlen("ratelimit") + 1 */
>   #define DEVKMSG_STR_MAX_SIZE 10
> -extern char devkmsg_log_str[];
> +extern char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE];
>   struct ctl_table;
>   
>   extern int suppress_printk;
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index adf99c05adca..64617bcda070 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -178,9 +178,9 @@ static int __init control_devkmsg(char *str)
>   	 * Set sysctl string accordingly:
>   	 */
>   	if (devkmsg_log == DEVKMSG_LOG_MASK_ON)
> -		strcpy(devkmsg_log_str, "on");
> +		strscpy(devkmsg_log_str, "on");
>   	else if (devkmsg_log == DEVKMSG_LOG_MASK_OFF)
> -		strcpy(devkmsg_log_str, "off");
> +		strscpy(devkmsg_log_str, "off");
>   	/* else "ratelimit" which is set by default. */
>   
>   	/*
> @@ -209,7 +209,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>   			return -EINVAL;
>   
>   		old = devkmsg_log;
> -		strncpy(old_str, devkmsg_log_str, DEVKMSG_STR_MAX_SIZE);
> +		strscpy(old_str, devkmsg_log_str);
>   	}
>   
>   	err = proc_dostring(table, write, buffer, lenp, ppos);
> @@ -227,7 +227,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>   
>   			/* ... and restore old setting. */
>   			devkmsg_log = old;
> -			strncpy(devkmsg_log_str, old_str, DEVKMSG_STR_MAX_SIZE);
> +			strscpy(devkmsg_log_str, old_str);
>   
>   			return -EINVAL;
>   		}
> @@ -2506,21 +2506,19 @@ static int __init console_setup(char *str)
>   	/*
>   	 * Decode str into name, index, options.
>   	 */
> -	if (str[0] >= '0' && str[0] <= '9') {
> -		strcpy(buf, "ttyS");
> -		strncpy(buf + 4, str, sizeof(buf) - 5);
> +	if (isdigit(str[0])) {
> +		scnprintf(buf, sizeof(buf), "ttyS%s", str);
>   	} else {
> -		strncpy(buf, str, sizeof(buf) - 1);
> +		strscpy(buf, str);
>   	}

Hi,

Nit: The { } around each branch can now also be removed.

CJ

> -	buf[sizeof(buf) - 1] = 0;
>   	options = strchr(str, ',');
>   	if (options)
>   		*(options++) = 0;
>   #ifdef __sparc__
>   	if (!strcmp(str, "ttya"))
> -		strcpy(buf, "ttyS0");
> +		strscpy(buf, "ttyS0");
>   	if (!strcmp(str, "ttyb"))
> -		strcpy(buf, "ttyS1");
> +		strscpy(buf, "ttyS1");
>   #endif
>   	for (s = buf; *s; s++)
>   		if (isdigit(*s) || *s == ',')
> 
> ---
> base-commit: 9e4bc4bcae012c98964c3c2010debfbd9e5b229f
> change-id: 20240429-strncpy-kernel-printk-printk-c-6a72fe6d0715
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 
> 


