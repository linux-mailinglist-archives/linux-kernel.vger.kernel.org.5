Return-Path: <linux-kernel+bounces-152173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B606E8ABA40
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC691F21679
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413E814012;
	Sat, 20 Apr 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="JGcU8aXN";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="1nC9nM3t"
Received: from mailrelay5-1.pub.mailoutpod3-cph3.one.com (mailrelay5-1.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D8F13ADC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713601442; cv=none; b=oOfh3YHfi3T/SVxWDUvIWLe+Z8FXXKAGKSle/sV8lLxtxXmf2Uw2j9NlPqAZ+z2P8P+z8zGS5IwPiSaahdVFPjczkqPX2R/1gDD5J3WH3Y7ueb6pdEQ+9k08qeY7WInY0U4Ba9ra3kNBa/HA+1GxYUcEjqN/45R65pjgl+IMa0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713601442; c=relaxed/simple;
	bh=nS3ey3049+WlxKQkhVMTi0rBQq5ENKMLDgGgeTYIWLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nra+g7m2g+i2ZmeGxARK2CW3PrL61hPBwp4872tO+svgp21pT4nl1KdwG3vEKQGT02mz7cnXZCtSpYcK9wV4w4cIkL3KKlM9FUDKr/flFSKOmHEP7h7YInB0JgXyIvpoGYeJx/DoVruEwNX0ZbzGO/L/DauAXoaWCeh3dHOInZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=JGcU8aXN; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=1nC9nM3t; arc=none smtp.client-ip=46.30.211.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=hyOTvAwW7LUhQz0hK6HLJgpu4ROvl5AjMdCeXnr5Bss=;
	b=JGcU8aXNKDt7uwhpzmCnmuGxLzBqrGFlZwdv8+DMg349ArodYUUeWBv5XN+KQGj/iewYBp8MIbTQx
	 sbstisQhyvYYPx3DKdPCxNYk7sjQIEb9ATQEkn5q3XJggc2c965U6s7gqcyYsrzN+R3AOci65IB00I
	 8dIyzID/5itTkHqTpaj1MaNI9vpYAOSBGpG+ZpJC59fkGpWjlscpvjxazOoRGnbJKDbydYLf9o/KY2
	 +cJ12QNeL21yqgmb8tWQfG7/kOTKvciQkQaTE50l9JdlrxkaQd94y1A7rnNuB9hiu3zkNL7JD//H/m
	 pI0upf7zm1EsIMNAsVy6QpSvwT61Yzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=hyOTvAwW7LUhQz0hK6HLJgpu4ROvl5AjMdCeXnr5Bss=;
	b=1nC9nM3tLBIs69vS1YlPRebIaVTB1fKRose4yyoMyQEYIPZJT9uRk0syRJxf3kZzDih4GOAwp9mgT
	 O5vYaqhBA==
X-HalOne-ID: 26a75d51-feef-11ee-b264-e973630cf47d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 26a75d51-feef-11ee-b264-e973630cf47d;
	Sat, 20 Apr 2024 08:22:48 +0000 (UTC)
Date: Sat, 20 Apr 2024 10:22:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] sparc/irq: Remove on-stack cpumask var
Message-ID: <20240420082239.GB614130@ravnborg.org>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
 <20240420051547.3681642-3-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420051547.3681642-3-dawei.li@shingroup.cn>

On Sat, Apr 20, 2024 at 01:15:42PM +0800, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> - Both 2 arguments of cpumask_equal() is constant and free of change, no
>   need to allocate extra cpumask variables.
> 
> - Merge cpumask_and(), cpumask_first() and cpumask_empty() into
>   cpumask_first_and().
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  arch/sparc/kernel/irq_64.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
> index 5280e325d4d6..01ee800efde3 100644
> --- a/arch/sparc/kernel/irq_64.c
> +++ b/arch/sparc/kernel/irq_64.c
> @@ -349,17 +349,13 @@ static unsigned int sun4u_compute_tid(unsigned long imap, unsigned long cpuid)
>  #ifdef CONFIG_SMP
>  static int irq_choose_cpu(unsigned int irq, const struct cpumask *affinity)
>  {
> -	cpumask_t mask;
>  	int cpuid;
>  
> -	cpumask_copy(&mask, affinity);
> -	if (cpumask_equal(&mask, cpu_online_mask)) {
> +	if (cpumask_equal(affinity, cpu_online_mask)) {
>  		cpuid = map_to_cpu(irq);
>  	} else {
> -		cpumask_t tmp;
> -
> -		cpumask_and(&tmp, cpu_online_mask, &mask);
> -		cpuid = cpumask_empty(&tmp) ? map_to_cpu(irq) : cpumask_first(&tmp);
> +		cpuid = cpumask_first_and(affinity, cpu_online_mask);
> +		cpuid = cpuid < nr_cpu_ids ? cpuid : map_to_cpu(irq);
>  	}
>  
>  	return cpuid;
> -- 
> 2.27.0

