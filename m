Return-Path: <linux-kernel+bounces-7223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54D181A36C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C301C23B00
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CC44644D;
	Wed, 20 Dec 2023 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLxiblT9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BF41206;
	Wed, 20 Dec 2023 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703087931; x=1734623931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ANyYmF935R/SIazsemldieHjpe61LMqbySrIbyIHSQ=;
  b=eLxiblT9baoxC3iMD9bjDAdH6QJWlG5IBd8LNMYis1p8/tqjJYgJQPrN
   T8Wr9+v2q1lu5BJkg0049nN7/ZuLd/ZsN5EvNBr03Nt0JE7/3SzLWSXfw
   UEGZ9jG8DQ4TDy3jBvii06AqvbjyVxv3+QIX0bI89707e8V7z0WSi1g8G
   4v8NCV5B21RSpw9wcjcmpH2l+v58UYSPlnF4kzxB3BNFwubFNX1Rg0YyK
   NMPtUtIFshbAvviXCOWj++qKrii/mRzyjr0Q4r/C/y/sKk6QKilY1UJgq
   hm5gJ/g6xm0ffEVC3kAkQy+rbpjq7ieTfiVYal7bTfHpa1u0EAhov6clp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3052934"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="3052934"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:58:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="769626352"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="769626352"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:58:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFyy1-00000007au4-0u41;
	Wed, 20 Dec 2023 17:58:41 +0200
Date: Wed, 20 Dec 2023 17:58:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 16/18] serial: sc16is7xx: reorder code to remove
 prototype declarations
Message-ID: <ZYMPMK2NqGByJnRa@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-17-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219171903.3530985-17-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:19:00PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Move/reorder some functions to remove sc16is7xx_ier_set() and
> sc16is7xx_stop_tx() prototypes declarations.
> 
> No functional change.
> 
> sc16is7xx_ier_set() was introduced in
> commit cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")

Missing period after ). Otherwise LGTM.

-- 
With Best Regards,
Andy Shevchenko



