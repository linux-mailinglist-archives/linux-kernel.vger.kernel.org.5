Return-Path: <linux-kernel+bounces-120006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FDC88D00A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62D81C66E00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B04F13D88F;
	Tue, 26 Mar 2024 21:29:36 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55E21EF1D;
	Tue, 26 Mar 2024 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488575; cv=none; b=aKohSaTNrfwkws77JoRMjZyKjq/EWEnnwnKPE5GB8GeQQkHM6t2xOI58BGw+TYIc+L+surC2XT0SZjXIVIh+hyAo5QQ6sm6/8k8aJJhf9e4YBbSWULt/Efvq30rPI79DH+v33hoobqXHWz9cN5mEv17Q/zyHbKcf73HZ3y6jKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488575; c=relaxed/simple;
	bh=62GPZHht6GgI2gK0JfrPxZscKZqKq+v0X1W+kOlbbLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5CmrxEqhw8I7VV2Tr1A08x22nf/eQVDah57zFaVhJom1jllNJPMyh5Ofw+rJn2tnGj2qAYnYmly87ZwD3u+ynRuzu3fFuVGA7gkWLn3q8Enut3BpNzw8eI5QRGrjxmDEy3i0Z5cdR88N82ntYuO5XOeldn1EkpCtgwwkCJAR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rpELV-00030a-3A;
	Tue, 26 Mar 2024 21:28:38 +0000
Date: Tue, 26 Mar 2024 21:28:33 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>
Cc: Diping Zhang <diping.zhang@gl-inet.com>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Jieying Zeng <jieying.zeng@gl-inet.com>,
	Chad Monroe <chad.monroe@adtran.com>,
	Adam Fox <adam.fox@adtran.com>, John Crispin <john@phrozen.org>,
	Felix Fietkau <nbd@nbd.name>,
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
Message-ID: <ZgM-AR1BFU_FPaXh@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
 <20240325151046.GA3591150-robh@kernel.org>
 <ZgGaay6bLFAcCo2E@makrotopia.org>
 <20240326202449.GA3255378-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326202449.GA3255378-robh@kernel.org>

Hi Rob,

On Tue, Mar 26, 2024 at 03:24:49PM -0500, Rob Herring wrote:
> +boot-architecture list

Good idea, thank you :)

> 
> On Mon, Mar 25, 2024 at 03:38:19PM +0000, Daniel Golle wrote:
> > On Mon, Mar 25, 2024 at 10:10:46AM -0500, Rob Herring wrote:
> > > On Thu, Mar 21, 2024 at 07:31:48PM +0000, Daniel Golle wrote:
> > > > On embedded devices using an eMMC it is common that one or more (hw/sw)
> > > > partitions on the eMMC are used to store MAC addresses and Wi-Fi
> > > > calibration EEPROM data.
> > > > 
> > > > Implement an NVMEM provider backed by a block device as typically the
> > > > NVMEM framework is used to have kernel drivers read and use binary data
> > > > from EEPROMs, efuses, flash memory (MTD), ...
> > > > 
> > > > In order to be able to reference hardware partitions on an eMMC, add code
> > > > to bind each hardware partition to a specific firmware subnode.
> > > > 
> > > > Overall, this enables uniform handling across practially all flash
> > > > storage types used for this purpose (MTD, UBI, and now also MMC).
> > > > 
> > > > As part of this series it was necessary to define a device tree schema
> > > > for block devices and partitions on them, which (similar to how it now
> > > > works also for UBI volumes) can be matched by one or more properties.
> > > > 
> > > > ---
> > > > This series has previously been submitted as RFC on July 19th 2023[1]
> > > > and most of the basic idea did not change since. Another round of RFC
> > > > was submitted on March 5th 2024[2] which has received overall positive
> > > > feedback and only minor corrections have been done since (see
> > > > changelog below).
> > > 
> > > I don't recall giving positive feedback.
> > > 
> > > I still think this should use offsets rather than partition specific 
> > > information. Not wanting to have to update the offsets if they change is 
> > > not reason enough to not use them.
> > 
> > Using raw offsets on the block device (rather than the partition)
> > won't work for most existing devices and boot firmware out there. They
> > always reference the partition, usually by the name of a GPT
> > partition (but sometimes also PARTUUID or even PARTNO) which is then
> > used in the exact same way as an MTD partition or UBI volume would be
> > on devices with NOR or NAND flash.
> 
> MTD normally uses offsets hence why I'd like some alignment. UBI is 
> special because raw NAND is, well, special.

I get the point and in a way this is also already intended and
supported by this series. You can already just add an 'nvmem-layout'
node directly to a disk device rather than to a partition and define a
layout in this way.

Making this useful in practice will require some improvements to the
nvmem system in Linux though, because that currently uses signed 32-bit
integers as addresses which is not sufficient for the size of the
user-part of an eMMC. However, that needs to be done then and should
of course not be read as an excuse.

> 
> > Just on eMMC we usually use a GPT
> > or MBR partition table rather than defining partitions in DT or cmdline,
> > which is rather rare (for historic reasons, I suppose, but it is what it
> > is now).
> 
> Yes, I understand how eMMC works. I don't understand why if you have 
> part #, uuid, or name you can't get to the offset or vice-versa. You 
> need only 1 piece of identification to map partition table entries to DT 
> nodes.

Yes, either of them (or a combination) is fine. In practise I've mostly
seen PARTNAME as identifier used in userland scripts, and only adding
this for now will probably cover most devices (and existing boot firmware)
out there. Notable exceptions are devices which are using MBR partitions
because the BootROM expects the bootloader to be at the same block as
we would usually have the primary GPT. In this case we can only use the
PARTNO, of course, and it stinks.
MediaTek's MT7623A/N is such an example, but it's a slingly outdated
and pretty weird niche SoC I admit.

> Sure, offsets can change, but surely the firmware can handle 
> adjusting the DT? 

Future firmware may be able to do this, of course. Current existing
firmware already out there on devices such as the quite popular
GL.iNet MT-6000, Netgear's Orbi and Orbi Pro series as well as all
Adtran SmartRG devices does not. Updating or changing the boot
firmware of devices already out there is not intended and quite
challenging, and will make the device incompatible with its vendor
firmware. Hence it would be better to support replacing only the
Linux-based firmware (eg. with OpenWrt or even Debian or any
general-purpose Linux, the eMMC is large enough...) while not having
to touch the boot firmware (and risking to brick the device if that
goes wrong).

Personally, I'm rather burdened and unhappy with vendor attempts to
have the boot firmware mess around too much in (highly customized,
downstream) DT, it may look like a good solution at the moment, but
can totally become an obstacle in an unpredictable future (no offense
ASUS...)

> 
> An offset would also work for the case of random firmware data on the 
> disk that may or may not have a partition associated with it. There are 
> certainly cases of that. I don't think we have much of a solution for 
> that other than trying to educate vendors to not do that or OS 
> installers only supporting installing to something other than eMMC. This 
> is something EBBR[1] is trying to address.

Absolutely. Actually *early* GL-iNet devices did exactly that: Use the
eMMC boot hw-partitions to store boot firmware as well as MAC
addresses and potentially also Wi-Fi calibration data.

The MT-2500 is the example I'm aware of and got sitting on my desk for
testing with this very series (which allows to also reference eMMC
hardware partitions, see "[7/8] mmc: block: set fwnode of disk
devices").
Unfortunately later devices such the the flag-ship MT-6000 moved MAC
addresses and WiFi-EEPROMs into a GPT partition on the user-part of
the eMMC.

> 
> > Depending on the eMMC chip used, that partition may not even be at the
> > same offset for different batches of the same device and hence I'd
> > like to just do it in the same way vendor firmware does it as well.
> 
> Often vendor firmware is not a model to follow...

I totally agree. However, I don't see a good reason for not supporting
those network-appliance-type embedded devices which even ship with
(outdated, downstream) Linux by default while going through great
lengths for things like broken ACPI tables in many laptops which
require lots of work-arounds to have features like suspend-to-disk
working, or even be able to run Linux at all.

> 
> > Chad of Adtran has previously confirmed that [1], which was the
> > positive feedback I was refering to. Other vendors like GL-iNet or
> > Netgear are doing the exact same thing.
> > 
> > As of now, we support this in OpenWrt by adding a lot of
> > board-specific knowledge to userland, which is ugly and also prevents
> > using things like PXE-initiated nfsroot on those devices.
> > 
> > The purpose of this series is to be able to properly support such devices
> > (ie. practially all consumer-grade routers out there using an eMMC for
> > storing firmware).
> > 
> > Also, those devices have enough resources to run a general purpose
> > distribution like Debian instead of OpenWrt, and all the userland
> > hacks to set MAC addresses and extract WiFi-EEPROM-data in a
> > board-specific ways will most certainly never find their way into
> > Debian. It's just not how embedded Linux works, unless you are looking
> > only at the RaspberryPi which got that data stored in a textfile
> > which is shipped by the distribution -- something very weird and very
> > different from literally all of-the-shelf routers, access-points or
> > switches I have ever seen (and I've seen many). Maybe Felix who has
> > seen even more of them can tell us more about that.
> 
> General purpose distros want to partition the disk themselves. Adding 
> anything to the DT for disk partitions would require the installer to be 
> aware of it. There's various distro folks on the boot-arch list, so 
> maybe one of them can comment.

Usually the installers are already aware to not touch partitions when
unaware of their purpose. Repartitioning the disk from scratch is not
what (modern) distributions are doing, at least the EFI System
partition is kept, as well as typical rescue/recovery partitions many
vendors put on their (Windows, Mac) laptops to allow to "factory
reset" them.

Installers usually offer to replace (or resize) the "large" partition
used by the currently installed OS instead.

And well, the DT reference to a partition holding e.g. MAC addresses
does make the installer aware of it, obviously.


Thank you for the constructive debate!


Cheers


Daniel


> 
> Rob
> 
> [1] https://arm-software.github.io/ebbr/index.html#document-chapter4-firmware-media

