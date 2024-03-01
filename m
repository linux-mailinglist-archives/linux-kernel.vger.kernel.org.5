Return-Path: <linux-kernel+bounces-88918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFBB86E85C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149B31C25434
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C9C2746D;
	Fri,  1 Mar 2024 18:24:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3F848D;
	Fri,  1 Mar 2024 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317482; cv=none; b=qtVQfK0e3ecDK02mErI0OGh79PvsxRJdkXAKbZl50Z54n6djyh2e1VSvyYxq0yNO4PDD0vEp+jWbXYrDsELcUBnDrs1RQKq1L5hYs5OuWLa5Hidsn/G0lXDzQyeXRzI5RG0436Dmdn40nOeY77KFCCuRfeczj2eopuk41OfsyCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317482; c=relaxed/simple;
	bh=vL6xWl5F2pgEMsvcwxEKxmayobLaqsGZdtA5sxipykg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCsN7As86r9SvAu78QS2d4WNoecGkYq7+sxLLSzcliDhtEXAwVW3vLZU42pN8bmcvdBD1eRfYIupduISB/39+LIOvRuyZS9MIaU4ANu/wFCfwWMuo16fa+yYi2XNTP5BQr/hnmCQ1Da+aOG1u/0Epm6jTX+YlJ9v1ZJPvL+qbIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14572584"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="14572584"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:24:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="914022215"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="914022215"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:24:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rg7Ya-000000091nn-1EHn;
	Fri, 01 Mar 2024 20:24:28 +0200
Date: Fri, 1 Mar 2024 20:24:28 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: geert@linux-m68k.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, pavel@ucw.cz, lee@kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] ARM: dts: marvell: Indicate USB activity on x530
Message-ID: <ZeIdXIx5zYjKQiSO@smile.fi.intel.com>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-5-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301014203.2033844-5-chris.packham@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 01, 2024 at 02:42:03PM +1300, Chris Packham wrote:
> Use the dot on the 7-segment LED block to indicate USB access on the
> x530.

As I said, I'm not going to apply this even with Acks.

The problem here as I see it is the future decision on how DP should
behave like. If you put this into DT, we will to support this to the end
of the platform.

So, drop this from the next version. You may try afterwards to apply it via
different routes (will be not my problem :-).

-- 
With Best Regards,
Andy Shevchenko



