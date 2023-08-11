Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EA57788B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjHKIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHKIEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:04:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2C410FB;
        Fri, 11 Aug 2023 01:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691741061; x=1723277061;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OI4Vyx79SFJFjotLEqTDnh6sgtstdHl0KwIylo48sJg=;
  b=TBa9Sdh2FKT/OGiseAjPHZsLATsgQ9YBw1Y0WkjjcImGGu+aNVoEATH5
   UBSVT6BypUF71Z093v+L2RSdoC0W8QeHzcDLHmsBNBh5XD6fJ/o+gzNfz
   AREayJvja9ipcYZTVdcu6iK+ijfsxhUpVPkKpqNawYRLexYuBX6gWieSr
   bKHj94gZDtqEMYN04sszU/vDgte3trtngnj9R5pY0vTxcvEk+BC7OTs+F
   qXY/8ClBH2rvVOtE3hexu1OiMINAS6w6oMFz4pLbMEG5NMSdYhg5vfa+x
   hPeRQYYhrH9f5mWGfIWPG6ae/31nrtKiD9rBfizC/F8e8kzHGfbSeBQbY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="371634171"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="371634171"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 01:04:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="979157565"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="979157565"
Received: from aberko-mobl1.ger.corp.intel.com ([10.252.51.87])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 01:04:19 -0700
Date:   Fri, 11 Aug 2023 11:04:17 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
cc:     jorge.lopez2@hp.com, hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] platform/x86: hp-bioscfg: Remove useless else
In-Reply-To: <20230811062957.82728-1-jiapeng.chong@linux.alibaba.com>
Message-ID: <2ec499b-c37e-0a9-c163-2a1591b56029@linux.intel.com>
References: <20230811062957.82728-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023, Jiapeng Chong wrote:

> The assignment of the else and if branches is the same, so the else
> here is redundant, so we remove it.
> 
> ./drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:545:3-5: WARNING: possible condition with no effect (if == else).
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> index 03d0188804ba..771e554182dc 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> @@ -541,14 +541,8 @@ void hp_exit_password_attributes(void)
>  		struct kobject *attr_name_kobj =
>  			bioscfg_drv.password_data[instance_id].attr_name_kobj;
>  
> -		if (attr_name_kobj) {
> -			if (!strcmp(attr_name_kobj->name, SETUP_PASSWD))
> -				sysfs_remove_group(attr_name_kobj,
> -						   &password_attr_group);
> -			else
> -				sysfs_remove_group(attr_name_kobj,
> -						   &password_attr_group);
> -		}
> +		if (attr_name_kobj)
> +			sysfs_remove_group(attr_name_kobj, &password_attr_group);
>  	}
>  	bioscfg_drv.password_instances_count = 0;
>  	kfree(bioscfg_drv.password_data);

While this is a valid observation, I wonder why you didn't change the 
create side too?

I hope it's not because you never took a look to understand the 
SETUP_PASSWD related code, it'd be pretty impossible to not notice it. 
This could have just as well have been a bug with inconsitent pairing 
against create side, which is why reports from automated tools must not be 
implemented blindly but the related code must be understood first.

-- 
 i.

