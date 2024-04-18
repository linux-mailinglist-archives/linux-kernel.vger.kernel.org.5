Return-Path: <linux-kernel+bounces-150011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A448A990F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F7A1C22595
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5406B15F41B;
	Thu, 18 Apr 2024 11:50:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A015ECD6;
	Thu, 18 Apr 2024 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441056; cv=none; b=VmEp2bL3165keBDed0IQNKipjkcFaoYx00PjuAAAIv/5TV7L4OPPiis6oB9lxBAwU12HJ28YQ1e4F1/va0c54sOA2j4e5sQ3adqCMv4cgGHK3xCPiZOlwB02c92nmaFOSi10QUnHpZptz+Y+qs1CL+uCuPWSMommWjTElXHX/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441056; c=relaxed/simple;
	bh=iRiAat630poaw1gRyOPsyjy2tdPc/RBRRifnHPmcN/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMWACTV5Or2vkObVklfIyWRz5IiPPyv9mHULBzqMWVB2KHx/OcNljOX7dSSNiQ58e/fJEobi0WJ/0ZS9Sb1ZJmMkM8nZYbB6yQWq80uX/sd77K+2T+vecA443tHshPy2umsUrgRgRy1eGPfIBCRFvrXMyC+koskc3r6X7AVCsXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: nF0AIfHgS3mPorslAnQQgg==
X-CSE-MsgGUID: cBAvAHS8S+i5ApmxoF7nXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19589353"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="19589353"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:50:55 -0700
X-CSE-ConnectionGUID: FMRnUkbkQqO57fbuMPTBwQ==
X-CSE-MsgGUID: QscAwcbsSYi9UxaYK13N0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27590374"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:50:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rxQHy-00000000JbL-1fNd;
	Thu, 18 Apr 2024 14:50:50 +0300
Date: Thu, 18 Apr 2024 14:50:50 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: keescook@chromium.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kunit-dev@googlegroups.com, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] string_kunit: Add test cases for str*cmp functions
Message-ID: <ZiEJGtpj1KIK1riW@smile.fi.intel.com>
References: <20240417233033.717596-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417233033.717596-1-ivan.orlov0322@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 12:30:33AM +0100, Ivan Orlov wrote:
> Currently, str*cmp functions (strcmp, strncmp, strcasecmp and
> strncasecmp) are not covered with tests. Extend the `string_kunit.c`
> test by adding the test cases for them.
> 
> This patch adds 8 more test cases:
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
> These test cases aim at covering as many edge cases as possible,
> including the tests on empty strings, situations when the different
> symbol is placed at the end of one of the strings, etc.

LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko



