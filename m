Return-Path: <linux-kernel+bounces-121371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DF188E705
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B211F30121
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292A313D518;
	Wed, 27 Mar 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYlHUCf2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4A12E1CA;
	Wed, 27 Mar 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546578; cv=none; b=ixFUssav1hTeY2Vf1YBJDG19WMCI4Hlsx8WC4sIACAE9j2V+NEKIthr43Zu0GgxcXsX8YSZz13DRAVxtZTncd05NoBuolyqj1YQRMCQmP19nm3LTHX647fshw4G1w2oUbaWCa8i+w9Fh20wUclZvcok89SJvdUjjL2iXwFhD8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546578; c=relaxed/simple;
	bh=tvpLVrhz+euw41OHiEC0NwXfQCCLWLqhiMZ7p+2r5iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJXBw7B3G5zX/hiVUtgkZJRoSVSTE3+3Ih8oLw6RtN3/2AaH1UjNRduujPK2S6nLle8K+lBepBtT1Mr84h8/CP/1+PTL5c2ygneIupJ/piNEXwza450+ySXTOqw5BvgJUFnIezv9jnyvTYqoKh7oZy9KmiacFI6eh6pQUWpHGWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYlHUCf2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711546577; x=1743082577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tvpLVrhz+euw41OHiEC0NwXfQCCLWLqhiMZ7p+2r5iA=;
  b=aYlHUCf2ccvzjIRwaRSeY6Qv3cL0zaXXsbrPT43AtesfX+CP3JegSCJ+
   cbe9Sj+1dOCTxF7Fb2gZgD8Xf0O1QLv/cNL4VZLjn9IUJ7ohtQPrsHaXT
   9uprZ9N13XffnQOxMXlD2AWS+mAaGcchKu//SckpbTAnHqv0kmdvyHkOG
   Vh9CVTU1kp7DvAkWQtxcfy/IUcYWgWIGM4N/u8uaRF+0tZunESq3MBz47
   66HVRo3zLE4H61l0DIjTwM0b05WpQMdHu92qoUlg0E04tXdLZYiZHzxEl
   kAsaxvnOwqx3bphYfQM8HUNBfRoDAAQkthxSpIZKQwWNmGYkI7AecHlmP
   Q==;
X-CSE-ConnectionGUID: JyrwrfKHTxKtcyGN5usIOg==
X-CSE-MsgGUID: bNthLcESQc2pSMkT2zhuzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6834547"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6834547"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914913420"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="914913420"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:36:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpTRn-0000000Ge4G-2wfg;
	Wed, 27 Mar 2024 15:36:07 +0200
Date: Wed, 27 Mar 2024 15:36:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 1/7] printk: Save console options for
 add_preferred_console_match()
Message-ID: <ZgQgx1uS2ugc-qPi@smile.fi.intel.com>
References: <20240327110021.59793-1-tony@atomide.com>
 <20240327110021.59793-2-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327110021.59793-2-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 27, 2024 at 12:59:35PM +0200, Tony Lindgren wrote:
> Driver subsystems may need to translate the preferred console name to the
> character device name used. We already do some of this in console_setup()
> with a few hardcoded names, but that does not scale well.
> 
> The console options are parsed early in console_setup(), and the consoles
> are added with __add_preferred_console(). At this point we don't know much
> about the character device names and device drivers getting probed.
> 
> To allow driver subsystems to set up a preferred console, let's save the
> kernel command line console options. To add a preferred console from a
> driver subsystem with optional character device name translation, let's
> add a new function add_preferred_console_match().
> 
> This allows the serial core layer to support console=DEVNAME:0.0 style
> hardware based addressing in addition to the current console=ttyS0 style
> naming. And we can start moving console_setup() character device parsing
> to the driver subsystem specific code.
> 
> We use a separate array from the console_cmdline array as the character
> device name and index may be unknown at the console_setup() time. And
> eventually there's no need to call __add_preferred_console() until the
> subsystem is ready to handle the console.
> 
> Adding the console name in addition to the character device name, and a
> flag for an added console, could be added to the struct console_cmdline.
> And the console_cmdline array handling could be modified accordingly. But
> that complicates things compared saving the console options, and then
> adding the consoles when the subsystems handling the consoles are ready.
> 
> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This requires my SoB as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Tony Lindgren <tony@atomide.com>

-- 
With Best Regards,
Andy Shevchenko



