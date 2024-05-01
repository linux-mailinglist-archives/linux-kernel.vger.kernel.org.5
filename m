Return-Path: <linux-kernel+bounces-165115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 367C08B8843
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5227FB20E26
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2356C51C4B;
	Wed,  1 May 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPeKcYz8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74954204E;
	Wed,  1 May 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557237; cv=none; b=ZeIevWZXXWOhXnVfx1wieCPRmmdV62pwCC3rU6PFbslxi//vmg5soZWpSWDEjLjf/H+ATGZrFZYcI6HqMlNFbkYDjFERDr9TCBicQjOPHf9aQa0CuWExhOBTo+t6lpiNhtpHc6AN8P7tz978ae5kOumkE17SWKMyOV9fK3j4bMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557237; c=relaxed/simple;
	bh=Hb846Cf7SRZX9pIUAJ1q07Z7Vsj0+r1xmkNfW29a3ZQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CLPyiBkclPq4zhTR3j+L/Q8RR71SPs978vexnNu3GJwzMevVsYmbbsuErivnZBsT6/zT6Twgqofb0qKi1fnjhjsSd5tyjaGic5ErNs5zUi5OTJItiBAHi1ZHamIkPzQ22dhz4lxaUudlai0cx1ZOS8ldMFJ2iFfXrxj6jPpnl5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPeKcYz8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714557236; x=1746093236;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hb846Cf7SRZX9pIUAJ1q07Z7Vsj0+r1xmkNfW29a3ZQ=;
  b=ZPeKcYz8FHnp3NVE8oSBwdDJD/oiqJw5SRSLpq2kcrSQbDW8AXdV4/Hg
   zoQOjFWx+OsZOI8Xw5sE37cZ424HHv4DhOm/mZ6lv73AKdJk95rrMV5Hi
   M+EPReGSBSVVOL+Ya9DWIMKgZDt6C00KTMBEmjhgZ6+PfnsL62ncj1rsK
   vST7VK4WYfcJq/8jRwnYIhafuyi8ZLZWy10qqVAAtGHFmpCr5z039uykN
   KVpjMzoHnLxYvk+6rk3VxR9QrfZqEOwtM69C51vsziMlGL9mEaCVy9hvv
   MobbEvxitCYbUDd1mW9VrsJWj2nvUwDZk3kjWItHToV3DF9mDLxh+9zFG
   A==;
X-CSE-ConnectionGUID: B1fAsC9CSHy8OzOLeKwctw==
X-CSE-MsgGUID: /XGlda/vTYahtY4WHmkQrA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="27730361"
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="27730361"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 02:53:55 -0700
X-CSE-ConnectionGUID: aAIcMIixT9Wtz8LRNgu3+Q==
X-CSE-MsgGUID: rSDqELpPRceJmOjVWPQj2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="31455876"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.225.176]) ([10.124.225.176])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 02:53:50 -0700
Message-ID: <89cbae17-58dd-4c06-9f24-0c651209f037@linux.intel.com>
Date: Wed, 1 May 2024 17:53:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com
Subject: Re: [PATCH v3 4/7] iommu/riscv: Enable IOMMU registration and device
 probe.
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <f9c9e5dcdc1457da4af70302e85c0a7be532f650.1714494653.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f9c9e5dcdc1457da4af70302e85c0a7be532f650.1714494653.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/1 4:01, Tomasz Jeznach wrote:
> Advertise IOMMU device and its core API.
> Only minimal implementation for single identity domain type, without
> per-group domain protection.
> 
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

with some nits below.

> ---
>   drivers/iommu/riscv/iommu.c | 64 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 64 insertions(+)

[..]

>   static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
>   {
>   	u64 ddtp;
> @@ -71,6 +126,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
>   
>   void riscv_iommu_remove(struct riscv_iommu_device *iommu)
>   {
> +	iommu_device_unregister(&iommu->iommu);
>   	iommu_device_sysfs_remove(&iommu->iommu);
>   }
>   
> @@ -96,8 +152,16 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   		goto err_sysfs;
>   	}
>   
> +	rc = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, iommu->dev);
> +	if (rc) {
> +		dev_err_probe(iommu->dev, rc, "cannot register iommu interface\n");
> +		goto err_iommu;
> +	}
> +
>   	return 0;
>   
> +err_iommu:
> +	iommu_device_sysfs_remove(&iommu->iommu);
>   err_sysfs:
>   	return rc;
>   }

It's better to make the goto label indicate what is going to be handled.
So it's more readable to make it like this:

err_remove_sysfs:
	iommu_device_sysfs_remove(&iommu->iommu);

Best regards,
baolu

