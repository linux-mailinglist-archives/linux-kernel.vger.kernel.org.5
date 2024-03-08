Return-Path: <linux-kernel+bounces-97198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC78766CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB451F23AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7D22616;
	Fri,  8 Mar 2024 14:56:32 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216625759;
	Fri,  8 Mar 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909792; cv=none; b=Wg+FdqksQBTKXFRkrXQ0Eh6SmJJE7swi2+vJPeyflOeyAR8g8hl/kzP5HUur2ORfVtYVwAsZm3eKZ9q8Ve72P0olC7vGL+qxyD10MDVslV4ZU3RjdukQU0u2B6kyvz/Q7hHYWwWrjA69R0pzFZc4oBFI9SmWz0C22/r7YZSKEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909792; c=relaxed/simple;
	bh=duHRboSBY4Ddw2Uqw5pOeQO8eFmgv5M1iTXUTHLZn3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh6k2BL3PHZsbbVv5nyoJgmBzVxG9q2NzqUChFvetpUrOsziZP3QrN3A9QEwEb+Lz3QP7wusi12URLWzNjarqVCwOcqDcM+JMx70OyUYJYnyfPUcHlze8Z6eqpvcKJAsruFW6QxdRPLbLEEPjDgv0nsiMzHruH7gNeYZdcxQH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ribdU-0000Wt-1o;
	Fri, 08 Mar 2024 14:55:48 +0000
Date: Fri, 8 Mar 2024 14:55:44 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Brauner <brauner@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Bean Huo <beanhuo@micron.com>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Diping Zhang <diping.zhang@gl-inet.com>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Jieying Zeng <jieying.zeng@gl-inet.com>,
	Chad Monroe <chad.monroe@adtran.com>,
	Adam Fox <adam.fox@adtran.com>, John Crispin <john@phrozen.org>
Subject: Re: [RFC PATCH v2 6/8] mmc: core: set card fwnode_handle
Message-ID: <Zesm8FhoVrVbvbwe@makrotopia.org>
References: <cover.1709667858.git.daniel@makrotopia.org>
 <055787bb6085c32907ee1772522a6bfa49d5d2ef.1709667858.git.daniel@makrotopia.org>
 <DM6PR04MB6575C0FB6376681697C97DE8FC272@DM6PR04MB6575.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB6575C0FB6376681697C97DE8FC272@DM6PR04MB6575.namprd04.prod.outlook.com>

On Fri, Mar 08, 2024 at 08:04:54AM +0000, Avri Altman wrote:
>  
> > Set fwnode in case it isn't set yet and of_node is present.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/mmc/core/bus.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c index
> > 0ddaee0eae54f..e1c5fc1b3ce4b 100644
> > --- a/drivers/mmc/core/bus.c
> > +++ b/drivers/mmc/core/bus.c
> > @@ -364,6 +364,8 @@ int mmc_add_card(struct mmc_card *card)
> > 
> >         mmc_add_card_debugfs(card);
> >         card->dev.of_node = mmc_of_find_child_device(card->host, 0);
> > +       if (card->dev.of_node && !card->dev.fwnode)
> > +               card->dev.fwnode = &card->dev.of_node->fwnode;
> Should this be restricted to eMMC only, or is it fine to be called for SD as well?

It's always odd to have of_node set and fwnode unset. And also SD
cards can be referenced in device tree, resulting in of_node being set
but fwnode being unpopulated, which is no more or less weird than for
an eMMC.

So imho it should always be called and shouldn't hurt.

