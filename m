Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0637D79BE47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354234AbjIKVxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236340AbjIKKXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:23:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FD31AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694427818; x=1725963818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qk8TuabgJtSCp7j499WRZJ0KpjibtjkaxhKDixdWBxA=;
  b=YxWZk5/0mURZuutiUdPwofoEPTC9cHN7iYcEpoimrykS84lX/vrfxMnq
   RYgKCg1xpUZuLa2sXFHE8j7CrFR2SbkQMs9BNOehVhTQFrhD0FcQ7Zmxp
   wWRVFfsG8Kleo/1ElLLSxL57upyXiQ9zNugAvB1GDV304uZsFspArdLau
   Zx8glPUlEqoxl8rIQg0ijaVYLSajHBGCLkhUNn7aVkJ/zTEUn2ne5kPsB
   UShmvos15ZowyJsp2cjgs550RUXX/m+cMuk5WgXJkDQyNdxzyQt9THUeU
   HcgFyE/rQBuFBlG3C4gALPM77RMaKZECndzxuiINEA3vgRUt04e0Dixu9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="444462277"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="444462277"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="858268504"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="858268504"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:23:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfe4n-008I1A-2f;
        Mon, 11 Sep 2023 13:23:29 +0300
Date:   Mon, 11 Sep 2023 13:23:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shenghao Ding <shenghao-ding@ti.com>
Cc:     tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        kevin-lu@ti.com, 13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        broonie@kernel.org, gentuser@gmail.com
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Support ACPI_ID both TXNW2781 and
 TIAS2781
Message-ID: <ZP7qoamIicmnbsB0@smile.fi.intel.com>
References: <20230910072704.1359-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910072704.1359-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 03:27:03PM +0800, Shenghao Ding wrote:
> Support ACPI_ID both TXNW2781 and TIAS2781, TXNW2781 is the only one legal
> ACPI ID, TIAS2781 is the widely-used ACPI ID named by our customers, so
> far it is not registered. We have discussed this with them, they requested
> TIAS2781 must be supported for the laptops already released to market,
> their new laptops will switch to TXNW2781.

...

> +/* TIAS2781 is the unofficial ACPI id, but widely used in current devices.
> + * TXNW2781 is the official ACPI id, and will be used in the new devices.
> + * Check TIAS2781 or TXNW2781
> + */

/*
 * This style is only for networking.
 * please use one as in this example.
 */

...

> +	const char c[][10] = { "TXNW2781", "TIAS2781" };

Can you put this to the ACPI device ID table, it will be easier to use it with
some other acpi_*() APIs?
That table might need a comment why it has no MODULE_DEVICE_TABLE() with it.

...

> +	int n = strlen(bus), i;

>  
> -	if (strncmp(d, p->bus, n))
> +	if (strncmp(d, bus, n))
>  		return 0;

It means you need to use str_has_prefix().

...

> +	for (i = 0; i < ARRAY_SIZE(c); i++) {
> +		/* the rest must be exact matching */
> +		snprintf(tmp, sizeof(tmp), "-%s:00", c[i]);
> +
> +		if (!strcmp(d + n, tmp))
> +			return 1;
> +	}

This can be done differently.
You are comparing the instance of the device to the actual id, right?
We have ACPI match APIs for that. Have you tried to look at them?

...

> +/* TIAS2781 is the unofficial ACPI id, but widely used in current devices.
> + * TXNW2781 is the official ACPI id, and will be used in the new devices.
> + */
> +static const struct acpi_device_id tas2781_acpi_hda_match[] = {
> +	{"TIAS2781", 0 },
> +	{"TXNW2781", 1 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);

So, besides the style of the comment, why do you have two different data
structures for the same? Can you find a common place and deduplicate it?

...

> -MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);

Ah, I see now, it's used for probing. Please, don't move it. The hid is
available via device pointer.

...

This patch requires much more work, and esp. be redesigned to use proper
ACPI APIs.

-- 
With Best Regards,
Andy Shevchenko


