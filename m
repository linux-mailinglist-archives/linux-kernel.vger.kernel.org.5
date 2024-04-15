Return-Path: <linux-kernel+bounces-145681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950638A5971
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51901C2243C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3111384B0;
	Mon, 15 Apr 2024 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPJtt9pM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944CA1E877;
	Mon, 15 Apr 2024 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713203759; cv=none; b=WuOIntjPbhiuWawRbOirVuFeuA1ZvmuFBnQum6h5ka5VLuMZFcXSROIbVzYXeHgvkEEfvbtx1hvPtgO9OfY0ANldfP4mjQPcj5JT0fGxtvngb0NoAkgj/uASYFYToZU/kx61v+cy88+WfsMWdGqE0mCIPuE8U1yp/FhsYA91agg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713203759; c=relaxed/simple;
	bh=wGHIqI7PWV7ZdcWPIFjMMbCwsfBnDgl0tiBx3SXn5kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ywov1Mfd1hLe4LsPOa8SmuWdKhBjM+vh2GPqTPNKmLO9LgFIJKFJDUmbERi8Kpxm98VK+uYHD76tAuYrx3Nmzg/9YFONV764YQAK+AB++6qpBQziaq0+A7R5sGLpeF6sDMjlq0l8GD7WdDGSOdoZlPhkp4nQ5M9X64PvL8hsTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPJtt9pM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713203758; x=1744739758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wGHIqI7PWV7ZdcWPIFjMMbCwsfBnDgl0tiBx3SXn5kw=;
  b=TPJtt9pM6hnLXlQZ2FnghpqHdjiF8DVRYKs0CUF7sxw3qJx7T/GdMlWA
   Tio92bMIUuhd1xaUkB8edEaxC9uux89aUMHG230bB4zmkLqrMB2RBxN2K
   VkwGxkRWVzQwNDAQuYCMq3uPWCV54ukEktuZKLNjXd8jtcX81b7XNOqHG
   Y+RdI04XdP0GyJaDTa85ZeufLwkyXKqjRWsDGdgEec9QW/+v9/L31HoU1
   pCtaT8oZpisvFEe1oLWGraNq51J26BzX6EeX/uq1awBFkO4R33AJsSeqI
   bXiqVs7uYqN3uzt2MUnnJPUUZc38q6n56sVhp8ujzmzLx1IwaKWY21ciC
   A==;
X-CSE-ConnectionGUID: gr7p1BitTm+pHE8h+vn9Qg==
X-CSE-MsgGUID: +S7fnQBoTUmAebujZV0lWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8479988"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8479988"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 10:55:57 -0700
X-CSE-ConnectionGUID: XpkYSpxIT32q836X2EVJXA==
X-CSE-MsgGUID: VN0WYoj+SJ6rZOY4lUVdRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="22573744"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.61.52]) ([10.212.61.52])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 10:55:57 -0700
Message-ID: <c62caa9d-f017-4aa5-9d9f-adf6c3b27f8f@intel.com>
Date: Mon, 15 Apr 2024 10:55:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] dax: remove redundant assignment to variable rc
To: Colin Ian King <colin.i.king@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240415101928.484143-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240415101928.484143-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/24 3:19 AM, Colin Ian King wrote:
> The variable rc is being assigned an value and then is being re-assigned
> a new value in the next statement. The assignment is redundant and can
> be removed.
> 
> Cleans up clang scan build warning:
> drivers/dax/bus.c:1207:2: warning: Value stored to 'rc' is never
> read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dax/bus.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 797e1ebff299..f758afbf8f09 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1204,7 +1204,6 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
>  	if (rc)
>  		return rc;
>  
> -	rc = -ENXIO;
>  	rc = down_write_killable(&dax_region_rwsem);
>  	if (rc)
>  		return rc;

