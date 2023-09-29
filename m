Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61E7B35A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjI2Oei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjI2OeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:34:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC2E1736;
        Fri, 29 Sep 2023 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695997998; x=1727533998;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JlFH3NCrPvb0cMSO3jeHHZRFJNo+/aNIP0tRSriishI=;
  b=FSzv3cPdk8/qc6DmOjiRZficTBqgPPALvHV+vBH75NhRN8iKtnXeGq0e
   /nMH2w3KEFhs3wKEDYyl9I4gSeUgkYVbsBNvqRxC3CSx76y4I+odvu6F2
   jt+kDtj3ucAqj34cAVXlf2C/u1YWJizo4VHTgVEjtfjOzfAZ/HSqQePfb
   Oe3ZLAWVwZ5cMhItalk+ECG2ud7sWqYXVkXglNyN7TfFWsJGqzbqxpxLZ
   b+Ixn+aaKS+K9luCX076LYuj5qEN1NbCYyny21w/T/LPWJAVbiDlhlF2i
   mesyqG14oyIjtT+twQmCFS9DeSF1h+qDSdqV3wwG/kSA+aLAt1lI0AaBe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="361687420"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="361687420"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 07:33:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="840288161"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="840288161"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 07:33:03 -0700
Date:   Fri, 29 Sep 2023 17:33:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] platform/x86: ISST : Check major minor version
In-Reply-To: <f82fcfc9-eb41-56cb-93e1-abf9cf7413@linux.intel.com>
Message-ID: <9d9d1c7e-482b-8817-a09b-9ce364a74cf@linux.intel.com>
References: <20230925194338.966639-1-srinivas.pandruvada@linux.intel.com> <20230925194338.966639-3-srinivas.pandruvada@linux.intel.com> <f82fcfc9-eb41-56cb-93e1-abf9cf7413@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-771370312-1695997985=:1989"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-771370312-1695997985=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Also the shortlog could be improved, IMO. E.g., Ignore minor version 
mismatch.

-- 
 i.

On Fri, 29 Sep 2023, Ilpo Järvinen wrote:

> On Mon, 25 Sep 2023, Srinivas Pandruvada wrote:
> 
> > Parse major and minor version number from the version field. If there
> > is a mismatch for major version, exit from further processing for that
> > domain.
> > 
> > If there is mismatch in minor version, driver continue to process with
> > an error message.
> 
> This sentence sounds odd.
> 
> > Minor version change doesn't change offsets and bit
> > structures of TPMI fields.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> >  .../x86/intel/speed_select_if/isst_tpmi_core.c   | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > index 63faa2ea8327..37f17e229419 100644
> > --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > @@ -30,7 +30,8 @@
> >  #include "isst_if_common.h"
> >  
> >  /* Supported SST hardware version by this driver */
> > -#define ISST_HEADER_VERSION		1
> > +#define ISST_MAJOR_VERSION	0
> > +#define ISST_MINOR_VERSION	1
> >  
> >  /*
> >   * Used to indicate if value read from MMIO needs to get multiplied
> > @@ -352,12 +353,19 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
> >  	pd_info->sst_header.cp_offset *= 8;
> >  	pd_info->sst_header.pp_offset *= 8;
> >  
> > -	if (pd_info->sst_header.interface_version != ISST_HEADER_VERSION) {
> > -		dev_err(&auxdev->dev, "SST: Unsupported version:%x\n",
> > -			pd_info->sst_header.interface_version);
> > +	if (pd_info->sst_header.interface_version == TPMI_VERSION_INVALID)
> > +		return -ENODEV;
> > +
> > +	if (TPMI_MAJOR_VERSION(pd_info->sst_header.interface_version) != ISST_MAJOR_VERSION) {
> > +		dev_err(&auxdev->dev, "SST: Unsupported major version:%lx\n",
> > +			TPMI_MAJOR_VERSION(pd_info->sst_header.interface_version));
> >  		return -ENODEV;
> >  	}
> >  
> > +	if (TPMI_MINOR_VERSION(pd_info->sst_header.interface_version) != ISST_MINOR_VERSION)
> > +		dev_err(&auxdev->dev, "SST: Ignore: Unsupported minor version:%lx\n",
> > +			TPMI_MINOR_VERSION(pd_info->sst_header.interface_version));
> 
> Why is this dev_err(), wouldn't dev_info() be more appropriate since 
> after this patch it's no longer an error?
> 
> > +
> >  	/* Read SST CP Header */
> >  	*((u64 *)&pd_info->cp_header) = readq(pd_info->sst_base + pd_info->sst_header.cp_offset);
> >  
> > 
> 
> 
--8323329-771370312-1695997985=:1989--
