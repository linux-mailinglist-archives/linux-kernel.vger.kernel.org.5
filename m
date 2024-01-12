Return-Path: <linux-kernel+bounces-24668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6DD82C023
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A28F1F2585A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996276BB2F;
	Fri, 12 Jan 2024 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="QC/2Hd7T"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79959B5F;
	Fri, 12 Jan 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (80-248-247-191.cust.suomicom.net [80.248.247.191])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TBM1V0DXPzyWN;
	Fri, 12 Jan 2024 14:54:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1705064063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzWR6azdCxzTrJlEWNz5xoJhdkTdjGT3DF/Jf5ldkYk=;
	b=QC/2Hd7TlxQPKtjMvX6WLc4+Y7j4q/ynh6hFG2kk/spR2L+42xwcqC0vInbqJsdoTYFl3a
	7i6jEbJqBslBuQRj8EMU87z2g2eQX21O6l91wyi4qXGZY+cD2aaSuUHupqiv8QB0NAqDrI
	95XaqJqwsnC/TMftAiFLfQ8uJveWxSQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1705064063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzWR6azdCxzTrJlEWNz5xoJhdkTdjGT3DF/Jf5ldkYk=;
	b=aVul/mOCNHpo31ul/HRBvw3WLBfHEriG0AWJPqVH+h7VWSMJ4I7zm8BKJvnAj5eJQe46X2
	KMc0LgWktZ9tiElK8Qha+oOUV+6m0mDB8FXapQkaAoAIqfDjYrXbNjx5LwT82yVwo4B8pG
	4adP8eNSaXjiKhH6+R0zNV/GBJfdPX4=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1705064063; a=rsa-sha256; cv=none;
	b=e3W8purB8WJj6DKILT5fIo/h1dvHwq7ET8NyoZFXnPLYMGVTuPNKuaQqXbEReYfByXefUR
	dRxeYcQ82dLeMhjK68pnVeEUB2hZZOuMz1K1V/q6aCNqPfCRDa9jaiGyVoLU7JuaQAScEE
	aaWw8UaEnkREo+6LFA7WTCim2cOYMqc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 1B88E634C93;
	Fri, 12 Jan 2024 14:54:21 +0200 (EET)
Date: Fri, 12 Jan 2024 12:54:20 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Mikhail Rudenko <mike.rudenko@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: rkisp1: Fix IRQ handling due to shared
 interrupts
Message-ID: <ZaE2fHqwkKs4-c_7@valkosipuli.retiisi.eu>
References: <20231218-rkisp-shirq-fix-v1-0-173007628248@ideasonboard.com>
 <20231218-rkisp-shirq-fix-v1-2-173007628248@ideasonboard.com>
 <20231218092240.GB26540@pendragon.ideasonboard.com>
 <b465355b-65c2-451f-ae2e-63da9d0a6282@ideasonboard.com>
 <20231219130849.GA29638@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219130849.GA29638@pendragon.ideasonboard.com>

Hi Laurent, Tomi,

On Tue, Dec 19, 2023 at 03:08:49PM +0200, Laurent Pinchart wrote:
> Hi Tomi,
> 
> CC'ing Sakari
> 
> On Tue, Dec 19, 2023 at 10:50:05AM +0200, Tomi Valkeinen wrote:
> > On 18/12/2023 11:22, Laurent Pinchart wrote:
> > > On Mon, Dec 18, 2023 at 09:54:01AM +0200, Tomi Valkeinen wrote:
> > >> The driver requests the interrupts as IRQF_SHARED, so the interrupt
> > >> handlers can be called at any time. If such a call happens while the ISP
> > >> is powered down, the SoC will hang as the driver tries to access the
> > >> ISP registers.
> > >>
> > >> This can be reproduced even without the platform sharing the IRQ line:
> > >> Enable CONFIG_DEBUG_SHIRQ and unload the driver, and the board will
> > >> hang.
> > >>
> > >> Fix this by adding a new field, 'irqs_enabled', which is used to bail
> > >> out from the interrupt handler when the ISP is not operational.
> > >>
> > >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > >> ---
> > >>   .../platform/rockchip/rkisp1/rkisp1-capture.c      |  3 +++
> > >>   .../media/platform/rockchip/rkisp1/rkisp1-common.h |  2 ++
> > >>   .../media/platform/rockchip/rkisp1/rkisp1-csi.c    |  3 +++
> > >>   .../media/platform/rockchip/rkisp1/rkisp1-dev.c    | 22 ++++++++++++++++++++++
> > >>   .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |  3 +++
> > >>   5 files changed, 33 insertions(+)
> > >>
> > >> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > >> index aebd3c12020b..c381c22135a2 100644
> > >> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > >> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > >> @@ -725,6 +725,9 @@ irqreturn_t rkisp1_capture_isr(int irq, void *ctx)
> > >>   	unsigned int i;
> > >>   	u32 status;
> > >>   
> > >> +	if (!rkisp1->irqs_enabled)
> > >> +		return IRQ_NONE;
> > > 
> > > Given that this is something all drivers that use shared IRQs have to
> > > do, would it make sense to use a standard helper here, such as
> > > pm_runtime_suspended() for instance ? I haven't looked at which one
> > > would be the most appropriate (if any), there's also
> > > pm_runtime_active() and pm_runtime_status_suspended(). That would
> > > simplify this patch.
> > 
> > I did consider that when writing the patch. But I just wasn't very 
> > comfortable using the runtime PM here, even if it would make sense, as 
> > I'm just not quite sure how it works.
> > 
> > For example, pm_runtime_suspended() checks if the device is in 
> > RPM_SUSPENDED state, and the device will be in RPM_SUSPENDED after the 
> > driver's suspend callback has finished. This makes sense.
> > 
> > However, _while_ suspending (not after we have suspended), we want to 
> > make sure that 1) no new irq handling will start, 2) we'll wait until 
> > any currently running irq handler has finished. For 1), we can't use 
> > pm_runtime_suspended() in the irq handler, as the status is not 
> > RPM_SUSPENDED. We could probably check for:
> > 
> > spin_lock(&dev->power.lock);
> > off = dev->power.runtime_status == RPM_SUSPENDED || 
> > dev->power.runtime_status == RPM_SUSPENDING;
> > spin_unlock(&dev->power.lock);
> > if (off)
> > 	return IRQ_NONE;
> > 
> > That would not work if we would depend on the irq handling while in the 
> > suspend callback (e.g. waiting for an irq which signals that the device 
> > has finished processing). But we don't do that at the moment, and that 
> > kind of this probably can usually be done before calling runtime_put().
> > 
> > When we take into account the resume part, I think we could just check 
> > for RPM_ACTIVE in the irq handler, which would then rule out 
> > RPM_RESUMING, RPM_SUSPENDED and RPM_SUSPENDING.
> > 
> > But we can't use pm_runtime_active(), as that also checks for 
> > dev->power.disable_depth. In other words, when we disable the PM for our 
> > device (e.g. when unloading the driver), the PM framework says our 
> > device became active.
> > 
> > Soo... I think this should work in the irq handler:
> > 
> > spin_lock(&dev->power.lock);
> > active = dev->power.runtime_status == RPM_ACTIVE;
> 
> It would be nice to use pm_runtime_active() instead. This would however
> require unregistering the IRQ handler before disabling runtime PM in the
> remove path. I think that should be done nonetheless though, as relying
> on devm to unregister the IRQ handler means it will happen after
> .remove() returns, which could cause all sort of issues (I'm thinking
> about the calls to dev_get_drvdata() in the IRQ handlers for instance).
> What do you think ?

You should use pm_runtime_get_if_active() as otherwise the device may be
powered off right after checking it was active. If it returns 0, the device
is not active. Don't put the usage_count by calling pm_runtime_put*()
however as the usage_count isn't incremented on error (which you typically
get when runtime PM is disabled). It's up to the driver to decide what to
do then I think, presumably the device is powered on e.g. in case CONFIG_PM
is disabled.

This is actually similar to what e.g. sensor drivers do in the s_ctrl()
callback.

It would be the best if you could ensure no interrupt will be triggered by
the device while it's about to suspend as you won't be able to ack it when
the device is suspending (and no longer active).

> 
> > spin_unlock(&dev->power.lock);
> > if (!active)
> > 	return IRQ_NONE;
> > 
> > I think the driver depends on runtime PM, but if no-PM was an option, I 
> > guess we'd need to ifdef the above away, and trust that the device is 
> > always powered on.
> > 
> > So, as I said in the beginning, "I just wasn't very comfortable using 
> > the runtime PM here". And that's still the case =). The runtime PM is 
> > horribly complex. If you think the above is clearer, and you think it's 
> > correct, I can make the change.
> 
> It sounds it may require some more work, and we should land this fix in
> v6.8, with the revert, right ? If so, I'm fine merging this patch, and
> moving to runtime PM checks on top if we decide to do so.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> By the way, I wonder if it would make sense to handle this in the driver
> core. The prospect of copying this code in all drivers doesn't make me
> happy.
> 
> > >> +
> > >>   	status = rkisp1_read(rkisp1, RKISP1_CIF_MI_MIS);
> > >>   	if (!status)
> > >>   		return IRQ_NONE;
> > >> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > >> index 4b6b28c05b89..b757f75edecf 100644
> > >> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > >> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > >> @@ -450,6 +450,7 @@ struct rkisp1_debug {
> > >>    * @debug:	   debug params to be exposed on debugfs
> > >>    * @info:	   version-specific ISP information
> > >>    * @irqs:          IRQ line numbers
> > >> + * @irqs_enabled:  the hardware is enabled and can cause interrupts
> > >>    */
> > >>   struct rkisp1_device {
> > >>   	void __iomem *base_addr;
> > >> @@ -471,6 +472,7 @@ struct rkisp1_device {
> > >>   	struct rkisp1_debug debug;
> > >>   	const struct rkisp1_info *info;
> > >>   	int irqs[RKISP1_NUM_IRQS];
> > >> +	bool irqs_enabled;
> > >>   };
> > >>   
> > >>   /*
> > >> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> > >> index b6e47e2f1b94..4202642e0523 100644
> > >> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> > >> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> > >> @@ -196,6 +196,9 @@ irqreturn_t rkisp1_csi_isr(int irq, void *ctx)
> > >>   	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
> > >>   	u32 val, status;
> > >>   
> > >> +	if (!rkisp1->irqs_enabled)
> > >> +		return IRQ_NONE;
> > >> +
> > >>   	status = rkisp1_read(rkisp1, RKISP1_CIF_MIPI_MIS);
> > >>   	if (!status)
> > >>   		return IRQ_NONE;
> > >> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> > >> index acc559652d6e..73cf08a74011 100644
> > >> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> > >> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> > >> @@ -305,6 +305,24 @@ static int __maybe_unused rkisp1_runtime_suspend(struct device *dev)
> > >>   {
> > >>   	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
> > >>   
> > >> +	rkisp1->irqs_enabled = false;
> > >> +	/* Make sure the IRQ handler will see the above */
> > >> +	mb();
> > >> +
> > >> +	/*
> > >> +	 * Wait until any running IRQ handler has returned. The IRQ handler
> > >> +	 * may get called even after this (as it's a shared interrupt line)
> > >> +	 * but the 'irqs_enabled' flag will make the handler return immediately.
> > >> +	 */
> > >> +	for (unsigned int il = 0; il < ARRAY_SIZE(rkisp1->irqs); ++il) {
> > >> +		if (rkisp1->irqs[il] == -1)
> > >> +			continue;
> > >> +
> > >> +		/* Skip if the irq line is the same as previous */
> > >> +		if (il == 0 || rkisp1->irqs[il - 1] != rkisp1->irqs[il])
> > >> +			synchronize_irq(rkisp1->irqs[il]);
> > >> +	}
> > >> +
> > >>   	clk_bulk_disable_unprepare(rkisp1->clk_size, rkisp1->clks);
> > >>   	return pinctrl_pm_select_sleep_state(dev);
> > >>   }
> > >> @@ -321,6 +339,10 @@ static int __maybe_unused rkisp1_runtime_resume(struct device *dev)
> > >>   	if (ret)
> > >>   		return ret;
> > >>   
> > >> +	rkisp1->irqs_enabled = true;
> > >> +	/* Make sure the IRQ handler will see the above */
> > >> +	mb();
> > >> +
> > >>   	return 0;
> > >>   }
> > >>   
> > >> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> > >> index f00873d31c42..78a1f7a1499b 100644
> > >> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> > >> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> > >> @@ -976,6 +976,9 @@ irqreturn_t rkisp1_isp_isr(int irq, void *ctx)
> > >>   	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
> > >>   	u32 status, isp_err;
> > >>   
> > >> +	if (!rkisp1->irqs_enabled)
> > >> +		return IRQ_NONE;
> > >> +
> > >>   	status = rkisp1_read(rkisp1, RKISP1_CIF_ISP_MIS);
> > >>   	if (!status)
> > >>   		return IRQ_NONE;
> 

-- 
Regards,

Sakari Ailus

