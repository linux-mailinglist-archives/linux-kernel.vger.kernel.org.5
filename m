Return-Path: <linux-kernel+bounces-134537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CFD89B2B6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0423A1F2146D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B299A3A1C7;
	Sun,  7 Apr 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qSha4Hyp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED18485;
	Sun,  7 Apr 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712503983; cv=none; b=K7Av1UtgiCl9J2vrO7vLEdv09e23+GH+QbHd5076O5gD67PUs5d6DiqJUJ9BEISAVyOjhqwfD87uM0Mlh2qV1VL4Fo9ldmJ0A7qBtjU/wpMcgN3pYDwH5fLdIamsXqpcrWWHNcp9dAO+0SuV31B/2+g/aK/+pSyLIxmNLKzCd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712503983; c=relaxed/simple;
	bh=AvRYUhFInEf5FxUp/Xb5Vz8WYz3KdPlt9mAh9CIAq7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/XLlDcjgdwD969C0rcTSlzEWIUUA74IeYjYkt0wkMFjdfsU3SvPuMQlJTzZ8sXHKnXvtvBBjizhRT4yCKJQrrLW4wOb55hjJ1v10KcFtd19s8SgRbAI8Y48b9iL7GorfLUj5sJioCsO5HK5Y3m5dqBqZG6IPicId2U15YI4kbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qSha4Hyp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=MLm6iC4WNTdIn+XgL/qIwT01bSJfAFu6/aMBhdI31mM=; b=qSha4Hyp47jW+Iw55N4ejDVPWe
	R50J4MZBkjl1ljsl8lmbCyXXeRCtIkvr9H8+MhKWL1RqgS0YadiGyTeVkQtJaLxMBUmny++XLamZo
	naMhlFfBA9Wj1dQyIMiwAlars/PfCZtyAe8Qt8T38x8MmzZhs7Y1Ke7WKWdMmJ+2iKSuM9sTd8kWc
	ti03BmHsO/GPxs1BL3ZrhSW3dzRvZi1ubQEIkPXTCog0N0uUXnTD9dbqqZoA4UhU85Rav2dPWANty
	RjPUjL9YjSqCk29sHdsFWuEV0tSwNWrASf/6aoPtQvkCY0ATh+zI1NiDBPE0hrxAeAGIGnclSDIPv
	c5aq+uNQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtUVo-0000000CuIr-3hLx;
	Sun, 07 Apr 2024 15:32:52 +0000
Message-ID: <7a8bc242-d41e-425b-9a62-36835aca7721@infradead.org>
Date: Sun, 7 Apr 2024 08:32:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume
To: xiongxin <xiongxin@kylinos.cn>, mario.limonciello@amd.com,
 Rafael Wysocki <rafael@kernel.org>, hdegoede@redhat.com,
 linus.walleij@linaro.org
Cc: Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20230602073025.22884-1-mario.limonciello@amd.com>
 <20230602073025.22884-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230602073025.22884-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/24 5:49 AM, xiongxin wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> All uses in the kernel are currently already oriented around
> suspend/resume. As some other parts of the kernel may also use these
> messages in functions that could also be used outside of
> suspend/resume, only enable in suspend/resume path.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3->v4:
>  * add back do/while as it wasn't pointless.  It fixes a warning.
> ---
>  include/linux/suspend.h | 8 +++++---
>  kernel/power/main.c     | 6 ++++++
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 1a0426e6761c..74f406c53ac0 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -555,6 +555,7 @@ static inline void unlock_system_sleep(unsigned int flags) {}
>  #ifdef CONFIG_PM_SLEEP_DEBUG
>  extern bool pm_print_times_enabled;
>  extern bool pm_debug_messages_on;
> +extern bool pm_debug_messages_should_print(void);
>  static inline int pm_dyn_debug_messages_on(void)
>  {
>  #ifdef CONFIG_DYNAMIC_DEBUG
> @@ -568,14 +569,14 @@ static inline int pm_dyn_debug_messages_on(void)
>  #endif
>  #define __pm_pr_dbg(fmt, ...)					\
>  	do {							\
> -		if (pm_debug_messages_on)			\
> +		if (pm_debug_messages_should_print())		\
>  			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
>  		else if (pm_dyn_debug_messages_on())		\
>  			pr_debug(fmt, ##__VA_ARGS__);	\
>  	} while (0)
>  #define __pm_deferred_pr_dbg(fmt, ...)				\
>  	do {							\
> -		if (pm_debug_messages_on)			\
> +		if (pm_debug_messages_should_print())		\
>  			printk_deferred(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
>  	} while (0)
>  #else
> @@ -593,7 +594,8 @@ static inline int pm_dyn_debug_messages_on(void)
>  /**
>   * pm_pr_dbg - print pm sleep debug messages
>   *
> - * If pm_debug_messages_on is enabled, print message.
> + * If pm_debug_messages_on is enabled and the system is entering/leaving
> + *      suspend, print message.
>   * If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is enabled,
>   *	print message only from instances explicitly enabled on dynamic debug's
>   *	control.
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 3113ec2f1db4..daa535012e51 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -556,6 +556,12 @@ power_attr_ro(pm_wakeup_irq);
>  
>  bool pm_debug_messages_on __read_mostly;
>  
> +bool pm_debug_messages_should_print(void)
> +{
> +	return pm_debug_messages_on && pm_suspend_target_state != PM_SUSPEND_ON;
> 
>> hibernate processes also mostly use the pm_pr_dbg() function, which
>> results in hibernate processes only being able to output such logs
>> through dynamic debug, which is unfriendly to kernels without
>> CONFIG_DYNAMIC_DEBUG configuration.

This part of the patch doesn't look so good. ^^^^^^^^^^^^^^^^^^^^

> 
> +}
> +EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
> +
>  static ssize_t pm_debug_messages_show(struct kobject *kobj,
>  				      struct kobj_attribute *attr, char *buf)
>  {
> 

-- 
#Randy

