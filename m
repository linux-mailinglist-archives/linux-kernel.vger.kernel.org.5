Return-Path: <linux-kernel+bounces-151605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCEB8AB108
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B656282467
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A7712F378;
	Fri, 19 Apr 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtsxEuI8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACAB184E;
	Fri, 19 Apr 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538192; cv=none; b=doLT5nsVnW6TzK+7XDIAa/9NO7JTYLGbVVfYlAQeXDHjgTTa7MtcVZHmsgcMx7vumjbiAiW8Yi8o6ByhR/xDeqVUUX7e/YwTrF5OXXJEUG+ExFi6IzFHzOwbllP1aEE4phryIcVS4vX8qga1nyalUsv/u8aK/hPPBTtMW51cktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538192; c=relaxed/simple;
	bh=ysWgaxTPf8BJMj2t9+aUTQlJaUaU+9JoXqUd/hdOzSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1nOZ3aMnxwOMgAsdCPwf/LimPJkZ5HDvtVhwKE4PRSLPAd+33of7vJbQIWSpMXr1d+8z8ucnlkqdlnsq1aNPHjKp1psUV8FbZZqYoFJqCjx+HMLvJsgsQihnUoypHcYNopqSIGpq/VjoGjr8Sbnb9RoEmYoEw/w1ZgI+5G1dNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtsxEuI8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713538192; x=1745074192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ysWgaxTPf8BJMj2t9+aUTQlJaUaU+9JoXqUd/hdOzSA=;
  b=OtsxEuI8NXOVv4764lEjGhozzXjxDl/gn1gSnWd8v+SngN5Tq2TjqQY6
   HdGRpHfLHEcuP37QgbjS/2I61YGtHh42YTAx+AtE9GOYwWAdH9XK5IvWx
   APU7Kun+WIG2IP6mdrWvKQ8TbgDDBzWi75MAL+poGwv7RKvi9Kx9YYbNF
   /P94VnL0V570RQyEyl+hW+ZeiLV1mOYWkE+SBprQtwfWI28Gzx1GeWB4A
   W5AP3wDLGFa2lwyVpwMeeA4/1Mfk9tmCu6TM3NBQQMx67YpICbPtq1FGO
   V6IgYTKhuisBQgRkyhSToUHLDCZLy4dWXXluQUZ+dfApQpHAU4E/e/nwI
   w==;
X-CSE-ConnectionGUID: mCZID/L0Q9GUXWkM742TnQ==
X-CSE-MsgGUID: 6vOUr+n1Tl2xl49kCTYBdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="8974764"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="8974764"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:49:51 -0700
X-CSE-ConnectionGUID: Re20F5ooTDuxwbPVlJJ1zQ==
X-CSE-MsgGUID: YnzbeqyySuCUc13mnNU2hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="28128493"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:49:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxpYd-00000000kvU-2NXy;
	Fri, 19 Apr 2024 17:49:43 +0300
Date: Fri, 19 Apr 2024 17:49:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Konstantin P." <ria.freelander@gmail.com>,
	Conor Dooley <conor@kernel.org>,
	Konstantin Pugin <rilian.la.te@ya.ru>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
Message-ID: <ZiKEh52d9Y0FitfT@smile.fi.intel.com>
References: <20240419124506.1531035-1-rilian.la.te@ya.ru>
 <20240419124506.1531035-3-rilian.la.te@ya.ru>
 <20240419-glue-pyramid-584728c0076a@spud>
 <CAF1WSuy4OJVTU5VJdn23BSw4aTAq7i8UQ416V7BxveuQ+5=-1w@mail.gmail.com>
 <dc6573ba-37cb-4394-9a89-16b6f8caa7ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc6573ba-37cb-4394-9a89-16b6f8caa7ad@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 19, 2024 at 04:24:16PM +0200, Krzysztof Kozlowski wrote:
> On 19/04/2024 16:17, Konstantin P. wrote:
> > On Fri, Apr 19, 2024 at 5:08 PM Conor Dooley <conor@kernel.org> wrote:

..

> Commits must stand on their own. Cover letter is not merged.

While the first is true, the second one depends on the maintainer and tooling.
For the patch series some maintainers either already use custom, or started
using `b4` feature to make cover letter to be a merge commit-like message.

Yet, it's not the case for TTY subsystem AFAIK.

> This is the place where you add new hardware, so here you describe and
> explain the hardware.

-- 
With Best Regards,
Andy Shevchenko



