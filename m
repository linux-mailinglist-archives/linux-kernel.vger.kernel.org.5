Return-Path: <linux-kernel+bounces-111922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AA48872B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7F81C20290
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58756629E0;
	Fri, 22 Mar 2024 18:12:21 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45403629E1;
	Fri, 22 Mar 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131140; cv=none; b=t42tDmnf0x8LeXB3RDr9W/2FBrw67SXSVhblcSFd6NwnE1GuMzonFdIUmUqYdTSTTlJXFJiDOhoIRMeHaZjAlbsyybqzkuZQHhHPXKn2zpoEGSpNVR6IYBszUT22Q44hH1EWBJpC0NVSn1GMyKvU9sMHXqpUuXZxuZY8MxeDCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131140; c=relaxed/simple;
	bh=0hrvSYNToT8Eq5YXROkXYwZEAFnql+3JchMf3WGhKIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Icn7e4vjsKqlySrxO/Fj7uLOlJXSiTQJ3j7BkyoSwnsBtHElyHuVmFXmyMmWg/FpZDlGJvdcP/R/RMRMJXR/v5lgNqVKD1SW7ydZXNVmK7yuf/PO3Pxv8hOB9EsroHBacnwAvb7wJWN0t/xzFs5A864znizhq2L8bmShwfp5raI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnjMx-0005ca-2P;
	Fri, 22 Mar 2024 18:11:55 +0000
Date: Fri, 22 Mar 2024 18:11:51 +0000
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
Message-ID: <Zf3J5wAgng8br6yd@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
 <7555db6eb71d4ccb2b9d5ebe3b41dc34088c6316.1711048433.git.daniel@makrotopia.org>
 <e170642d-9ae8-4d5a-90d9-2837f1bcef9b@acm.org>
 <ZfyW8jTAgclicAWd@makrotopia.org>
 <99874d1e-ff5c-4e8a-9922-752207119147@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99874d1e-ff5c-4e8a-9922-752207119147@acm.org>

On Fri, Mar 22, 2024 at 10:52:36AM -0700, Bart Van Assche wrote:
> On 3/21/24 13:22, Daniel Golle wrote:
> > On Thu, Mar 21, 2024 at 12:44:19PM -0700, Bart Van Assche wrote:
> > > Why to add this functionality to the block layer instead of somewhere
> > > in the drivers/ directory?
> > 
> > Simply because we need notifications about appearing and disappearing
> > block devices, or a way to iterate over all block devices in a system.
> > For both there isn't currently any other interface than using a
> > class_interface for that, and that requires access to &block_class
> > which is considered a block subsystem internal.
> 
> That's an argument for adding an interface to the block layer that
> implements this functionality but not for adding this code in the block
> layer.

Fine with me. I can implement such an interface, similar to how it is
implemented for MTD devices or UBI volumes for the block layer.

I would basically add a subscription and callback interface utilizing
a class_interface inside the block subsystem similar to how the same
is done in this series for registering block-device-backed NVMEM
providers.

However, given that this is a bigger task, I'd like to know from more
than one block subsystem maintainer that this approach would be
agreeable before spending time and effort in this direction.

Also note that obviously it would be much more intrusive and affect
*all* users of the block subsystem, while the current approach would
only affect those users who got CONFIG_BLOCK_NVMEM enabled.

