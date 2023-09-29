Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1DF7B3244
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjI2MQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjI2MQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:16:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560541AA;
        Fri, 29 Sep 2023 05:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695989814; x=1727525814;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zEtSaGQQldOuMb9UbBfnehBBWljA8KQhdg/ggm/rEb4=;
  b=ElEWFY0O7SMHjJKDDMI7MmX6ZiFVS6wbcAgFZyYy3s1+XjByVqYENNDN
   6PGfcnDjWk9PQxNkRA8B8Zy26S4iZhfnJfGiMg2MML8mKKYjCOeh8DL4A
   g+0Vi/HbjHL2cckTgVgnCi03DYbYviWZ6gatoUKn/s1KDO2Z+V2c5LG6o
   qSFl9YtpZUw2HhgliRUSAus2nyMEnvP/rY6BA4KLtZDLWIgh87RTdP/7r
   jMGrVBpgvKs65f4roo0HEAisZmOiCiBMm2iN1jlh6WJOf00wIodUUOuqr
   aOKdVIy7AycXSlB/k+z2ZwXNBI1UJbI3lJo5EvSMdz1yj48SYFrAssIq0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="381173223"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="381173223"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 05:16:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="779255392"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="779255392"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 05:16:51 -0700
Date:   Fri, 29 Sep 2023 15:16:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] platform/x86: ISST: Allow level 0 to be not
 present
In-Reply-To: <20230925194555.966743-3-srinivas.pandruvada@linux.intel.com>
Message-ID: <403141e7-461e-8b31-16f4-c2d6ee3d12a7@linux.intel.com>
References: <20230925194555.966743-1-srinivas.pandruvada@linux.intel.com> <20230925194555.966743-3-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1457656436-1695989813=:1989"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1457656436-1695989813=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 25 Sep 2023, Srinivas Pandruvada wrote:

> It is possible that SST level 0 or base level is not present in some
> configurations. So don't set level 0 mask in level_en_mask by default.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 48465636aadb..e6d84ce0e7a5 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -372,9 +372,6 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
>  	/* Read PP header */
>  	*((u64 *)&pd_info->pp_header) = readq(pd_info->sst_base + pd_info->sst_header.pp_offset);
>  
> -	/* Force level_en_mask level 0 */
> -	pd_info->pp_header.level_en_mask |= 0x01;
> -
>  	mask = 0x01;
>  	levels = 0;
>  	for (i = 0; i < 8; ++i) {
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1457656436-1695989813=:1989--
