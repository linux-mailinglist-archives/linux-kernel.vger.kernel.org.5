Return-Path: <linux-kernel+bounces-150364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B57B78A9DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483C7286D00
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FAA16C453;
	Thu, 18 Apr 2024 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QO4a+es3"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7726916C43B;
	Thu, 18 Apr 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452775; cv=none; b=TKDH4Yxj4N9uMTpHSyAoH0ZIfNxbrcdOCGdldRaRtCynRE94boXaTLqHvS7fcer4ZK4TVJkAqA6apykwaD7bVT9u2I99tBapZrzRnHEEr5J1dihtecAymSJdz63XkrySnDP/y+H319403bEivs8fxEsUlRenCFGTQcVCCYZ0nhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452775; c=relaxed/simple;
	bh=/GJmJIxgwpeXg6nGwefkpZv+RUFN7WkwtYfpoHK8lNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHmXJlsK8I1NXsQm1WVhgkLSBUxXHr68IM56Xv97NuxPUNDIbJ9U0W1JskL4FomOEBNYa3h4kOpDPmvbbnH3DhwhrW5r35NX0EO3RrnZvlJGEiTKkbmfNV9VQj2X+e56E6y+7dKwBUGcSh9jPkQoC2ZYovC+Pc0qL9wJvf11BmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QO4a+es3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 1EFB020FD8B4; Thu, 18 Apr 2024 08:06:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1EFB020FD8B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713452767;
	bh=YLrF65GkaRI97civNB8NhoqUIrCEEdcrIySZDt5Q0LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QO4a+es39sVfjgRPixoZvKK9reiFB/6ZcNzygVZHvRx0NTUwneQHWoZrA/0Wn2TwW
	 ZGTm/ns6EWJD6ZK5/heMrbFElihTAtHo80EoyOwKZeUcXpPDxxYN3eXYJ3tn0JA101
	 lBxJrH7zGaxcTTE5I5XSQ+1gjW3JHqntqLvBYgrY=
Date: Thu, 18 Apr 2024 08:06:07 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Aditya Nagesh <adityanagesh@linux.microsoft.com>
Cc: adityanagesh@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Message-ID: <20240418150607.GA27653@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1712899683-20311-1-git-send-email-adityanagesh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712899683-20311-1-git-send-email-adityanagesh@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Apr 11, 2024 at 10:28:03PM -0700, Aditya Nagesh wrote:
> Fix issues reported by checkpatch.pl script in hv.c and
> balloon.c
>  - Remove unnecessary parentheses
>  - Remove extra newlines
>  - Remove extra spaces
>  - Add spaces between comparison operators
>  - Remove comparison with NULL in if statements
> 
> No functional changes intended
> 
> Signed-off-by: Aditya Nagesh <adityanagesh@linux.microsoft.com>
> ---
> [V3]
> Fix alignment issues in multiline function parameters.
> 
> [V2]
> Change Subject from "Drivers: hv: Fix Issues reported by checkpatch.pl script"
>  to "Drivers: hv: Cosmetic changes for hv.c and balloon.c"
> 
>  drivers/hv/hv.c         |  35 +++++++-------
>  drivers/hv/hv_balloon.c | 101 +++++++++++++++-------------------------
>  2 files changed, 54 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index a8ad728354cb..4906611475fb 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -45,7 +45,7 @@ int hv_init(void)
>   * This involves a hypercall.
>   */
>  int hv_post_message(union hv_connection_id connection_id,
> -		  enum hv_message_type message_type,
> +		    enum hv_message_type message_type,

This line is fixed now, but now below line is unaligned.

>  		  void *payload, size_t payload_size)
>  {

<snip>

>  
>  	if (req->more_pages == 1)
>  		return;
> @@ -1415,7 +1395,7 @@ static int dm_thread_func(void *dm_dev)
>  
>  	while (!kthread_should_stop()) {
>  		wait_for_completion_interruptible_timeout(
> -						&dm_device.config_event, 1*HZ);
> +						&dm_device.config_event, 1 * HZ);

IMO, we can move this to previous line, as now 100 characters are allowed in single line.


Once fixed above,
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

- Saurabh


