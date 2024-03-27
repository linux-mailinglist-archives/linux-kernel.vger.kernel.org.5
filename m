Return-Path: <linux-kernel+bounces-121355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D0688E6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3031C2E1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37D913AA43;
	Wed, 27 Mar 2024 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTTkUfSY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071D13AA39;
	Wed, 27 Mar 2024 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545302; cv=none; b=BJgkpVsGz/Z5r7qxoQgV/cA3KxMNjk5KggDiXMcdXWA+iqvI/xQzGiLTAwI8uCOuFNooLV3r6CF0YW2XzDitV+HJs6v3KQjzvIGyYi8Q6X/+rSfQO+lQqQa9kr0swtTviON7WrHgZUbH7Nn0CfP5x9RQJ5wD9mxX9Uky60jm3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545302; c=relaxed/simple;
	bh=8tk+d89+nu+/3O94EB8v7SUf5lcppLMydV5yYR9XYVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKpEbtKjTfRYrpt1bZIR7D4IdkvqgGjWXuQy2QZpHyDWO9YVJh7WaKb8cXCyiwC9F8gTSYh+Zx56brrcnRU7mbCgtX+pLSkdeKS5DM1WcO4JcaDNovNeM+oGR6jDSRCbSZSNl+IPvkNQXeUWAyLIYmgyTx6809JvcfwxqyaL5Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTTkUfSY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711545301; x=1743081301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8tk+d89+nu+/3O94EB8v7SUf5lcppLMydV5yYR9XYVQ=;
  b=nTTkUfSYGxDETVeZMvuhhDIsTpY0IE5qkeGuiSvpLGZjFaBuitBRgpWp
   7ETbuHkxoNMv4hCRXN0yzMhdwMNFsjvWZAYQQLLAHUidNmUYJacI/Zn8h
   EzT3bj/3dKy8SjIKdxmw1aOU92PwKu/6EOE5IF7J/rHDul0Sk4CvbrsNX
   Vabj3k/gOQcJrypf0hJXklLnQGvdqCRosQmLSXgNIkn3OQtPu23WtT57k
   wl7ZkHHZfVV9zUwZFvfkaX6+sWr8P3P+yrEbLSPryreuiqoOXxytFDzQH
   2wOn40EHdKXcAsnyF1YIE0OzolmMW+6cGRWEi9LSKu1b71P/5zhJ5J1o8
   A==;
X-CSE-ConnectionGUID: UnsQGdRfQUy3FMXCjMQimw==
X-CSE-MsgGUID: es0V+fsfRw+911lCDFwgeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6581939"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6581939"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914913033"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="914913033"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:14:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rpT7H-0000000Gdlt-367t;
	Wed, 27 Mar 2024 15:14:55 +0200
Date: Wed, 27 Mar 2024 15:14:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?utf-8?B?6Im+6LaF?= <aichao@kylinos.cn>,
	"ilpo.jarvinen" <ilpo.jarvinen@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v11] platform/x86: add lenovo wmi camera button driver
Message-ID: <ZgQbz5pBTuY64pNF@smile.fi.intel.com>
References: <je8phmmtfz-je9zfg1v9s@nsmail7.0.0--kylin--1>
 <030beaf8-12e1-400a-b064-f17384e32714@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <030beaf8-12e1-400a-b064-f17384e32714@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 27, 2024 at 11:54:55AM +0100, Hans de Goede wrote:
> On 3/26/24 3:54 AM, 艾超 wrote:

..

> >> > +config LENOVO_WMI_CAMERA
> >> > + tristate "Lenovo WMI Camera Button driver"
> >> > + depends on ACPI_WMI
> >> > + depends on INPUT
> > 
> >> No COMPILE_TEST?
> > 
> > I compile this driver and used Evtest tool to test it on lenovo A70.

What I meant here is to add respective COMPILE_TEST to the dependency(ies).

-- 
With Best Regards,
Andy Shevchenko



