Return-Path: <linux-kernel+bounces-117405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DFC88AAED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72011C3B8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDBD140391;
	Mon, 25 Mar 2024 15:46:53 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6A913E8BF;
	Mon, 25 Mar 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381612; cv=none; b=mtNQeHaOcepL3ocX67vPqH0whnWw5fViBf4Lds2aNBZhKVEmkyul7QrMT6anHjAfgW6cM/Ljgdc6DLZ/aknd1S9tQ0/tipN1bH3TMXY4LOQUT/mStUJCFByvLWSuzotBIdWA1Dzk1ISnf6kEwTAtwJY63aGN3gczSWdQF2g14Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381612; c=relaxed/simple;
	bh=GzSXXAtn+MG9MXEBydJA28ph4fycU10z4qRFnMd2PPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0UA+8jHgSaJssZqSmpm77krzrTugaU/1e27IlVe9WSSpMcE9R5lP/zrT1g4VfhC2BmJ2+g117YtIoWmrXDkYs4OrTDMBFV4m0e1U0oHa0T0oEzYnfLR6XISKcmoxXnN4rxjcL5mec8Oa+LnU04E6wkfTE5pmXDXrqxL9iopprg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1romWj-0002mZ-1Y;
	Mon, 25 Mar 2024 15:46:21 +0000
Date: Mon, 25 Mar 2024 15:46:17 +0000
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
Message-ID: <ZgGcSclcPMlXiPLV@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
 <20240325151259.GB3591150-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325151259.GB3591150-robh@kernel.org>

On Mon, Mar 25, 2024 at 10:12:59AM -0500, Rob Herring wrote:
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
> Also, please version your patches. 'RFC' is a tag, not a version. v1 was
> July. v2 was March 5th. This is v3.

According to "Submitting patches: the essential guide to getting your
code into the kernel" [1] a version is also a tag.

Quote:
 Common tags might include a version descriptor if the [sic] multiple
 versions of the patch have been sent out in response to comments
 (i.e., “v1, v2, v3”), or “RFC” to indicate a request for comments.

Maybe this should be clarified, exclusive or inclusive "or" is up to
the reader to interpret at this point, and I've often seen RFC, RFCv2,
v1, v2, ... as a sequence of tags applied for the same series, which
is why I followed what I used to believe was the most common
interpretation of the guidelines.

In any way, thank you for pointing it out, I assume the next iteration
should then be v4.

[1]: https://docs.kernel.org/process/submitting-patches.html

