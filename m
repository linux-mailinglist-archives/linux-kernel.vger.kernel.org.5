Return-Path: <linux-kernel+bounces-123140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F0C8902D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58741C25194
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD5212F38B;
	Thu, 28 Mar 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpPeGYEF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186E7EF03;
	Thu, 28 Mar 2024 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639096; cv=none; b=MoYShkfDThuoIo8c55EcwQ137PSvrxhhH0TTjzNrABtaZFa3jZzFF82Y5r3vd2TK2q5IBFiMCigZXJQDNt8x1QY58pVosrt/9cYcXsbJo1FPbbj7I8GiFVRyD3B/Nid9llqkqj8BxhFm3lHsU/Z0u27tUZFMD56SYcdrPXtnEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639096; c=relaxed/simple;
	bh=ygUv44C6fCMRIUqPyxznSTwJE2TEnNoEGSK5L1twTvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKGUr+8PZLOpWYEfWn9sR+HJyNIf2QekgTQk/4CVuAejRLAnhvVuDL5B1VNg6i+TcnzTN4VpJ8keAEvqJs2O4qxyMFttWmayyp88ici+hZb6/958GmOfu9J28trcuKEqkwpbcZUxRM8rkjPhD163HG4xyicaJEMyRbDuW/BDYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpPeGYEF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711639094; x=1743175094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ygUv44C6fCMRIUqPyxznSTwJE2TEnNoEGSK5L1twTvo=;
  b=CpPeGYEFbrVnJGKYUfUX9+mVtyi4UdHCo4oV7xOKJtBGrUGKoGVygXps
   RDpv6gkON2SzLc8fVOvsnjtP/WJd+b1gyXmj7YCnGg7x5N5LocAJyU7Fq
   vC+eXJJoiXvXwglFX7QACfkdNuQyCndLbplb7fGpQM/NBPt/PYLconoj7
   qExTbH5UPN1Mei+4K86Ul7QAggakQPGkUI9sLtLzRA3B/ipIpGHSPn19o
   TQRx4WmZEnwyJloHLVm2kQu8MzUrXxwzw0Xh8urDQZ76D5l8lVyGoMJXO
   pMZXwsxLjwn5NvXi352y3yahIgAWMHPo7iTyOpOmIpCMP0aGuS9zsCe8u
   A==;
X-CSE-ConnectionGUID: xvGgeUjSSmaqfU640ucE4A==
X-CSE-MsgGUID: Fv83MgJBSpSwTGvr9/3+uQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24284186"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="24284186"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 08:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="914953082"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="914953082"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 08:18:11 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rprW5-0000000H35x-1cSf;
	Thu, 28 Mar 2024 17:18:09 +0200
Date: Thu, 28 Mar 2024 17:18:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?utf-8?B?6Im+6LaF?= <aichao@kylinos.cn>,
	"ilpo.jarvinen" <ilpo.jarvinen@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v11] platform/x86: add lenovo wmi camera button driver
Message-ID: <ZgWKMUKmEhYtlyQ0@smile.fi.intel.com>
References: <je8phmmtfz-je9zfg1v9s@nsmail7.0.0--kylin--1>
 <030beaf8-12e1-400a-b064-f17384e32714@redhat.com>
 <ZgQbz5pBTuY64pNF@smile.fi.intel.com>
 <4b6aa3ef-82f1-43d4-9544-89f591f49e41@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b6aa3ef-82f1-43d4-9544-89f591f49e41@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 27, 2024 at 09:03:38PM +0100, Hans de Goede wrote:
> On 3/27/24 2:14 PM, Andy Shevchenko wrote:
> > On Wed, Mar 27, 2024 at 11:54:55AM +0100, Hans de Goede wrote:
> >> On 3/26/24 3:54 AM, 艾超 wrote:

..

> >>>>> +config LENOVO_WMI_CAMERA
> >>>>> + tristate "Lenovo WMI Camera Button driver"
> >>>>> + depends on ACPI_WMI
> >>>>> + depends on INPUT
> >>>
> >>>> No COMPILE_TEST?
> >>>
> >>> I compile this driver and used Evtest tool to test it on lenovo A70.
> > 
> > What I meant here is to add respective COMPILE_TEST to the dependency(ies).
> 
> Neither include/linux/input.h nor include/linux/wmi.h offer
> stubs when disabled so this will not work.

Oh, I didn't realize that!

> Besides x86 has a lot of compile test coverage in general,
> so I don't see much value in adding || COMPILE_TEST to
> dependencies.

Agree.

-- 
With Best Regards,
Andy Shevchenko



