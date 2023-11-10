Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8767E83BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbjKJU0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjKJU01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:26:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3023E39CC6;
        Fri, 10 Nov 2023 06:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699627564; x=1731163564;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5DefA1jGiMB0jC/ObGqDHilaH2y2s05XvqizrJc9Z+w=;
  b=XywdbUIZFn1R69UbBsp/sr/9wbwbBp28WW1It6EgvGGJMOwQqyt47rtn
   TqCB0V5/yDmeBTS6SaP8pGYIxa19owl5fDU7rh7yt1PeuXWVFSL+bJTfM
   5rL3l4l99lbnG+qnPkpNLAAHlkhYiTNt2l86XvcLwpE0TQBJQ/I1FqIJg
   fwG2HTDAF8/+gTsY16KM6urjRJdOdJFc7K63bFwDJICqTd1tkw1HYj1fc
   mMsMXIXUtIUaugC2WOpm9n6ala3CVMV3ZcRM3/wzTtnrb56gvpmHCkNHH
   3A3ozCvbTEj3mtS/PjsVbxjwkSXx0mZRf3Fjaplj6MUuBAC2ujxWeen5C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="3177023"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="3177023"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 06:46:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="792870541"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="792870541"
Received: from joudin-mobl2.ger.corp.intel.com ([10.252.38.36])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 06:46:00 -0800
Date:   Fri, 10 Nov 2023 16:45:57 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com,
        vegard.nossum@oracle.com, darren.kenny@oracle.com
Subject: Re: [PATCH v2 1/4] platform/x86: hp-bioscfg: Remove unused obj in
 hp_add_other_attributes()
In-Reply-To: <20231110142921.3398072-1-harshit.m.mogalapalli@oracle.com>
Message-ID: <8bfac7ad-1934-cbb4-2e78-dde532bf7df6@linux.intel.com>
References: <20231110142921.3398072-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023, Harshit Mogalapalli wrote:

> acpi_object *obj is unused in this function, so delete it, also
> delete a unnecessary kfree(obj);
> 
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---

Please make this the last patch of the series since the others are true 
fixes and this is just a (useful!) cleanup.

-- 
 i.

>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> index 5798b49ddaba..0b563582d90d 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -575,82 +575,80 @@ static void release_attributes_data(void)
>  /**
>   * hp_add_other_attributes() - Initialize HP custom attributes not
>   * reported by BIOS and required to support Secure Platform and Sure
>   * Start.
>   *
>   * @attr_type: Custom HP attribute not reported by BIOS
>   *
>   * Initialize all 2 types of attributes: Platform and Sure Start
>   * object.  Populates each attribute types respective properties
>   * under sysfs files.
>   *
>   * Returns zero(0) if successful. Otherwise, a negative value.
>   */
>  static int hp_add_other_attributes(int attr_type)
>  {
>  	struct kobject *attr_name_kobj;
> -	union acpi_object *obj = NULL;
>  	int ret;
>  	char *attr_name;
>  
>  	mutex_lock(&bioscfg_drv.mutex);
>  
>  	attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
>  	if (!attr_name_kobj) {
>  		ret = -ENOMEM;
>  		goto err_other_attr_init;
>  	}
>  
>  	/* Check if attribute type is supported */
>  	switch (attr_type) {
>  	case HPWMI_SECURE_PLATFORM_TYPE:
>  		attr_name_kobj->kset = bioscfg_drv.authentication_dir_kset;
>  		attr_name = SPM_STR;
>  		break;
>  
>  	case HPWMI_SURE_START_TYPE:
>  		attr_name_kobj->kset = bioscfg_drv.main_dir_kset;
>  		attr_name = SURE_START_STR;
>  		break;
>  
>  	default:
>  		pr_err("Error: Unknown attr_type: %d\n", attr_type);
>  		ret = -EINVAL;
>  		goto err_other_attr_init;
>  	}
>  
>  	ret = kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
>  				   NULL, "%s", attr_name);
>  	if (ret) {
>  		pr_err("Error encountered [%d]\n", ret);
>  		kobject_put(attr_name_kobj);
>  		goto err_other_attr_init;
>  	}
>  
>  	/* Populate attribute data */
>  	switch (attr_type) {
>  	case HPWMI_SECURE_PLATFORM_TYPE:
>  		ret = hp_populate_secure_platform_data(attr_name_kobj);
>  		if (ret)
>  			goto err_other_attr_init;
>  		break;
>  
>  	case HPWMI_SURE_START_TYPE:
>  		ret = hp_populate_sure_start_data(attr_name_kobj);
>  		if (ret)
>  			goto err_other_attr_init;
>  		break;
>  
>  	default:
>  		ret = -EINVAL;
>  		goto err_other_attr_init;
>  	}
>  
>  	mutex_unlock(&bioscfg_drv.mutex);
>  	return 0;
>  
>  err_other_attr_init:
>  	mutex_unlock(&bioscfg_drv.mutex);
> -	kfree(obj);
>  	return ret;
>  }
>  
> 
