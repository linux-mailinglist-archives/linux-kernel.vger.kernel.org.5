Return-Path: <linux-kernel+bounces-150843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D48AA587
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5E01F22822
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAEC4F5EC;
	Thu, 18 Apr 2024 22:52:50 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C1286AF;
	Thu, 18 Apr 2024 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713480770; cv=none; b=lsV2BjQrMUSqcZaXbGrlyaGSWb6QTUhEZzT8kLYG0ihz9MWiUrsDePGT0mJu+CCYMGRnBS5CmvvdXZJezP157c6jgVyR1q0uiYzFOGXvmg9qaDA3XsRRgYbK4ADhIWNlLMEGO83MjaCVhn5dSoKRwAQlacb9hjkfUVQncVXAVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713480770; c=relaxed/simple;
	bh=e9cfJN8rNWU9caYstywKsUUR/GDFScyvCazNhCJrrfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJKPagMNalECQMf7/jSH/lsHSIheoSKhc7bd4GCjYiKNOVuehlnO/AV7eOHFtP93jBq+BTSCEGYnEYzzTPX3MHIW3kGTz78zxuvQzfGFzidLnSTLJCQi3cDBKA5MKn/cbaxJHwaSWKetc48ofIG8J/9Xm85h71Wo2G8n3f5jQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rxabl-00033c-35;
	Thu, 18 Apr 2024 22:51:58 +0000
Date: Thu, 18 Apr 2024 23:51:49 +0100
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
Subject: Re: [PATCH 3/8] block: add new genhd flag GENHD_FL_NVMEM
Message-ID: <ZiGkBXIXfFP0pv_N@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
 <89abd9ab93783da0e8934ebc03d66559f78f6060.1711048433.git.daniel@makrotopia.org>
 <7027ccdc-878a-420e-a7ea-5156e1d67b8a@acm.org>
 <Zf3I6DDqqyd924Ks@makrotopia.org>
 <192acb8f-47b8-426c-bcc9-ef214a797f26@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <192acb8f-47b8-426c-bcc9-ef214a797f26@acm.org>

On Fri, Mar 22, 2024 at 12:22:32PM -0700, Bart Van Assche wrote:
> On 3/22/24 11:07, Daniel Golle wrote:
> > On Fri, Mar 22, 2024 at 10:49:48AM -0700, Bart Van Assche wrote:
> > > On 3/21/24 12:33, Daniel Golle wrote:
> > > >    enum {
> > > >    	GENHD_FL_REMOVABLE			= 1 << 0,
> > > >    	GENHD_FL_HIDDEN				= 1 << 1,
> > > >    	GENHD_FL_NO_PART			= 1 << 2,
> > > > +	GENHD_FL_NVMEM				= 1 << 3,
> > > >    };
> > > 
> > > What would break if this flag wouldn't exist?
> > 
> > As both, MTD and UBI already act as NVMEM providers themselves, once
> > the user creates a ubiblock device or got CONFIG_MTD_BLOCK=y set in their
> > kernel configuration, we would run into problems because both, the block
> > layer as well as MTD or UBI would try to be an NVMEM provider for the same
> > device tree node.
> 
> Why would both MTD and UBI try to be an NVMEM provider for the same
> device tree node?

I didn't mean that both MTD and UBI would **simultanously** try to act
as NVMEM providers for the same device tree node. What I meant was
that either of them can act as an NVMEM provider while at the same time
also providing an emulated block device (mtdblock xor ubiblock).

Hence those emulated block devices will have to be excluded from acting
as NVMEM providers. In this patch I suggest to do this by opt-in of
block drivers which should potentially provide NVMEM (typically mmcblk).

I apologize for the confusion and assume that wasn't clear from the
wording I've used. I hope it's more clear now.

Alternatively it could also be solved via opt-out of ubiblock and
mtdblock devices using the inverted flag (GENHD_FL_NO_NVMEM) --
however, this has previously been criticized and I was asked to rather
make it opt-in.[1]


> Why can't this patch series be implemented such that
> a partition UUID occurs in the device tree and such that other code
> scans for that partition UUID?

This is actually one way this very series allows one to handle this:
by identifying a partition using its partuuid.

However, it's also quite common that the MMC boot **hardware**
partitions are used to store MAC addresses and/or Wi-Fi calibration
data. In this case there is no partition table and the NVMEM provider
has to act directly on the whole disk device (which is only a few
megabytes in size in case of those mmcblkXbootY devices and never has
a partition table).

[1]: https://patchwork.kernel.org/comment/25432948/

