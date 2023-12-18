Return-Path: <linux-kernel+bounces-3511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBE1816D30
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4567F1C233B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EA339AEC;
	Mon, 18 Dec 2023 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ls/yicY6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921EF39ADD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702900281; x=1734436281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6O3Se3B93E8UTNW/7OH1GdeQwdpeUBFggJ6p3nIai14=;
  b=Ls/yicY6qdzyPbxJO7CrqAtb7uqNXk0I3mBuVe6u9NioG/EkHuaZuJls
   /WC8iCQS9Vxkq3fIKuTjqPwwBGoK7qfMD6UL1FhwLXJRFiaRtm2AkmJT4
   lIF44Ng7igCSa2lhRJMzk7Ut2pU9J9KUUkxLHw/eGuTtI0FgJMI/4wdpT
   Wgq+aOX/A7WfZ087I8qx2DknJM6KQpYHPR+4C79qlXmlFHOZeAbuhgZSJ
   0kxnnxrzZAmgwF+XEc8aogsy+HLK4SkvrYBNa9uG0v8XzOxAj51e/vJjK
   OxUcBqJyMyim+6md/YXvHAFoB2rccXzVzNzoGOzXCwkXzVw1wifTm2vTN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="385918416"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="385918416"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:51:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="768816570"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="768816570"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:51:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFC9S-00000006uu0-2zbc;
	Mon, 18 Dec 2023 13:51:14 +0200
Date: Mon, 18 Dec 2023 13:51:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, perex@perex.cz,
	tiwai@suse.com, sbinding@opensource.cirrus.com,
	james.schulman@cirrus.com, david.rhodes@cirrus.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Jasper Smet <josbeir@gmail.com>
Subject: Re: [PATCH 1/1] ALSA: hda: cs35l41: Dell Fiorano add missing _DSD
 properties
Message-ID: <ZYAyMu9IuNDI69FP@smile.fi.intel.com>
References: <20231212195243.10666-1-alex.vinarskis@gmail.com>
 <87fs05qc65.wl-tiwai@suse.de>
 <d98a3157-6e58-4dd9-a35a-759bcdcbe0c9@opensource.cirrus.com>
 <87ttokpyws.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttokpyws.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 14, 2023 at 04:49:23PM +0100, Takashi Iwai wrote:
> On Thu, 14 Dec 2023 16:39:58 +0100,
> Stuart Henderson wrote:
> > On 14/12/2023 11:02, Takashi Iwai wrote:
> > > On Tue, 12 Dec 2023 20:52:43 +0100,
> > > Aleksandrs Vinarskis wrote:

...

> > > Can Cirrus team review this?

> > The patch looks sensible, with some minor comments below, however
> > we're just at the tail end of testing a patch chain that genericises a
> > lot of this code and adds support for a rather large batch of other
> > laptops with incomplete DSD.  We're hoping to push this upstream on
> > Monday.
> > 
> > Can I be awkward and ask that we hold off on this patch chain until
> > then?  Then we can add this laptop using the new approach.
> > 
> > If/when the chain is accepted, we will add support for a few Dell
> > laptops as well, including this one.
> 
> It's fine to wait for a while for me.
> Hopefully we can make it in 6.7, and we can catch up in the next
> week.
> 
> (BTW, I'll be off from the next Tuesday, and the reply will be
> delayed, but I can eventually check and merge patches remotely :)

Since v6.7 is going to be an LTS, I think we are eagerly want to have
one or the other to be included. In case Cirrus is slow with their
patch, I would like to see this one being included. Let's make an
xmas/ny gift to all users of this codec!

-- 
With Best Regards,
Andy Shevchenko



