Return-Path: <linux-kernel+bounces-159501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D8A8B2F78
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91652B22AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D725B139D11;
	Fri, 26 Apr 2024 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+4grbhM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38A6A8BE;
	Fri, 26 Apr 2024 04:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714106008; cv=none; b=D+zafQyjBFbB3RmZcAOz7xN6QSiIPYIbbdNuvxKjYSsMHDBcs2vnDq9rE/vxExW/QVGIT/N1OJP7zGFZ9hGBI1YBrlvf8KeB4W0hKyUnp4IM06IM0AXJJW2QnitUJ3sse2ni06QxJ5CYCVkSzN360hnUKGdlZ3L6qBVji1Adbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714106008; c=relaxed/simple;
	bh=ouBzjU4+4fX0NoFQILvDJXHxLTT4ke2VM49lWm9WJeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEP7ipRCzUBerI+/4CC1dtZDX30wUr55BpCF4/Awgur3aNnihxN+7qhlXhJnwO6/S+l7JZLPMQop91K1ZiR7Ewk5Ypw9XdV0SsfVs9lZ4n6JP3mpnYIdMqWm3CGeSo1fFK4ClQWagTHD9IG6aPyPv4gQHEzhoRTb9lHplAjNduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+4grbhM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714106007; x=1745642007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ouBzjU4+4fX0NoFQILvDJXHxLTT4ke2VM49lWm9WJeM=;
  b=L+4grbhMTU3FVpQdM6rcjkBLyJp9RX1QikrapkxvRt40cWTHpLPgtZgo
   YT0Om/woy9LUEr0yV7zFIOehI3Y0phrZCqL2X3jImcRuk8UfakhA8silG
   IPuc0Mqs41kGeSX0X46RVOze3Dc7rqw6RmI0EGfaD/jwA/dWeXukzFQHK
   Q1ma4GMSsfUdK6QXDh7HVnLjc9RLscXthXhBmbBPTAhKotB8rkDCU/Ip2
   B9oDSFV4Hw3M9ADQ2bcmAQTQVfDHcUE9tQ936dyNOdMzqCETCYwYXPo2v
   +6H21zEi1vgRwW5+sqV/dUXw7uuWqddzg7zzO2yFAhiuTLlouiyM+trh/
   A==;
X-CSE-ConnectionGUID: uVPkuNNnSqih8kPFp2KruA==
X-CSE-MsgGUID: 7w2/GnJuTAmn12MU7MsJSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9994349"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="9994349"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 21:33:26 -0700
X-CSE-ConnectionGUID: frjkDK3gSDqtJoPxbxg9Dg==
X-CSE-MsgGUID: ntvV4eweQjCQ1hwzEvoIrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="29961385"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 25 Apr 2024 21:33:25 -0700
Date: Fri, 26 Apr 2024 12:28:00 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: re-enable KUnit test suites for the subsystem
Message-ID: <ZistUCl6hbRdhjKL@yilunxu-OptiPlex-7050>
References: <20240423162229.52023-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423162229.52023-1-marpagan@redhat.com>

On Tue, Apr 23, 2024 at 06:22:29PM +0200, Marco Pagani wrote:
> The core components no longer assume that low-level modules register a
> driver for the parent device and use its owner pointer to take the module's
> refcount. KUnit test suites can now be safely re-enabled even with loadable
> module support.
> 
> This reverts commit a3fad2e92c76 ("fpga: disable KUnit test suites when
> module support is enabled")

Don't wrap the commit reference.

Instead just keep the auto-generated shortlog & changelog auto-generated
by "git revert", then follow your description about the change.

Thanks,
Yilun

> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
> index d4e55204c092..e4a64815f16d 100644
> --- a/drivers/fpga/tests/Kconfig
> +++ b/drivers/fpga/tests/Kconfig
> @@ -1,6 +1,6 @@
>  config FPGA_KUNIT_TESTS
> -	bool "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
> -	depends on FPGA=y && FPGA_REGION=y && FPGA_BRIDGE=y && KUNIT=y && MODULES=n
> +	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
> +	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
>  	default KUNIT_ALL_TESTS
>          help
>            This builds unit tests for the FPGA subsystem
> 
> base-commit: b7c0e1ecee403a43abc89eb3e75672b01ff2ece9
> -- 
> 2.44.0
> 
> 

