Return-Path: <linux-kernel+bounces-25517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1033282D192
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 18:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BB92823EA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1C3568D;
	Sun, 14 Jan 2024 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpvRF2RV"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C8566A;
	Sun, 14 Jan 2024 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705252178; x=1736788178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w0C7Y42iMUvEZrazpl/+nsFsK8w/Ws2SVqeMLM7RlSw=;
  b=DpvRF2RVcdIsKO8SNsbuW2W+jqNnryAGFZB+TL3crHEUaHTib8oMzQGE
   YW66I36Q6RurQEbwgVF+o7fnwpw8xQ1qjxr660CBxrIgRIYqFWefmgpU4
   vf4lBykp3m/ooW6qTYvByqNLbbfNQQOAZJWDQDK3wBC7UwY+Qm5brPzgw
   RgJYGCVf5EkV8/Q7lisWSMA+ujUDz3yrwpavqdJ0WuXGX3VmTLTKFzIQO
   mxJWQFU7nZbhhtZuY4As6cgA8zqdJqIxbeShVF5aNZ3X9NJp6UmdgkJvV
   XfCotk0DM7TMIK/tb3xkS9HkIDmY4NOjGpLdCYeVIOioLr//+++fqBTBv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="396621404"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="396621404"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 09:09:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="759643084"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="759643084"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 09:09:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rP3zF-0000000DyBQ-32J1;
	Sun, 14 Jan 2024 19:09:29 +0200
Date: Sun, 14 Jan 2024 19:09:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] firmware: coreboot: Generate aliases for coreboot
 modules
Message-ID: <ZaQVScQ2AYquG-Zr@smile.fi.intel.com>
References: <20240112131857.900734-1-nfraprado@collabora.com>
 <20240112131857.900734-3-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112131857.900734-3-nfraprado@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jan 12, 2024 at 10:18:31AM -0300, Nícolas F. R. A. Prado wrote:
> Generate aliases for coreboot modules to allow automatic module probing.

..

> (no changes since v1)

Same Q as per v1.

-- 
With Best Regards,
Andy Shevchenko



