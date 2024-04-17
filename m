Return-Path: <linux-kernel+bounces-148676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E84A8A85F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A79B282D73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F021411FA;
	Wed, 17 Apr 2024 14:28:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048331411EE;
	Wed, 17 Apr 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364104; cv=none; b=FZc/ku0kRfV4kacOHsRgH0b+07nm+roOzVmE1xVWTXBw2M0k0QdesUsFaS43saial16VrDhQXkzzhJZBllcNHIHE3GaafENzkuRf09fnxZth++ZS3VAQBE9lRoZw7o14+fXUQbnn4mN4PQc/JPxvOvdRSUCms/PgTCnOYyjGte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364104; c=relaxed/simple;
	bh=VKYaU0weTmqETCWf5O2KLIbE7mXficrIOSi4WszxuWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmoH9zWwVcACNFXVQk+T7BmShbqJPZfWaEy7nsU1ckGBHgGBLxhxddGaJEou9cpFgi7OUJvS7mOXYSmriZsG9BBks3OI7AL1C9PpzJmKFudIyMy93Aday7OAp3UmzcY7pRIv3rs6K6HoEQyA1av+v5EDf/pjM8nm9LXFzHLrM8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: aI4XVQLpQGavd8PTG64EBw==
X-CSE-MsgGUID: 0afxlIQESpOfl/3lueyUdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9027623"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9027623"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 07:28:22 -0700
X-CSE-ConnectionGUID: zXKsVT89Q3ebM+0O7s/U+w==
X-CSE-MsgGUID: urf+054gTFy9jCs++3bZrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="45939432"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 07:28:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rx6Go-0000000046R-2cgY;
	Wed, 17 Apr 2024 17:28:18 +0300
Date: Wed, 17 Apr 2024 17:28:18 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: keescook@chromium.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] string: Implement KUnit test for str*cmp functions
Message-ID: <Zh_cgnMOFHuP-lKu@smile.fi.intel.com>
References: <20240417135415.614284-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417135415.614284-1-ivan.orlov0322@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 17, 2024 at 02:54:15PM +0100, Ivan Orlov wrote:
> Currently, str*cmp functions (strcmp, strncmp, strcasecmp and
> strncasecmp) are not covered with tests. Implement the test which
> covers them all.
> 
> The strcmp test suite consist of 8 test cases:
> 
> 1) strcmp test
> 2) strcmp test on long strings (2048 chars)
> 3) strncmp test
> 4) strncmp test on long strings (2048 chars)
> 5) strcasecmp test
> 6) strcasecmp test on long strings
> 7) strncasecmp test
> 8) strncasecmp test on long strings
> 
> The test aims at covering as many edge cases as possible, including
> the tests on empty strings, situations when the different symbol is
> placed at the end of one of the strings, etc.

..

>  lib/strcmp_kunit.c | 170 +++++++++++++++++++++++++++++++++++++++++++++

Why is not part of the existing string_kunit.c?

-- 
With Best Regards,
Andy Shevchenko



