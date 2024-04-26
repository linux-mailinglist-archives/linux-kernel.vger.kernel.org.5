Return-Path: <linux-kernel+bounces-160185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81148B3A54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7401F28940C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1BA148FF5;
	Fri, 26 Apr 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOzwoJxg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2612C7FB;
	Fri, 26 Apr 2024 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142756; cv=none; b=aig5X6MIXkzJoDGNUEXlYIgD/DSgthqFHQSg//JR3Dmn2CzvDStOYJNw7cEKNKJg8iqpflMkEogoNgIjFtWnO//xZPELHNroI3VDNDqtVtSVd/hWkJd22d9VYj/y7WMSu1yk4tSsdJTAVL271EIcCN5rSFdBMuWVN4IPGHxnq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142756; c=relaxed/simple;
	bh=4kHshSLluo35vKBkcvlnt2An+iSygvE7sAOsh4y5pxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1KZIF+K6FDBZmYMtR7/J1lALs2WqCeA2TBEmP9KjcDVA/KvDUNoC+AcJ43PZSAUzgbd/M8kWi3HjbEzgEPM3H7D6YPu0mdFm+x664Gd4H30HkZ3xXx17H7ThUoei1aPcdbMXhBc8iwbVAHnaQIGuoXTOemUIgmPGzyH9PuyP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOzwoJxg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714142755; x=1745678755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4kHshSLluo35vKBkcvlnt2An+iSygvE7sAOsh4y5pxQ=;
  b=XOzwoJxggAcUrb64m5pXySeaOcMaJGE7KNGOm0BejCQ5hiREsXgifjSu
   VpcUclEB9Me/9n2vbPOS6SGnAx4go/rYuNd9nvnPujhboIrKI4POFVJgj
   icLvppem1HbAkOjYDho7EmeiAufhgaDB8l5VsH7/jg61n+D+y1UIAL6pC
   yC6h5PafYt1+7PMc+o6eKEGU0pREI94gKgF6Q+OslSCvonQhyDAOla5WX
   1tUZDOboGR/MdOwTqvYdgHuAON0zC8y7qudhb/dOuzQ8Nm5tszOqPCQgF
   IML93imtXW/M6ucPTY0EMMevqREPCmJH/KNoR1vRY1OnRCKip5eer/SFx
   w==;
X-CSE-ConnectionGUID: 8oDS4AMMSZCcaNui5d0lQw==
X-CSE-MsgGUID: r3swzGasQpKnXxhgT14gNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="12813850"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="12813850"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:45:54 -0700
X-CSE-ConnectionGUID: F5nX7GqTQGmqsppbDxe/5g==
X-CSE-MsgGUID: R312I55TTYOS8yoBb1jLiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="62916669"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:45:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s0Mph-00000001LiQ-3SGP;
	Fri, 26 Apr 2024 17:45:49 +0300
Date: Fri, 26 Apr 2024 17:45:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: lumingyindetect@126.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: Re: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
Message-ID: <Ziu-HUUE43xsjnia@smile.fi.intel.com>
References: <20240426114716.1275085-1-lumingyindetect@126.com>
 <87d376e4-84f1-48c3-8c5d-955f706f3bfb@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d376e4-84f1-48c3-8c5d-955f706f3bfb@moroto.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 04:53:18PM +0300, Dan Carpenter wrote:

> > Fixes: e88c4cfcb7b888ac374916806f86c17d8ecaeb67
> 
> This is the wrong hash and the format is wrong.  It should be:
> 
> Fixes: 254cc7743e84 ("serial: 8250_lpss: Switch over to MSI interrupts")

Since you are here, just pay attention that this does NOT fix anything
as it uses pcim_enable_device(). I hope smatch won't stumble over this
and produce false positives.

-- 
With Best Regards,
Andy Shevchenko



