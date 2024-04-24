Return-Path: <linux-kernel+bounces-157121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F93C8B0D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1087B1F257D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7435415EFB6;
	Wed, 24 Apr 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gW6nCbgg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5515D5C7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970120; cv=none; b=n0/LPv4gYgBi2gcFXqC+fHSbEYRxjwBqGg0y4rWhw1yfjb/W4297c3GekPXhsrBFDBgiM+f/k41MvFUnGu+eru5oDI+0TIGbCu72vCtEJKkv2Emb0F+Okjv+RFnvrlpRhMaAjaLAJgknAq4VErI2EjA5cVsL6NyxoaAvTJav3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970120; c=relaxed/simple;
	bh=firtOClvlk7tO268mgRCTSgTFgXs4b3Zl7clm7MAqEE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDaqyb53dLMVWQy7owQjZ/UmHMAKwjc6jAsGEQoNbrYAWx4JcCDpHcJCJXKFkPNCQ94Po1oLTR1dv8vaWLEHresJpVjfmW/kqhUFaUdszpqnJwOXJE05GnVhIFbsZFZ2GQMU7oamLgEQFE9Y71oTfxA62oLurohxW5gXwd7UK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gW6nCbgg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713970119; x=1745506119;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=firtOClvlk7tO268mgRCTSgTFgXs4b3Zl7clm7MAqEE=;
  b=gW6nCbggwYkw1H+poU2ZIfXBzBetHeaTG61Za8DoJ9OgsFemq4KNoNfI
   ZlI1HiJgmZBPw0Bz36xQzOqJojP5un4Y4wg2iWPl/zGNOYDPhd7CdG7hF
   Y+34naiqwMzep/a6LJe1IrlUn8Go77QIR5UU7iHA61nmMCmFL/H1awYzN
   /Myoaq28DoOG0mkOEt1DrXx482RrTmCki0F3WogUsUzK3+oyER5C6Wrdr
   ipWE/9jD4TzRheMhGMRFnLY+oHZllmXlYb+mRgcL8wrlSALc+TggANLsU
   h2mvZGXTXL76tt4FWltIOg3CQN42pcPbdgBAMybAAtJUz5Joqywm1hezL
   Q==;
X-CSE-ConnectionGUID: qiHg5/vwSpeaPg2m0SAMzA==
X-CSE-MsgGUID: ebvhfep1QLezQuXAimXNoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="20155406"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="20155406"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:48:39 -0700
X-CSE-ConnectionGUID: D9XlVexHS26W0zu9Q7kBhw==
X-CSE-MsgGUID: LY5MqHWFRGuqlXZXBU7QXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24749882"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:48:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzdvH-00000000gCT-2H6G;
	Wed, 24 Apr 2024 17:48:35 +0300
Date: Wed, 24 Apr 2024 17:48:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] fs/ntfs3: Fix compilation error
Message-ID: <Zikbw9Z5p4XDiyMW@smile.fi.intel.com>
References: <20240423205634.3673120-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423205634.3673120-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 11:56:34PM +0300, Andy Shevchenko wrote:
> Compilation with CONFIG_WERROR=y, which is default, is broken:
> 
>   fs/ntfs3/super.c:1247:26: error: variable 'attr' is uninitialized when used here [-Werror,-Wuninitialized]
> 
>   attr = ni_find_attr(ni, attr, NULL, ATTR_VOL_INFO, NULL, 0, NULL, NULL);
> 				^~~~
> Pass NULL instead.

Hmm... Something weird is going on. I'm looking now into the code and
have no clue why compiler is not okay with this code. The proposed patch
seems incorrect anyway.

-- 
With Best Regards,
Andy Shevchenko



