Return-Path: <linux-kernel+bounces-166223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B398B97B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7A31C211E1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3948F54903;
	Thu,  2 May 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrfzZMut"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7BA2C6BC;
	Thu,  2 May 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642216; cv=none; b=an3O2OyNJ0qlqLQwYfLvcli8Jlp4iFlHtBeWtLlrv4PXfjCW2ZSn9Bsbnvxgz7JBGo7iTRJGUIjg57RtSYXXeAOPBs27RfXItdqtLzDX5zoYFcx0428qbltGAh22k6VMQAIKiJ22vsL4dAhyIuha6OsnqWqilLtqfriKAZjB6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642216; c=relaxed/simple;
	bh=JpCJBKENug99JXbw+5TXRfM0ZuevAoPOLpbNNp9xdiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhyCFoc79E7qIGDu61R5va3gn2X4D4KYXsmQ8RAxUO3OGKBf5imFcGllSYmoRq8reCERt74gszGYI1VxKTf0sBkuLDsKOt6Z+Jtxcng8k0RxHu1yN/JaCdGNMx8gWlaGjCY3QXtaGwrlH6nW8IIn+vvn0mZf122PiaFcPbaYhSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrfzZMut; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714642215; x=1746178215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JpCJBKENug99JXbw+5TXRfM0ZuevAoPOLpbNNp9xdiw=;
  b=KrfzZMutOtY9bzJUhHlhBaPC4lTpxjFkB8CqUVBB8mru0TlXCwNlHG4n
   gpTT32T+SHos1FadG2M+6R6a4HI1pdjRxBx93o4j9d6AFZFHefhRJyzmu
   pVIUh4k3wMVk5cJp7934/5VRlEq3FgrVlrJLWDUh+g9M/TvgDdwYNoIm4
   sos9IteF6nGs7CE5eAeXZNca3Pkv/Bfe/BgIHKLCK4j6rDmd2Co9pvFsE
   S75jRyRVh9TaZW9wTzQ+5JuE0/ZGe0AaGQtdQAandM8/t/L8aOxGOJaoP
   9/kB0KkL8lMJJ2h0BPF11TpSDNv5Ygzb4j+GQe1Pebhv4L9OhFSReUeOo
   Q==;
X-CSE-ConnectionGUID: smkmGoyASVy66C665nL72w==
X-CSE-MsgGUID: oxjR+YY8SdaNct0nXDwhhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="21091128"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21091128"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 02:30:14 -0700
X-CSE-ConnectionGUID: WOErYpKFRVmzkl7OuZHlEQ==
X-CSE-MsgGUID: 0Tp+Ac+pSnmNfZtlBulmFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27467729"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 02:30:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2SlU-00000003GNr-3YmU;
	Thu, 02 May 2024 12:30:08 +0300
Date: Thu, 2 May 2024 12:30:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: intel: Add missing module description
Message-ID: <ZjNdILvlyei-_Z7A@smile.fi.intel.com>
References: <20240430225826.65289-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430225826.65289-1-srinivas.pandruvada@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 30, 2024 at 03:58:25PM -0700, Srinivas Pandruvada wrote:
> Fix warnings displayed by "make W=1" build:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/intel_soc_dts_iosf.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



