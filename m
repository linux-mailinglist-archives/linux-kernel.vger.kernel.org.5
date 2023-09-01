Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C2378FBD1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348991AbjIAKhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbjIAKhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:37:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5D510CE;
        Fri,  1 Sep 2023 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693564665; x=1725100665;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/YrD3pUhVQuCyxqDJ5brdtCYwmf6ladyDWJ7j+HnMdE=;
  b=Duvbm9W48wD0+o7bYe0m93nV6mmphflp7ypCcv4m20Q7Cpj+pahgnlYT
   XVuUWJfePxAKUzMNQivmdOAzR/w91cSL/h3XRd4ZaPrf7RMVN6IE2oV9M
   2FP6vAhoiWiAL2q2PmumDUF4hFuBvjP1yuRkVTBhxyD2l8EHPavQRN1nb
   QCjfanLNMIfu8BD9FYBoLGIOFw5qhjW3GiiEtqqzXFbQXxQdSD1va7Qhj
   ttc0zA4U5S27zMeMuxh/DGt61d6o1t9Q8iOOquS4Xoi6Jlqih1gqUIaPX
   Ddg9UGw0+Lh8EGzbCeVlnQzxydzXttg7FPsA/GLJKbx/bbd7WwHTB8HTA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="376126290"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="376126290"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 03:37:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="689725036"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="689725036"
Received: from pboudier-mobl.ger.corp.intel.com ([10.252.47.249])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 03:37:02 -0700
Date:   Fri, 1 Sep 2023 13:37:00 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shravan Kumar Ramani <shravankr@nvidia.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] platform/mellanox: mlxbf-pmc: Add support for
 BlueField-3
In-Reply-To: <94d48f57b3625ff7021e11ebdf9facf5cfec36cc.1693545970.git.shravankr@nvidia.com>
Message-ID: <5c811875-aeab-183c-858f-298013741c60@linux.intel.com>
References: <cover.1693545970.git.shravankr@nvidia.com> <94d48f57b3625ff7021e11ebdf9facf5cfec36cc.1693545970.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023, Shravan Kumar Ramani wrote:

> Add new access mechanism and list of supported events to program
> and read the counters in BlueField-3.
> Performance counter blocks being added for BlueField-3 include:
>   - Memory Sub-system (mss) which has counters for monitoring
> various DRAM and related skylib events
>   - Last level Tile, which has 2 sets of counters (llt, llt_miss)
> for monitoring Tile and cache metrics
> 
> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 685 ++++++++++++++++++++++++--
>  1 file changed, 653 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index 2d4bbe99959e..ddd91f298721 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c

> @@ -712,6 +1160,42 @@ static int mlxbf_pmc_program_l3_counter(int blk_num, uint32_t cnt_num,
>  	return mlxbf_pmc_write(pmcaddr, MLXBF_PMC_WRITE_REG_32, *wordaddr);
>  }
>  
> +/* Method to handle crspace counter programming */
> +static int mlxbf_pmc_program_crspace_counter(int blk_num, uint32_t cnt_num,
> +					     uint32_t evt)
> +{
> +	uint32_t word;
> +	void *addr;
> +	int ret;
> +
> +	addr = pmc->block[blk_num].mmio_base + (rounddown(cnt_num, 2) * 4);


> +	addr = pmc->block[blk_num].mmio_base +
> +		MLXBF_PMC_CRSPACE_PERFMON_VAL0(pmc->block[blk_num].counters) +
> +		(cnt_num * 4);


> +	status = mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
> +		MLXBF_PMC_CRSPACE_PERFMON_VAL0(pmc->block[blk_num].counters) +
> +		(cnt_num * 4), &value);


> +	addr = pmc->block[blk_num].mmio_base + (rounddown(cnt_num, 2) * 4);

Should those * 4 be sizeof(something) or defined?


-- 
 i.

