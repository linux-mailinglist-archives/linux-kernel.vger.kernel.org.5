Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FF37B3625
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjI2O4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjI2O4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:56:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D685BF7;
        Fri, 29 Sep 2023 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695999399; x=1727535399;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7q109KUgTdWs+4oLGKBVIqCfCVkxJrWtxAxCJ7Ii44g=;
  b=W7Y7Y/779317umuvncSGfWH95lWWCBBOESixqVFo+IFB6fa5DBrxH1O/
   W3oqlJg60yo0CmyHxN6gbuU0gbyavjsR0nw3kLbj1MY7xo8gtRtX+kc72
   sdlURV+MBBUx6PDPra0CVPfzlVNDpW+cxPZTubFOSPyS/d8/A7Hb+8nT9
   po4tUYOlr4Eza+C0YD3LTZfsTyA70HrHEqkNaI7ATlizzDaAOTA3oMZkG
   cXc8mm163dmLcbIQJkcFtAlibQmCaawM1jQ6F15G+bj53T1HVFSIF/RVR
   phdknqwSBwwHw8ZuIv8EVxAaWRPAFe3ZPLAwvNLlpFtH5tRrCHs+wFpUi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="385131315"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="385131315"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 07:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="840291662"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="840291662"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 07:56:35 -0700
Date:   Fri, 29 Sep 2023 17:56:33 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Peter Newman <peternewman@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Documentation/x86: Document resctrl's new
 sparse_masks
In-Reply-To: <c42f54af4790785dec25dd537aaea56bfba78a67.1695977733.git.maciej.wieczor-retman@intel.com>
Message-ID: <b94b695f-f644-4936-60db-b1312fb13667@linux.intel.com>
References: <cover.1695977733.git.maciej.wieczor-retman@intel.com> <c42f54af4790785dec25dd537aaea56bfba78a67.1695977733.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-930727500-1695999398=:1989"
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

--8323329-930727500-1695999398=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 29 Sep 2023, Maciej Wieczor-Retman wrote:

> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> The documentation mentions that non-contiguous bit masks are not
> supported in Intel Cache Allocation Technology (CAT).
> 
> Update the documentation on how to determine if sparse bit masks are
> allowed in L2 and L3 CAT.
> 
> Mention the file with feature support information is located in
> the /sys/fs/resctrl/info/{resource}/ directories and enumerate what
> are the possible outputs on file read operation.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v3:
> - Added Peter's tested-by and reviewed-by tags.
> 
> Changelog v2:
> - Change bitmap naming convention to bit mask. (Reinette)
> 
>  Documentation/arch/x86/resctrl.rst | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index cb05d90111b4..4c6421e2aa31 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -124,6 +124,13 @@ related to allocation:
>  			"P":
>  			      Corresponding region is pseudo-locked. No
>  			      sharing allowed.
> +"sparse_masks":
> +		Indicates if non-contiguous 1s value in CBM is supported.
> +
> +			"0":
> +			      Only contiguous 1s value in CBM is supported.
> +			"1":
> +			      Non-contiguous 1s value in CBM is supported.
>  
>  Memory bandwidth(MB) subdirectory contains the following files
>  with respect to allocation:
> @@ -445,12 +452,13 @@ For cache resources we describe the portion of the cache that is available
>  for allocation using a bitmask. The maximum value of the mask is defined
>  by each cpu model (and may be different for different cache levels). It
>  is found using CPUID, but is also provided in the "info" directory of
> -the resctrl file system in "info/{resource}/cbm_mask". Intel hardware
> +the resctrl file system in "info/{resource}/cbm_mask". Some Intel hardware
>  requires that these masks have all the '1' bits in a contiguous block. So
>  0x3, 0x6 and 0xC are legal 4-bit masks with two bits set, but 0x5, 0x9
> -and 0xA are not.  On a system with a 20-bit mask each bit represents 5%
> -of the capacity of the cache. You could partition the cache into four
> -equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
> +and 0xA are not. Check /sys/fs/resctrl/info/{resource}/sparse_masks
> +if non-contiguous 1s value is supported. On a system with a 20-bit mask
> +each bit represents 5% of the capacity of the cache. You could partition
> +the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-930727500-1695999398=:1989--
