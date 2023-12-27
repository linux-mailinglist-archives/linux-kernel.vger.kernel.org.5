Return-Path: <linux-kernel+bounces-12170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120F081F0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E062823A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE9646521;
	Wed, 27 Dec 2023 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbmnqlA+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEEF45BE0;
	Wed, 27 Dec 2023 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703697991; x=1735233991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hlkUwbDWvK8KsZE8U1/eeGcZHCBPmwFQ/HYeIrknmxY=;
  b=fbmnqlA+bmug7VF5vKk1BUWiGM3kGSwGu93Mf3VHpFfhETgqsrhaGHHH
   NnuL2fFxERh4z1+E7EpOksoq7kEmKcpR56doMGryAI3c7S0Swve8VwrPA
   dX9dLOA2qzKte0bKBApt0PdFJGGQCLb61LqGG+RwjjVFOVVBWPcogRAZp
   IDdM6IRfJ9HkP1X9YZJM+A2nxz0oEJtBmvHURkffH2zwP2bxy0qduGeMA
   m92OpqrKpczue9r22pv2rr8U068IQT/pqhSFcfx+0x44GVzyGBH7nG4Lh
   qOFtJpFrDdJGYzHQAZqYnf4qdJ0uU3f2j2uq6MkLz+kFSHPzd7i6klKGr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="400280270"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="400280270"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:26:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="901732654"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="901732654"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:26:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIXfk-00000009TUR-1WNu;
	Wed, 27 Dec 2023 19:26:24 +0200
Date: Wed, 27 Dec 2023 19:26:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 22/24] device property: Update functions to use
 EXPORT_SYMBOL_GPL
Message-ID: <ZYxeQCfaaAnZY6KA@smile.fi.intel.com>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.22.I186bc5737c5ac4c3a5a7a91e9ec75645e723ca7b@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226122113.v3.22.I186bc5737c5ac4c3a5a7a91e9ec75645e723ca7b@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 26, 2023 at 12:21:26PM -0700, Mark Hasemeyer wrote:
> Some of the exported functions use EXPORT_SYMBOL instead of

EXPORT_SYMBOL()

> EXPORT_SYMBOL_GPL and are inconsistent with the other exported functions

EXPORT_SYMBOL_GPL()

> in the module. The underlying APCI/OF struct fwnode_operations
> implementations are also exported via EXPORT_SYMBOL_GPL.

EXPORT_SYMBOL_GPL()

> Update them to use the EXPORT_SYMBOL_GPL macro.

EXPORT_SYMBOL_GPL()

...

With the above fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



