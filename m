Return-Path: <linux-kernel+bounces-143082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C2D8A33D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D83A1F22AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9090F1487E4;
	Fri, 12 Apr 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdLKaNzr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B3143899;
	Fri, 12 Apr 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939242; cv=none; b=REj4QZIj3kQj2gnUj1PLXZotWLKjFQhju2NWsSEpwZaYIXmWSDwbszEoTPVGU6htkzhZeeT/WNNei0NnpATMU4ku3No0KgPpnI76tI540g7i1BK5zj8RqRCV0b/CuSZYgevDgh8LPHFszdMcMCTgDBkglrwb0gRuKvVVGg5YKoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939242; c=relaxed/simple;
	bh=gcsTPT2VbxnCy4/hmONC+PzW5Mk8k6HOzDqVSrQaYwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaqTGQ4xrNxoXL+P991Dn8pG18vU8/JrPqeq2TgGoLQRCxJJieT6Qd/Cue+bPzx5zkuhbSKWE6d+T/P6UR0ONcTKYAEraONjffcZotTVQM3k9KKQ5DJHOOjdKJ0LsLypFg63g1XjyBJppbDOpVCS7xD7ToWS08Hb+tbH9eoVP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdLKaNzr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712939241; x=1744475241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gcsTPT2VbxnCy4/hmONC+PzW5Mk8k6HOzDqVSrQaYwA=;
  b=MdLKaNzrbsZCSSDWXgiQ9fiMSaxxPt2AFwKtiANKAahaQUdZmgfzJZn1
   ccgwPiDYHMTccQpXO+rYNe2ChM19zeaU4Jv4J093jkZVzMPixAgvmjXtq
   bkw5hnJXMJMYonat52Dpfrjf1RZR2mobr9CvpqnK2bmPo4NNB9v9un8z7
   6mD6gG/4qgKRYwky649nrzcqIpl7jzkZgK+2dOxLPIxrAgnZ96/Gux6jd
   cby9ai7+g3zuCf0mkHeOytgYeGUf8QiA6H7HTYZ06B7ODkfLR9cNowQyA
   378HvMAkQNWhXaIZVsOVKQ3uEfoMSdsMso3dhrDCl19ao8vWnIuIbneZw
   A==;
X-CSE-ConnectionGUID: XcCAQ859QdeyUTtJM3NGDQ==
X-CSE-MsgGUID: HxR5ZNwNQlyDAdwrLiNtAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19796051"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="19796051"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:27:21 -0700
X-CSE-ConnectionGUID: Mm1CB60SSDWVM0xvwac6iw==
X-CSE-MsgGUID: nH7qB1XQTMen7psDVDJiFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="26077121"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.34.215]) ([10.212.34.215])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:27:19 -0700
Message-ID: <1a397659-2163-4582-ac5c-2eab7f30c925@intel.com>
Date: Fri, 12 Apr 2024 09:27:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/30] dmaengine: idxd: Assign parent for event_source
 device
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org
Cc: linuxarm@huawei.com, Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Yicong Yang <yangyicong@hisilicon.com>, Jiucheng Xu
 <jiucheng.xu@amlogic.com>, Khuong Dinh <khuong@os.amperecomputing.com>,
 Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Frank Li <Frank.li@nxp.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Vineet Gupta <vgupta@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Wu Hao <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Liang Kan <kan.liang@linux.intel.com>
References: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
 <20240412161057.14099-27-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240412161057.14099-27-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/24 9:10 AM, Jonathan Cameron wrote:
> Currently the PMU device appears directly under /sys/devices/
> Only root busses should appear there, so instead assign the pmu->dev
> parent to be the iDXD PCI Device.
> 
> Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/perfmon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
> index fdda6d604262..fbb586eed0b3 100644
> --- a/drivers/dma/idxd/perfmon.c
> +++ b/drivers/dma/idxd/perfmon.c
> @@ -477,6 +477,7 @@ static void idxd_pmu_init(struct idxd_pmu *idxd_pmu)
>  	}
>  
>  	idxd_pmu->pmu.name		= idxd_pmu->name;
> +	idxd_pmu->pmu.parent		= &idxd_pmu->idxd->pdev->dev;
>  	idxd_pmu->pmu.attr_groups	= perfmon_attr_groups;
>  	idxd_pmu->pmu.task_ctx_nr	= perf_invalid_context;
>  	idxd_pmu->pmu.event_init	= perfmon_pmu_event_init;

