Return-Path: <linux-kernel+bounces-129566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D79D896CA3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8741C261D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF68143863;
	Wed,  3 Apr 2024 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIr257Ki"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE4D1411EE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140413; cv=none; b=ad+6NsJTE0v6lw4ZyVKd4GSmjPGNXCKA3eXubQ6ES1WMHdU6UtF8SPvmlFnqBdSuTLVkc3qYxeYP77+6Wa3EZGIiEPLkHaBwHFdcDhOS7FHISLHSSWeJEKHYq+p1jInQT2H7t8Esjkc4UdAOstv+XKhPwrdpXV9hi416/7RSy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140413; c=relaxed/simple;
	bh=wCwCJ+Y7r7otcIdqPkZx2IkSMw7iWAcpjHpZpyUxGqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahmTvevungGbwvdbcBzZTvaRfykQXPPaTAf7beCVbg4Dt0SQqz8u2laI8aCf/GWTWkfPhICeknj2uw1PQ+ZDARnRnl9HJ3hRBBZiavca4hBK5QWUlmiGEgR/SiPKJ4IXn5BcOI4JpgT4VeEpzj4d6jcpLPg1op3qFU94MkV/KDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIr257Ki; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712140411; x=1743676411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wCwCJ+Y7r7otcIdqPkZx2IkSMw7iWAcpjHpZpyUxGqs=;
  b=kIr257KiBnPFWTxwhxjJ+FcuzEYb1I+xVj3c9eCmzTYTJTa6Y2KLpO6d
   BHgAZpZJQ4yyHRl4vdl4CkNMJeFvOS45gFgvXgVpMTIRXuu7hdWlkK9ft
   5gmka3pkr7s/05eM+up/XBR9RrAzODwWcLIFZz2NHRusOaRg8s4N/rcfq
   F+J0/o6m2a23bDE/6P8Mi0lQfO/6W7eWaTJkd8RPaoAUM7ePMLBzJOMxp
   7+RBFRwbRw+Ne59fyyCSLyhyS7NpCfFv9wHf38VqjL/Co6j9jgs7jchjM
   /7VYxf6CdzAcgxgf+B1hD2PUgFccJ61BPSBTIurjZIK/Vv0O/nTipsn//
   Q==;
X-CSE-ConnectionGUID: LwLpkgdoRHSidR3HCu6K2w==
X-CSE-MsgGUID: ic+cdLg+SVKPVBo0d2Pk5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24861396"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="24861396"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915178245"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915178245"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:33:29 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrxvq-000000015hp-3ZEc;
	Wed, 03 Apr 2024 13:33:26 +0300
Date: Wed, 3 Apr 2024 13:33:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 10/27] printk: nbcon: Do not rely on proxy
 headers
Message-ID: <Zg0wdhaV1dWXysS3@smile.fi.intel.com>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-11-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-11-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 12:17:12AM +0206, John Ogness wrote:
> The headers kernel.h, serial_core.h, and console.h allow for the
> definitions of many types and functions from other headers.
> Rather than relying on these as proxy headers, explicitly
> include all headers providing needed definitions. Also sort the
> list alphabetically to be able to easily detect duplicates.

Thank you! LGTM,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



