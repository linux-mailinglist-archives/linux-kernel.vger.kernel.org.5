Return-Path: <linux-kernel+bounces-151607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21DB8AB113
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145D1284868
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F13C12F38C;
	Fri, 19 Apr 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J78Px5fw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205BF12E1EE;
	Fri, 19 Apr 2024 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538367; cv=none; b=MruHCEjqQJVn1AkjeUyTAuTjmgDBE5gBmPUG4qpyZzIz/GXtkoyL4UbLXmL8fRZnbVG8IPJRqlfaNxOReGkUaht2nIpIf/VK7MJFydeBJpNnVUkq15vLxM4t6+6FLva6eWEOmwFdc/Z1hKruur8BGwfqiPRsWL/3CyUxYHw1Bj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538367; c=relaxed/simple;
	bh=g0wcUxaLZSRrl1G0JddAfln9599kuRp5XGi4sszZTAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me4Rjr9vSZUVsqoCBAN7ljm56iSRCPmBX6cZAcxmNC8fmwiVp0Zo2bv8FJRyx1YU/tlag05tT5CcG91vCKUSyAmx0EcW5tGW8KyU2GaoTCQZGhqrVDrllvc3u5JBpNR2DmZ0gbFUSD6CbJ4SsmlplM73mwOL4S7h9Cl7aJELHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J78Px5fw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713538367; x=1745074367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=g0wcUxaLZSRrl1G0JddAfln9599kuRp5XGi4sszZTAI=;
  b=J78Px5fwWT9RlS+tksdBM/T8CMOr3EqOzoSRa/JTsWZuYcXul6ac702J
   iTrH3brHA1BS7gVSmMfqhoGux6KlWh0I/52oEMTU6FECHKk/T/uiH5CQK
   ohUWOxWbRwdKenpkc7BB6ly0IIONxlZpcfaWe7wuIFDHZvoCUAbtkwdOB
   fB7VQTMXpQ/06n2zwh8lwsbGTwUXfXRAhyaYcRgAARwaoR1kRCgcJWaun
   1vX955FmoDYhM8a5LVdz/D8UBd+y0hXE0ogqRPu7HaLOnjX5yiS2/DjD3
   PqSVdxmRo25rnVnXqfJrr5TFJXKBKIjtCGFnNhpZbt9HWbVhnGQjWKWX4
   g==;
X-CSE-ConnectionGUID: 3w+AdQi+Qc2Tkfdl3uKgPQ==
X-CSE-MsgGUID: fx9lGF9wTUqv/IjcjdXMBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="12933843"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="12933843"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:52:46 -0700
X-CSE-ConnectionGUID: q3jbjbEnS7eK8MTv25xLLA==
X-CSE-MsgGUID: P2OVXCe3TKqZplWdA7dvCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="27816226"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:52:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxpbS-00000000kxc-2G7M;
	Fri, 19 Apr 2024 17:52:38 +0300
Date: Fri, 19 Apr 2024 17:52:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Konstantin P." <ria.freelander@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>,
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
Message-ID: <ZiKFNllT9tMHlH7M@smile.fi.intel.com>
References: <20240419124506.1531035-1-rilian.la.te@ya.ru>
 <20240419124506.1531035-3-rilian.la.te@ya.ru>
 <20240419-glue-pyramid-584728c0076a@spud>
 <CAF1WSuy4OJVTU5VJdn23BSw4aTAq7i8UQ416V7BxveuQ+5=-1w@mail.gmail.com>
 <dc6573ba-37cb-4394-9a89-16b6f8caa7ad@kernel.org>
 <CAF1WSuzVLrsYt6+CyMHJuRbuXNEy2XnWhbHkcPHT3xXpB3Yh-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF1WSuzVLrsYt6+CyMHJuRbuXNEy2XnWhbHkcPHT3xXpB3Yh-Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 19, 2024 at 05:34:44PM +0300, Konstantin P. wrote:
> On Fri, Apr 19, 2024 at 5:24 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On 19/04/2024 16:17, Konstantin P. wrote:

..

> > Commits must stand on their own. Cover letter is not merged. This is the
> > place where you add new hardware, so here you describe and explain the
> > hardware.
> 
> It is also described in patch 3 in the series. I need to repeat this
> description in patch 2 too?
> 
> Cite from patch 3:
> 
> XR20M1172 register set is mostly compatible with SC16IS762, but it has
> a support for additional division rates of UART with special DLD register.

The point is, if I got it correctly, to have a few words in the description
of the DT binding itself, so whoever reads the bindings (w/o even accessing
the Git history of the project) may understand this.

-- 
With Best Regards,
Andy Shevchenko



