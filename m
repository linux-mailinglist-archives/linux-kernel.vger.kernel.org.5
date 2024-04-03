Return-Path: <linux-kernel+bounces-129782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3099C896FDF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622DD1C2656A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54A41487E7;
	Wed,  3 Apr 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apHUNtpR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08569146D72;
	Wed,  3 Apr 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149550; cv=none; b=mQQaBPu+RssPCIYAdmZyaYh+qnGxejbd3EbEt3oUAFH/Mwv1wLnybqsIhFWlg1qmZFSmqftE1BiWiyyH3RjDsI9u9FNX3TMTraZkB15fjpXeOitUIJBu9ZnI9QYoP/d8XDgeCZtk0Y6VQJNodWRFud9Hlu5cv3GpNhQ8fhtL3jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149550; c=relaxed/simple;
	bh=ND3jNXeXD8UCa8WzVy98aeHA4SFwZtX43lGgSbkdjqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSxT24ylxmguiqGrTmejpWoqiZDzkMdxZCSCcFyT1WKxXPdfcpMxXS8DoNd+atXMGFHrZ7gBCR5i73SJLeyzB3UZuEBEBZ2l9K6zAy1+FHKbE2AZGbgbcVJGsdQBMfmAM968b7kmhNbbSPZNYuZH92PynD8lOtDHBII+tqVeE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apHUNtpR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712149548; x=1743685548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ND3jNXeXD8UCa8WzVy98aeHA4SFwZtX43lGgSbkdjqg=;
  b=apHUNtpR7UTQtGLy3gYaxv4uPVCrasYY2GG/lYUAt2LOrUQAtJ4LNKs3
   gJk9j2eaOGVspOdZVGrOobpBlhndW0IIWz8KsjEbLUnfVfEHaL9anMeU4
   otmGIWdsTWLO+/ciA7PNU0hiJmfQvQ7wT+wPKsNztnnBewFvyH30P+C0r
   x1v4MclW7zeCe2duPFiItOZrp0lN4cFWdT45Fgp8NK1bqHqsoI3NcsHLq
   nML3tDLsjsVLvHjHH2WpmuiLPuEA/y+wEvbNddsRvKbbi29WcU/5dn90i
   e8YHHJRcO+noVD6wp18DRWtTEkaYejPuW3ncQ3sJSvbrpPu35n6f7UtrG
   Q==;
X-CSE-ConnectionGUID: +JQm8PsAQLa3v3O2K/aqAg==
X-CSE-MsgGUID: I2TZ4D3tRs2JpFr3SQR93A==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="17992665"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="17992665"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:05:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915182954"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915182954"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:05:43 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rs0JB-000000017iB-00E6;
	Wed, 03 Apr 2024 16:05:41 +0300
Date: Wed, 3 Apr 2024 16:05:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 0/3] gpiolib: Get rid of
 gpio_free_array()/gpio_request_array()
Message-ID: <Zg1UJPhFnQoIfNBR@smile.fi.intel.com>
References: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
 <ZgxRzyQGeSAl4MzX@smile.fi.intel.com>
 <CAMRc=Md_81qY02=XPmQA5_EWRC1eU0zYAjRwjbAGxvGg2kOL+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md_81qY02=XPmQA5_EWRC1eU0zYAjRwjbAGxvGg2kOL+A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 01:09:13PM +0200, Bartosz Golaszewski wrote:
> On Tue, Apr 2, 2024 at 8:43 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Mar 07, 2024 at 03:49:02PM +0200, Andy Shevchenko wrote:
> > > There are only two users left of the gpio_free_array()/gpio_request_array().
> > > Convert them to very basic legacy APIs (it requires much less work for
> > > now) and drop no more used gpio_free_array()/gpio_request_array().
> >
> > Any comments on this? We really want to get rid of the legacy APIs.
> 
> I applied the patches, they only touch the GPIO part in legacy
> platform code. It's not very controversial IMO.

Thank you!

FWIW, In case of issue(s) I would like to help to fix, but I don't think
it will be even one.

-- 
With Best Regards,
Andy Shevchenko



