Return-Path: <linux-kernel+bounces-55529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A097F84BDB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404431F21C4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36B71429B;
	Tue,  6 Feb 2024 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1ztfrLP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF15514006;
	Tue,  6 Feb 2024 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246125; cv=none; b=p/YIHjgRxhTz5kd4NveQsXhKoOS5wlapcM2OWBfTlzC7TplMULF35EkfJ//fMmSffUh7+GoQyJRXeGfqBXv+uroTbRQY0f+xo+H+oZ0IGnjQQMgLKInJp1CGk70L80tUpCDIQUovFnNOWSS9q5UsFkOfdr7YUGF3Ua3v+nwduTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246125; c=relaxed/simple;
	bh=Dx9E9yWYBkPkRZpeRlRMB+rccONyDzn/HrjXdlDcw6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeukscotXB22v3sg4QBpKzXnFFaYakkVoFYHKlUXD+IjC3asjHCPOl/Yy3aBkzg8yl67ACTSxmpJfbKePwEmAk2HUhhd0nu/3LYr9QncpyTA6du5xjLXYIy08zDyKoZx48G3P91awZZKx+QB9h8OyrmXDQVSiDtWKxokBCZhPFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1ztfrLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F155C433F1;
	Tue,  6 Feb 2024 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707246124;
	bh=Dx9E9yWYBkPkRZpeRlRMB+rccONyDzn/HrjXdlDcw6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1ztfrLPO/SsVoXiVW7vNVraGgBbZ5ao9p2I8aBbrBMpWCVHSyKEJUD8ISeV3JdDb
	 egozPyftyyabRb6RccVztHqXaXrjHg71iva/HfrFfSNAiAnt02FX91ykFS7S5gzsFs
	 /lOGOvy0es6+BAqQ4rHbnaWJPpM36Guv1J0zhFwdQvJdU/NoKkazPVkXq0CzFPHOVE
	 CTcq557d20fAh167k4wcJCmWByOQZ0NL9EzhhT9TjNgRBlxu5BTVZiCt4i5orXeIpx
	 XPhYYSa06Og/Gkq4u4+PkYutqV9orLFyBvWd+BQizTSMYjqFw8t6CFYKjCTFXQAPlg
	 WaN26DQGofzZQ==
Date: Tue, 6 Feb 2024 11:06:36 -0800
From: Bjorn Andersson <andersson@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] hwspinlock: omap: Use devm_pm_runtime_enable() helper
Message-ID: <73jxbyqatxc7r56df2iweewb22qvmqo33rhpsu3darczn7ldof@p2qepqpdf5ds>
References: <20240123160405.360437-1-afd@ti.com>
 <20240123160405.360437-2-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123160405.360437-2-afd@ti.com>

On Tue, Jan 23, 2024 at 10:04:03AM -0600, Andrew Davis wrote:
> This disables runtime PM on module exit, allowing us to simplify
> the probe exit path and remove callbacks. Do that here.

As with the later patch, unless I'm misreading the code, you already do
disable runtime PM in omap_hwspinlock_remove().

> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/hwspinlock/omap_hwspinlock.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
[..]
> @@ -129,16 +125,12 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
>  	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
>  						base_id, num_locks);
>  	if (ret)
> -		goto runtime_err;
> +		return ret;
>  
>  	dev_dbg(&pdev->dev, "Registered %d locks with HwSpinlock core\n",
>  		num_locks);

I don't fancy these debug information messages, there are other ways to
confirm that the device probed successfully etc.

Now that you don't need the goto runtime_err, I'd prefer the tail of
this function:

	return hwspin_lock_register(...);

Regards,
Bjorn

>  
>  	return 0;
> -
> -runtime_err:
> -	pm_runtime_disable(&pdev->dev);
> -	return ret;
>  }
>  
>  static void omap_hwspinlock_remove(struct platform_device *pdev)
> @@ -151,8 +143,6 @@ static void omap_hwspinlock_remove(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
>  		return;
>  	}
> -
> -	pm_runtime_disable(&pdev->dev);
>  }
>  
>  static const struct of_device_id omap_hwspinlock_of_match[] = {
> -- 
> 2.39.2
> 

