Return-Path: <linux-kernel+bounces-158435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A447B8B200E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F8E1F25C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85B28527D;
	Thu, 25 Apr 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHdLG4pM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A922EE9;
	Thu, 25 Apr 2024 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043739; cv=none; b=gVxvPSH98GnsfFoI2IKVa3a6Qsaun7eAsIVKpzaOMUB2C4b/b3UWZl0+IssUnG3twkT0bAIKlfRjZoQrBwyKovtLmP9T9293Cm2DfPhe4+dd0EyznZW3NIULGBpXP5VU2YzpBaEKLgSUBO8CyU1q5JPuUKpBUgndYN+7BFRy1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043739; c=relaxed/simple;
	bh=FgzSQ9IBEOAd2GifUOQS/EsEskBpYYkqAZfbe9gx8U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJo1JxCM1UIHLpN/t1skVv7byh2Pt1uMpc3GB9cgK+5BjjFilc7mFjxl99CNAa/pQlLHCiZqWgrmfgD7njBtxUMAs/8BhDmWzlzhoAkF4yb5BpZ/NI0JbY0/FYFQFGPDCLXek8N80a+VWdZ4vMrLxqT2D2KTBQoK/xcFTdp6d/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHdLG4pM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714043738; x=1745579738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FgzSQ9IBEOAd2GifUOQS/EsEskBpYYkqAZfbe9gx8U0=;
  b=gHdLG4pMxO/JSmVNGVxTl/bnrs8XLWFMnQO3Gq0B1GAr9Hdd1sqnTloy
   Fwv0y3HtS526iIQ9p/+BfBKILCaUnINueyYwB4rEoWEfgTokfTnuELFgP
   H59Ko96J+jYIrPDDCo9sa3tqDpdZSnCtEK76V5hxLFRXnUQYbF2IxHNS5
   q4JX6RqcrJ9Wz61KZKrFTmirtoxSnzgtBR+noyaTXLpTtC8YAi0iiS9Uz
   6CXwcmZoRaXXEAltBWhCHIHhyFpd6Nor1HiCxV3HhYazUnLp+Zyrf9fLc
   lTywN07I6nUaJ1vgO4B8UU5UA27grKpa9jWaG5GgmWiD78TCaXbn7CVDh
   A==;
X-CSE-ConnectionGUID: 3BFs8ev7SaC+KzF/T8SeZQ==
X-CSE-MsgGUID: VvoJydaITS6KxzMZTqkBTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="27178551"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="27178551"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 04:15:37 -0700
X-CSE-ConnectionGUID: BkQTZMRcTUu4geYzW/WcKA==
X-CSE-MsgGUID: AqPRCR9IQw2l1pIHojeleA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="56218057"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 04:15:34 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id E062D11F855;
	Thu, 25 Apr 2024 14:15:31 +0300 (EEST)
Date: Thu, 25 Apr 2024 11:15:31 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/11] media: subdev: Improve s_stream documentation
Message-ID: <Zio7U2oexKUjFcyd@kekkonen.localdomain>
References: <20240424-enable-streams-impro-v6-0-5fb14c20147d@ideasonboard.com>
 <20240424-enable-streams-impro-v6-11-5fb14c20147d@ideasonboard.com>
 <20240425110854.GA28454@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425110854.GA28454@pendragon.ideasonboard.com>

Hi Laurent, others,

On Thu, Apr 25, 2024 at 02:08:54PM +0300, Laurent Pinchart wrote:
> Hi Tomi,
> 
> Thank you for the patch.
> 
> On Wed, Apr 24, 2024 at 06:39:14PM +0300, Tomi Valkeinen wrote:
> > Now that enable/disable_streams operations are available for
> > single-stream subdevices too, there's no reason to use the old s_stream
> > operation on new drivers. Extend the documentation reflecting this.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

If there are no further comments requiring changes, I'll send a PR on these
with Umang's imx335 and my CCS driver patches tomorrow.

-- 
Kind regards,

Sakari Ailus

