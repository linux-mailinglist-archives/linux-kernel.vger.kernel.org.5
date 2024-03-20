Return-Path: <linux-kernel+bounces-108816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81721881067
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668AA1C231B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49CE3BBCE;
	Wed, 20 Mar 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adM4JI8r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C053B2BD;
	Wed, 20 Mar 2024 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932698; cv=none; b=Cul7ZA++5n4HZE7JK7DKyVHuNtux39PBFptfm33fFjnNei0RzzA5Bh49n1norqiMkz0nqs7/Z1t1+3PF4C3/4xMjK4tg54amMEGcQeh0ensRk9WYhr3YC3bgYIEifUzySwUoYBUIdSPveNv8zZoA3Td5gMY9roNLvhfo8ccA74A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932698; c=relaxed/simple;
	bh=Cwof0Z+oy90M8Xb+By8UycSr4zT+Ql+w4SZTkWEzKy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2aYjCmIsxhie98SLbbuXY0SrDZ0chKRvfoWcjQVz9TaQShmEIolcL4bK2Avg7GDSEAapDOn/naWsPWnbe2+UoD0V0nC9n4a1Y7SEf8GxhkWnX2Ae8AKVtDj+4ySKEEbm0sHFEfxjNzApcwUtFIrInrpGyvdsQfIy4Ncs27NcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adM4JI8r; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710932697; x=1742468697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cwof0Z+oy90M8Xb+By8UycSr4zT+Ql+w4SZTkWEzKy8=;
  b=adM4JI8rZg9CHGJekA4uqMZy+q3rxrorRIvY4lG2MLF63zZANw2pLnr4
   PkdK590EeBGmgX37xVHGLfbxpPEglN+35kiaXLN3oAPQ+7p4TFoKQweOh
   JuY2id8jv2evhOlOaxIkonu2K+JkL/5uDvTN0b+FtrVN5NfzCBLKRm2x4
   G7OdRv53B9b8D2pGGP2OJMLtVV0Mps1E5y+u/mV38kaYB6G/rFaxqer2h
   5LJZw7SjqnqT8DXpnkl7YXBUz2BmN1B65+J4PlSDKObl76q0VHwfkHwWU
   F+UZTPFTLVtWIEslnMrIZnMbrOAZNjxo2oQVur1tpdMNLrS5Iy408Slh5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17295094"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="17295094"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914662946"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="914662946"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:04:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmtkY-0000000EY5f-0ok0;
	Wed, 20 Mar 2024 13:04:50 +0200
Date: Wed, 20 Mar 2024 13:04:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/6] iio: pressure: Introduce new cleanup routines to
 BMP280 driver *_raw() functions
Message-ID: <ZfrC0R8jZ5snBnH6@smile.fi.intel.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-3-vassilisamir@gmail.com>
 <ZfrBsY1rF-5stHqU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfrBsY1rF-5stHqU@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 20, 2024 at 01:00:01PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 19, 2024 at 01:29:21AM +0100, Vasileios Amoiridis wrote:
> > Introduce the new linux/cleanup.h with the guard(mutex) functionality
> > in the {read/write}_raw() functions
> 
> Missing period at the end of the sentence.

And also

{read,write}_raw()

-- 
With Best Regards,
Andy Shevchenko



