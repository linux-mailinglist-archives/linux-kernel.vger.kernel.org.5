Return-Path: <linux-kernel+bounces-158330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F1F8B1E75
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F25FB287CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB3D85953;
	Thu, 25 Apr 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+5+CW2w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7584FA9;
	Thu, 25 Apr 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038625; cv=none; b=Aeznhcz3HEq5jx0GRzvbsZHI0tT5FBvXTxISRTZ51yD20te/u1aiOwe8/brVlFTdDPhQ5Y0l5V1qqj/JoZ/O4u0YJy1M2tTvUOFm5h7v38kCNuGkgw4AFkU2Y5BHDcb70yDruebXMoMSulj0zqjoxt8HUmFjnXM975cvr5Up/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038625; c=relaxed/simple;
	bh=uC4kA70xl93pLuFD/UoEPvIqfy9CGMqdBnnLhXJ/cBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0RrrI19gRVwFEpxYvxqueOhkz1wUcivqBgg18MRUiCEaIGjTBJXZsmN2LmnV+IdkY5gj3kkZYr2dvRFyED63gwfliuBAStpbuX3PRVq2LW25BL/dbUE1eBsOMaw/U5Oy8sUHA8oMRJ1zLeBT9UQTdPt+gCwa1EgBD4yR8SXDwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+5+CW2w; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714038625; x=1745574625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uC4kA70xl93pLuFD/UoEPvIqfy9CGMqdBnnLhXJ/cBo=;
  b=P+5+CW2wjWoxriDmMXkV0lP7dNpw1xrmOiVYlrV1lioC8DqWVM6RJXS5
   yaq8r/ufyDpyz7oF/p5QAp69Wuj1LjpaW8oFM77v6Dz8OKUqezHTaWy2/
   HxuoNievGncRYftJrwGq9ez82Ir2CzaqG8f59/yej7+hdcAM2wNtCgHtj
   aVj82Pzxlj4lsw/ew4p9XQLei6HfLvySvldckUYBQOTaP+riB9k2ra145
   WWDseSA2bCwdW1uNNcFxtr26cWIMcAR28yTLUOXpPvO55xTcT0gGnyUGk
   Ycpz395fxtobQ8p0jIiQhjHQxD+/AORIMKAD6MD4+8zffOXZusvl4HWSf
   w==;
X-CSE-ConnectionGUID: GwBduIHkQ1aIAq7rPCE8FQ==
X-CSE-MsgGUID: 0LCnd31GQJePku8meyYfpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13546863"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="13546863"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:50:24 -0700
X-CSE-ConnectionGUID: BWhnmIHyQm+oMO9OMsFKcw==
X-CSE-MsgGUID: tnRuId7DRZe98pwRC8vrCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29644225"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:50:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzvk8-00000000x7w-3GXg;
	Thu, 25 Apr 2024 12:50:16 +0300
Date: Thu, 25 Apr 2024 12:50:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, tony@atomide.com,
	l.sanfilippo@kunbus.com, tglx@linutronix.de,
	geert+renesas@glider.be, ulf.hansson@linaro.org, peng.fan@nxp.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFT PATCH v2] serial: core: Call device_set_awake_path() for
 console port
Message-ID: <ZionWJ7ods60zuYX@smile.fi.intel.com>
References: <20240425070936.547100-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425070936.547100-1-claudiu.beznea.uj@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 25, 2024 at 10:09:36AM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> In case the UART port is used as a console, no_console_suspend is
> available in bootargs and UART port is part of a software-controlled power
> domain we need to call device_set_awake_path(). This lets the power
> domain core code know that this domain should not be powered off
> during system suspend. Otherwise, the UART port power domain is turned off,
> nothing is printed while suspending and the suspend/resume process is
> blocked. This was detected on the Renesas RZ/G3S SoC while adding support
> for power domains.
> 
> Based on code investigation, this issue is present on other SoCs (e.g.,
> Renesas R-Mobile A1 [1], IMX8QXP [2]) and different SoCs have particular
> implementation to handle it. Due to this the patch added the call of
> device_set_awake_path() in uart_suspend_port() instead of having it in
> the platform specific UART driver.

> [1] https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/pmdomain/renesas/rmobile-sysc.c#L116
> [2] https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/pmdomain/imx/scu-pd.c#L357

No need to have the HTTP links into the kernel sources, you may simply refer to
the files in the source tree.

[1] drivers/pmdomain/renesas/rmobile-sysc.c:L116
[2] drivers/pmdomain/imx/scu-pd.c:L357

> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The rest makes sense to me as we also have an internal hack to achieve
something similar in the case of Intel LPSS (8250_dw).

But I like Tony to comment on this, from my perspective it's good:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



