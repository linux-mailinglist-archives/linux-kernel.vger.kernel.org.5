Return-Path: <linux-kernel+bounces-148539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD188A8424
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF12C2823DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3D913F443;
	Wed, 17 Apr 2024 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3MjoS6v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632713D8B4;
	Wed, 17 Apr 2024 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359927; cv=none; b=Dgnu129MuB4wDwVLHVRW+9r8SH+MJVVFB8zHHyJKL5Un9IEeNg22ZWpsEOlcJgS9emiA43cSqNlZBrzAHOjS53F8RXXm/cLtLIoCZmkbzYO5QVSOF8GEEXzKV+h+eybcpMPb4Wb00fSOBTYRmi5UjDTwHFoVRWe+GA7oKLg9ILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359927; c=relaxed/simple;
	bh=RuHzYN0ZhBqkJDC8Ui0Nm3edOOTTp2WF+RIcT7keQlQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gWT4X/GeaRpwHdRTTaZ1KdpL3y4y1lSidFQKcc7IJATTpFPsdlJezY8T2mfnxJg3uLDwd/7vmSPrUDdV/HKX34NyZYRLEe9y7gUHpasNUROBSB1mdBeaxK/JiJ54NL2zjFDWCVIlCKbh682DoL80cYtfFfYRrR5ssxgfr3F13R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3MjoS6v; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713359925; x=1744895925;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RuHzYN0ZhBqkJDC8Ui0Nm3edOOTTp2WF+RIcT7keQlQ=;
  b=Z3MjoS6vLhbve00pn1jDDBm7HFc2hDU1ueBEYggr1dl40gb0FVbSGQNq
   527vgUnegtKGMHQE3ZdNaSBTVsHDnysFd1u4BSIjIhZ3erhDQCXsxWK4h
   bPrdECyLiAi83ipfRR/z85C9kKKrCqU0QsOOkZJpFtpLE5Y78jmftwpfo
   4nzLi2z+PWYymcUHTrAEevS45zmyF+y4dqKzKxJuObZyhv5H4d0VBhSAR
   tpZKudrHh9ZRPWBJDgoNmBK8rIgA/RhydoASDq7UEllnDd/HIXJP/m3TC
   Qsr+X76Ztf+nLvAWc7OFDnsA/usvcKpHoiQRz8hOmJ7WGxtNcHGG3GPOw
   Q==;
X-CSE-ConnectionGUID: /GM8inDWTMuHvj7DRy79ng==
X-CSE-MsgGUID: DaTE+ZnUSsO//O4LdEDRjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9018534"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9018534"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 06:18:44 -0700
X-CSE-ConnectionGUID: sMzf6z22SD618eNgS1KsNw==
X-CSE-MsgGUID: FJFoLFuUSRyFr4MWccoxdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="23211608"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.35])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 06:18:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 17 Apr 2024 16:18:37 +0300 (EEST)
To: Shravan Kumar Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
In-Reply-To: <aec3aaa44a5738940b2511726177976336a6c72d.1713334019.git.shravankr@nvidia.com>
Message-ID: <e77f01b4-f314-6822-8533-95f37a42cd4f@linux.intel.com>
References: <cover.1713334019.git.shravankr@nvidia.com> <aec3aaa44a5738940b2511726177976336a6c72d.1713334019.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 17 Apr 2024, Shravan Kumar Ramani wrote:

> Add support for programming any counter to monitor the cycle count.
> Since counting of cycles using 32-bit ocunters would result in frequent
> wraparounds, add the ability to combine 2 adjacent 32-bit counters to
> form 1 64-bit counter.
> Both these features are supported by BlueField-3 PMC hardware, hence
> the required bit-fields are exposed by the driver via sysfs to allow
> the user to configure as needed.
> 
> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> ---

> @@ -1799,6 +1902,37 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
>  		attr = NULL;
>  	}
>  
> +	if (pmc->block[blk_num].type == MLXBF_PMC_TYPE_CRSPACE) {
> +		/*
> +		 * Couple adjacent odd and even 32-bit counters to form 64-bit counters
> +		 * using "use_odd_counter" sysfs which has one bit per even counter.
> +		 */
> +		attr = &pmc->block[blk_num].attr_use_odd_counter;
> +		attr->dev_attr.attr.mode = 0644;
> +		attr->dev_attr.show = mlxbf_pmc_use_odd_counter_show;
> +		attr->dev_attr.store = mlxbf_pmc_use_odd_counter_store;
> +		attr->nr = blk_num;
> +		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
> +							  "use_odd_counter");
> +		if (!attr->dev_attr.attr.name)
> +			return -ENOMEM;
> +		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
> +		attr = NULL;
> +
> +		/* Program crspace counters to count clock cycles using "count_clock" sysfs */
> +		attr = &pmc->block[blk_num].attr_count_clock;
> +		attr->dev_attr.attr.mode = 0644;
> +		attr->dev_attr.show = mlxbf_pmc_count_clock_show;
> +		attr->dev_attr.store = mlxbf_pmc_count_clock_store;
> +		attr->nr = blk_num;
> +		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
> +							  "count_clock");
> +		if (!attr->dev_attr.attr.name)
> +			return -ENOMEM;
> +		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
> +		attr = NULL;
> +	}

Hi,

What was the reason why this driver could not use .dev_groups to setup 
sysfs (filtering can be done with .is_visible)?


-- 
 i.


