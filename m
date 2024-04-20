Return-Path: <linux-kernel+bounces-152174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F38ABA42
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919761F21307
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8293014012;
	Sat, 20 Apr 2024 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="ViIUtWba";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="cteacejL"
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [46.30.211.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C413ADC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713601476; cv=none; b=uQahVDkEkmIgR03dXYHuCXtJdszv0NUmmvSpEddjopLRCJquCfiMMw8uNchdKT9AtB7B09AEf1zK2Dh+sDCNSPah7ntaQ657yhAJ3DMyyug9I8JVJ2si96vqEalq4H33dC3P9AFnr26MQT4/uo3uEltlSIlnjVlvCtQOPTz0WfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713601476; c=relaxed/simple;
	bh=Il63Q2m0L9+hqPHPjqyTajErfjfgMlXo727fIwhZOso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbMqjcRELSOyu0OmlC34EEAh78CH5WLxVpKv4GziSk9dx81vRm6Uuyw1r3Bf24ZnCHNVzJ7iWfqoQ2QDkeesP+ldUWiY8E7etMfwUrq2B8COZ5l2e/9poqNifnCZEGmHokjNjlhYtvhP2babzZ4H/Best0fkez0LufN2AXF9hXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=ViIUtWba; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=cteacejL; arc=none smtp.client-ip=46.30.211.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=7YP2kOUgvAO9nmgByalozkQAbZID4F1+sT3c89bqYzc=;
	b=ViIUtWbax5AOyGg8Ye8xGr07hfvyWNvoBAQeuDy14BCyh7dtyi7IJn0MDGaOOHam6if7gS4BvwzJC
	 rLHS7UTQmd4rE10gbZAhgZXUFFh4ioMKvexxOzT3IftDUqJITIFKjTr+ouBePCYRSYxLlIyOQYhCWb
	 vcNw4u9w01AyqmNGlH06CdS8p+rv/foqj4pSqGE6uPpjUSD2TucHRe+BkHCxWqjx63Ty80O79pI6Xp
	 ZFRgKgskENL+qNYaCWKGZOGfv+vTA9RX9trc9fW3w3akupiQbWDM9aHE0WIgGty6P3R1BKfBchZCdV
	 xAMkLBwnJ7aX/8UF/MwJM54oclAIjzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=7YP2kOUgvAO9nmgByalozkQAbZID4F1+sT3c89bqYzc=;
	b=cteacejLg5FuxogO4h+ojabJsg/GaluN8Oa7/EUsza4fkTrlz6K0rSZLvQVIwxIVr7vAyImuCF2Px
	 Vq3xD5RBw==
X-HalOne-ID: 413a2b34-feef-11ee-bf3b-2778176e2c98
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 413a2b34-feef-11ee-bf3b-2778176e2c98;
	Sat, 20 Apr 2024 08:23:25 +0000 (UTC)
Date: Sat, 20 Apr 2024 10:23:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] sparc/of: Remove on-stack cpumask var
Message-ID: <20240420082323.GC614130@ravnborg.org>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
 <20240420051547.3681642-4-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420051547.3681642-4-dawei.li@shingroup.cn>

On Sat, Apr 20, 2024 at 01:15:43PM +0800, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> @cpumask of irq_set_affinity() is read-only and free of change, drop
> unneeded cpumask var.
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  arch/sparc/kernel/of_device_64.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
> index c350c58c7f69..f98c2901f335 100644
> --- a/arch/sparc/kernel/of_device_64.c
> +++ b/arch/sparc/kernel/of_device_64.c
> @@ -624,10 +624,7 @@ static unsigned int __init build_one_device_irq(struct platform_device *op,
>  out:
>  	nid = of_node_to_nid(dp);
>  	if (nid != -1) {
> -		cpumask_t numa_mask;
> -
> -		cpumask_copy(&numa_mask, cpumask_of_node(nid));
> -		irq_set_affinity(irq, &numa_mask);
> +		irq_set_affinity(irq, cpumask_of_node(nid));
>  	}
>  
>  	return irq;
> -- 
> 2.27.0

