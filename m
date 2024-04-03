Return-Path: <linux-kernel+bounces-129399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F9A896A28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3C6B2A82E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2021373527;
	Wed,  3 Apr 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYfmfX8S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80D70CC5;
	Wed,  3 Apr 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135487; cv=none; b=rSt8eYXxioxQp+gCtktgoHN66wlgLSc/NiWwV50PTYRTV+EaaT+HXq20wAktqJnXwECyKPsrLO8Tz+q62ly1teJmj36kVbpkuc56fN+uk33cxLmrazaH1CqvK0pI+LL1uKpC9GgBSs4XFSVXvCGJ98uEepwdmz02+v8z402BhzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135487; c=relaxed/simple;
	bh=IA1OJw345hlCGqk0ccmAtp6JLPgEQh8BAaZtKS7cgWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiJ0o3IuhbC9Xp/jl90+mnIKwNt86DoKoTLoLAOPO+nSTirxegYaNqVCQsL5wm+88VyS6p4Ek2qJpQSD3KnyQZYC/fcZyt5gVjvZN/cjA+1qwoA5vPdxPhOr8PX2Mm8c4Qxl9MuvZsj6Z9uN/VCNl86ct+ZmxK8KPWbXoMTXnpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYfmfX8S; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712135485; x=1743671485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IA1OJw345hlCGqk0ccmAtp6JLPgEQh8BAaZtKS7cgWU=;
  b=NYfmfX8SsRlLodVW/UT/NSE2oHtOkSjtM73lxJ7+jtXVkZ3akWpyWVXJ
   i1rCLgA8+KeHMFFy+jE4BoryMqZYmLf3jo/cGHK7qJ5AKeWJ4lZNnAtM4
   GeK43295JUZCd0Y8i/WIMRvgOLF4Rec3yTdMASAaD/cFiNFGl0T9wtzwP
   POHcrR9QpgTZp/QaaHe9RHQerMyzMcUVfCczvdEqxQ+1nXrkeQpl4Wjh3
   M860Z+nswh1RBTYtTtdip27z9rfV8xNhLMGjySjNNNmxM0lvmpD0RXthb
   B40mgJGqWVKYIKbYzIIP9Gbu8zaAsreQ+o1IQ+ilr1LvAQ/zCNpQ8y0sj
   A==;
X-CSE-ConnectionGUID: QIEIIAZFRIWqK2kl2F3UOA==
X-CSE-MsgGUID: RT5m7VNLToSqBZoliyJY7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7480963"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7480963"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915175196"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915175196"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:11:21 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrwe9-000000014Qk-0z2Q;
	Wed, 03 Apr 2024 12:11:05 +0300
Date: Wed, 3 Apr 2024 12:10:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Saeed Bishara <saeed@ubuntu-saeed.il.marvell.com>,
	Arnd Bergmann <arnd@arndb.de>, Ma Ke <make_ruc2021@163.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 30/34] sata: mv: drop unnecessary #ifdef checks
Message-ID: <Zg0dGmVC9AFYY_RH@smile.fi.intel.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-31-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-31-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 10:06:48AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with W=1 shows a warning for an unused variable when CONFIG_PCI
> is diabled:
> 
> drivers/ata/sata_mv.c:790:35: error: unused variable 'mv_pci_tbl' [-Werror,-Wunused-const-variable]
> static const struct pci_device_id mv_pci_tbl[] = {
> 
> Move the table into the same block that containsn the pci_driver
> definition.

..

> +	{ }			/* terminate list */
> +};

> +

Too many blank lines now.

>  
>  static struct pci_driver mv_pci_driver = {
>  	.name			= DRV_NAME,

-- 
With Best Regards,
Andy Shevchenko



