Return-Path: <linux-kernel+bounces-97266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0D38767E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF041F226C0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC872577B;
	Fri,  8 Mar 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MYBeSPn5"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D415C0;
	Fri,  8 Mar 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913669; cv=none; b=GxcsLTL63rK/909pWvxcyxs8EpFLZQe0fl77UlI7iKJIXuabUNXVhbrk4oP/ZGP75tYNOJDZpKSiKJjloA+mMORtqkQqYZRM8rhfP7BCZYtiS5bwO1NK2LiiYV4yVOaF1HE3tD2g7GszYvz4eVtXrZoIOvvgmicktwcyz/0xOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913669; c=relaxed/simple;
	bh=RFfZFo9qX00ig1YaxgXYwq7KQphEKTKfNwAYxMhxCqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4X9LgTNTb2IXM0/wwtZlr5FzDbaR6b4Lrj+pCjS9Tsx2GZOx6A/sQ/c5bOE4iywZXgkqpSE4R20WuhIlmTIpbHEJj7nF+L0xh+gfsqkj3zad7xRj3wfYmdFvBgW1dz8hoNnjW8AmL9SRANZAOFtcCKkUPyu3u2WY4WbZNHTErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MYBeSPn5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VhIY4Br0Ekomd9yYHf9WgFKFdCONPOv+EuoT+Fc7ADw=; b=MYBeSPn57zP643IurkdUBAC8DS
	II0cKShArpmUvluLrOeVnlqn9o8WdfVHcR0cxPFOPedxpRhzAdz+C64Y7432zU7DDP63nfjC4aw56
	UYOX4FhPylwHczTbp5JcbnInbl38N+6sN3WJWvFxC27frBvmrXGZdfbSMi8nXktEeTF2raZH5cn/d
	7NQEUpvT5+0vjlywpXkiyD28qqJdYBgtwr1NX21J7ZlX+fw9yC5eDRiorZah2UoGMfwItHuPZx9h+
	l6+gjTWnzGDMJW14qGbKs+iiTbRh0SHYm78ZIiRyo7z7cW4/NxTIc8eCQUrBkL1VpCDZqAg+brhAf
	31f7k9dQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricee-0000000A2Y6-0RrI;
	Fri, 08 Mar 2024 16:01:07 +0000
Message-ID: <691bd1ca-a199-474f-9b1c-1c91f21648ae@infradead.org>
Date: Fri, 8 Mar 2024 08:01:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ACPI: Add kernel-doc comments for ACPI suspend and
 hibernation functions
Content-Language: en-US
To: Yang Li <yang.lee@linux.alibaba.com>, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240308072033.116556-1-yang.lee@linux.alibaba.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240308072033.116556-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 3/7/24 23:20, Yang Li wrote:
> This patch enhances the documentation for the ACPI power management
> functions related to system suspend and hibernation. This includes the
> use of kernel-doc style comments which provide developers with clearer
> guidance on the usage and expectations of these functions.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/acpi/sleep.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 728acfeb774d..5bc61f40c189 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -502,6 +502,7 @@ static void acpi_pm_finish(void)
>  
>  /**
>   * acpi_pm_start - Start system PM transition.
> + * @acpi_state: The target ACPI power state to transition to.
>   */
>  static void acpi_pm_start(u32 acpi_state)
>  {
> @@ -540,8 +541,9 @@ static u32 acpi_suspend_states[] = {
>  };
>  
>  /**
> - *	acpi_suspend_begin - Set the target system sleep state to the state
> - *		associated with given @pm_state, if supported.
> + *acpi_suspend_begin - Set the target system sleep state to the state
> + *	associated with given @pm_state, if supported.
> + *@pm_state: The target system power management state.

Please use a space between '*' and function names, function parameters, etc.

>   */
>  static int acpi_suspend_begin(suspend_state_t pm_state)
>  {
> @@ -671,10 +673,11 @@ static const struct platform_suspend_ops acpi_suspend_ops = {
>  };
>  
>  /**
> - *	acpi_suspend_begin_old - Set the target system sleep state to the
> - *		state associated with given @pm_state, if supported, and
> - *		execute the _PTS control method.  This function is used if the
> - *		pre-ACPI 2.0 suspend ordering has been requested.
> + *acpi_suspend_begin_old - Set the target system sleep state to the
> + *	state associated with given @pm_state, if supported, and
> + *	execute the _PTS control method.  This function is used if the
> + *	pre-ACPI 2.0 suspend ordering has been requested.
> + *@pm_state: The target suspend state for the system.

Ditto.

>   */
>  static int acpi_suspend_begin_old(suspend_state_t pm_state)
>  {
> @@ -967,10 +970,11 @@ static const struct platform_hibernation_ops acpi_hibernation_ops = {
>  };
>  
>  /**
> - *	acpi_hibernation_begin_old - Set the target system sleep state to
> - *		ACPI_STATE_S4 and execute the _PTS control method.  This
> - *		function is used if the pre-ACPI 2.0 suspend ordering has been
> - *		requested.
> + *acpi_hibernation_begin_old - Set the target system sleep state to
> + *	ACPI_STATE_S4 and execute the _PTS control method.  This
> + *	function is used if the pre-ACPI 2.0 suspend ordering has been
> + *	requested.
> + *@stage: The power management event message.

Ditto.

>   */
>  static int acpi_hibernation_begin_old(pm_message_t stage)
>  {

thanks.
-- 
#Randy

