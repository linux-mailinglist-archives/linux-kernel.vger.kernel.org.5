Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0ED7915B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbjIDKc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjIDKcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:32:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4374AE6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 03:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693823542; x=1725359542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zu+tMGAxaM9YFrYI5l7kCZRRlpRcpVet28df0zWTJwc=;
  b=dlqvgRzaoUVSA/UIPv47n9pQK6T4lyaL8LPhifoXkVXY7GI2jNL3MA+Z
   WcutBnTEaPFuPTRX/xYkj5CgHc1DBKjew7BVTGoKq/qRnAII97AEaTvEL
   7E5mi/MN+P7ThzQMTHKFSdXcOaOG4313gDrneTkKGC6iWkXs482vchzdC
   EgT+ftid1ulqWEgpk3ZpcZV8rv0Te9LvG3GclnbBrc6AaLCxGS0i8sJKn
   A5d8gwSaTXPHZzwSMUyMdOir9eZweFJftvLs+zIbII2CYMNJBt7m+cKCn
   LqhpLRQZj4Eryvi0rXrL9EKBvi6QU5clVL1cGsHK3iKXuumMttyeMPsfQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="375461215"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="375461215"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="806220201"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="806220201"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:32:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd6sQ-006Osv-0k;
        Mon, 04 Sep 2023 13:32:14 +0300
Date:   Mon, 4 Sep 2023 13:32:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shenghao Ding <shenghao-ding@ti.com>
Cc:     tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        kevin-lu@ti.com, 13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        broonie@kernel.org, gentuser@gmail.com
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Update tas2781 HDA driver
Message-ID: <ZPWyLWsEUysyCrsl@smile.fi.intel.com>
References: <20230904090725.1388-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904090725.1388-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 05:07:24PM +0800, Shenghao Ding wrote:
> Revert structure cs35l41_dev_name and redefine tas2781_generic_fixup.

...

>  	/* check the bus name */
> -	if (strncmp(d, p->bus, n))
> +	if (strncmp(d, bus, n))
>  		return 0;
>  	/* skip the bus number */
>  	if (isdigit(d[n]))
>  		n++;
>  	/* the rest must be exact matching */
> -	snprintf(tmp, sizeof(tmp), "-%s:00", p->hid);
> +	snprintf(tmp, sizeof(tmp), "-%s:00", "TIAS2781");
>  
>  	return !strcmp(d + n, tmp);

Try to use one of the respectve acpi_*_match*() APIs.

-- 
With Best Regards,
Andy Shevchenko


