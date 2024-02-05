Return-Path: <linux-kernel+bounces-53074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B021A84A05D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623EF1F23638
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41B340BEF;
	Mon,  5 Feb 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhzRt8cu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383544C64;
	Mon,  5 Feb 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153229; cv=none; b=sAsyZ6dPE5m128x16WZnEGzO+Elk60+mMs5/+7DopBMr1rCX1WbJGci3qfG+y7ff/nzynGlncniO5eMDhGBk6D3ZMxSDdOMiU+qVOMq5aV2qSq0U6aiO1pIqUEoISW8afI6l3RWI93zCVbuNcg79i019G0k1Or8kwLAUYDkNAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153229; c=relaxed/simple;
	bh=GUIw1Clt8W7XheqxN9DyFdV0X+bok90f0WYN3AWZKu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDdR5AEKyRHRiEc1wz2FLkmU8Q9JniCJPGgtAcAyzLeh3yD+C9aKT5hySraitLHAIAfQ4K8ZQ0gpb13YlmKzACrQNyzhEOrF+H4RkKEm6GohpRE9LD+qWfWJoX0ZIRS/k5eruav2pSOj6cg4CkspGKcTKK8PsiW4s7OLiYp7Dek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhzRt8cu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707153227; x=1738689227;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GUIw1Clt8W7XheqxN9DyFdV0X+bok90f0WYN3AWZKu8=;
  b=lhzRt8cuNDsKSapgNoglOuRKCfmubB5v6CA7SCvTfVjwWYyTO5msEJfO
   lgqnVuccbaFsLNKaEFLTR4jBUOjwUM/J3FuC23vgvZKG/58d3bRNwZjPg
   JKhtrNT8gxnzQLIZZE/Ff2vtudoINn7rAgWX250oDbgxHwu6BEDBJrUrC
   OINJ6xJSwL88p8sqJritH/iSHpcncjHN1ibSCTdk+6tutRwXtAGvBwjkr
   r3bwd9s72ib1aPkrPRQOKnW4dqdJnfN8Pbv2+YSUqjINBNxWxCJ0Xd1Ci
   3IjepLwRRdV1ltX6QK5LTZ4CD2KAfs197PoIoWsjxrn0hRmRGG6w826jS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11210870"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11210870"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:13:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909345630"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909345630"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.181]) ([10.246.112.181])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:13:45 -0800
Message-ID: <14b212a4-e7b5-494a-8665-06842b2c7cbf@intel.com>
Date: Mon, 5 Feb 2024 10:13:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v2] cxl/region: Use cond_guard() in show_targetN()
Content-Language: en-US
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
References: <20240205142613.23914-1-fabio.maria.de.francesco@linux.intel.com>
 <20240205142613.23914-3-fabio.maria.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240205142613.23914-3-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/24 7:26 AM, Fabio M. De Francesco wrote:
> Use cond_guard() in show_target() to not open code an up_read() in an 'out'
> block. If the down_read_interruptible() fails, the statement passed to the
> second argument of cond_guard() returns -EINTR.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/region.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0f05692bfec3..bd3236786a25 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -666,28 +666,20 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled;
> -	int rc;
>  
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> +	cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);
>  
>  	if (pos >= p->interleave_ways) {
>  		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
>  			p->interleave_ways);
> -		rc = -ENXIO;
> -		goto out;
> +		return -ENXIO;
>  	}
>  
>  	cxled = p->targets[pos];
>  	if (!cxled)
> -		rc = sysfs_emit(buf, "\n");
> +		return sysfs_emit(buf, "\n");
>  	else

This else isn't needed because your if statement above returns. I think if you run checkpatch it should've flagged this.

> -		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
> -out:
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +		return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
>  }
>  
>  static int match_free_decoder(struct device *dev, void *data)

