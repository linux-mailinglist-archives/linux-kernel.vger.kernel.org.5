Return-Path: <linux-kernel+bounces-136214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A258189D148
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F2C1F24FB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6056155772;
	Tue,  9 Apr 2024 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLIxgiXG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D13154BEF;
	Tue,  9 Apr 2024 03:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634288; cv=none; b=NOjrgv47sgaxZrwJ2Fcj1Wi4qEUU2Q/Rczlz7ChryoIRPnqr1th/QQQVcSRZCCGkzvpnNxSPhAMgv9jSGykChyXjqIq0nhEXpnKj+XXQjbdUKNaw5YA9G20AVCbu9EIIK9JsBWqytiVmEJAz8Z+1vZco/ALEU3m4ghJ/in12WyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634288; c=relaxed/simple;
	bh=RR5SyerU3swP7blXlrp09ILNLJGLjX1OuihRg3Zwf08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nkp4sfsR80LOmW7jQ5+yhozEwR+3ekS4AxEfC4+BQxxMKZq9mFIdTXXevebTwVkxTJM4MWh6pnNYYvS3zpOrJ7jvYDh3Wd0B1LjuN7Q61zgkN45hJj/sNtbHWFUkVFaFuRkXroKmg3MC5hitA2eXPkHpQ8eboZvIPasm7PteWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLIxgiXG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712634287; x=1744170287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RR5SyerU3swP7blXlrp09ILNLJGLjX1OuihRg3Zwf08=;
  b=TLIxgiXGRHM7il4ctmA3N4NGvrRDMo9me1rQxheEqFq6EQUM5Pu9JaA8
   +rnpMUu0MqB8w4VWCFy00MsIEqY3pRFyvq0QGVIVK8H1LVvClCRiPP+BO
   TCcYnl8awUH0PiFjIfbbz3a+HQ78IRZdNFPOGKRpSwBPTqSghRXAPe6wa
   3ryu7+xLiTI9pB094sO/09+DCx3kfgYsB9PbKFKNyqo522NPwnVcPBXfb
   uDEZVnhwwdbNlQKxQyUcQgd9Y9HXQiQbqexHVYLPQrQieKYGHgCevsQY1
   gFEJx+mtOY3jk33Gse1ojPzq/eC7b5y9ZPJIEZMPGETSrC3OPAI4/8RnK
   Q==;
X-CSE-ConnectionGUID: StNyYDN2R8yKa6Lrw6aWSw==
X-CSE-MsgGUID: keU8WLW0QHOxC7DGTWRJog==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="30427936"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="30427936"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:44:46 -0700
X-CSE-ConnectionGUID: ggQOrKGGT7iExxoFkcpFEg==
X-CSE-MsgGUID: r2ZzOJOLTWafzvUNP/wPJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20533497"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2024 20:44:43 -0700
Date: Tue, 9 Apr 2024 11:39:42 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Alan Tull <atull@kernel.org>, Shiva Rao <shiva.rao@intel.com>,
	Kang Luwei <luwei.kang@intel.com>,
	Enno Luebbers <enno.luebbers@intel.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] fpga: dfl: fme: revise kernel-doc comments for some
 functions
Message-ID: <ZhS4fuijYnstZ6Rt@yilunxu-OptiPlex-7050>
References: <20240402204743.1069624-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402204743.1069624-1-peter.colberg@intel.com>

On Tue, Apr 02, 2024 at 04:47:43PM -0400, Peter Colberg wrote:
> From: Xu Yilun <yilun.xu@intel.com>
> 
> This amends commit 782d8e61b5d6 ("fpga: dfl: kernel-doc corrections"),
> which separately addressed the kernel-doc warnings below. Add a more
> precise description of the feature argument to dfl_fme_create_mgr(),
> and also use plural in the description of dfl_fme_destroy_bridges().
> 
> lkp reported 2 build warnings:
> 
>    drivers/fpga/dfl/dfl-fme-pr.c:175: warning: Function parameter or member 'feature' not described in 'dfl_fme_create_mgr'
> 
> >> drivers/fpga/dfl/dfl-fme-pr.c:280: warning: expecting prototype for
> >> dfl_fme_destroy_bridge(). Prototype was for dfl_fme_destroy_bridges()
> >> instead

Why still list the 2 warnings here? Do they still exsit even with commit
782d8e61b5d6 ("fpga: dfl: kernel-doc corrections") ?

> 
> Fixes: 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature support")

You are still trying to fix this commit?


I'm sorry, but please do check and test your patches before submit.
Re-submitting quickly but full of errors makes people doubt if you are
really serious about your patches. At least, I do have doubt if you did
tests for all your patches, or if your test could sufficiently prove the
issue exists or fixed.

Do not just passively waiting for reviewers to find out the issue. Maybe
you should again read the Documentation/process/*.rst


Back to this patch, I think you can just drop it. Because:
1. The previous fix works fine, the doc doesn't tell anything wrong.
2. The 2 functions are internal, no outside users. Little value for the
kernel doc.

So no need a dedicated fix patch. The preferred practice is you point
out the nits when the previous patch is not yet merged. Or you by the
way include these fixes in some new patches which relates to these
functions.

Thanks,
Yilun

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> ---
> v2:
> - Correctly rebase patch onto commit 782d8e61b5d6.
> ---
>  drivers/fpga/dfl-fme-pr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index cdcf6dea4cc9..b66f2c1e10a9 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -164,7 +164,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  
>  /**
>   * dfl_fme_create_mgr - create fpga mgr platform device as child device
> - * @feature: sub feature info
> + * @feature: the dfl fme PR sub feature
>   * @pdata: fme platform_device's pdata
>   *
>   * Return: mgr platform device if successful, and error code otherwise.
> @@ -273,7 +273,7 @@ static void dfl_fme_destroy_bridge(struct dfl_fme_bridge *fme_br)
>  }
>  
>  /**
> - * dfl_fme_destroy_bridges - destroy all fpga bridge platform device
> + * dfl_fme_destroy_bridges - destroy all fpga bridge platform devices
>   * @pdata: fme platform device's pdata
>   */
>  static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
> -- 
> 2.44.0
> 
> 

