Return-Path: <linux-kernel+bounces-110604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA45886130
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A761C2255E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4F1353F5;
	Thu, 21 Mar 2024 19:36:25 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC83134738;
	Thu, 21 Mar 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049784; cv=none; b=gMbFQYj6DgHPkYgUlL8XAM4AYlCRugrnwzMspTRY3cO433PHD/3AoXXEmfwM6XBdzWLBaKoWk+lofI6XRy4sR5QkjbcG2/Dm/CH4vPe+Pu5DxOfhGMCM4wzCKNs8y6hNWsMekggSWkBml/7lME+LX3L04y7uyAv0kLrDZq87PmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049784; c=relaxed/simple;
	bh=75x//W7RDIHAUZfwPjE9NS58D1kinAORLhAfTLl8XUI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8f8sFLh5U0Fiwddiy5e8UjkspWVmKZ19Uo54H61rLpWBrC3urQZ75wy8c10h/mwMHP/9qAmp09Vsz9prx0J40DL2k4geBtyLsdDDYEDRVViI0Tl2Hq0Sjb5s6yQp6Oe0Z7PkZ5FIr5zHam+f1fNmPifDt2cjuUU+8ycThkMgLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnOCt-0000LF-0j;
	Thu, 21 Mar 2024 19:36:07 +0000
Date: Thu, 21 Mar 2024 19:36:03 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Daniel Golle <daniel@makrotopia.org>,
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
Subject: [PATCH 8/8] mmc: block: set GENHD_FL_NVMEM
Message-ID: <8c10008a7be4664920db332d4baef5755d92531e.1711048433.git.daniel@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1711048433.git.daniel@makrotopia.org>

Set flag to consider MMC block devices as NVMEM providers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mmc/core/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 5b7dfd4a21fa5..157e6d0aed495 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2516,6 +2516,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->disk->major	= MMC_BLOCK_MAJOR;
 	md->disk->minors = perdev_minors;
 	md->disk->first_minor = devidx * perdev_minors;
+	md->disk->flags = GENHD_FL_NVMEM;
 	md->disk->fops = &mmc_bdops;
 	md->disk->private_data = md;
 	md->parent = parent;
-- 
2.44.0

