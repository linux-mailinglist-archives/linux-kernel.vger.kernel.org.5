Return-Path: <linux-kernel+bounces-151216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CB78AAB39
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC3028234B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB027B3FE;
	Fri, 19 Apr 2024 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgfJxwHz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AA78276;
	Fri, 19 Apr 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517825; cv=none; b=Sl3fsseZhsucIGdqQjlry6HPdk5t6fr5sqaZizyl+x/erWHn3h57Dydrvi6gmVHH3QXfjhQ/1xZtYX6GxmbrtHFWSe6iI4JgyxRvX0OZwDtBRVgmb6ZyMB/Xn/AXwn4O9Kpj+g+uYoUOqcpRe0VtarOv65wtj28qatv4NotZE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517825; c=relaxed/simple;
	bh=LZkmvma4B22MpUpSB/Kxjj7wTeNAjYu4yV5s+TYTD2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAsNk/432sc7QyW7IT5rWxWFkYVXRDTfnszXMUDAzOhnEZQQLSjVzCIg1VO3xcNl4EE1x1ktcwup+/qxL0rUSkz6q//nphROcVsnZnJNP09hCCxOF94w32aqn/0kSKJ1TqfA67vwf4ZnQOBgthFLjspBLWyFyLBpD5/qV3m9uLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgfJxwHz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713517824; x=1745053824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LZkmvma4B22MpUpSB/Kxjj7wTeNAjYu4yV5s+TYTD2A=;
  b=hgfJxwHzo06nvdMpusV51LNmlbqFIRXFMkWKhgsP4v45VH6EdCid1K0x
   e2MiKbN5+Yv/R4vVzad2B7qFyR7ZTtIxzajfAlh86lDJ8ZkHlvXwucwqt
   FX52W2b2Pf5iJZ66jcQfzZiyknyX4si0/hoWJWGbZIyrLCiWeMWYvzCi7
   fHNdud8dd1DJPqj2oWDnCirzYnTKDx3QxFl8/TLL7/4oU0VS8tSVy46J0
   SzFK7YBc4zLLqejgkz1q1J3OAaziz9ApPQvjGHT7GD8T/EPP1cvlkZwTI
   v8ubnk0YsXzMKuVLOqk1wWjWnzM9X2X3dM+MXHNlAjSJc3ccMNqbDL1av
   w==;
X-CSE-ConnectionGUID: wBmgFU3tTpKlDp4iYxuCsg==
X-CSE-MsgGUID: 6mIvrXiISg6n86kn62F/xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9268684"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9268684"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 02:10:24 -0700
X-CSE-ConnectionGUID: ErvI0qQtSZeexIE1DwlAhg==
X-CSE-MsgGUID: /hFhtf6bQGaJ3kynhS+r9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27930136"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 19 Apr 2024 02:10:21 -0700
Date: Fri, 19 Apr 2024 17:05:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Colberg, Peter" <peter.colberg@intel.com>
Cc: "Xu, Yilun" <yilun.xu@intel.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"Wu, Hao" <hao.wu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"russ.weight@linux.dev" <russ.weight@linux.dev>,
	"Pagani, Marco" <marpagan@redhat.com>, "Rix, Tom" <trix@redhat.com>,
	"matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for
 dev_dbg()
Message-ID: <ZiIzwjggxFmXvau8@yilunxu-OptiPlex-7050>
References: <20240329000429.7493-1-peter.colberg@intel.com>
 <Zgt7fA/Jfks/iKYi@yilunxu-OptiPlex-7050>
 <61cf643fda9b983b8a78b9f66c46290becf4f537.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61cf643fda9b983b8a78b9f66c46290becf4f537.camel@intel.com>

On Thu, Apr 18, 2024 at 09:30:48PM +0000, Colberg, Peter wrote:
> On Tue, 2024-04-02 at 11:29 +0800, Xu Yilun wrote:
> > On Thu, Mar 28, 2024 at 08:04:29PM -0400, Peter Colberg wrote:
> > > Omit unneeded casts of u64 values to unsigned long long for use with
> > > printk() format specifier %llx. Unlike user space, the kernel defines
> > > u64 as unsigned long long for all architectures; see commit 2a7930bd77fe
> > > ("Documentation/printk-formats.txt: No casts needed for u64/s64").
> > 
> > The change is OK. But I suggest just delete the unnecessary dev_dbg()
> > since now people normally don't want these "Hello, I'm here!" info.
> 
> How would you like me to proceed? Should I remove dev_dbg() in all DFL

I think do for all DFL would be enough. Usually you want something to
follow up and do the related clean up in advance.

Thanks,
Yilun

> modules? There are "Hello, I'm here!" in non-DFL FPGA modules, too.
> 
> $ rg --sort=path -c dev_dbg drivers/fpga/
> drivers/fpga/altera-freeze-bridge.c:7
> drivers/fpga/altera-pr-ip-core.c:1
> drivers/fpga/dfl-afu-dma-region.c:7
> drivers/fpga/dfl-afu-error.c:1
> drivers/fpga/dfl-afu-main.c:8
> drivers/fpga/dfl-fme-error.c:1
> drivers/fpga/dfl-fme-main.c:3
> drivers/fpga/dfl-fme-mgr.c:12
> drivers/fpga/dfl-fme-perf.c:2
> drivers/fpga/dfl-fme-pr.c:1
> drivers/fpga/dfl-fme-region.c:1
> drivers/fpga/dfl-n3000-nios.c:1
> drivers/fpga/dfl-pci.c:3
> drivers/fpga/dfl.c:4
> drivers/fpga/fpga-bridge.c:4
> drivers/fpga/fpga-region.c:3
> drivers/fpga/socfpga-a10.c:2
> drivers/fpga/stratix10-soc.c:4
> 
> Thanks,
> Peter

