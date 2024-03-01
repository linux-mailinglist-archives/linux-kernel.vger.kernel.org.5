Return-Path: <linux-kernel+bounces-88924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE2D86E873
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE8F1C226C1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0587B38DCD;
	Fri,  1 Mar 2024 18:31:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036191E88A;
	Fri,  1 Mar 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317906; cv=none; b=saUj8wJzIA4f+o26VqBxn/5S6jPDP0i3Y6yrMBWqfk38Kdefxs9iUDq9L4BVnvFLROSWS45fHIb7Bud2cHSSc7r+srUSWrTTqmx2TXZ6MtERWrbE6Wd8JDbE2BasBOrz5hK4vNloOKMH7dmYMPsiERY8MW8PnhEaaJlqt/5UZtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317906; c=relaxed/simple;
	bh=uvA7MIHTJcGenB7nrHefgXzSSiCHXiAuvFdOm0hCOro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVUFtZensBr92ZMNKbpeVJVY0MDlqEYyNBR/CLy253FU5s3TDvtu4ptIRtMymcRnqwpBEm73OVBnpOLKc1LFhsCNCfexWWcn9LrAysTH4QV03biy6Aae8V/owwfZ9zdxAmENa/kMuZZ1y6QuhYiXV35gWVcxDyl4xks4pW2eMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14573814"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="14573814"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:31:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="914022371"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="914022371"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:31:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rg7fH-000000091u5-0DFJ;
	Fri, 01 Mar 2024 20:31:23 +0200
Date: Fri, 1 Mar 2024 20:31:22 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: geert@linux-m68k.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, pavel@ucw.cz, lee@kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/4] auxdisplay: 7 segment LED display
Message-ID: <ZeIe-tr2IpwFvKw9@smile.fi.intel.com>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 01, 2024 at 02:41:59PM +1300, Chris Packham wrote:
> This series adds a driver for a 7 segment LED display.
> 
> I haven't had a chance to look at the gpio changes that'd be required to
> have multiple characters as subnodes. I wanted to get the code that
> addressed Andy and Rob's comments out before my weekend.

Thank you for the update!
Almost fine, one more iteration needed for some minor fixes.

-- 
With Best Regards,
Andy Shevchenko



