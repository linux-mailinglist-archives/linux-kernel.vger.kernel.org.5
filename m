Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831EA7D0D46
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376913AbjJTKfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376891AbjJTKfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:35:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8B0D65;
        Fri, 20 Oct 2023 03:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697798112; x=1729334112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RxoqXyv0zETKYqwyH5UYMhDM7joOC36tuvjkJay4FOU=;
  b=iSfn9tujwsZivYeaY2IHCA0/xdJRn+Io1mMSjmrXsWjYMut7WxB2Mcvs
   WlIPHSxydOQhqwc/WgvDPS0ZjFIIEeACCllCfU6TsnRvh2+rwE4ldPHz8
   R7yOo3DAjX58uKf6FRBwd4fISzDW0iZM7zSmAlZjDADPzZ2oDShyE0CpZ
   JuoE/i7zresv4/dE4KIy/nHq1wXH8mCuBqLx4Fc4k2TEtvCkiKn4yGqZL
   ECfkvikuAcFjtfjCl+jj5BhKdxzxzkpWO/vbFDjNfmSpZ+/s/SvTZ7dKn
   QrWu4fNJsnB4ApBBeYq1jrURWuqrcY7ZK6L59Cqk8TslOosW2VxIioi4B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="365810931"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="365810931"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:35:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="733934381"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="733934381"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:35:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtmqN-000000077dZ-2inU;
        Fri, 20 Oct 2023 13:35:03 +0300
Date:   Fri, 20 Oct 2023 13:35:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, linux@roeck-us.net, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 1/8] ACPI: utils: Introduce acpi_dev_uid_match() for
 matching _UID
Message-ID: <ZTJX1ytv2aEcHULA@smile.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-2-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020084732.17130-2-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 02:17:25PM +0530, Raag Jadav wrote:
> Introduce acpi_dev_uid_match() helper that matches the device with
> supplied _UID string.

...

> +/**
> + * acpi_dev_uid_match - Match device by supplied UID
> + * @adev: ACPI device to match.
> + * @uid2: Unique ID of the device, pass NULL to not check _UID.
> + *
> + * Matches UID in @adev with given @uid2. Absence of @uid2 will be treated as
> + * a match. If user wants to validate @uid2, it should be done before calling
> + * this function. This behaviour is as needed by most of its current users.

The "current" internally I applied to the result of the series. So reading this
again I think the better wording is "potential".

> + *
> + * Returns:
> + *  - %true if matches or @uid2 is NULL.
> + *  - %false otherwise.
> + */

...

>  /**
>   * acpi_dev_hid_uid_match - Match device by supplied HID and UID
>   * @adev: ACPI device to match.
>   * @hid2: Hardware ID of the device.
>   * @uid2: Unique ID of the device, pass NULL to not check _UID.
>   *
> - * Matches HID and UID in @adev with given @hid2 and @uid2.
> - * Returns true if matches.
> + * Matches HID and UID in @adev with given @hid2 and @uid2. Absence of @uid2
> + * will be treated as a match. If user wants to validate @uid2, it should be
> + * done before calling this function. This behaviour is as needed by most of
> + * its current users.

Ditto.

> + * Returns:
> + *  - %true if matches or @uid2 is NULL.
> + *  - %false otherwise.
>   */

-- 
With Best Regards,
Andy Shevchenko


