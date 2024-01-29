Return-Path: <linux-kernel+bounces-43226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D6E84111C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6191F26906
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A18F3F9D8;
	Mon, 29 Jan 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KZdkwnlD"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87A13F9CC;
	Mon, 29 Jan 2024 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550378; cv=none; b=f/jhAN8bDcXC4QK1faEp9I5Tg8hbcUkwcG1UEWM6A9jk8HtoeeaHHmPJPMPs7dGoCMZGc3Fl7vBVq6+PE9VjReasM+RH9cNoMlXtwUBpoNob6BvgPgE5kCcN1IjGmcpWb1XlxAwPCXRpW74TCc3LKjB2arICjS+vnRsh9cu2P/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550378; c=relaxed/simple;
	bh=s93DASLXzgaSLrX3kPwTzofL6DaVYy0uKoz5AbAVS2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t43FGZ/L4aANV1RSVsxuJEy85qTn74s49xuTLfdniG3/v5Ij7r7uUZXuohGX+8sg6wooBP+7lnpf1KafXmSxDPG5ca/n6GeFKX1MD8Xg55rpLPQJrsPbSUo2i7aAVzx/MeNjEn58uiFTHAqOHzSRPaS0kz8jqpXXISTAB+3/KbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KZdkwnlD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=12CzKYhCfKqun2A4domPiemnWWbzqM+PUv+a4ErseME=; b=KZdkwnlDbT8eAW0GrcflfnrVvu
	VTXDUzAwpieANDEa8k07vlipq2o51Z+841CgkuOYWEQ4ZKHIb2+uc020A/uT7Bx9kgKYcbYhth221
	pwsr9Awh2PT9ZiUDrf4Imbjz8Cybrt/iX9lbNuN/pDIzRoR/Og1MYp2UjImIPiQrjQY26Ai2UTpUC
	d0iCIno+oxBxqcz1pfcr5QH0K20E8ffubEviROc46EXkUTwGzqP1+6LCOPO5MDTW1gsQ4boAok3Zm
	UG/wcvj9VJ/Beeaukhh42tbiAEuYp9zASeJ8NAahEpxzZ3qQnXCL8q1OAUom8grZOoHRIEm6DQuDo
	GJGVUx7A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUVi3-0000000Dn65-2Waj;
	Mon, 29 Jan 2024 17:46:15 +0000
Date: Mon, 29 Jan 2024 09:46:15 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linan666@huaweicloud.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linan122@huawei.com,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] scsi: sd: unregister device if device_add_disk() failed
 in sd_probe()
Message-ID: <ZbfkZxMVpVI97zmk@bombadil.infradead.org>
References: <20231208082335.1754205-1-linan666@huaweicloud.com>
 <ZYUxZc/my2v6UfFJ@bombadil.infradead.org>
 <78fb6d82-c50a-8fea-ae6d-551fd35656bf@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78fb6d82-c50a-8fea-ae6d-551fd35656bf@huaweicloud.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Dec 22, 2023 at 04:27:16PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/12/22 14:49, Luis Chamberlain 写道:
> > On Fri, Dec 08, 2023 at 04:23:35PM +0800, linan666@huaweicloud.com wrote:
> > > From: Li Nan <linan122@huawei.com>
> > > 
> > > "if device_add() succeeds, you should call device_del() when you want to
> > > get rid of it."
> > > 
> > > In sd_probe(), device_add_disk() fails when device_add() has already
> > > succeeded, so change put_device() to device_unregister() to ensure device
> > > resources are released.
> > > 
> > > Fixes: 2a7a891f4c40 ("scsi: sd: Add error handling support for add_disk()")
> > > Signed-off-by: Li Nan <linan122@huawei.com>
> > 
> > Nacked-by: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > > ---
> > >   drivers/scsi/sd.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > > index 542a4bbb21bc..d81cbeee06eb 100644
> > > --- a/drivers/scsi/sd.c
> > > +++ b/drivers/scsi/sd.c
> > > @@ -3736,7 +3736,7 @@ static int sd_probe(struct device *dev)
> > >   	error = device_add_disk(dev, gd, NULL);
> > >   	if (error) {
> > > -		put_device(&sdkp->disk_dev);
> > > +		device_unregister(&sdkp->disk_dev);
> > >   		put_disk(gd);
> > >   		goto out;
> > >   	}
> > 
> > This is incorrect, device_unregister() calls:
> > 
> > void device_unregister(struct device *dev)
> > {
> > 	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
> > 	device_del(dev);
> > 	put_device(dev);
> > }
> > 
> > So you're adding what you believe to be a correct missing device_del().
> > But what you missed is that if device_add_disk() fails then device_add()
> > did not succeed because the new code we have in the kernel *today* unwinds
> > this for us now.
> 
> I'm confused here, there are two device here, one is 'sdkp->disk_dev',
> one is gendisk->part0->bd_device, and the order in which they
> initialize:
> 
> sd_probe
> device_add(&sdkp->disk_dev) -> succeed
> device_add_disk -> failed, and device_add(bd_device) did not succeed
> put_device(&sdkp->disk_dev) -> device_del is missed
> 
> I don't see that if device_add_disk() fail, device_del() for
> 'sdkp->disk_dev'is called from anywhere. Do I missing anything?

Ah then the fix is still incorrect and the commit log should
describe that this is for another device.

How about this instead?

From c3f6e03f4a82aa253b6c487a293dcd576393b606 Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Mon, 29 Jan 2024 09:25:18 -0800
Subject: [PATCH] sd: remove extra put_device() for extra scsi device

The sd driver first device_add() its own device, and later use
device_add_disk() with another device. When we added error handling
for device_add_disk() we now call put_disk() and that will trigger
disk_release() when the refcount is 0. That will end up calling
the block driver's disk->fops->free_disk() if one is defined. The
sd driver has scsi_disk_free_disk() as its free_disk() and that
does the proper put_device(&sdkp->disk_dev) for us so we should not
need to call it, however we are left still missing the device_del()
for it.

While at it, unwind with scsi_autopm_put_device(sdp) *prior* to
putting to device as we do in sd_remove().

Reported-by: Li Nan <linan122@huawei.com>
Reported-by: Yu Kuai <yukuai1@huaweicloud.com>
Fixes: 2a7a891f4c40 ("scsi: sd: Add error handling support for add_disk()")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/scsi/sd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 7f949adbadfd..6475a3c947f8 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3693,8 +3693,9 @@ static int sd_probe(struct device *dev)
 
 	error = device_add(&sdkp->disk_dev);
 	if (error) {
+		scsi_autopm_put_device(sdp);
 		put_device(&sdkp->disk_dev);
-		goto out;
+		return error;
 	}
 
 	dev_set_drvdata(dev, sdkp);
@@ -3734,9 +3735,10 @@ static int sd_probe(struct device *dev)
 
 	error = device_add_disk(dev, gd, NULL);
 	if (error) {
-		put_device(&sdkp->disk_dev);
+		scsi_autopm_put_device(sdp);
+		device_del(&sdkp->disk_dev);
 		put_disk(gd);
-		goto out;
+		return error;
 	}
 
 	if (sdkp->security) {
-- 
2.42.0

