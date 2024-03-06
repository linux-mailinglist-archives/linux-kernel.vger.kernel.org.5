Return-Path: <linux-kernel+bounces-93832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC0873554
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C656284AB8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D077F0A;
	Wed,  6 Mar 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wlal6nzd"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D876762D9;
	Wed,  6 Mar 2024 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723244; cv=none; b=GVo4ScYLU/sGVURcQAWe/tZEz83ke7pI1ktAUEHwvKYmGi7+CDVsn3hYVqbA4H5+cH5z8Q+IttxJitXhtfZFRGHeBW8PiZhuDTFUaJrWb6EYWC383veOOtpYAXCMYlRkJwWD7xtf02Ub/DLGp8OGF7p6RvcC6LqXzgCLooAqyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723244; c=relaxed/simple;
	bh=dhUYkisSRgaEsKU54+0TtX8xvTK2vt6Z1QeO97lvAIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8NZSW7cRyeSP3sYLEfRzvXb3PgyPnWoP12XOYEU5+XWR/kb0PRTW6JPDUIXWlXDLiG6C6Bs4Q3HZXFZ/rApSH+ZGflILk36ciVAY/iDJQuSn9Xl3sMx0EGsTEQb8V6C6hxdUnhzqTi8NWl/SfTFTlOax6tNqJCVLGlmSdaUKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wlal6nzd; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9772540006;
	Wed,  6 Mar 2024 11:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709723240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkpSPLFwPA6sIr441GTPKMTLs5vOapZYIPq9ZxQdhg8=;
	b=Wlal6nzd3buzIfRLQsB5cqSN6nx1HoJ3I03GuUShz7k5AzVIlhhZC/dQJkiMZHplmw5yof
	UpOVZQRDUKyhnoanVLdafiTX3NSMPhUEbKzTbHfmJF8jyeK0M9UP6a4UrtHayFyGyMd1LC
	QdB+DLPHvRrphVoG5UHHTtm9Goze7bOlCWUrBN6kDe9ZHo8LUK5FSQOyIU1hBGqFV/mdq/
	tDNGvii0WMUeOFmd8obQtT1y1wzKIMbJ0CUH+L+Y4fJjM8SuaOGlIcoubDNWGnwQl/igqd
	3g1Tx7tHd3ztaOX9luNqHyTYCYGGES545n9dLDTlndXjMr+2KAg7hwnDvd7t3Q==
Date: Wed, 6 Mar 2024 12:07:17 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Saravana Kannan <saravanak@google.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Nuno Sa <nuno.sa@analog.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] of: dynamic: Synchronize of_changeset_destroy()
 with the devlink removals
Message-ID: <20240306120717.524bcd36@booty>
In-Reply-To: <20240306085007.169771-3-herve.codina@bootlin.com>
References: <20240306085007.169771-1-herve.codina@bootlin.com>
	<20240306085007.169771-3-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

On Wed,  6 Mar 2024 09:50:03 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> In the following sequence:
>   1) of_platform_depopulate()
>   2) of_overlay_remove()
> 
> During the step 1, devices are destroyed and devlinks are removed.
> During the step 2, OF nodes are destroyed but
> __of_changeset_entry_destroy() can raise warnings related to missing
> of_node_put():
>   ERROR: memory leak, expected refcount 1 instead of 2 ...
> 
> Indeed, during the devlink removals performed at step 1, the removal
> itself releasing the device (and the attached of_node) is done by a job
> queued in a workqueue and so, it is done asynchronously with respect to
> function calls.
> When the warning is present, of_node_put() will be called but wrongly
> too late from the workqueue job.
> 
> In order to be sure that any ongoing devlink removals are done before
> the of_node destruction, synchronize the of_changeset_destroy() with the
> devlink removals.
> 
> Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/of/dynamic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 3bf27052832f..169e2a9ae22f 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -9,6 +9,7 @@
>  
>  #define pr_fmt(fmt)	"OF: " fmt
>  
> +#include <linux/device.h>
>  #include <linux/of.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
> @@ -667,6 +668,12 @@ void of_changeset_destroy(struct of_changeset *ocs)
>  {
>  	struct of_changeset_entry *ce, *cen;
>  
> +	/*
> +	 * Wait for any ongoing device link removals before destroying some of
> +	 * nodes.
> +	 */
> +	device_link_wait_removal();

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

And no problem appeared in my tests due to the removed unlock/lock
around device_link_wait_removal().

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

