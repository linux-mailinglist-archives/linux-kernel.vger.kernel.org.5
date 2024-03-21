Return-Path: <linux-kernel+bounces-110637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD85B886193
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4991C21F36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9EB134CEC;
	Thu, 21 Mar 2024 20:22:52 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E081332B8;
	Thu, 21 Mar 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052571; cv=none; b=dtPak7eSbV+7cjRW7E0oxb00INeKAtR1G6DLqJAk8FOHWd1IWlndUmcV/J86+7J6ygPaPP4JkZDT75tqDT0HPp3MmdQbwpTNRZWixxzt0ppfkaWv4Tk8dX+hXM4GgIzPHT9XD++M+BKDxkwoN5jTzchSzYD18Vw4l9orWmBGCjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052571; c=relaxed/simple;
	bh=c6UtEIX10Dr+Hx/y+0/Bd09nWB7sQpI4NOWhdd+BG64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP71qdqwIEu7WLJkdyzz6RkdG+5GXxFOWZNzI+LZzO2hLZSiPoq8Ph6MY1qktKn4IaEhiAhrSoL85uNz6/vQOupZ3lqesnTgcnSqot50LTRM5J/soYdJPNIWgTD+//SZ1m7RG7/hF0etD4vRglej+UExjPJK5H1MlbAVoa9Ydik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnOvW-0000Y8-0R;
	Thu, 21 Mar 2024 20:22:14 +0000
Date: Thu, 21 Mar 2024 20:22:10 +0000
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
Subject: Re: [PATCH 4/8] block: implement NVMEM provider
Message-ID: <ZfyW8jTAgclicAWd@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
 <7555db6eb71d4ccb2b9d5ebe3b41dc34088c6316.1711048433.git.daniel@makrotopia.org>
 <e170642d-9ae8-4d5a-90d9-2837f1bcef9b@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e170642d-9ae8-4d5a-90d9-2837f1bcef9b@acm.org>

Hi Bart,

thank you for looking at the patches!

On Thu, Mar 21, 2024 at 12:44:19PM -0700, Bart Van Assche wrote:
> On 3/21/24 12:34, Daniel Golle wrote:
> > On embedded devices using an eMMC it is common that one or more partitions
> > on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
> > data. Allow referencing the partition in device tree for the kernel and
> > Wi-Fi drivers accessing it via the NVMEM layer.
> 
> Why to store calibration data in a partition instead of in a file on a
> filesystem?

First of all, it's just how it is already in the practical world out
there. The same methods for mass-production are used independently of
the type of flash memory, so vendors don't care if in Linux the flash
ends up as MMC/block (in case of an eMMC) device or MTD device (in
case of SPI-NOR, for example). I can name countless devices of
numerous vendors following this generally very common practise (and
then ending up extracting that using ugly custom drivers, or poking
around in the block devices in early userland, ... none of it is nice,
which is the motivation for this series).
Adtran, GL-iNet, Netgear, ... to name just a few very popular vendors.

The devices are already out there, and the way they store those
details is considered part of the low level firmware which will never
change. Yet it would be nice to run vanilla Linux on them (or
OpenWrt), and make sure things like NFS root can work, and for that
the MAC address needs to be in place already, ie. extracting it in
userland would be too late.

However, I also believe there is nothing wrong with that and using a
filesystem comes with many additional pitfalls, such as being possibly
not cleanly unmounted, the file could be renamed or deleted by the
user, .... All that should not result in a device not having it's
proper MAC address any more.

Why have all the complexity for something as simple as storing 6 bytes
of MAC address?

I will not re-iterate over all that discussion now, you may look at
list archives where this has been explained and discussed also for the
first run of the RFC series last year.

> 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8c88f362feb55..242a0a139c00a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3662,6 +3662,11 @@ L:	linux-mtd@lists.infradead.org
> >   S:	Maintained
> >   F:	drivers/mtd/devices/block2mtd.c
> > +BLOCK NVMEM DRIVER
> > +M:	Daniel Golle <daniel@makrotopia.org>
> > +S:	Maintained
> > +F:	block/blk-nvmem.c
> 
> Why to add this functionality to the block layer instead of somewhere
> in the drivers/ directory?

Simply because we need notifications about appearing and disappearing
block devices, or a way to iterate over all block devices in a system.
For both there isn't currently any other interface than using a
class_interface for that, and that requires access to &block_class
which is considered a block subsystem internal.

Also note that the same is true for the MTD NVMEM provider (in
drivers/mtd/mtdcore.c) as well as the UBI NVMEM provider (in
drivers/mtd/ubi/nvmem.c), both are considered an integral part of
their corresponding subsystems -- despite the fact that in those cases
this wouldn't even be stricktly needed as for MTD we got
register_mtd_user() and for UBI we'd have
ubi_register_volume_notifier().

Doing it differently for block devices would hence not only complicate
things unnessesarily, it would also be inconsistent.

