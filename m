Return-Path: <linux-kernel+bounces-142947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6638A326A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D8E284CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C083147C95;
	Fri, 12 Apr 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqDJWi85"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6D137C59;
	Fri, 12 Apr 2024 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935655; cv=none; b=kSNw68q1ptJYNRjv4XNtKANJ9eTBZSeOlnJkiWO/NZywqiD8xiM0sYX9FGBLGE9tDx/8bm/BN590Ia6qamSYy0PU0RmOeoabBx73TaGO1qqBi8cAd08gs0+x1wWumq/WaXIvEZtTafAsERkREjZVn9VWwdFtTB5m/bQ1QlV3Gg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935655; c=relaxed/simple;
	bh=3ocp6HJUXvmCPVFIur9qbSPmsfazTRISGOaIoLPoDO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSlCkqDHVZeRkz+GzOAnHq2TrFniBTpN7OrGRuGphKo+VUsgJp4NCIXu5h62JbQxzYLhfB04OuTi+Su1AhFLGOn9ECzDoiQUvBiw/mx2YT9/Xn5eeuHHKdYutB8cvCNdPQCbuqGq80vaeHxGsJtUBKj5hlCbPYmSkJzWg1zltFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqDJWi85; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712935654; x=1744471654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ocp6HJUXvmCPVFIur9qbSPmsfazTRISGOaIoLPoDO4=;
  b=dqDJWi85uo2b5nj2Yz5YPHnLM6QAjZq/pfIrFJZrtuNQ8JMH02Lct0ew
   Q4At+IsceI1AG8Ypgt90VJ7UQ3ZKbNk1ezD+wCWVmZuSYrGUyoWhNpcRW
   xAaSQ59ztF1UBXgWuWC3X2C5no52hOeOc3VT20vzYuoD7DfhzZGijN5po
   WTzTOwQ79FUdg+WCQyctfkl6AdjEyFNSFAq3Yifv9cCkxU90nq/xwJjn4
   sTVibuDIa7xfZCClDCp/xa2KXzmDanwuDvZpHuH/APK7th44F/MuYvj3V
   ff6cz+TZVYn4SMN6q+2Nas6a71hueFQKizNilbp83voqI45/AUgcCYYhR
   g==;
X-CSE-ConnectionGUID: bBV3cOsIRbmjjQzPFRiAOg==
X-CSE-MsgGUID: lVm6iX6uRfO7WB6c3wt99g==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12186314"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="12186314"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:27:34 -0700
X-CSE-ConnectionGUID: 71/Qep/DT0OF6e0hYWCLVQ==
X-CSE-MsgGUID: ljtoSLqtS9qZbPYhubwGnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21245359"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:27:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rvIoL-00000003gkX-1Kl8;
	Fri, 12 Apr 2024 18:27:29 +0300
Date: Fri, 12 Apr 2024 18:27:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the fpga tree
Message-ID: <ZhlS4VrShNwoL4IF@smile.fi.intel.com>
References: <20240412151147.22a059ff@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412151147.22a059ff@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 03:11:47PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the fpga tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/fpga/ice40-spi.c:201:35: error: implicit declaration of function 'of_match_ptr' [-Werror=implicit-function-declaration]
>   201 |                 .of_match_table = of_match_ptr(ice40_fpga_of_match),
>       |                                   ^~~~~~~~~~~~
> drivers/fpga/ice40-spi.c:201:35: error: initialization of 'const struct of_device_id *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> drivers/fpga/ice40-spi.c:201:35: note: (near initialization for 'ice40_fpga_driver.driver.of_match_table')
> drivers/fpga/ice40-spi.c:201:35: error: initializer element is not constant
> drivers/fpga/ice40-spi.c:201:35: note: (near initialization for 'ice40_fpga_driver.driver.of_match_table')
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   5d04660b29fb ("fpga: ice40-spi: Remove unused of_gpio.h")
> 
> I have used the fpga tree from next-20240411 for today.

Okay, thanks for the report. I'll send a fix soon.

-- 
With Best Regards,
Andy Shevchenko



