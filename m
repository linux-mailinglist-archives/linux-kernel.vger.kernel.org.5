Return-Path: <linux-kernel+bounces-90771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB8A8704BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE88CB25547
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971EC4654E;
	Mon,  4 Mar 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPl++o7H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348745C1C;
	Mon,  4 Mar 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564572; cv=none; b=Kz5VhIYpzirqUIUSJJ45LddlPxrcqFzxFIL56CDT75hJaX9lEvsKomH2XyXuj0dZllpkukt6hk/FmjOsDY3JopaNuruJ3oGtwh8FlYdxCs362ReFkgsgtc+c7HAnMKqCGMhFFZYAHnuv+/GLt5Hoid2wUAODP0lThQ6KQ18gBmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564572; c=relaxed/simple;
	bh=NJq21IcMWpBFi3GGq2wDJ4XI/iHf+aVc6N3sYqI37K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kET5vrKOGqZeYj/GWGBlB5nSSpT/yfJXiZGtCr8DfVx15+YwKUC1CeEhXbxnjo3Ep1/uWv/3l9wSSAiqwYs1bTaqujxH8/Bn8L89IxQ8wEHHraVXtdjWYUDvzEu85sudeDZbDeemKpKudUbODgh3WQ7C989KegMD/p0U7F6btrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPl++o7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4D6C433C7;
	Mon,  4 Mar 2024 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709564572;
	bh=NJq21IcMWpBFi3GGq2wDJ4XI/iHf+aVc6N3sYqI37K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPl++o7H+Cp4Q6tf5O3Gj21PmjH/SJB5KIG/HCbhHd+d2INNQ1h7QmlnC8Vb9W32V
	 Tg3WhQHabCbF9Qjg58PGwYUQ4lDBiAhASMp06MukKsYJRoUKpHoF+Ue/C+k/4hO1Di
	 lUUmjRjzJmjGy6CKSG2AHh05sP4j9rWWJwqjT1CrPyMUbkmIh5/BVJmf6QG75f9TP5
	 gNBJPT3gjkBkquIWINkwlFbbzcfuBLF2ysl3ITRfkAZleDFoJ1hTECubVUrvwHJN0M
	 T7itKqVY1rEOQOvLQJDfPZCdjHyvXE5Xdom4cy8ERuvXU02nA5nVeYNZs8fBA6QX/I
	 4m8OF9OtZra1g==
Date: Mon, 4 Mar 2024 09:02:48 -0600
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>,
	Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 0/2] Synchronize DT overlay removal with devlink
 removals
Message-ID: <20240304150248.GA211460-robh@kernel.org>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229105204.720717-1-herve.codina@bootlin.com>

On Thu, Feb 29, 2024 at 11:52:01AM +0100, Herve Codina wrote:
> Hi,

Please CC Saravana on this.

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
> this v3 series:
> - add the missing device.h
> 
> This series handles cases reported by Luca [1] and Nuno [2].
>   [1]: https://lore.kernel.org/all/20231220181627.341e8789@booty/
>   [2]: https://lore.kernel.org/all/20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com/
> 
> Best regards,
> Hervé
> 
> Changes v2 -> v3
>   - Patch 1
>     No changes
> 
>   - Patch 2
>     Add missing device.h
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
>  drivers/of/overlay.c   | 10 +++++++++-
>  include/linux/device.h |  1 +
>  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> -- 
> 2.43.0
> 

