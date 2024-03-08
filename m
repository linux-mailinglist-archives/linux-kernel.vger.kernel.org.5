Return-Path: <linux-kernel+bounces-96989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD44876420
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2938D1C21709
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC625676F;
	Fri,  8 Mar 2024 12:15:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D253818;
	Fri,  8 Mar 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900099; cv=none; b=haikQJsIcwzTBbbHEoLaTAPGEF1AFgufd2lWOU4QlEL6zGT6E/smaOdKfLs1ePgzn2OLNlS5+lcb1Dcnb24WnszmDjQdWIpkndeCaWeLGdqu49uJge+tHdLvboyAbYJhZxGYB6DmqXUv0oXaO9A/JFSdlkoRpepsAzbNoHyEF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900099; c=relaxed/simple;
	bh=c4Cwm7ifvWc4RvPOyc1rd7U9MyD/SxSzIcTCM4uUkCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwLKA/+jc19x7Z5RqdT7C/iuSRbZjdSfcZizYmt6wd1D4tpBasWvgVg5ZfP/XpVdBvn2SSqIc+pb+1E+tJtb//jt7Bznp+Dlgh0xYXCRy4XRbVu1NYmPpciELbnkijwj/4RSg0PJpHwbpeaVCN8wYAuphdiopftsVMOK0umdhp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="30058511"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="30058511"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 04:14:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914245050"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914245050"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 04:14:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1riZ7j-0000000Aprm-2vuP;
	Fri, 08 Mar 2024 14:14:51 +0200
Date: Fri, 8 Mar 2024 14:14:51 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: geert@linux-m68k.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, lee@kernel.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/3] auxdisplay: 7-segment LED display
Message-ID: <ZesBO16D21b6sXLe@smile.fi.intel.com>
References: <20240307195053.1320538-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307195053.1320538-1-chris.packham@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 08:50:50AM +1300, Chris Packham wrote:
> This series adds a driver for a 7-segment LED display.

You were too fast to miss some tags, but they are related to the last patch
which according to Arnd's suggestion I'm not going to take right now.

So, the first two on their way, thanks!

-- 
With Best Regards,
Andy Shevchenko



