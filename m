Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95157779085
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjHKNOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjHKNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:14:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA641270F;
        Fri, 11 Aug 2023 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691759653; x=1723295653;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DqlutKDFR+edpFN90YKfv+7uoSGtCYEEKq4YBuFZQSA=;
  b=SeIJURKK1QkinR4OL07QpMSY0amBYCeB7p9gyxOp+vZCxV4LiR/54jbB
   AWpW3ycXHdlpqzR30ifOqDQBS9MsSMCsmagpfNp1e88q/jR68pW+wrr1U
   9ECj7BmeZK3O446p1vkqKHGp/5MFuxAB2ROuymskfFVAdvfVNCtv7/U27
   F5gGb48CPMk3FGP/7q43tmMFB8VcllOVztIKRT/sxXvj5RMZokY9FmcV3
   HD5w9Yj75JEC/jn/U5d2x0UqxEKIdeAO/dRUcvIa9IdjAy/808V48dMR1
   ia4GPIhGJaH4c+v8mX/vc/8zd7lFBRXlqpKCYxnxB0JwVdPdgkmR341Tn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369145177"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="369145177"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:14:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="846802058"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="846802058"
Received: from aberko-mobl1.ger.corp.intel.com ([10.252.51.87])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:14:11 -0700
Date:   Fri, 11 Aug 2023 16:14:08 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/1] platform/x86/amd/pmf: Use str_on_off() helper
In-Reply-To: <20230811131330.71263-1-andriy.shevchenko@linux.intel.com>
Message-ID: <3c7dde60-e6a8-1729-4ace-9768d331c2d0@linux.intel.com>
References: <20230811131330.71263-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1649411613-1691759652=:50003"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1649411613-1691759652=:50003
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 11 Aug 2023, Andy Shevchenko wrote:

> We have a common helper to represent a boolean value as "on"/"off"
> string. Use it for the sake of the unified style.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/amd/pmf/cnqf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/cnqf.c b/drivers/platform/x86/amd/pmf/cnqf.c
> index 539b186e9027..bc8899e15c91 100644
> --- a/drivers/platform/x86/amd/pmf/cnqf.c
> +++ b/drivers/platform/x86/amd/pmf/cnqf.c
> @@ -8,6 +8,7 @@
>   * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>   */
>  
> +#include <linux/string_choices.h>
>  #include <linux/workqueue.h>
>  #include "pmf.h"
>  
> @@ -399,7 +400,7 @@ static ssize_t cnqf_enable_store(struct device *dev,
>  			amd_pmf_set_sps_power_limits(pdev);
>  	}
>  
> -	dev_dbg(pdev->dev, "Received CnQF %s\n", input ? "on" : "off");
> +	dev_dbg(pdev->dev, "Received CnQF %s\n", str_on_off(input));
>  	return count;
>  }
>  
> @@ -409,7 +410,7 @@ static ssize_t cnqf_enable_show(struct device *dev,
>  {
>  	struct amd_pmf_dev *pdev = dev_get_drvdata(dev);
>  
> -	return sysfs_emit(buf, "%s\n", pdev->cnqf_enabled ? "on" : "off");
> +	return sysfs_emit(buf, "%s\n", str_on_off(pdev->cnqf_enabled));
>  }
>  
>  static DEVICE_ATTR_RW(cnqf_enable);
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1649411613-1691759652=:50003--
