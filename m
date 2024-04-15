Return-Path: <linux-kernel+bounces-145548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F648A57BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C96A1F22B41
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C1880BF0;
	Mon, 15 Apr 2024 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jv5MCLyn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B780635;
	Mon, 15 Apr 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198500; cv=none; b=GRnFyWV8Xf99h+2as2YBoigqu4516Et2SEcMOZVFV2hG2ySXWLl3yi3CsoDG0ShANzBBV6qePxbgtDf0VoL2YLX5oe8MoacBJK6g0DySJ11FdG4iXG5Lw26LNAw7tF+XXQTzPG56g0xpF6g55Ax9VoDA8roM2yIIYAac+geiJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198500; c=relaxed/simple;
	bh=U2/UnAEfxAjeQOls/oNn2mc+hH1lDCfv8DsHXxkohlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfnVl1z4IQiHJZB9lYlXmUbAeoiMHG5LRkfRR7ygZI9OaacBfW6rBiWLxyiUkZwyxAh/L+kEGVDnVbl/UfP0n6+hc85q/r4MinQvjy8hCdKd8QHPSxeZPurk0zt2c4cO1I1UfZpxcUaqWodFVcjabWD8SOyV56O9SYDGl+X8y8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jv5MCLyn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713198498; x=1744734498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U2/UnAEfxAjeQOls/oNn2mc+hH1lDCfv8DsHXxkohlI=;
  b=Jv5MCLynFyOF5xicsvuqQJ/of6LD/6D5yXlN7BX1IZn/PrOSujK3q/Ei
   1wT80bnaTHcVqipbiNf05dbO/DhjKcB2xn5LScNl0Raixb9j1tJQD6wPr
   CGWEHgX4FAnA/UMR8RVWq8tAuBTs1fULf7ug3arsLhY/6q/4ghNmNuwOJ
   aGVxqSj+O5DDkJg5ghC0aj4Z7UTsPrbLZdkglWv1NA68cnI6Z1FmxWy4X
   fuWRaQqrV44m7WDxt31xnlOPBzkuZjRMBbsLTZRqQ4Xlho7XEfSMk/f2D
   a4DDPyL7MNYH3N/OXfELDCnTZNnZtmtBuQwbR+P13eYBWgBywRqBTrU22
   w==;
X-CSE-ConnectionGUID: vxCWpPVhR5KFzYswhUXgDA==
X-CSE-MsgGUID: L4rurhbnTTakJOO3nImuyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8708464"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8708464"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 09:28:18 -0700
X-CSE-ConnectionGUID: L67mHGv8TzCH4dF8pCaK4w==
X-CSE-MsgGUID: GkjPkxbCQvartfrYdbKRIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26613854"
Received: from rabinapr-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.27.254])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 09:28:17 -0700
Date: Mon, 15 Apr 2024 09:28:15 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] dax: remove redundant assignment to variable rc
Message-ID: <Zh1Vn0iQk0AVTJHD@aschofie-mobl2>
References: <20240415101928.484143-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415101928.484143-1-colin.i.king@gmail.com>

On Mon, Apr 15, 2024 at 11:19:28AM +0100, Colin Ian King wrote:
> The variable rc is being assigned an value and then is being re-assigned
> a new value in the next statement. The assignment is redundant and can
> be removed.
> 
> Cleans up clang scan build warning:
> drivers/dax/bus.c:1207:2: warning: Value stored to 'rc' is never
> read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

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
> -- 
> 2.39.2
> 
> 

