Return-Path: <linux-kernel+bounces-9711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B8381CA12
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAA92877DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B59218C07;
	Fri, 22 Dec 2023 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWX9Demk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001C18AE4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703248677; x=1734784677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=A7tECuFw+sheNvoT1sQ2bfBSYHt5SbkgnADaRBKyPlY=;
  b=WWX9DemkCA+IvQWrY1aiRmbiIBNM38sEdOiXmd1ArCIUDlDxFs8Cx1Yh
   2Vqm3IbhSY9FiIB+hKwEFZQBc1Vo6gcAy8gK/m1b/6MmLyFeOjAHBcxk6
   qjkMhoHpI9jfJVLhwJfncYMqoROFDkZCcGAhJOkCJ/jLVVd+NlqzppR/T
   bMbYtdnOxciW/9Dw9OuOhXoX38lxFacfFabElOuF2gcUKYibY15AZ/MCA
   iKVYsEZFhhIXGUnqrOoxHOLbIn30sDonnB8ff3ilRk+ijWVv58csdD/qZ
   QHYZlJqav1Za+ZkkAoxhQf2snJ5cHeOj6HjFBsDUbNqVmr4PNPctTCJZ4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3355051"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="3355051"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:37:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1024185181"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="1024185181"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:37:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGemm-000000088z9-0p0D;
	Fri, 22 Dec 2023 14:37:52 +0200
Date: Fri, 22 Dec 2023 14:37:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] pvpanic: Don't use "proxy" headers
Message-ID: <ZYWDHzG0zDTbMwEH@smile.fi.intel.com>
References: <20231221144447.2762077-1-andriy.shevchenko@linux.intel.com>
 <c37fecee-f5b2-497f-a48d-2a2faf6697d9@t-8ch.de>
 <ZYSD3C6fKvWUulXC@smile.fi.intel.com>
 <f3e4f74b-c532-48f6-990f-232208268c04@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3e4f74b-c532-48f6-990f-232208268c04@t-8ch.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 12:08:51AM +0100, Thomas Weißschuh wrote:
> On 2023-12-21 20:28:44+0200, Andy Shevchenko wrote:
> > On Thu, Dec 21, 2023 at 06:48:49PM +0100, Thomas Weißschuh  wrote:
> > > Dec 21, 2023 15:44:55 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

...

> > > Note:
> > > This also drops the unused include of the UAPI header
> > > which could be mentioned in the changelog.
> > 
> > Isn't it implied?
> 
> It's not covered by the subject. The message itself is fine.

Ah, I thought you are talking about the body of the message.

> But it's only a tiny nitpick anyways.

Yes, I don't think we need a new iteration due to this.

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



