Return-Path: <linux-kernel+bounces-138679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8964489F8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E012281BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D62F16D4DB;
	Wed, 10 Apr 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igrRdy6u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF70161330;
	Wed, 10 Apr 2024 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757000; cv=none; b=m3KfZTiPND4U7fhYic7cdzWhG9T3hBt42r3S9kfepuTF8XMideitciiwBd0v1ln0UA/0PKo1pQ6fwgDB0mJaKn1h+U36Wy8qzW6wiBaHj2vP0zwcS515HXpL2K7FHzlcng84WYHdXi0sRPwVRwK9QEq8CiHHHGuI7wHavJ5TuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757000; c=relaxed/simple;
	bh=W4+YbNUqKogJXfDDJSCYKuOrE+ecQbdSDpvdWU+QHYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz1rrw9FIHb0vonDWIUZDqSfQfZJjriQ0+pKqNMEeKZgTL6bWaDfD+i5a+43hSY8fZM5S5tCRMMW4wxH157wyiF9pkiwDl24hX0+2Yy4gVDN/1XY/JEV8mg6I+XNiFwqy3vg8n0o6IFiimQmtgtFpfoon/q5Aia6N0+LIV5UMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igrRdy6u; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712756999; x=1744292999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W4+YbNUqKogJXfDDJSCYKuOrE+ecQbdSDpvdWU+QHYI=;
  b=igrRdy6u1h6IRBnxzbF22t+SGdXgJ02C7CbbILpaVmk3U40OwQpY24sh
   UEoEDVGVsH4+ZtDTR7TMBJQlhqRzfuzSTgOcZkOl9v1RFHgx0KvsQ4TEf
   6UKQN2S5pRvmfjRFnGo247s/SyPSLBngJvM1ovpgSZHsTf5j/XYaOXtpz
   U7SREIa2fi36/7/QVDZ4zxHZ7FDJLCeTL+eYg1NQRDUA9eL9lnz3Tz/Fv
   mYjEY+UJEbUoDsHgcUW+8RmAz2lCpiJCbZnbxYWhYLehIx2MrLaeuWhQ9
   VoOCzUQOcouWWZT4WesdBJk8Jtg1ihefRtz3Beui6xTO2j/RPhAwOlKva
   Q==;
X-CSE-ConnectionGUID: wqPbS27zROKCmyqFrG71yA==
X-CSE-MsgGUID: 1VdtrMQwSAK4dAm1DboUig==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7992403"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7992403"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915433555"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="915433555"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:49:56 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruYKo-0000000357e-0ywy;
	Wed, 10 Apr 2024 16:49:54 +0300
Date: Wed, 10 Apr 2024 16:49:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 2/2] media: atomisp: Replace open-coded
 i2c_find_device_by_fwnode()
Message-ID: <ZhaZAdUdAwL80Tza@smile.fi.intel.com>
References: <20240326202813.1425431-1-andriy.shevchenko@linux.intel.com>
 <20240326202813.1425431-3-andriy.shevchenko@linux.intel.com>
 <c9741df0-6c12-4ff5-90b4-5a13f0bd9b51@redhat.com>
 <ZhaVnYtFoTaFOKD-@smile.fi.intel.com>
 <911d84a7-cb3b-4ca5-86a1-334e7b3f85c6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911d84a7-cb3b-4ca5-86a1-334e7b3f85c6@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 10, 2024 at 03:41:15PM +0200, Hans de Goede wrote:
> On 4/10/24 3:35 PM, Andy Shevchenko wrote:
> > On Wed, Apr 10, 2024 at 12:35:29PM +0200, Hans de Goede wrote:
> >> On 3/26/24 9:27 PM, Andy Shevchenko wrote:

..

> >> I'm going to merge this variant into my media-atomisp branch
> >> instead of the orignal.
> > 
> > Thanks!
> > 
> > This explains why changelog made the commit message.
> > Was it done deliberately?
> 
> Oops, no that was by accident. I normally git send-email
> + git am my patches and then git am cuts it off...
> 
> I just send out a pull-request with this minor wart in it
> (after testing), so unless there are other reasons to respin
> I guess we'll have to live with it.

You might check the linux-next scripts or ask Stephen if this is an issue.
In any case we will know sooner or later :-)

-- 
With Best Regards,
Andy Shevchenko



