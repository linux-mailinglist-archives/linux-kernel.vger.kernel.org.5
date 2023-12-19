Return-Path: <linux-kernel+bounces-4784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00758181FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54285B247E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48D2C2C2;
	Tue, 19 Dec 2023 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mJpKWc2V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1EC150;
	Tue, 19 Dec 2023 07:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0674DC433C7;
	Tue, 19 Dec 2023 07:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702969717;
	bh=3J1O+eiA1WeesxQ7m8AkRVrzJ85o2jk2JQWk8IT0M2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJpKWc2VflhKk8sVK4UoWTmaXmsfkUBM2Sx0AkVvBlrE7dUjKL97BYX0dDQdNV/Tp
	 xDXqpj+X+7gkMdgU0BMGK4WswbL21UhNAAeXQKAwZWlX3YFZ2jAPeKHaV/cSn/aJxK
	 Il95StdTuB8X2HdzaYy/ITDRIfG4Bl32jQl1cEY0=
Date: Tue, 19 Dec 2023 08:08:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	jikos@kernel.org, jic23@kernel.org, lars@metafoo.de,
	Basavaraj.Natikar@amd.com, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix regression in ALS
Message-ID: <2023121928-annotate-moody-e5b9@gregkh>
References: <20231217200703.719876-1-srinivas.pandruvada@linux.intel.com>
 <20231218162227.00002197@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218162227.00002197@Huawei.com>

On Mon, Dec 18, 2023 at 04:22:27PM +0000, Jonathan Cameron wrote:
> On Sun, 17 Dec 2023 12:07:01 -0800
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> > Addition of color temperature and chromaticity support breaks ALS sensor
> > on several platforms. Till we have a good solution, revert these commits
> > for 6.7 cycle.
> > 
> > Srinivas Pandruvada (2):
> >   Revert "iio: hid-sensor-als: Add light chromaticity support"
> >   Revert "iio: hid-sensor-als: Add light color temperature support"
> > 
> >  drivers/iio/light/hid-sensor-als.c | 100 +----------------------------
> >  include/linux/hid-sensor-ids.h     |   4 --
> >  2 files changed, 2 insertions(+), 102 deletions(-)
> 
> +CC Greg KH.  (resent as I messed up Greg's address first time around)
> 
> Hi Greg,
> 
> This is a regression fix that I'd like to get in asap. Currently light sensors
> on a wide range of laptops are broken.  I was hoping we'd fix the the problem
> rather than need to revert, but time is running out so revert it is.
> 
> I don't have anything else that needs to be rushed in before the merge cycle,
> so if you are happy to pick these two reverts directly that would be great.
> 
> Message ID of the cover letter is
> 
> 20231217200703.719876-1-srinivas.pandruvada@linux.intel.com
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> If not I should be able to do a pull request in next couple of days
> with these in.

Now queued up, thanks.

greg k-h

