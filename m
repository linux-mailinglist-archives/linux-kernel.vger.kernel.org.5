Return-Path: <linux-kernel+bounces-148735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB358A86C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4775B287A26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805F1422A4;
	Wed, 17 Apr 2024 14:53:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6213D24A;
	Wed, 17 Apr 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365621; cv=none; b=QAjHrf0E92E4OdyElWZJB6/0mPrx9kLAVoqzWzmDs4UStmMJ69R5QEDDlfiM8o7hU0zJlp39Rg8gLeQtdLL537Vv46Yz+jyfldwFImfGnAOEmGfqLfc5dZ4azJZ/SUxCQXAGepON8p+lC86RXHfYuyb6QHWhyUwBGRp12PHZc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365621; c=relaxed/simple;
	bh=7SNM5GZDurYtgpeoMmLJ7ejYSH9vVUcjJXUXLjZHY2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na6PsR0+NwxR7ELRENmXpGQmjmfgSEI0CkMDZdKhwznVoye4nbDrIUvMMSDJ+9b1ynK3vhSr6X3+wN2EU5soyiSQiLnm44wCCTERgSA39jfn8ufKQ6boBm31HJeUz0+sGbGyPNqXJkIOo4J8RC2ttL7RpTw+LXDUT4M5r/VyavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: m2xIabjvQF6NmsjFNfdfOg==
X-CSE-MsgGUID: VjD7vwsaSI247dvAEhSW/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8726606"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8726606"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 07:53:39 -0700
X-CSE-ConnectionGUID: 469OcrOyTH6csSgCd+yI2g==
X-CSE-MsgGUID: kZUYMOd7Sv2S4PIWg6/a3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22730571"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 07:53:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rx6fH-000000004QL-18Os;
	Wed, 17 Apr 2024 17:53:35 +0300
Date: Wed, 17 Apr 2024 17:53:34 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: keescook@chromium.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] string: Implement KUnit test for str*cmp functions
Message-ID: <Zh_ibi_Y6xogktg-@smile.fi.intel.com>
References: <20240417135415.614284-1-ivan.orlov0322@gmail.com>
 <Zh_cgnMOFHuP-lKu@smile.fi.intel.com>
 <10085ec8-0109-444c-bce4-d0b0ef1a4164@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10085ec8-0109-444c-bce4-d0b0ef1a4164@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 17, 2024 at 03:46:44PM +0100, Ivan Orlov wrote:
> On 4/17/24 15:28, Andy Shevchenko wrote:
> > On Wed, Apr 17, 2024 at 02:54:15PM +0100, Ivan Orlov wrote:

..

> > >   lib/strcmp_kunit.c | 170 +++++++++++++++++++++++++++++++++++++++++++++
> > 
> > Why is not part of the existing string_kunit.c?
> 
> There are already 2 other KUnit tests in `lib/` covering different groups of
> string functions separately (lib/strscpy_kunit.c, lib/strcat_kunit.c), so
> this patch just follows this pattern. I believe it makes sense: the tests
> are separated to cover one specific group of string functions with a similar
> purpose

We have handful of the string functions, are you going to have a file per
function? Isn't it way too many?

P.S>
Having those does not prove it's a correct approach. I would rather expect
somebody to incorporate those into string_kunit.c.

-- 
With Best Regards,
Andy Shevchenko



