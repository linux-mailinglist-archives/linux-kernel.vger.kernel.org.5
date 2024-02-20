Return-Path: <linux-kernel+bounces-73259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB9485C026
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 229BCB23A07
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786D7763E5;
	Tue, 20 Feb 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt87XlPg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A7762F5;
	Tue, 20 Feb 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443378; cv=none; b=AYeWnLs+hplupcjEH8X0u7GK+j7Rh5dqSrrjOE+6E6DoyRQCXtq8iXHBkos3LZZCOabgqRv2w1aXqQyDUtLXah9RG/qk9GaSQ178WqDRi1m6i0MjOhGU1F27RmdxnnK5//SnEDjLIudFuLgjZPvSHp57WsxuzguQgne7iVIZ36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443378; c=relaxed/simple;
	bh=91doaSK1OA6gFTh8JNp1z7riF9y+l3+n/Ojx52n96AE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D2jq/H4QH8URjYkWz8EccMDLvxPk/OzbW0qxaOdbSTRSTtaqOFCqbS5+QlHxdQqFYYkCVjLQc405hfBHjijkC2lw8YawbZK03xFxmYW3qhEfvC+5TNfFz4wHACRImuYOTzxIOgBrlg28wFrbUEosGCticl0kakoeP1JfIY/PgxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt87XlPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D2FC433F1;
	Tue, 20 Feb 2024 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708443378;
	bh=91doaSK1OA6gFTh8JNp1z7riF9y+l3+n/Ojx52n96AE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Xt87XlPg+sBVe/zFZQCf4sXMZurtA7DkT5+P1M9iXF6H7MkHXOCIc96L8nToM/aB1
	 XTBI8Fjko4VDW6TMgoLavbmY02zoFHGL1fyC0X9mAOIXxtcccMto//W06TAQR4zYQ7
	 00gjltz55RDh93J/d2WlzSbzGe/TGoS5MZT0ySkAbtpBdmMR2ltKVU1HGzoXw3FJS7
	 r5g3aNP4LZd7JkN6Modqhwx8cFGaVnEweIUFABx7JO8AM0q1qhPOQpBy8pUBRSsRKG
	 tCaL0H51IaS2708iFrkXTylC6CxfG9DKZe100gmxZbM1nrRkhCiosXZeEH4+Aggk7t
	 Hhw9+VxL47IUQ==
Date: Tue, 20 Feb 2024 09:36:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: linux-next: manual merge of the pm tree with the pci-current tree
Message-ID: <20240220153616.GA1481509@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214103008.0bb12069@canb.auug.org.au>

On Wed, Feb 14, 2024 at 10:30:08AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the pm tree got a conflict in:
> 
>   drivers/pci/pci.c
> 
> between commit:
> 
>   41044d536068 ("PCI: Fix active state requirement in PME polling")
> 
> from the pci-current tree and commit:
> 
>   c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usage")
> 
> from the pm tree.

Just FYI, 41044d536068 is now upstream for v6.8, so the conflict will
be between upstream and the pm tree:

https://git.kernel.org/linus/41044d536068

> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/pci/pci.c
> index a532bf597e57,cb51c4079013..000000000000
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@@ -2361,36 -2522,29 +2361,36 @@@ static void pci_pme_list_scan(struct wo
>   		if (pdev->pme_poll) {
>   			struct pci_dev *bridge = pdev->bus->self;
>   			struct device *dev = &pdev->dev;
>  -			int pm_status;
>  +			struct device *bdev = bridge ? &bridge->dev : NULL;
>  +			int bref = 0;
>   
>   			/*
>  -			 * If bridge is in low power state, the
>  -			 * configuration space of subordinate devices
>  -			 * may be not accessible
>  +			 * If we have a bridge, it should be in an active/D0
>  +			 * state or the configuration space of subordinate
>  +			 * devices may not be accessible or stable over the
>  +			 * course of the call.
>   			 */
>  -			if (bridge && bridge->current_state != PCI_D0)
>  -				continue;
>  +			if (bdev) {
> - 				bref = pm_runtime_get_if_active(bdev, true);
> ++				bref = pm_runtime_get_if_active(bdev);
>  +				if (!bref)
>  +					continue;
>  +
>  +				if (bridge->current_state != PCI_D0)
>  +					goto put_bridge;
>  +			}
>   
>   			/*
>  -			 * If the device is in a low power state it
>  -			 * should not be polled either.
>  +			 * The device itself should be suspended but config
>  +			 * space must be accessible, therefore it cannot be in
>  +			 * D3cold.
>   			 */
>  -			pm_status = pm_runtime_get_if_active(dev);
>  -			if (!pm_status)
>  -				continue;
>  -
>  -			if (pdev->current_state != PCI_D3cold)
>  +			if (pm_runtime_suspended(dev) &&
>  +			    pdev->current_state != PCI_D3cold)
>   				pci_pme_wakeup(pdev, NULL);
>   
>  -			if (pm_status > 0)
>  -				pm_runtime_put(dev);
>  +put_bridge:
>  +			if (bref > 0)
>  +				pm_runtime_put(bdev);
>   		} else {
>   			list_del(&pme_dev->list);
>   			kfree(pme_dev);



