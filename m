Return-Path: <linux-kernel+bounces-117394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FF888AAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552D41C2C692
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6248A13CFA9;
	Mon, 25 Mar 2024 15:39:16 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54587174F;
	Mon, 25 Mar 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381153; cv=none; b=lhHuHyRzJ9d7LZ3iBN1RO5fNH0mCxXil1TLptS/SGulIaWsd4b4hk323FoEFjD2KzpWzGENSIbLQMKenP+VtPCoJ/nLDEYCr7hpUJczrCN+frRSPIBwqy1UXfq3kJE+qSM4ignWjD9DQSKk0Ic8kdDnMo/qDkgsT7B16xRlxv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381153; c=relaxed/simple;
	bh=nknJYIONB75PX2/X0Pvf2Ghs0Wtg0AtN05Shf/1SaGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBqO8PXjDNvYRvYykTDeP3FCp0Fq9CWMKVxTflo/nCevpOlMKiFJgTWA7zVAdiHSFpzvkLymDlVwHZ43a+1ApPBlGwb8JAePIf4KrlKibESQJ/7N7aRLPnzzL3mRA7c4GsdnUKjPoktfuWM0HYU45hvxnyDEn2dAovPCGoK/1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1romP3-0002bd-2M;
	Mon, 25 Mar 2024 15:38:25 +0000
Date: Mon, 25 Mar 2024 15:38:19 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Message-ID: <ZgGaay6bLFAcCo2E@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
 <20240325151046.GA3591150-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325151046.GA3591150-robh@kernel.org>

On Mon, Mar 25, 2024 at 10:10:46AM -0500, Rob Herring wrote:
> On Thu, Mar 21, 2024 at 07:31:48PM +0000, Daniel Golle wrote:
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
> > 
> > ---
> > This series has previously been submitted as RFC on July 19th 2023[1]
> > and most of the basic idea did not change since. Another round of RFC
> > was submitted on March 5th 2024[2] which has received overall positive
> > feedback and only minor corrections have been done since (see
> > changelog below).
> 
> I don't recall giving positive feedback.
> 
> I still think this should use offsets rather than partition specific 
> information. Not wanting to have to update the offsets if they change is 
> not reason enough to not use them.

Using raw offsets on the block device (rather than the partition)
won't work for most existing devices and boot firmware out there. They
always reference the partition, usually by the name of a GPT
partition (but sometimes also PARTUUID or even PARTNO) which is then
used in the exact same way as an MTD partition or UBI volume would be
on devices with NOR or NAND flash. Just on eMMC we usually use a GPT
or MBR partition table rather than defining partitions in DT or cmdline,
which is rather rare (for historic reasons, I suppose, but it is what it
is now).

Depending on the eMMC chip used, that partition may not even be at the
same offset for different batches of the same device and hence I'd
like to just do it in the same way vendor firmware does it as well.

Chad of Adtran has previously confirmed that [1], which was the
positive feedback I was refering to. Other vendors like GL-iNet or
Netgear are doing the exact same thing.

As of now, we support this in OpenWrt by adding a lot of
board-specific knowledge to userland, which is ugly and also prevents
using things like PXE-initiated nfsroot on those devices.

The purpose of this series is to be able to properly support such devices
(ie. practially all consumer-grade routers out there using an eMMC for
storing firmware).

Also, those devices have enough resources to run a general purpose
distribution like Debian instead of OpenWrt, and all the userland
hacks to set MAC addresses and extract WiFi-EEPROM-data in a
board-specific ways will most certainly never find their way into
Debian. It's just not how embedded Linux works, unless you are looking
only at the RaspberryPi which got that data stored in a textfile
which is shipped by the distribution -- something very weird and very
different from literally all of-the-shelf routers, access-points or
switches I have ever seen (and I've seen many). Maybe Felix who has
seen even more of them can tell us more about that.


[1]: https://patchwork.kernel.org/project/linux-block/patch/f70bb480aef6f55228a25ce20ff0e88e670e1b70.1709667858.git.daniel@makrotopia.org/#25756072

