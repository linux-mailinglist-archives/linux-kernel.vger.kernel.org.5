Return-Path: <linux-kernel+bounces-52470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5DD849897
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092911C2174C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D2218B02;
	Mon,  5 Feb 2024 11:14:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D018EB0;
	Mon,  5 Feb 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131640; cv=none; b=XEZnmd5PdV8Xv6wqgz/uqrfQVWB0NaelMPMocV1VtKQ1Ye8m30LWVPvakqQ8SAmDijC4RgGJTEurGUSwhhe9qMmoVzVj+xFp1tFcfFZt1fdYtJZx/fsx82UgcKv8/D1PIdGtR06xFs1+FNssqMzYiIV5HfxeO/RvqjZuW5F/ufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131640; c=relaxed/simple;
	bh=S7C/kWLN5RArPUjnyoZ+KqIZM3xJ1mKOXrMvB6ObfBM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQJsnfLvMxAtkiQX1Mnb/YduxbE2RvUlI1Prej9131/+lifc2oBZ9EqRuUhM64VJnCU7vOKUcVkvi7a0yQlswi/F0vTXdCfqJdg6PsgOWi1Iaz8wI+AgyV+ZgcKEXa802zJh6ymuFHVSnvyNY0erIkPGurstAppa1QZ5k8QmNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT3Zl6SL9z6K6Cx;
	Mon,  5 Feb 2024 19:10:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B7450140CF4;
	Mon,  5 Feb 2024 19:13:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 5 Feb
 2024 11:13:51 +0000
Date: Mon, 5 Feb 2024 11:13:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Masahiro Yamada <masahiroy@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: remove CONFIG_CXL_PMU entry in drivers/cxl/Kconfig
Message-ID: <20240205111349.00006ea5@Huawei.com>
In-Reply-To: <20240204094613.40687-1-masahiroy@kernel.org>
References: <20240204094613.40687-1-masahiroy@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun,  4 Feb 2024 18:46:13 +0900
Masahiro Yamada <masahiroy@kernel.org> wrote:

> Commit 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> added the config entries for CXL_PMU in drivers/cxl/Kconfig and
> drivers/perf/Kconfig, so it can be toggled from multiple locations:
> 
> [1] Device Drivers
>      -> PCI support
>        -> CXL (Compute Expres Link) Devices
>          -> CXL Performance Monitoring Unit  
> 
> [2] Device Drivers
>      -> Performance monitor support
>        -> CXL Performance Monitoring Unit  
> 
> This complicates things, and nobody else does this.
> 
> I kept the one in drivers/perf/Kconfig because CONFIG_CXL_PMU controls
> the compilation of drivers/perf/cxl_pmu.c.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

oops.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks

Jonathan

> ---
> 
>  drivers/cxl/Kconfig | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 67998dbd1d46..5f3c9c5529b9 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -144,17 +144,4 @@ config CXL_REGION_INVALIDATION_TEST
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
>  
> -config CXL_PMU
> -	tristate "CXL Performance Monitoring Unit"
> -	default CXL_BUS
> -	depends on PERF_EVENTS
> -	help
> -	  Support performance monitoring as defined in CXL rev 3.0
> -	  section 13.2: Performance Monitoring. CXL components may have
> -	  one or more CXL Performance Monitoring Units (CPMUs).
> -
> -	  Say 'y/m' to enable a driver that will attach to performance
> -	  monitoring units and provide standard perf based interfaces.
> -
> -	  If unsure say 'm'.
>  endif


