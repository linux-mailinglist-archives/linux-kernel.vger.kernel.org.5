Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73798791598
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347351AbjIDKRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjIDKRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:17:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FFB1B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693822653; x=1725358653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C1sxTWSukD5VjbJkhBh/4XO0u1A8SVO5BB9Wv/rZVKs=;
  b=J1yhT/VmPYAjUfvOdRl0ogjjsv+rBsttLmxJqqWrKzOhBquQrx38eAyo
   uwcva7ObwfTkXnZowiuUgJRdWK6M/tBmooPIdkTdkqmUYTx+u1olPYUrD
   zHADhTGY2FJtoPgxGR20aP8zjeNZ/N2kC4Zg6ubk0DhxVG9xXlezI+J9M
   8h5trSDdjMPlzwSQcgtPMZW57J2j5gLUNSthssflRW44/FxlnWD6A11Di
   uacrL9lKwnOs+8fydOCl6FqWHsVmt3Uu5yaPolEAMYUvUM44cY6vJmOnl
   zDaJOEMk8cs4mv42aFx7JsxF0xJujpeVf9bldjENcJc6fy/5ucBQyN0i9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="462934038"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="462934038"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:17:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="810868946"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="810868946"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:17:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd6e4-006OhD-0P;
        Mon, 04 Sep 2023 13:17:24 +0300
Date:   Mon, 4 Sep 2023 13:17:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shenghao Ding <shenghao-ding@ti.com>
Cc:     tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        kevin-lu@ti.com, 13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        broonie@kernel.org, gentuser@gmail.com
Subject: Re: [PATCH v1 1/2] ALSA: hda/tas2781: Update tas2781 HDA driver
Message-ID: <ZPWus9/OCJ/DJHQq@smile.fi.intel.com>
References: <20230903143759.92-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903143759.92-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 10:37:57PM +0800, Shenghao Ding wrote:
> Support ACPI_ID both TXNW2781 and TIAS2781, and revert structure
> cs35l41_dev_name.

...

> +	/* exactly match either TXNW2781 or TIAS2781 */
> +	/* the rest must be exact matching */
> +	snprintf(tmp, sizeof(tmp), "-%s:00", "TXNW2781");
> +
> +	if (!strcmp(d + n, tmp))
> +		return 1;
> +
>  	/* the rest must be exact matching */
> -	snprintf(tmp, sizeof(tmp), "-%s:00", p->hid);
> +	snprintf(tmp, sizeof(tmp), "-%s:00", "TIAS2781");

Basically this should use acpi_dev_match infra like Intel drivers do.
But I haven't read code deeply to understand if it's the case here or
not.

-- 
With Best Regards,
Andy Shevchenko


