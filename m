Return-Path: <linux-kernel+bounces-94151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B1873A9D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B6CB20F08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160CE1353E2;
	Wed,  6 Mar 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mjPEfKeZ"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916A131E4B;
	Wed,  6 Mar 2024 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738696; cv=none; b=O6P2/0iXnbxRiZTIiSKcnCfEegyXXRgMZXj8ijGqPaGU6krQvfeSeHoVx8O8xitoDRh9pXb60Cs1rO4zA/fDHvkuAg174wEqby2R/PvU1JZXgVzJ18jfyfvY5oO025AT0PAJSf/ZSo6VZLvd5/YU2EhCWDysm5BaWkjIZ4RI3iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738696; c=relaxed/simple;
	bh=WeLCZdyxH9Jm1/DFqGl++RMaB5Vh55Nxbh+OghW/4M8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4UBA+o9iHi+v5VTx7/pSjnJSRSZZH7kIRYBXuGIqkBFQ0GnQBI+PJ7YHdoh9yTdR9jTd47OGrGKkY6V6XWCwH6ZM/oAud2XMO1JhuR1JvNMkgMKbWsi+0WVlrTGHDkfKymTLBi23ISWpFIvXJu79NfvAmKkbjjhAubvng9BJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mjPEfKeZ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ACE3C240004;
	Wed,  6 Mar 2024 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709738691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ws/U9rXw9hdPUiJEnWGbV1/PZTEyE4ZxFWPvEgZTLpI=;
	b=mjPEfKeZan85r8q/7mQLKFtDrGbze986rwZdjZ546wwT8wwvmRrmktmmv6jbuMW35W6q0a
	mcHNCoSlW1oXYlOkOQdhxUmdulbNz93JW0kRce/y5PXqK4C8/LIq/+PTKTt1zWJBJLSRuu
	Ddk+G0zrsi3pR/ri9jUS2i6Hup4kTY2RsFnvIDsC4jLrcDR2We7kJ5+QVMyX57LZ1aipLB
	Fyyg5TAZ+tUO01m/IlCIiZuLpK6sA3ws1QxQ+4wjmkA6Goill9XMgFGQw02+5WagbixZao
	SxMBf2EtZnOBqglKKToQEW4qWd2POOSb7uQKDj7qoIOdwRvFK7zEi66c2i3Kkg==
Date: Wed, 6 Mar 2024 16:24:47 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
 <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Saravana
 Kannan <saravanak@google.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] driver core: Introduce
 device_link_wait_removal()
Message-ID: <20240306162447.2a843a11@bootlin.com>
In-Reply-To: <CAJZ5v0gENrBFfJ3FDJ=m0-veFbue_Bw168+k2cs7v2u9MtCT8Q@mail.gmail.com>
References: <20240306085007.169771-1-herve.codina@bootlin.com>
	<20240306085007.169771-2-herve.codina@bootlin.com>
	<CAJZ5v0gENrBFfJ3FDJ=m0-veFbue_Bw168+k2cs7v2u9MtCT8Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Rafael,

On Wed, 6 Mar 2024 13:48:37 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Mar 6, 2024 at 9:51 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > introduces a workqueue to release the consumer and supplier devices used
> > in the devlink.
> > In the job queued, devices are release and in turn, when all the
> > references to these devices are dropped, the release function of the
> > device itself is called.
> >
> > Nothing is present to provide some synchronisation with this workqueue
> > in order to ensure that all ongoing releasing operations are done and
> > so, some other operations can be started safely.
> >
> > For instance, in the following sequence:
> >   1) of_platform_depopulate()
> >   2) of_overlay_remove()
> >
> > During the step 1, devices are released and related devlinks are removed
> > (jobs pushed in the workqueue).
> > During the step 2, OF nodes are destroyed but, without any
> > synchronisation with devlink removal jobs, of_overlay_remove() can raise
> > warnings related to missing of_node_put():
> >   ERROR: memory leak, expected refcount 1 instead of 2
> >
> > Indeed, the missing of_node_put() call is going to be done, too late,
> > from the workqueue job execution.
> >
> > Introduce device_link_wait_removal() to offer a way to synchronize
> > operations waiting for the end of devlink removals (i.e. end of
> > workqueue jobs).
> > Also, as a flushing operation is done on the workqueue, the workqueue
> > used is moved from a system-wide workqueue to a local one.
> >
> > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")  
> 
> No, it is not fixed by this patch.

Was explicitly asked by Saravana on v1 review:
https://lore.kernel.org/linux-kernel/CAGETcx9uP86EHyKJNifBMd23oCsA+KpMa+e36wJEEnHDve+Avg@mail.gmail.com/

The commit 80dd33cf72d1 introduces the workqueue and so some asynchronous tasks
on removal.
This patch and the next one allows to re-sync execution waiting for jobs in
the workqueue when it is needed.

> 
> In fact, the only possibly observable effect of this patch is the
> failure when the allocation of device_link_wq fails AFAICS.
> 
> > Cc: stable@vger.kernel.org  
> 
> So why?

Cc:stable is needed as this patch is a prerequisite of patch 2 (needed
to fix the asynchronous workqueue task issue).

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

