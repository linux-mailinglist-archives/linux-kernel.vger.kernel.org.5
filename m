Return-Path: <linux-kernel+bounces-90811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B600087054B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D33F1F26650
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967E7487AE;
	Mon,  4 Mar 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA+XVt8b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A1E14ABC;
	Mon,  4 Mar 2024 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565546; cv=none; b=mD6ycauGWBuvBXKpbfpL6dcPFSA6PiUNaOT8S1TowAxx6Typ/T3jkcLoq8XqBjnLO89N7zH6n7flR+uVQYfZ3kwnvFNdx/yd3HcDpdDisWjFweMDv/w1MSynUTZKFj3RJTc/63YYzUwnyRSs3sUGFhJ6ADdaK3+pO86c7xndv1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565546; c=relaxed/simple;
	bh=QR5PaUloC2glE+RawDBmkFXBJ+lOR6RPDaFaRyQRbV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cy1P5ONKOd0Uxjq2vIngSHKuqB8pZxDT48Hf+gsWGWUxRfIn5jnN0kwIbsOe2di5+mZfzbsXdWzi9YqiiSKruEe1JfhF4ROKHi0QJMh97xAQWBz5qIxxFR+7hA5uAcyd8FSC8hvmpvOWph1umssS9SW9zbBTDFVvRay0ADPxDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA+XVt8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A508C433C7;
	Mon,  4 Mar 2024 15:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709565546;
	bh=QR5PaUloC2glE+RawDBmkFXBJ+lOR6RPDaFaRyQRbV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MA+XVt8bw4FeD+KfDJ6Gb8c1VkRZlvxZ95p7aFH1YyRpPYlCDdexNW6rHwG+cLsw4
	 UWwG/OwbkC4K4xFL7eylA0Jyg9tdoN4OvrJL0z6GUncK5M4fAbR5picEBJvwWmKA8F
	 fvQedPfnkSU6GKqp0QgBgH+S+ecLFl0GexCrnWRC/Hb2rgGtZLQWVp8/oVs9U9wtnM
	 5Jq/sCf4hW8H36C/0LXkMU7ZPOEP3sqiC7vIXuDz1MtdatmCDhEegbFA98U8GAIFaL
	 Bu1RZ7QpF7g/2ur3CH1cDYligyLpg+9/HoUXdCkCdW1uo0gT+0dX5JRjzbnmLxEwv+
	 LKqmHv4f64bEQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rhA5y-000000001Jq-1OB2;
	Mon, 04 Mar 2024 16:19:14 +0100
Date: Mon, 4 Mar 2024 16:19:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Qingliang Li <qingliang.li@mediatek.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v2] PM: sleep: wakeirq: fix wake irq warning in system
 suspend
Message-ID: <ZeXmcl4ngEm1RccW@hovoldconsulting.com>
References: <20240301092657.15528-1-qingliang.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301092657.15528-1-qingliang.li@mediatek.com>

On Fri, Mar 01, 2024 at 05:26:57PM +0800, Qingliang Li wrote:
> When driver uses pm_runtime_force_suspend() as the system suspend callback
> function and registers the wake irq with reverse enable ordering, the wake
> irq will be re-enabled when entering system suspend, triggering an
> 'Unbalanced enable for IRQ xxx' warning. In this scenario, the call
> sequence during system suspend is as follows:
>   suspend_devices_and_enter()
>     -> dpm_suspend_start()
>       -> dpm_run_callback()
>         -> pm_runtime_force_suspend()
>           -> dev_pm_enable_wake_irq_check()
>           -> dev_pm_enable_wake_irq_complete()
> 
>     -> suspend_enter()
>       -> dpm_suspend_noirq()
>         -> device_wakeup_arm_wake_irqs()
>           -> dev_pm_arm_wake_irq()
> 
> To fix this issue, complete the setting of WAKE_IRQ_DEDICATED_ENABLED flag
> in dev_pm_enable_wake_irq_complete() to avoid redundant irq enablement.
> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Qingliang Li <qingliang.li@mediatek.com>

Thanks for the fix. Looks correct to me:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

I think you should add back the Fixes tag from v1 and CC stable as well:

Fixes: 8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")
Cc: stable@vger.kernel.org      # 5.16

Note that WAKE_IRQ_DEDICATED_REVERSE was added in 5.16 by commit
259714100d98 ("PM / wakeirq: support enabling wake-up irq after
runtime_suspend called") so no need to try to backport any further than
that.

Johan

