Return-Path: <linux-kernel+bounces-126867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9B98941F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A3FB21AEB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6899B482EF;
	Mon,  1 Apr 2024 16:48:05 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB95481C6;
	Mon,  1 Apr 2024 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990084; cv=none; b=bMZ9wNCXyXg5HkdoaRSlqINupYquyPOSUC4QbRcrUwCZS0dlQHCm2sZkITA5xgWEcTmkQejmCIRZDJLryl9S34j7OBD5pdTFDse30KH+ixxSdAa4bvCediPjvQsv8yoGMuR9Z3r13yv/8Y0aEYzHvLvqt12fkCVfpSoLibanhQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990084; c=relaxed/simple;
	bh=804Vw/RbErS2pmzr890A96kbwN5Kbbf7T2Xg3aXgqik=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HX7eknx49X4YYDrjW9oSrSRsZUFPc1jb7IBAiSTauuzVc5Oth4pwYesVzjYmeHyxbIhBm1+aFGi42GFf4IPdYXx2UDVh1B5+0Fz32QhRK8JEkTz7PC2GiYzznyHhoK1oxRL9rV3TVbKGoAvCy6phYwJHCdCvpU/O998x3yoTSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V7cJq34QHz6K7JS;
	Tue,  2 Apr 2024 00:43:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 728E51400D9;
	Tue,  2 Apr 2024 00:47:58 +0800 (CST)
Received: from localhost (10.48.156.172) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 17:47:57 +0100
Date: Mon, 1 Apr 2024 17:47:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Syunya Ohshio
	<syunya.ohshio@atmark-techno.com>, Guido =?ISO-8859-1?Q?G=FCnther?=
	<agx@sigxcpu.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Message-ID: <20240401174756.0000786a@Huawei.com>
In-Reply-To: <Zgpt136Q2rGL-cl_@atmark-techno.com>
References: <Zd7hSOw3_zosyrn3@atmark-techno.com>
	<daed8ada-9e01-41ad-82af-5da5cbbc865c@linaro.org>
	<Zd7qz1Qte8HWieF_@atmark-techno.com>
	<20240228142441.00002a79@Huawei.com>
	<Zd_zB_ymxkx0HB3q@atmark-techno.com>
	<ZfPg-nMANUtBlr6S@atmark-techno.com>
	<CAMknhBG_kJx8JPvTBQo7zpy3mFAkUjZpRY3DLBfXt+39nRJWiA@mail.gmail.com>
	<ZfejyEvPIncygKJ9@atmark-techno.com>
	<20240318122953.000013f3@Huawei.com>
	<20240331152042.394b4289@jic23-huawei>
	<Zgpt136Q2rGL-cl_@atmark-techno.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 1 Apr 2024 17:18:31 +0900
Dominique Martinet <dominique.martinet@atmark-techno.com> wrote:

> Jonathan Cameron wrote on Sun, Mar 31, 2024 at 03:20:42PM +0100:
> > Hi, got back to this finally...  
> 
> Thank you for taking the time to express your thoughts!
> 
> > So the problems compared to other 'alias' users is that IIO is a bit more
> > complex than for example LEDs.  A single DT node/compatible (or equivalent) can
> > result in a 1+ IIO devices and 1+ triggers.  
> 
> Right. I'm no longer really arguing for it at this point, but for
> comparison in the patch I sent, the alias sets the start of the idr for
> the device index, so if you have a driver that creates two IIO devices
> you could just "reserve" two for this DT node and assuming the order
> within this node is constant you'd still get constant numbering, so I
> think it still somewhat holds up here.
> 
> For triggers though the numbers are separate and it wouldn't make sense
> to use the same alias, if we wanted a coherent design with this we'd
> need to add a second alias (such as iio_trigger = ..), but that makes
> much less sense to me given they're also likely to be dynamically
> instancied via configfs from what I've seen; I wouldn't want to do this
> kind of mapping, so I agree with you.
> 
> > So I've messed around a bit and can think of various possible options to make
> > this simpler.
> > 1) Use a tmpfs mount and link from that.
> >    Now we 'could' put an alias directory somewhere under /sys/bus/iio/ that
> >    is a mount point created via sysfs_create_mount_point() - I abused the
> >    /sys/kernel/debug directory to test this (unmounted debugfs and mounted
> >    a tmpfs).  That would provide somewhere in sysfs that allows suitable
> >    links. However, this is unusual so likely to be controversial.  
> 
> Agreed that's probably not something we want to put our hands into.
> 
> > 2) Alternatively the relevant platform could create one of these somewhere
> >    outside of sysfs and use udev rules to create the links.  
> 
> I'm not sure I understood this one, something akin to the udev rules
> I've showed that made links to the /sys iio device in /dev?
> "relevant platform" here would be vendors?

Yes.  Just somewhere other than /dev because I agree that feels wrong.
> 
> > 3) Stick to the oddity of doing it under /dev/
> > 4) Access the things in the first place via more stable paths?
> >   /sys/bus/i2c/devices/i2c-0/0-0008/iio\:device?/ etc 
> >    Relying on the alias support for i2c bus numbering to make that stable should work
> >    and if you are sure there will only be one entry (most devices) that matches
> >    the wild card, should be easy enough to use in scripts.
> > 
> > My personal preference is this last option.  Basically if you want stable paths
> > don't use /sys/bus/iio/devices/ to get them.  
> 
> Hmm, I wouldn't call that path stable given the '?' portion can change,
> but at least that certainly is a single glob away so it's definitely
> simpler than checking every labels all the time.

Agreed - this does rely on that wildcard.

> 
> My second nitpick with this is that while these paths are stable for a
> given kernel version, but we've had some paths changes over many years
> (not sure if it was 3.14 or 4.9 but one of these perhaps didn't have
> /sys/devices/platform yet? and things got moved there at some point with
> some subtle name changes, breaking a couple of scripts).
> OTOH /sys/bus/iio/devices feels less likely to change, but I guess this
> is something that'd come up on tests when preparing a new kernel anyway,
> so this is probably acceptable; I'm just thinking out loud.

Agreed they have changed in the past. Mostly a case of fixing up
devices that didn't have their parents set (there are lots of those left
- that reminds me that I was cleaning up perf drivers that do this wrong
last year and only got part way through it :(

We will keep the /sys/bus/iio/devices/ path the same and continue to
support all paths below there (there are already compatibility links
in place for buffers for example from when we added multiple buffer support).
However, sysfs docs are pretty blunt on not relying on reliable paths for
classes (and the IIO bus is effectively a class from this point of view).

> 
> 
> With that said I can't think of anything that'd work everywhere either,
> so I guess we can stick to the status-quo and I'll rediscuss what we
> want to do with coworkers.

Good luck.  If you have time it might be good to hear what you end up
with!

Thanks,

Jonathan

> 
> 
> Thanks,


