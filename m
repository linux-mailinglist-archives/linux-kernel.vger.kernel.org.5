Return-Path: <linux-kernel+bounces-144320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E68A4494
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5BA282AA6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF6B13664D;
	Sun, 14 Apr 2024 18:13:31 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACFC135A49;
	Sun, 14 Apr 2024 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713118411; cv=none; b=MbAYyi88erZ7Dmnp9dkv7XPeXc29BLrtcPcCaEIYcdS4a3+TnLiQvr8WSTaj29uxP6yD4oiRtdeJTZ0HMGYVw0t9UM/0wSA5BUPrKSqXYDzzYgz92Gdp7UR8Lp8EUiVjJhwpDMwr2pwQF52tJEypcELgdj/ytTWvPIdi6khH4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713118411; c=relaxed/simple;
	bh=YlNaXbRtiYNdS81J1UUqLONIiTumCVL1a8UXOuzGBdU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9Y0AmLjdv9sb6UiGl1V2tK+TItH1HBD6Sg8OPUz0uvpUtULmeKCc/3F+NpwtGe8v9R6CL3jOvLJznbyLxTtCwuUFiJZGTQaG1nceM9sF+WjA5DIispPuYU2HXg1PEWwKmOD0O+hVyODR6ZYCAEycEVGhwp3YYUIxWL05Dx896k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VHdfb1W05z689sn;
	Mon, 15 Apr 2024 02:11:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 62ECD140B38;
	Mon, 15 Apr 2024 02:13:26 +0800 (CST)
Received: from localhost (10.48.158.114) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 14 Apr
 2024 19:13:23 +0100
Date: Sun, 14 Apr 2024 19:13:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
	<andriy.shevchenko@linux.intel.com>, <ang.iglesiasg@gmail.com>,
	<mazziesaccount@gmail.com>, <ak@it-klinger.de>,
	<petre.rodan@subdimension.ro>, <phil@raspberrypi.com>, <579lpy@gmail.com>,
	<u.kleine-koenig@pengutronix.de>, <biju.das.jz@bp.renesas.com>,
	<linus.walleij@linaro.org>, <semen.protsenko@linaro.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] iio: pressure: bmp280: Various driver cleanups
Message-ID: <20240414191322.00005408@Huawei.com>
In-Reply-To: <20240414161902.GA4388@vamoiridPC>
References: <20240407172920.264282-1-vassilisamir@gmail.com>
	<20240407172920.264282-2-vassilisamir@gmail.com>
	<20240413175257.6cadbb83@jic23-huawei>
	<20240414161902.GA4388@vamoiridPC>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 14 Apr 2024 18:19:02 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sat, Apr 13, 2024 at 05:52:57PM +0100, Jonathan Cameron wrote:
> > On Sun,  7 Apr 2024 19:29:15 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > Various driver cleanups including:
> > >   
> > Not sure how we got to a v4 with a patch title various.
> > 
> > If you have to list multiple changes, it should normally
> > be multiple patches.
> > 
> > White space can all be grouped, but the others should be separate.
> > Please break it up for v5.
> > 
> > I'll take a look at the actual changes even though I won't merge
> > a 'various' patch like this.
> > 
> > I may well miss things because there is simply too much in here
> > and some of the diffs are subtle as it can be hard to spot
> > if it's a name change or a functional change.
> >   
> 
> Hi Jonathan,
> 
> Thank you once again for the very valuable feedback! We didn't actually
> reached v4 with a title various. It is just that the more that I was
> working on this driver the more things I noticed that could be cleaned
> (apparently not all of them as you mentioned) but still quite some that
> could be cleaned. So I took the opportunity before adding the triggered
> buffer support to do this cleaning.
> 
> The reason that I did it in a big patch is that in a previous version
> of this set of patches, you mentioned that we must find a way to make
> the commits less, so that's why I thought that a cleaning patch could
> include many different types of cleaning since there are no functional
> changes but as I understand that's not the case, so I will split them
> for v5.

Ah.  I was interested in reducing overhead of having the same change
that everyone was happy with being posted in lots of versions due
to other changes later in the series.  Not reducing number
of patches overall!

BTW I picked up the header sorting in v3 so you don't need to
carry that change any more.

Jonathan




