Return-Path: <linux-kernel+bounces-127447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79375894B84
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E344283BB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7B12B9BD;
	Tue,  2 Apr 2024 06:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3khOu2N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A2249E4;
	Tue,  2 Apr 2024 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039754; cv=none; b=ATfO+jxyOjbi2kb6FuuNE8RImKsgM+wXQFdbLfZSnkN1s2p8yhgC58/DP0iA/b/Mk6A2dy8BnmRsrwSmLecCJNfBfm4Tv7dgnNNJ+VPZPD5O0VQOO9KR6z5JgYrLgYBqy6gh9aRN5vMca5q3JkZ5E2c9oHtbCiSnGm42NlrwzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039754; c=relaxed/simple;
	bh=Feqjj4R3LtzqrmfPSc4AxFtg1P9nxO6x1fNkNugNZJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOdBmLtyr+qol1ufV9agnc9NRVdyeLA5aNAPyskVw7tYenXbfx4PRp/xg9WGlVr/JURSLxLNTVmL5MMdxlcAOH5skLDGjLVj7yqolnIcJ8PwAyF0IDZEibSW2HEMYr/obCdBGaIrPpDJFnStexcnBpi5jFrkDoAMZNdaE3IxfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3khOu2N; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712039753; x=1743575753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Feqjj4R3LtzqrmfPSc4AxFtg1P9nxO6x1fNkNugNZJw=;
  b=c3khOu2NdM2V0fD0EqN6gA1l/69wX05ds4CxY8Q/G7b0w7HEwqnBJ8wA
   VELK99RFIS4HOu89u6253Dld4Uz5y73vqgWRC1yGBoGgy3DlEN9wjACDM
   S4NQIBHBRO7Lu9QVpVgkzXlTWTDFOdnY7SXN6VP9pRXQLLNu14MmlaZKI
   wCymdkbZBtlqpEfozJo9wR9ABTjhw/yEjHUETUTFqExV3srOX8mZsTVEy
   36J86TTGlC/6tvH/HUk/Mn8SYzgUO0txlwip2RjMJm3I/+K6CKxIe+TyA
   2lo1PgMckCi9u7T+QMo/6HEetxFl9kMXNPcczC49WqEgce/waGrrebS2e
   A==;
X-CSE-ConnectionGUID: VoxBJcvFQvSfIUkcPxb2iw==
X-CSE-MsgGUID: ddVnmZ9ZS3WW58SS/DlbiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17810246"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17810246"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 23:35:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18043933"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2024 23:35:47 -0700
Date: Tue, 2 Apr 2024 14:30:57 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-cvp: Remove an unused field in struct
 altera_cvp_conf
Message-ID: <ZgumIQV3fUpxNqno@yilunxu-OptiPlex-7050>
References: <7986690e79fa6f7880bc1db783cb0e46a1c2723e.1711976883.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7986690e79fa6f7880bc1db783cb0e46a1c2723e.1711976883.git.christophe.jaillet@wanadoo.fr>

On Mon, Apr 01, 2024 at 03:08:21PM +0200, Christophe JAILLET wrote:
> In "struct altera_cvp_conf", the 'mgr' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

> ---
> Apparently, it has never been used. It is not a left-over from a
> refactoring.
> 
> The address of the 'fpga_manager' is handled via pci_[s|g]et_drvdata().
> 
> Compile tested only.
> ---
>  drivers/fpga/altera-cvp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4ffb9da537d8..6b0914432445 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -72,7 +72,6 @@ static bool altera_cvp_chkcfg;
>  struct cvp_priv;
>  
>  struct altera_cvp_conf {
> -	struct fpga_manager	*mgr;
>  	struct pci_dev		*pci_dev;
>  	void __iomem		*map;
>  	void			(*write_data)(struct altera_cvp_conf *conf,
> -- 
> 2.44.0
> 
> 

