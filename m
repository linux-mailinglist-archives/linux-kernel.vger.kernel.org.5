Return-Path: <linux-kernel+bounces-7373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E5681A6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A8528824B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1344482DB;
	Wed, 20 Dec 2023 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UGvSyWwd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972547A53;
	Wed, 20 Dec 2023 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 520ECC0007;
	Wed, 20 Dec 2023 18:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703095954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sjy+8ecPU0FjeS9zuzm6XKl4DZ4A+icbDW10+elVCcU=;
	b=UGvSyWwdCSFkT09GwwJjntaScciGzIttvnNWIoQAkBKSOibBBUfcFdwhPYHGlaCqLmzlen
	jgeH7pq491urM5Ib2gJ46OPhEWT8sgY0cTaG0tK5YYcUwF/AQ+CIdLWnj8i50T3y+bx+Qg
	rRIIc1KUaOiyt/6lcHOkik3qOlesTjSLIKR5lug/WHIhcCVh3BQgNz4xHA9Ym9SQ+gSmPX
	R2HrTJ7bE8Pjo06v1CZd9NWgv/5tae4SO8LiUxJTPL4LuiyDD6nBET5uxcTtO1gEV0roxD
	x7cX3M4tFb7JH5BYBtGzamOp8kZRRJrF8iq4OohwcUvJK1QtUk6Svi1xB7oy1Q==
Date: Wed, 20 Dec 2023 19:12:32 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 0/2] Synchronize DT overlay removal with devlink
 removals
Message-ID: <20231220191232.0a9c495f@bootlin.com>
In-Reply-To: <20231220181627.341e8789@booty>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	<20231206171540.GA2697853-robh@kernel.org>
	<CAGETcx-F8G3dcN-VTMrbya_=19zXP=S2ORA_qZqy+yND7S41_Q@mail.gmail.com>
	<20231220181627.341e8789@booty>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

On Wed, 20 Dec 2023 18:16:27 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> Hello Saravana, Rob, Hervé,
> 
> [+Miquèl, who contributed to the discussion with Hervé and me]
> 
> On Wed, 6 Dec 2023 19:09:06 -0800
> Saravana Kannan <saravanak@google.com> wrote:
> 
> > On Wed, Dec 6, 2023 at 9:15 AM Rob Herring <robh@kernel.org> wrote:  
> > >
> > > On Thu, Nov 30, 2023 at 06:41:07PM +0100, Herve Codina wrote:    
> > > > Hi,    
> > >
> > > +Saravana for comment    
> > 
> > I'll respond to this within a week -- very swamped at the moment. The
> > main thing I want to make sure is that we don't cause an indirect
> > deadlock with this wait(). I'll go back and look at why we added the
> > work queue and then check for device/devlink locking issues.  
> 
> While working on a project unrelated to Hervé's work, I also ended up
> in getting sporadic but frequent "ERROR: memory leak, expected refcount
> 1 instead of..." messages, which persisted even after adding this patch
> series on my tree.
> 
> My use case is the insertion and removal of a simple overlay describing
> a regulator-fixed and an I2C GPIO expander using it. The messages appear
> regardless of whether the insertion and removal is done from kernel code
> or via the configfs interface (out-of-tree patches from [0]).
> 
> I reconstructed the sequence of operations, all of which stem from
> of_overlay_remove():
> 
> int of_overlay_remove(int *ovcs_id)
> {
>     ...
> 
>     device_link_wait_removal(); // proposed by this patch series
> 
>     mutex_lock(&of_mutex);
> 
>     ...
> 
>     ret = __of_changeset_revert_notify(&ovcs->cset);
>     // this ends up calling (excerpt from a long stack trace):
>     // -> of_i2c_notify
>     // -> device_remove
>     // -> devm_regulator_release
>     // -> device_link_remove
>     // -> devlink_dev_release, which queues work for
>     //      device_link_release_fn, which in turn calls:
>     //      -> device_put
>     //      -> device_release
>     //      -> {platform,regulator,...}_dev*_release
>     //      -> of_node_put() [**]
> 
>     ...
> 
>     free_overlay_changeset(ovcs);
>     // calls:
>     // -> of_changeset_destroy
>     // -> __of_changeset_entry_destroy
>     // -> pr_err("ERROR: memory leak, expected refcount 1 instead of %d...
>     // The error appears or not, based on when the workqueue runs
> 
> err_unlock:
>     mutex_unlock(&of_mutex);
> 
>     ...
> }
> 
> So this adds up to the question of whether devlink removal should actually
> be run asynchronously or not.
> 
> A simple short-term solution is to move the call to
> device_link_wait_removal() later, just before free_overlay_changeset():

Indeed, during of_overlay_remove() notifications can be done and in Luca's
use-case, they lead to some device removals and so devlink removals.

That's why we move the synchronization calling device_link_wait_removal()
after notifications and so just before free_overlay_changeset().

> 
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 1a8a6620748c..eccf08cf2160 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -1375,12 +1375,6 @@ int of_overlay_remove(int *ovcs_id)
>  		goto out;
>  	}
>  
> -	/*
> -	 * Wait for any ongoing device link removals before removing some of
> -	 * nodes
> -	 */
> -	device_link_wait_removal();
> -
>  	mutex_lock(&of_mutex);
>  
>  	ovcs = idr_find(&ovcs_idr, *ovcs_id);
> @@ -1427,6 +1421,14 @@ int of_overlay_remove(int *ovcs_id)
>  		if (!ret)
>  			ret = ret_tmp;
>  
> +	/*
> +	 * Wait for any ongoing device link removals before removing some of
> +	 * nodes
> +	 */
> +	mutex_unlock(&of_mutex);
> +	device_link_wait_removal();
> +	mutex_lock(&of_mutex);
> +
>  	free_overlay_changeset(ovcs);
>  
>  err_unlock:
> 
> 
> This obviously raises the question of whether unlocking and re-locking
> the mutex is potentially dangerous. I have no answer to this right away,
> but I tested this change with CONFIG_PROVE_LOCKING=y and no issue showed
> up after several overlay load/unload sequences so I am not aware of any
> actual issues with this change.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/overlays
> 
> Luca

Thanks Luca for this complementary use-case related to this issue.

Hervé
-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

