Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC57B51A6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbjJBLqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbjJBLqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:46:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5FBDA;
        Mon,  2 Oct 2023 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696247154; x=1727783154;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I3VMcrfrrzVRMP7tew8/AAjMaayozfUSJGNVjbPHSZI=;
  b=ffvEn378ZhkTgmOsuKhsaDnWaOzOV0/StOpPvMdWZxADb55Ve31Wlasu
   1XPE+dEG6AITgob3yHNiesrvxmXdC5wDo6TIE+YKblUfINuw+gumYWrO/
   rOXSLcoxCqxc3Wb061bD6syIFz4u/1MugsXfIetP0m5zc4VuGGrMfSRPD
   MEy8rt2hf1Qj6yWUbRXhmYesow98sPNGKrKhrCul4Z+QtPuXb0/Qh/EM5
   afeXaBtI9C154gbvtgbY5OGox4/Up3wQ2eKdp6Qi7UT+yF75o/ha4z/hg
   Juz3tPcujrCxTF/g2DLwLc2kLgwwYPdkF8zgRD5agNXoaWUazOVutKzWu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="413537593"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="413537593"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="816261582"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="816261582"
Received: from roliveir-mobl1.ger.corp.intel.com ([10.251.222.16])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:45:50 -0700
Date:   Mon, 2 Oct 2023 14:45:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH v3 5/9] platform/x86/intel/ifs: Validate image size
In-Reply-To: <20230929202436.2850388-6-jithu.joseph@intel.com>
Message-ID: <f5a560b6-3410-f4bd-479c-c9ebec7fdc63@linux.intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com> <20230929202436.2850388-1-jithu.joseph@intel.com> <20230929202436.2850388-6-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1671406893-1696247153=:2459"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1671406893-1696247153=:2459
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 29 Sep 2023, Jithu Joseph wrote:

> Perform additional validation prior to loading IFS image.
> 
> Error out if the size of the file being loaded doesn't match the size
> specified in the header.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/load.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index 6b827247945b..da54fd060878 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -375,6 +375,7 @@ int ifs_load_firmware(struct device *dev)
>  {
>  	const struct ifs_test_caps *test = ifs_get_test_caps(dev);
>  	struct ifs_data *ifsd = ifs_get_data(dev);
> +	unsigned int expected_size;
>  	const struct firmware *fw;
>  	char scan_path[64];
>  	int ret = -EINVAL;
> @@ -389,6 +390,13 @@ int ifs_load_firmware(struct device *dev)
>  		goto done;
>  	}
>  
> +	expected_size = ((struct microcode_header_intel *)fw->data)->totalsize;
> +	if (fw->size != expected_size) {
> +		dev_err(dev, "File size mismatch (expected %d, actual %ld). Corrupted IFS image.\n",
> +			expected_size, fw->size);
> +		return -EINVAL;
> +	}
> +
>  	ret = image_sanity_check(dev, (struct microcode_header_intel *)fw->data);
>  	if (ret)
>  		goto release;
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1671406893-1696247153=:2459--
