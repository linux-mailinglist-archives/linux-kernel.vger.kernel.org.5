Return-Path: <linux-kernel+bounces-158453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B498B205A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1524F282512
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC25212AAD4;
	Thu, 25 Apr 2024 11:37:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F084E11;
	Thu, 25 Apr 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045034; cv=none; b=MsaVdIT8y02G0/a+9xHDDq6V4qJsnHI8qKCsuhUcCCB3JAwSH7RLlGURKmwpOX9lyBPTGz/K567Q7MuRFzY/fXex/reX5er3P+bTybZt5wcoU/EN4KiMQw4m1FoBcIxLc1z80bnQkDJjPb09mCdgr9l3zYeP8uiXDKFqmf2t0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045034; c=relaxed/simple;
	bh=7J+mmeT+8DslaIOcleJfv4UKmJfNlM447+noEVzc4R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc414I+7y6WRp9NcXl08bHjvj3poL8K4ZRzFISr3xB1MyJ6mqoDLliG7TmZ2o4ql0aAHrHmY6MsDrEZ3YxkPqFg4zaq6PzazvGN0czb5yv+YRakBztX23WQZiqWNkHjeKd24MNkFz08b52zbeFu3ag2fnUOzpmcjfs5xZFiMCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: R7R64es4Q+qYqrBXahAHoQ==
X-CSE-MsgGUID: UVddoimvTQmm8pORkAl/yg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9588376"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9588376"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 04:36:57 -0700
X-CSE-ConnectionGUID: UJKutA7VQiq+4zXuML1fXA==
X-CSE-MsgGUID: DJAOAm5QR2+lJQlMOCDDEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29667230"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 04:36:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rzxPI-00000000ydJ-2bzV;
	Thu, 25 Apr 2024 14:36:52 +0300
Date: Thu, 25 Apr 2024 14:36:52 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Aapo Vienamo <aapo.vienamo@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Elliott, Robert (Servers)" <elliott@hpe.com>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] gpio: Add Intel Granite Rapids-D vGPIO driver
Message-ID: <ZipAVAmrK3NEDow8@smile.fi.intel.com>
References: <20240423181314.84677-1-aapo.vienamo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423181314.84677-1-aapo.vienamo@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 09:13:14PM +0300, Aapo Vienamo wrote:
> This driver provides a basic GPIO driver for the Intel Granite Rapids-D
> virtual GPIOs. On SoCs with limited physical pins on the package, the
> physical pins controlled by this driver would be exposed on an external
> device such as a BMC or CPLD. The virtual GPIO registers are an
> interface to firmware, which communicates with the external device that
> implements the GPIO hardware functionality.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



