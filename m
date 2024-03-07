Return-Path: <linux-kernel+bounces-95512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DC1874E9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478151C20C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5A7129A8A;
	Thu,  7 Mar 2024 12:07:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E813233;
	Thu,  7 Mar 2024 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813262; cv=none; b=tgPmyok/egrUl9UwUEqLcMzrtSSiF4/Nn5C5ucX48zcaEOspaNzgEIt6DB5yTnLmpjYQevzLTBy70ruIMLsTxPAqkFj7gKTKzvYv87hxciqWAdWfYxBQYqT3gfEa88qW/uFOAfR+ykdcfrBqW4Dl83SPJlLqP+ZAUmd7hrIx4M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813262; c=relaxed/simple;
	bh=QMIfzGcY3K+mHYmT4fNfZyE3xXCFUNGyqDsOWla87Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6Kv2f+f8oCrNX8OQhAHSji3W7OQF6UNtmCtw2ZOh3t07tJZdmqEwIAocdguc5H3XOmYmQzcZGY2TIOyNqUhph20jxrfsCT6u/VGCFN3zxrjvQF0aVhXCPnLOr9ife1rKDiKiUkoRXLU5MDBO6JioQ/a7/9fgnRaSulT4LiCO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4341743"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4341743"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 04:07:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="914212665"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="914212665"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 04:07:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1riCX8-0000000AYR2-1Pve;
	Thu, 07 Mar 2024 14:07:34 +0200
Date: Thu, 7 Mar 2024 14:07:34 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: geert@linux-m68k.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, lee@kernel.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/3] auxdisplay: 7-segment LED display
Message-ID: <ZemuBvyP24kNH0ZK@smile.fi.intel.com>
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 12:50:18PM +1300, Chris Packham wrote:
> This series adds a driver for a 7-segment LED display.
> 
> I think I've addressed all of Andy's feedback in this round. I haven't
> heard from the ARM maintainers on any of the previous rounds. At Andy's
> request I've dropped the USB LED change as it's not related. I can
> submit the dts change separately if required, I've mostly been including
> it so there is an in-tree user of the driver I'm adding.

All LGTM, I need a Geert's Ack/Rb on the first one and DT maintainer on
the second. The third one I have no clue by heart who, but somebody related
should also give a tag.

-- 
With Best Regards,
Andy Shevchenko



