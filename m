Return-Path: <linux-kernel+bounces-8875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D416581BD90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113D51C237CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5464A97;
	Thu, 21 Dec 2023 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnS6KtPG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EECC63517
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703180756; x=1734716756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ceys46WOg3QlcwrEA+PYh0JO1xKpKRUfzyFgf5e49J4=;
  b=cnS6KtPGfLnslKoXuaxUFkgsxMXJFvcwoyX1x8GdQthVxq+OZYn4rQBa
   TKrJToWc3LWkqEPeRjL3GPlDxDYzz1jH1MBQms0qNgpRg46z9BwP4VBS8
   tdR/YsyMXEp+oV0DG3KodrQn5yCgU5jHTQa366mDX3P2rOn4xGl/R/07k
   l7oAoDzZSqqsWVLkTUtzsDqfsToF3olpSGo4YSmxBSRb64fbWXoxw1k0h
   btSUgv+udlrhltSBNUw8okCbHX+VYSTCLbC4A/mCviXii4nd0qVrr2YrD
   zNjnh/51twX/RMBSjkPaPmGiHPpg3AtNwJWNAFfPTK1j6SxBN13mOr2I2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="462455056"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="462455056"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 09:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="920394609"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="920394609"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 09:45:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGN5i-00000007ud8-3TQu;
	Thu, 21 Dec 2023 19:44:14 +0200
Date: Thu, 21 Dec 2023 19:44:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch to generalized quirk table
Message-ID: <ZYR5bh596slWaqjF@smile.fi.intel.com>
References: <20231221171113.35714-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221171113.35714-1-alex.vinarskis@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 06:11:13PM +0100, Aleksandrs Vinarskis wrote:
> Introduce generic quirk table, and port existing walkaround for select
> Microsoft devices to it. This is a preparation for
> QUIRK_CLOCK_DIVIDER_UNITY.

Check your repository, seems you forgot to add -s to git commit --amend or so.

...

> +static const struct pci_device_id quirk_ids[] = {
>  	/* Microsoft Surface Go (version 1) I2C4 */
> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182), },
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182),
> +		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS },
>  	/* Microsoft Surface Go 2 I2C4 */
> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237), },
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
> +		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS },
>  	{ }
>  };

I would suggest to look at the existing style, as I also in doubts on the
above. Perhaps the following is more common in MFD subsystem?

	{
		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS
	},


-- 
With Best Regards,
Andy Shevchenko



