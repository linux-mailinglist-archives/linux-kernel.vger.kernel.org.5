Return-Path: <linux-kernel+bounces-111909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68C6887281
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A79289C53
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD89B61667;
	Fri, 22 Mar 2024 18:03:38 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7AE482F3;
	Fri, 22 Mar 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130618; cv=none; b=EiL1XxL4sGmMXTGIsah5F/5ftQy6XP3xPMhgS6mgtdeqjlwEg6IxRUKb6HIHItVPZGdyabfaGn3Pmm5HOivXwu+i0wFzmiCsc2vxLTyeHRm+JmivzZoU/s5BA/7NhSizEXkn1B6HBJqEjB9x6joDmyitptyZvSD5r2B0nf7W74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130618; c=relaxed/simple;
	bh=D1Ns2DV3olSdUJGSgYWDvM4g0A1SnXxonjtZR/pjfd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPXGKmK3PIuyfkfBiUTZaViRJQ4ioJak0y3U1x/W/jzpQw+n606aXasdCc9FV3YukHn/7Rup9Fntpm4ay4SD6zfTncozPAEQjSLUEdG90fGQRc67VXM5h+Tqa/uktRBKZVk8qC7U96c07hjA+lICAscZI4fF+bHh0NdS2xlqu2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnjEH-0005YL-1W;
	Fri, 22 Mar 2024 18:02:57 +0000
Date: Fri, 22 Mar 2024 18:02:50 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>, Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Bean Huo <beanhuo@micron.com>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/8] block: implement NVMEM provider
Message-ID: <Zf3HylHNrrj20mBO@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
 <e5fb3e70-8f3c-4dda-b642-401d9d047a03@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5fb3e70-8f3c-4dda-b642-401d9d047a03@acm.org>

On Fri, Mar 22, 2024 at 10:52:17AM -0700, Bart Van Assche wrote:
> On 3/21/24 12:31, Daniel Golle wrote:
> > On embedded devices using an eMMC it is common that one or more (hw/sw)
> > partitions on the eMMC are used to store MAC addresses and Wi-Fi
> > calibration EEPROM data.
> > 
> > Implement an NVMEM provider backed by a block device as typically the
> > NVMEM framework is used to have kernel drivers read and use binary data
> > from EEPROMs, efuses, flash memory (MTD), ...
> > 
> > In order to be able to reference hardware partitions on an eMMC, add code
> > to bind each hardware partition to a specific firmware subnode.
> > 
> > Overall, this enables uniform handling across practially all flash
> > storage types used for this purpose (MTD, UBI, and now also MMC).
> > 
> > As part of this series it was necessary to define a device tree schema
> > for block devices and partitions on them, which (similar to how it now
> > works also for UBI volumes) can be matched by one or more properties.
> 
> Since this patch series adds code that opens partitions and reads
> from partitions, can that part of the functionality be implemented in
> user space? There is already a mechanism for notifying user space about
> block device changes, namely udev.

No. Because it has to happen (e.g. for nfsroot to work) before
userland gets initiated: Without Ethernet MAC address (which if often
stored at some raw offset on a partition or hw-partition of an eMMC),
we don't have a way to use nfsroot (because that requires functional
Ethernet), hence userland won't come up. It's a circular dependency
problem which can only be addressed by making sure that everything
needed for Ethernet to come up is provided by the kernel **before**
rootfs (which can be nfsroot) is mounted.

