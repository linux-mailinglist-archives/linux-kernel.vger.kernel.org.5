Return-Path: <linux-kernel+bounces-152175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FFB8ABA44
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65387B215AF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80531426E;
	Sat, 20 Apr 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="Bh1xpN2G";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="kzwmgfIa"
Received: from mailrelay3-1.pub.mailoutpod3-cph3.one.com (mailrelay3-1.pub.mailoutpod3-cph3.one.com [46.30.211.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E9714005
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713601498; cv=none; b=ticIS/vM9QylKieKnJtuU/iZbB1MM+OrFODplI1lt8Q0epY3es8ppbU2SKDcuee3zSDpAIMbcDvlGAo+qGTFeL6aeTV4Xk+NrrJ/H5yR+5GIKDELDTBiVByuD6ZIuMvTBOwF2zCdXxWOIoGisrq8KCZzwTB/PwxSV0nMD/6yugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713601498; c=relaxed/simple;
	bh=Rf/2X1F+tjt21y4m/23DQ2XX+1pfGqLqyJwI9KkjUTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGmJzAhK5zZziCyufSvx681cUNVJ4iDjSx/Rei3SS+k16jGciwR+5KJS9JriPc82ZOGsNQoSTdL76AIU79F/RycHC0KxrKU+cAbCKxHL8JB9VM1xIuau1Z+KcNNjL7iqFebBB4xsWeJqzduIyAP8Ldh8KWJtxBOUk13oOA9A3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=Bh1xpN2G; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=kzwmgfIa; arc=none smtp.client-ip=46.30.211.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=+r8emxDSoScNCbTF0m4d/E0SQAbAdMld3Wax9V46eSw=;
	b=Bh1xpN2GjrGqjxQx/YANnMNAcPj2VpXzWwasc07sOu+2bJiR5N7/QJYmrvYidtS/NXyRa8A9lWEHr
	 AJ7xFKfx16muFEp1bA6d3tIxToYFOCA6z0AevLrSFyl7kkOj3EqijTl+AW9hQMxW0plRI9PB42ZFcb
	 hPtQGLDsrTGNfZ/EdjZ8AzjV1TKez3rfcG5D7izZG5e2J2ZWoYch6w63w7An98SYvk1KWHLyfNu9Qi
	 2oVrzWfOBI1HmNQKzNQSeK/XqZ0R/9wzE8AY6VTDxNsFD9vp4CDz6Uw0h+0QrQIBUVeVgM+bJuZOIZ
	 ypGn6zEEnCIp1kyg7gdgdBrhM3dHrTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=+r8emxDSoScNCbTF0m4d/E0SQAbAdMld3Wax9V46eSw=;
	b=kzwmgfIar7f+YAUGKp0IkFB8UiGu3BQqKRftBZfQE5aZ+DLOii5Ff9NyDHUwamhM31d2nVNHiL8ql
	 1xFvFO8AQ==
X-HalOne-ID: 4dc453fc-feef-11ee-856a-5166eb5bc2d3
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 4dc453fc-feef-11ee-856a-5166eb5bc2d3;
	Sat, 20 Apr 2024 08:23:46 +0000 (UTC)
Date: Sat, 20 Apr 2024 10:23:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] sparc/pci_msi: Remove on-stack cpumask var
Message-ID: <20240420082345.GD614130@ravnborg.org>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
 <20240420051547.3681642-5-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420051547.3681642-5-dawei.li@shingroup.cn>

On Sat, Apr 20, 2024 at 01:15:44PM +0800, Dawei Li wrote:
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
>  arch/sparc/kernel/pci_msi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
> index fc7402948b7b..acb2f83a1d5c 100644
> --- a/arch/sparc/kernel/pci_msi.c
> +++ b/arch/sparc/kernel/pci_msi.c
> @@ -287,10 +287,7 @@ static int bringup_one_msi_queue(struct pci_pbm_info *pbm,
>  
>  	nid = pbm->numa_node;
>  	if (nid != -1) {
> -		cpumask_t numa_mask;
> -
> -		cpumask_copy(&numa_mask, cpumask_of_node(nid));
> -		irq_set_affinity(irq, &numa_mask);
> +		irq_set_affinity(irq, cpumask_of_node(nid));
>  	}
>  	err = request_irq(irq, sparc64_msiq_interrupt, 0,
>  			  "MSIQ",
> -- 
> 2.27.0

