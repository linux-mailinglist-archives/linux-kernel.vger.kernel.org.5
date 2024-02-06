Return-Path: <linux-kernel+bounces-55511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B520D84BD91
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74E51C25333
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A9F14281;
	Tue,  6 Feb 2024 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcXugZUr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827E14014;
	Tue,  6 Feb 2024 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245862; cv=none; b=Cu1m6gq1PjTLEBTDNtP9Yf1RQGc8cVx3ADckyCcAiLzsih+4gW1asBegzPyORTs8ApNLzwT7za3p1cBETt97jIirubi9dwyJr7LkZCqm5qVrHR+ih7ei+ztP1Ioqq8wXjZQ5awh5AdoaAxvWxNej32xrUOWILRm1QB8jcQhnbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245862; c=relaxed/simple;
	bh=fYHynLl47B1W2Z5QOqN5UVH9e+0HGupd5yGI+0dilNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmaCXT0JPPOqNooHV1kIoUvnNRRLDwDFd7k3JNJMaeXx9653lsqwzrS1lFCK6HiTevWAYHI49XD5OM80Mk57TiW1hSgwpYgG/s0SqeNeDH/cGVir8Uj7CdCc1jpSEm6LWYW6CDxjzGewg19CrBXBIIjt4LX5aAC7EPVdg0llTdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcXugZUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC528C433C7;
	Tue,  6 Feb 2024 18:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707245862;
	bh=fYHynLl47B1W2Z5QOqN5UVH9e+0HGupd5yGI+0dilNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcXugZUrvSzDmMY/QV/VC/4yWoI6rqQgS/zzsgpmEms3cr+r3YXi6i6RP62jJVv/y
	 M6OHEyDMIYoxTfEQavGjx606nfuKzcNzb0cYQTQv/VRsG10SzbfU/GNugjcH1ZYSZn
	 RSXhSwID63aVy37na1B3sBcrCmMLfwsl9H3mhPSd0bSS5KXYfPIPyWe+J8msfNf2cW
	 okWhVFSHzpLClYwgJJGrjEP5c7JmjswTeeYsQCrYP1YqagxlZSduCaMT0OdlVKJkW5
	 QrU/QQh6mF4DtueUT7RIxdvuPZEWV3OJ5QGqDeozQgV6XKYz5gcDLh2ITWEyo/IV/s
	 DNm/0ZAl6xgfQ==
Date: Tue, 6 Feb 2024 11:02:14 -0800
From: Bjorn Andersson <andersson@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] hwspinlock: omap: Use devm_hwspin_lock_register()
 helper
Message-ID: <sbbjsqci42iz24lommsq5ebmsjhf73r2hnsxlh3xiurhvypdze@vsh637r722n2>
References: <20240123160405.360437-1-afd@ti.com>
 <20240123160405.360437-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123160405.360437-3-afd@ti.com>

On Tue, Jan 23, 2024 at 10:04:04AM -0600, Andrew Davis wrote:
> This unregister the HW spinlock on module exit, allowing us to
> remove the remove callback. Do this here.
> 

I interpret this as stating that the driver currently doesn't unregister
the spinlocks, but as far as I can see it does, and that the patch has
no functional change.

Can you please rewrite this commit message to clearly express which
"problem" you're solving, and unless I'm mistaken clarify that there's
no functional change.


Patch itself looks good.

Regards,
Bjorn

> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/hwspinlock/omap_hwspinlock.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
> index 2f18ea6c05e3f..1b0a1bea2b24a 100644
> --- a/drivers/hwspinlock/omap_hwspinlock.c
> +++ b/drivers/hwspinlock/omap_hwspinlock.c
> @@ -117,12 +117,10 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
>  	if (!bank)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, bank);
> -
>  	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
>  		hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
>  
> -	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
> +	ret = devm_hwspin_lock_register(&pdev->dev, bank, &omap_hwspinlock_ops,
>  						base_id, num_locks);
>  	if (ret)
>  		return ret;
> @@ -133,18 +131,6 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static void omap_hwspinlock_remove(struct platform_device *pdev)
> -{
> -	struct hwspinlock_device *bank = platform_get_drvdata(pdev);
> -	int ret;
> -
> -	ret = hwspin_lock_unregister(bank);
> -	if (ret) {
> -		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
> -		return;
> -	}
> -}
> -
>  static const struct of_device_id omap_hwspinlock_of_match[] = {
>  	{ .compatible = "ti,omap4-hwspinlock", },
>  	{ .compatible = "ti,am64-hwspinlock", },
> @@ -155,7 +141,6 @@ MODULE_DEVICE_TABLE(of, omap_hwspinlock_of_match);
>  
>  static struct platform_driver omap_hwspinlock_driver = {
>  	.probe		= omap_hwspinlock_probe,
> -	.remove_new	= omap_hwspinlock_remove,
>  	.driver		= {
>  		.name	= "omap_hwspinlock",
>  		.of_match_table = omap_hwspinlock_of_match,
> -- 
> 2.39.2
> 

