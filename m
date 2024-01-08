Return-Path: <linux-kernel+bounces-19961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C6827783
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7179D1C22C14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570CB47793;
	Mon,  8 Jan 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leA/eWMR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B654F80;
	Mon,  8 Jan 2024 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704738778; x=1736274778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F+MtWtXNmcKgKfhazz5ks8Nh+6BaSWwtIMg/qzqL/8A=;
  b=leA/eWMRG1IX/4G6jy/EM0GsCF0bYqpkn1c9Gc1YpHmyBuy739gcHVRz
   OWkXwLdOLdduZNLEPuXfgHpnR7TYPEkEo6VmTHKg9AQpuarTxZVlpXjK9
   lG4FAXTuw1vo8q/iw4aB7NGG+yAFOsKRWbTsxXLdpDOnmpFkN7HSYJjwd
   YDtm0GmDrNB1W1PuwsyXPLYNA2HUS4oPPB/KIssG/KicXsB829EdWkPFX
   uWgXZh6TJ5+9/GYNGfCwXP6J48tJRm2G5pg8+FykdUmK0+8fvnBuGgCUS
   0G5ZsUNSOs9J40HS5qzPaexi4WOL2lF4EVyTYAcCry7UL4qbeVpeSsS5v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="484147853"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="484147853"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 10:32:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1112807511"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="1112807511"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 10:32:54 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5021A11F7E4;
	Mon,  8 Jan 2024 20:32:51 +0200 (EET)
Date: Mon, 8 Jan 2024 18:32:51 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 22/24] device property: Update functions to use
 EXPORT_SYMBOL_GPL()
Message-ID: <ZZw_0yw8PoBrFMHS@kekkonen.localdomain>
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.22.I186bc5737c5ac4c3a5a7a91e9ec75645e723ca7b@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102140734.v4.22.I186bc5737c5ac4c3a5a7a91e9ec75645e723ca7b@changeid>

Hi Mark,

On Tue, Jan 02, 2024 at 02:07:46PM -0700, Mark Hasemeyer wrote:
> Some of the exported functions use EXPORT_SYMBOL() instead of
> EXPORT_SYMBOL_GPL() and are inconsistent with the other exported
> functions in the module. The underlying APCI/OF struct fwnode_operations
> implementations are also exported via EXPORT_SYMBOL_GPL().
> 
> Update them to use the EXPORT_SYMBOL_GPL() macro.
> 
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>

Thanks!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Regards,

Sakari Ailus

