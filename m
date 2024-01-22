Return-Path: <linux-kernel+bounces-33096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CD3836472
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA8C1F22919
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4E3CF7C;
	Mon, 22 Jan 2024 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Orqi7aiC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7903CF63;
	Mon, 22 Jan 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930120; cv=none; b=m6cS1cQTZjOEu9hGfOOmRmcveM7q8pbFqPclY9Xvha5+OEwqPfIziwcWSGGYqfaoy2SBbkDhYUuk2nyaHU/WPspYddsnX1qMqIrqIS1s3lCD4UKVDqpeu9Gmf5CTOIBx529DmAuaM5z+ZrUFsala4iIdck+LtUM24aMW53sDv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930120; c=relaxed/simple;
	bh=AznU8j2SdYTSEwJC02gNSrCDmEKaUE5Gb5SSkPG/ikk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5anx7uZMEB28NQ9rLf5QBfGVhaMYjLobVh/teqb84YjfhaNi2D3EHK5J2131MWQ2824I+sggrWfm6FH3Si2yGheQ9A/BZEcNO6inJ4ViJTRE6JMYQ/jVuyCHD+WqpOH3k3yYrSvY4+BwxlQrn9tUMh0CeOrb+nsPu1/dcu3BH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Orqi7aiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597BAC433F1;
	Mon, 22 Jan 2024 13:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705930119;
	bh=AznU8j2SdYTSEwJC02gNSrCDmEKaUE5Gb5SSkPG/ikk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Orqi7aiC+MyAfrSUnAhgP70oXz5dI7MFqSKqRDMj+ItUyiUhpnc0EkdZbiF1uRd+D
	 GdGn4aHFa0wrO8UzM9Lkl+JoDb2gEv35fDMn+p0fxkZTjAIHV6cPgHrcNWIaZ69yvA
	 qbsE1jDGAnMzcPieSig70g02DgIo49lf3PGqweQlCUmu4y2CayoEBVFM+k8InFT7BV
	 doe8bzRFgDFwtVt44nIb74UYVfLOyH7TAhKTZT54VlcPWJc1fXJYZRX2QhClsuE54n
	 7T4BR/ILR3EK8ORRDsOuKacfvP4q01IQZa5WVgNsyWavrLNpSgDt44NtpjTJ+IjyNd
	 Jj/Cw4KQG62tQ==
Date: Mon, 22 Jan 2024 14:28:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: dlemoal@kernel.org, richardcochran@gmail.com, piyush.mehta@xilinx.com,
	axboe@kernel.dk, michal.simek@amd.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com,
	Piyush Mehta <piyush.mehta@amd.com>
Subject: Re: [PATCH 2/2] ata: ahci_ceva: add missing enable regulator API for
 Xilinx GT PHY support
Message-ID: <Za5tgFKxylHR91KF@x1-carbon>
References: <1705604904-471889-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1705604904-471889-3-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705604904-471889-3-git-send-email-radhey.shyam.pandey@amd.com>

Hello Radhey,

On Fri, Jan 19, 2024 at 12:38:24AM +0530, Radhey Shyam Pandey wrote:
> From: Piyush Mehta <piyush.mehta@amd.com>
> 
> The regulators API are disabled and enabled, during suspend and resume,
> respectively. The following warning notice shows up on the initial suspend
> because the enable regulators API is unaddressed in the probe:

Please be a bit more specific in your commit message.

e.g. during system suspend, ahci_platform_suspend() calls
ahci_platform_disable_resources() which calls
ahci_platform_disable_regulators() which calls
regulator_disable() for all regulators found in the controller.


> 
> regulator-dummy: Underflow of regulator enable count
> 
> Added the ahci_platform_enable_regulators API in probe to maintain the
> regulator enabled and disabled ref count.

s/Added/Add/

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz" instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy to do frotz", as if you are giving orders to the codebase to change its behaviour."

see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes


> 
> Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support xilinx GT phy")
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  drivers/ata/ahci_ceva.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
> index bfc513f1d0b3..1c56f0cabb11 100644
> --- a/drivers/ata/ahci_ceva.c
> +++ b/drivers/ata/ahci_ceva.c
> @@ -219,9 +219,14 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  		if (rc)
>  			return rc;
>  	} else {
> -		rc = ahci_platform_enable_clks(hpriv);
> +		rc = ahci_platform_enable_regulators(hpriv);
>  		if (rc)
>  			return rc;
> +
> +		rc = ahci_platform_enable_clks(hpriv);
> +		if (rc)
> +			goto disable_regulator;
> +

Like I wrote in patch 1/2, I would prefer if you could somehow get
ahci_platform_enable_resources() to work for your platform, so that you
don't need to copy paste all of ahci_platform_enable_resources() to
your driver.

If it does not work to simply add a reset_control_assert() + usleep(),
considering that this function is essentially a copy paste of
ahci_platform_enable_resources(), I would still prefer the addition of
a new flag, and keep the extra logic needed in libahci_platform.c, so that
the code is kept in the same place, rather than to copy paste the whole
function to your driver.


Kind regards,
Niklas

>  		/* Assert the controller reset */
>  		reset_control_assert(cevapriv->rst);
>  
> @@ -340,6 +345,9 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  disable_clks:
>  	ahci_platform_disable_clks(hpriv);
>  
> +disable_regulator:
> +	ahci_platform_disable_regulators(hpriv);
> +
>  	return rc;
>  }
>  
> -- 
> 2.34.1
> 

