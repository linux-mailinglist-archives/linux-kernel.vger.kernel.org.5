Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0697A7A2409
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjIOQ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbjIOQ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:58:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53238211E;
        Fri, 15 Sep 2023 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694797080; x=1726333080;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GJvSC4wZ70sklL2nyd+0IoJ0iYnegdWVS9yxn2Uh8vc=;
  b=QGna7J/b1S4ucoqkX3vogbnJNpEBVWztnFK9rSCWP50OMVoebPIvvlM3
   OAcMDaenDFTCzJrSw42phVFBLVtT9W4uA+0zfMsyx5gRYjv2odcssqSq/
   ASl+aeZJDFf89bu+rdUr52O8mJOyrBkDo++tdkXZnngR2Pt/bq1owGfh/
   srMWXChLFK0tpP/EIb2vWgDI54EUQtcLJigMJ1QpdXfgkgSaeQxcXF2/Q
   AtwxndJ7Kh4uDOcWR+znLXr9xQHCLQjbqfVycL1f59380kgHLOdKxHdhK
   x46zPaLnhFt/uHMw77abZCUQURvkkfMpc/KYVk8da7XBw2TsmDafyogDm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="445756597"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="445756597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="694783038"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="694783038"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:57:55 -0700
Date:   Fri, 15 Sep 2023 19:57:53 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        pengfei.xu@intel.com
Subject: Re: [PATCH 06/10] platform/x86/intel/ifs: Validate image size
In-Reply-To: <20230913183348.1349409-7-jithu.joseph@intel.com>
Message-ID: <b189850-ce7c-d8fc-ecd-1a843f52b916@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230913183348.1349409-7-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023, Jithu Joseph wrote:

> Perform additional validation prior to loading IFS image.
> 
> Error out if the size of the file being loaded doesn't
> match the size specified in the header.

Please fix these short lines in all your patches.
 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/load.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index e8fb03dd8bcf..778a3b89a24d 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -376,6 +376,7 @@ int ifs_load_firmware(struct device *dev)
>  {
>  	const struct ifs_test_caps *test = ifs_get_test_caps(dev);
>  	struct ifs_data *ifsd = ifs_get_data(dev);
> +	unsigned int expected_size;
>  	const struct firmware *fw;
>  	char scan_path[64];
>  	int ret = -EINVAL;
> @@ -390,6 +391,13 @@ int ifs_load_firmware(struct device *dev)
>  		goto done;
>  	}
>  
> +	expected_size = ((struct microcode_header_intel *)fw->data)->totalsize;
> +	if (fw->size != expected_size) {
> +		dev_err(dev, "File size mismatch (expected %d, actual %ld). Corrupted IFS image.\n",
> +			expected_size, fw->size);
> +		return -EBADFD;
> +	}
> +
>  	ret = image_sanity_check(dev, (struct microcode_header_intel *)fw->data);

It looks than a bit odd to add the check here and not into a function 
called image_sanity_check()?!?

>  	if (ret)
>  		goto release;
> 

-- 
 i.

