Return-Path: <linux-kernel+bounces-111916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2E688729B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508011C20B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D032626AB;
	Fri, 22 Mar 2024 18:08:09 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88255A0EE;
	Fri, 22 Mar 2024 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130888; cv=none; b=bph+S9D8eZMwMvVY6bA1JnCHAUUtOPszp/HAu85TGTr4zuc7vXhqbfnjv4/rUjy+WlbfGtRdbAmQI+lNsrVcR4L5kNKaPkSs/Xa/PGLxr6hgFkUtu0XZD/ZsdPtaKj/05eYbJ/0ujSCDFnHa8C/WnNi5GKT7NthACx+bjKTEMbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130888; c=relaxed/simple;
	bh=KiwcN6OXG4cAG14WcslHNhcajsRkQ9j3y5Cu1CHHcik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mye19LDdG+7+l2epbCG44/PXoyURjsXoSNT32uenVF+y4AoQUvl0ltV4U0vPXAPj7nqZo8u+NuOo4SsxPorsnkvCqu/34oRRkD49KKCoWIfUbtYoXXvCl1kCtmss9nT/GTwFcTzG3xOtmnaHQnKFz+OGUXua4D3ySnHHoVd+PJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnjIq-0005aI-0F;
	Fri, 22 Mar 2024 18:07:40 +0000
Date: Fri, 22 Mar 2024 18:07:36 +0000
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
Message-ID: <Zf3I6DDqqyd924Ks@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
 <89abd9ab93783da0e8934ebc03d66559f78f6060.1711048433.git.daniel@makrotopia.org>
 <7027ccdc-878a-420e-a7ea-5156e1d67b8a@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7027ccdc-878a-420e-a7ea-5156e1d67b8a@acm.org>

On Fri, Mar 22, 2024 at 10:49:48AM -0700, Bart Van Assche wrote:
> On 3/21/24 12:33, Daniel Golle wrote:
> > Add new flag to destinguish block devices which may act as an NVMEM
> > provider.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >   include/linux/blkdev.h | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index c3e8f7cf96be9..f2c4f280d7619 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -81,11 +81,13 @@ struct partition_meta_info {
> >    * ``GENHD_FL_NO_PART``: partition support is disabled.  The kernel will not
> >    * scan for partitions from add_disk, and users can't add partitions manually.
> >    *
> > + * ``GENHD_FL_NVMEM``: the block device should be considered as NVMEM provider.
> >    */
> >   enum {
> >   	GENHD_FL_REMOVABLE			= 1 << 0,
> >   	GENHD_FL_HIDDEN				= 1 << 1,
> >   	GENHD_FL_NO_PART			= 1 << 2,
> > +	GENHD_FL_NVMEM				= 1 << 3,
> >   };
> 
> What would break if this flag wouldn't exist?

As both, MTD and UBI already act as NVMEM providers themselves, once
the user creates a ubiblock device or got CONFIG_MTD_BLOCK=y set in their
kernel configuration, we would run into problems because both, the block
layer as well as MTD or UBI would try to be an NVMEM provider for the same
device tree node.

I intially suggested the invert of this flag, GENHD_FL_NO_NVMEM which
would be set only for mtdblock and ubiblock devices to opt-out of acting
as NVMEM proviers. However, in a previous comment [1] on the RFC it was
requested to make this opt-in instead.

[1]: https://patchwork.kernel.org/comment/25432948/

