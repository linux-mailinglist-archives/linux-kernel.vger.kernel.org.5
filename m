Return-Path: <linux-kernel+bounces-100277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EAC8794E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69EB1F234D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4970C7A149;
	Tue, 12 Mar 2024 13:12:45 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA479DBD;
	Tue, 12 Mar 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249164; cv=none; b=BUoIX7aerK0kmi80Q9z1H/35+Qv0eks4Og3H4CPXkPjAInu69lPMdVbZcRHyJpZAmZqcMqdhRKUUPo8obMRyA9pYjatT+ay30wu007YoFy2VhB/sUMkq5M78Rd/UGB7L7/zz5TLbPbfCmHFoVudgfi06NKBGBzEaVpnmvHEROhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249164; c=relaxed/simple;
	bh=qw1Un7hVSUETXMazHe5VgTx1aM7+42G+J07xZ9g9/iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZKEkHeO/6ErnfPyHyvqfQTk2JAWBliNjoNgOUCjDY6xDUGmGPW2g4M+4mPSQkL9qwZ6PFmSQyjQiGm3l3HXTUTtdg3jD1j8tkGZNtdv3wfwAm87DE9hXDcFrvAJ21bmsnTILSECjFsIK/N36SH1QMPqk02bnvLcnEtGszKr2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rk1vO-00056B-2t;
	Tue, 12 Mar 2024 13:12:11 +0000
Date: Tue, 12 Mar 2024 13:12:01 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Brauner <brauner@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Avri Altman <avri.altman@wdc.com>, Bean Huo <beanhuo@micron.com>,
	Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
	Diping Zhang <diping.zhang@gl-inet.com>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Jieying Zeng <jieying.zeng@gl-inet.com>,
	Chad Monroe <chad.monroe@adtran.com>,
	Adam Fox <adam.fox@adtran.com>, John Crispin <john@phrozen.org>
Subject: Re: [RFC PATCH v2 0/8] nvmem: add block device NVMEM provider
Message-ID: <ZfBUoc5IjzxbEj7B@makrotopia.org>
References: <cover.1709667858.git.daniel@makrotopia.org>
 <CAPDyKFpQfue5Fi0fFSnqHNg2ytCxAYfORVP_Y86ucz2k5HRuDA@mail.gmail.com>
 <ZfBK5qT_GO_FgtQP@makrotopia.org>
 <CAPDyKFr7mMEZE5n=6kxxsj9P3oLjLyVx20O9q0-pmyXzXYk52A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr7mMEZE5n=6kxxsj9P3oLjLyVx20O9q0-pmyXzXYk52A@mail.gmail.com>

On Tue, Mar 12, 2024 at 01:57:39PM +0100, Ulf Hansson wrote:
> On Tue, 12 Mar 2024 at 13:30, Daniel Golle <daniel@makrotopia.org> wrote:
> >
> > Hi Ulf,
> >
> > On Tue, Mar 12, 2024 at 01:22:49PM +0100, Ulf Hansson wrote:
> > > On Tue, 5 Mar 2024 at 21:23, Daniel Golle <daniel@makrotopia.org> wrote:
> > > >
> > > > On embedded devices using an eMMC it is common that one or more (hw/sw)
> > > > partitions on the eMMC are used to store MAC addresses and Wi-Fi
> > > > calibration EEPROM data.
> > > >
> > > > Implement an NVMEM provider backed by block devices as typically the
> > > > NVMEM framework is used to have kernel drivers read and use binary data
> > > > from EEPROMs, efuses, flash memory (MTD), ...
> > > >
> > > > In order to be able to reference hardware partitions on an eMMC, add code
> > > > to bind each hardware partition to a specific firmware subnode.
> > > >
> > > > This series is meant to open the discussion on how exactly the device
> > > > tree schema for block devices and partitions may look like, and even
> > > > if using the block layer to back the NVMEM device is at all the way to
> > > > go -- to me it seemed to be a good solution because it will be reuable
> > > > e.g. for (normal, software GPT or MBR) partitions of an NVMe SSD.
> > > >
> > > > This series has previously been submitted on July 19th 2023[1] and most of
> > > > the basic idea did not change since.
> > > >
> > > > However, the recent introduction of bdev_file_open_by_dev() allow to
> > > > get rid of most use of block layer internals which supposedly was the
> > > > main objection raised by Christoph Hellwig back then.
> > > >
> > > > Most of the other comments received for in the first RFC have also
> > > > been addressed, however, what remains is the use of class_interface
> > > > (lacking an alternative way to get notifications about addition or
> > > > removal of block devices from the system). As this has been criticized
> > > > in the past I'm specifically interested in suggestions on how to solve
> > > > this in another way -- ideally without having to implement a whole new
> > > > way for in-kernel notifications of appearing or disappearing block
> > > > devices...
> > > >
> > > > And, in a way just like in case of MTD and UBI, I believe acting as an
> > > > NVMEM provider *is* a functionality which belongs to the block layer
> > > > itself and, other than e.g. filesystems, is inconvenient to implement
> > > > elsewhere.
> > >
> > > I don't object to the above, however to keep things scalable at the
> > > block device driver level, such as the MMC subsystem, I think we
> > > should avoid having *any* knowledge about the binary format at these
> > > kinds of lower levels.
> > >
> > > Even if most of the NVMEM format is managed elsewhere, the support for
> > > NVMEM partitions seems to be dealt with from the MMC subsystem too.
> >
> > In an earlier iteration of this RFC it was requested to make NVMEM
> > support opt-in (instead of opt-out for mtdblock and ubiblock, which
> > already got their own NVMEM provider implementation).
> > Hence at least a change to opt-in for NVMEM support is required in the
> > MMC subsystem, together with making sure that MMC devices have their
> > fwnode assigned.
> 
> So, the NVMEM support needs to be turned on (opt-in) for each and
> every block device driver?
> 
> It's not a big deal for me - and I would be happy to apply such a
> change. On the other hand, it is just some binary data that is stored
> on the flash, why should MMC have to opt-in or opt-out at all? It
> should be the upper layers who decide what to store on the flash, not
> the MMC subsystem, if you get my point.
> 

I agree, and that's exactly how I originally wrote it. However, in the
first round of rewiew it was requested to be in that way (ie. opt-in
for each subsystem; rather than opt-out for subsystems already
providing NVMEM in another way, such as MTD or UBI), see here:

https://patchwork.kernel.org/comment/25432948/

> >
> > > Why can't NVMEM partitions be managed the usual way via the MBR/GPT?
> >
> > Absolutely, maybe my wording was not clear, but that's exactly what
> > I'm suggesting here. There are no added parsers nor any knowledge
> > about binary formats in this patchset.
> 
> Right, but there are new DT bindings added in the $subject series that
> allows us to describe NVMEM partitions for an eMMC. Why isn't that
> parsed from the MBR/GPT, etc, rather than encoded in DT?

The added dt-bindings merely allow to **identify** the partition by
it's PARTNAME, PARTNO or PARTUUID, so we can reference them in DT.
We'd still rely on MBR or GPT to do the actual parsing of the on-disk
format.

> 
> >
> > Or did I misunderstand your comment?
> 
> Maybe. I am just trying to understand this, so apologize if you find
> my questions silly. :-)

Let's make sure to all be on the same page and everything is fully
understood by everyone. Everyone has to bare the noise, but I guess
that's ok ;)


Cheers


Daniel

