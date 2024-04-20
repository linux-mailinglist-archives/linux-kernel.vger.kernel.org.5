Return-Path: <linux-kernel+bounces-152169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A308ABA32
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0DF2B20FE8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320C114003;
	Sat, 20 Apr 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="DgBUJ93W";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="7aDLeJh6"
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C33EEDE
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713600010; cv=none; b=qc/X93QhZiUxL/PFGRrypz9oiIrP9Q0sqq+i4IomukfPVT09HUGhMbJZ/gC64wm+qbHabexMlu8ZHKlT4QcKooF4Ayg6SM2Hw/ppV0VoPTxAGh7qxyI38qXLcStz8QF9MX7YCUHGRzGo5UClaQYxuZod51Pc9P/fJuidsKvWrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713600010; c=relaxed/simple;
	bh=Zgce6zv1q2p3ZzIim3wBuPu7uvIRjBuJqkyxEkf1f3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4SbRSpz1rU3CPDvkoRIML1sbBbbn4DFeRa9n7Plq59I2ph+YNw01sXZ1jLOq9PYjSct0uxhGLIAtQNUTBdWFIx56szmNHgg2E8NorGg7N8U3IhmcsbHvBVXnsC1u0FDs47zLkVd0asy4t3uA8dpTsjgMo49SdiwMVq8ID2SLVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=DgBUJ93W; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=7aDLeJh6; arc=none smtp.client-ip=46.30.211.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=0loidWV2ihloVcz5aeoH7O995WGy2I4QV0SsCN+3csU=;
	b=DgBUJ93WY+ZlppT5tNOlP59Rjftn0Te0tB/+MFEU2hz0/VkI6iwuCM5pQiTRO7OH6oLVFRue3SRfk
	 socPbvhEADcygyCTVwXeUN0eZ5KE1aEch6ezTptaCw5OJNZV0NNglv14t7l++Iy383iC5tOGJrdkxt
	 Vw4AzReUbNw5+0smrdZ08XzipdMYbJ+6zYAexH4VTCDfctLkgj5ll6hu6RP6e/JzokDPwqw7KYGMui
	 ZJF3xWq6rP1EIDjphQOzD/9Zppbf5NwnGUnGeasveMj6JZ00fMoz8FYpiSiRSLZkXUFUntK8Ff8XYm
	 /vG255cYfjv86lgDLh1AR4DIp0PcDSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=0loidWV2ihloVcz5aeoH7O995WGy2I4QV0SsCN+3csU=;
	b=7aDLeJh6FyNvSeTi7QIRA+4wSdkJs7s6d40T3TJm4G1tc4yye1gQibzEtxguxPpH1jQsk6/2Fori7
	 wXIn0iqDw==
X-HalOne-ID: d08ee4b9-feeb-11ee-93d5-edf132814434
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id d08ee4b9-feeb-11ee-93d5-edf132814434;
	Sat, 20 Apr 2024 07:58:55 +0000 (UTC)
Date: Sat, 20 Apr 2024 09:58:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] sparc/srmmu: Remove on-stack cpumask var
Message-ID: <20240420075846.GA614130@ravnborg.org>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
 <20240420051547.3681642-2-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420051547.3681642-2-dawei.li@shingroup.cn>

Hi Dawei,
On Sat, Apr 20, 2024 at 01:15:41PM +0800, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> Use cpumask_any_but() to avoid the need for a temporary cpumask on
> the stack.

Another good argument for this patch is the simplification of the code.

> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  arch/sparc/mm/srmmu.c | 40 ++++++++++++----------------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 852085ada368..86fd20c878ae 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -1653,13 +1653,15 @@ static void smp_flush_tlb_all(void)
>  	local_ops->tlb_all();
>  }
>  
> +static bool cpumask_any_but_current(struct mm_struct *mm)
> +{
> +	return cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_cpu_ids;
> +}

This helper is not a cpumask helper - the name should reflect what it is
used for.

Something like:
static bool any_other_mm_cpus(struct mm_struct *mm)
{
	return cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_cpu_ids;
}

The implementation is fine - it is only the naming that should be
improve.
With this change (or a better name):
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam

