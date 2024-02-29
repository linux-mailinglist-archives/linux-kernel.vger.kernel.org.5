Return-Path: <linux-kernel+bounces-86590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E7F86C77E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DA91C21EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294CD7A72F;
	Thu, 29 Feb 2024 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X29181Pg"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C979DDA;
	Thu, 29 Feb 2024 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204144; cv=none; b=RXRCn/fliMovFHaV1chXOGpPdjfdIskgfWURXbcjsLs2C85mRhJReCsbDk6b2cDqwgg3snlNSaukukKhd0oGP6bYCJuMVJxvRZlUHFLcNwdUc3YDKB9ng46YvVtvhEd575TrZIjXMLm9OtlWxBaEJRoVCvK+ot1RcL220FhjdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204144; c=relaxed/simple;
	bh=uJQ8oK6S3btZM/i+xqMBD+VnKIFGNlckNP4cfaBVpp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lmyn20S4nCfH9h/gOxk3/Rd4nsvbkCJpu+L5hm4KNnKcouaP4zTHr5gj6t0wSpJ61GpK3PIApqZj+NW7lbWOL9QCFm2pnWYraZMWTxDEeepV4I7mMt0xpjI/X61E3rotd3NofccZuXFvuiL0RT3jWghk6eQE3H1gKMJyO/tXs5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X29181Pg; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A92FFF809;
	Thu, 29 Feb 2024 10:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709204140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucmCXKr9aC1Z8X3a+6gOaQampla6gbJJBtAdPFqD47o=;
	b=X29181PgT3vCMk+kh1MSYsbzKUVA4SU2MSz62Y9uwO2DfTgwj92cYZ4UJKpoAudrvKwn3W
	ZS+7H74PBUwe3jysNFI8q0sdKZBIsv5YzVwXN3jMcvzFDnZKjBzPDM7lNQLhWPdO56hFau
	JY/r0WbXSzxd86RvGYvpBY+7aioaKto5lNzm8yLUoNm9EC4xB4uMRY/dgyOACGEfiTXZY0
	pb30wl/Tr0bMXusNsuWgiFmsGFS4drC3yLIIuXjV9JQIYzzlkNW8DFaYHE7MJ4JFpv7eaI
	BLfj0gE0dBUrcnGsBx+C2NtqYJjpfzXEXuZYcur7siSHAsjYaBUiKDvCbZJKsA==
Date: Thu, 29 Feb 2024 11:55:38 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/2] Synchronize DT overlay removal with devlink
 removals
Message-ID: <20240229115538.7d2f5a35@bootlin.com>
In-Reply-To: <20240229083953.607569-1-herve.codina@bootlin.com>
References: <20240229083953.607569-1-herve.codina@bootlin.com>
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

Hi All,

I did a mistake in this series.
As noted by Nuno, the device.h include is missing in patch 2 and so
the patch 2 doesn't compile :(

A v3 is already sent fixing my missing device.h mistake.
  https://lore.kernel.org/all/20240229105204.720717-1-herve.codina@bootlin.com/

Sorry for this error.
Best regards,
Hervé

On Thu, 29 Feb 2024 09:39:40 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi,
> 
> In the following sequence:
>   of_platform_depopulate(); /* Remove devices from a DT overlay node */
>   of_overlay_remove(); /* Remove the DT overlay node itself */
> 
> Some warnings are raised by __of_changeset_entry_destroy() which  was
> called from of_overlay_remove():
>   ERROR: memory leak, expected refcount 1 instead of 2 ...
> 
> The issue is that, during the device devlink removals triggered from the
> of_platform_depopulate(), jobs are put in a workqueue.
> These jobs drop the reference to the devices. When a device is no more
> referenced (refcount == 0), it is released and the reference to its
> of_node is dropped by a call to of_node_put().
> These operations are fully correct except that, because of the
> workqueue, they are done asynchronously with respect to function calls.
> 
> In the sequence provided, the jobs are run too late, after the call to
> __of_changeset_entry_destroy() and so a missing of_node_put() call is
> detected by __of_changeset_entry_destroy().
> 
> This series fixes this issue introducing device_link_wait_removal() in
> order to wait for the end of jobs execution (patch 1) and using this
> function to synchronize the overlay removal with the end of jobs
> execution (patch 2).
> 
> Compared to the previous iteration:
>   https://lore.kernel.org/linux-kernel/20231130174126.688486-1-herve.codina@bootlin.com/
> this v2 series mainly:
> - Renames the workqueue used.
> - Calls device_link_wait_removal() a bit later to handle cases reported
>   by Luca [1] and Nuno [2].
>   [1]: https://lore.kernel.org/all/20231220181627.341e8789@booty/
>   [2]: https://lore.kernel.org/all/20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com/
> 
> Best regards,
> Hervé
> 
> Changes v1 -> v2
>   - Patch 1
>     Rename the workqueue to 'device_link_wq'
>     Add 'Fixes' tag and Cc stable
> 
>   - Patch 2
>     Add device.h inclusion.
>     Call device_link_wait_removal() later in the overlay removal
>     sequence (i.e. in free_overlay_changeset() function).
>     Drop of_mutex lock while calling device_link_wait_removal().
>     Add	'Fixes'	tag and Cc stable
> 
> Herve Codina (2):
>   driver core: Introduce device_link_wait_removal()
>   of: overlay: Synchronize of_overlay_remove() with the devlink removals
> 
>  drivers/base/core.c    | 26 +++++++++++++++++++++++---
>  drivers/of/overlay.c   |  9 ++++++++-
>  include/linux/device.h |  1 +
>  3 files changed, 32 insertions(+), 4 deletions(-)
> 

