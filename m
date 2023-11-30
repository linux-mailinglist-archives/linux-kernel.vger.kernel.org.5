Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5057FEE78
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345339AbjK3MBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345305AbjK3MBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:01:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E394E10E6;
        Thu, 30 Nov 2023 04:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701345666; x=1732881666;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZixJZq2C5Em0LPUyj1YLbf7Mo+UhBMXQq3SSosCyiFE=;
  b=iGtsfSwcOzds0x6FVM+gPzE/Q2EeBn5p9cSbwXlNiio3doKekaJ8zdG8
   7wNGa6EstXW4abpHwJ4hgyClYJb0CMRPCPIQz0rYM8Dv94ontmFZAP4a5
   dbhOMBKwiy2JuPiK+jqs+JfKXXQRwEGHFf4Fs9ErEqUfXHaCSYnqbOvcb
   EyfbNXXunBPSuVbtwXSK0JOeiAO5mLRbxbCkNfAUP0A81V3Hvph5amAC7
   LPMxg8uSyGcmamOsamb9ApYr0PyQ2NL7l/qhzTcQrMm24mAhQPIcYG3Ql
   3peeV/1bu9k/IrNu2LM1DM+SYvjYrjYw3HmfVA/ntvaCrg+igiDXpatRJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="302983"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="302983"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 04:01:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="839779672"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="839779672"
Received: from bergler-mobl.ger.corp.intel.com ([10.249.33.30])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 04:01:03 -0800
Date:   Thu, 30 Nov 2023 14:01:00 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] platform/x86/intel/tpmi: Move TPMI ID definitions
In-Reply-To: <20231128185605.3027653-5-srinivas.pandruvada@linux.intel.com>
Message-ID: <35f3ae1d-d714-69c2-6447-eba312c712c1@linux.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com> <20231128185605.3027653-5-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-904996486-1701345664=:1808"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-904996486-1701345664=:1808
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 28 Nov 2023, Srinivas Pandruvada wrote:

> Move TPMI ID definitions to common include file. In this way other
> feature drivers don't have to redefine.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/platform/x86/intel/tpmi.c | 13 -------------
>  include/linux/intel_tpmi.h        | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
> index 44773c210324..14575da91d2c 100644
> --- a/drivers/platform/x86/intel/tpmi.c
> +++ b/drivers/platform/x86/intel/tpmi.c
> @@ -176,19 +176,6 @@ struct tpmi_feature_state {
>  	u32 locked:1;
>  } __packed;
>  
> -/*
> - * List of supported TMPI IDs.
> - * Some TMPI IDs are not used by Linux, so the numbers are not consecutive.
> - */
> -enum intel_tpmi_id {
> -	TPMI_ID_RAPL = 0, /* Running Average Power Limit */
> -	TPMI_ID_PEM = 1, /* Power and Perf excursion Monitor */
> -	TPMI_ID_UNCORE = 2, /* Uncore Frequency Scaling */
> -	TPMI_ID_SST = 5, /* Speed Select Technology */
> -	TPMI_CONTROL_ID = 0x80, /* Special ID for getting feature status */
> -	TPMI_INFO_ID = 0x81, /* Special ID for PCI BDF and Package ID information */
> -};
> -
>  /*
>   * The size from hardware is in u32 units. This size is from a trusted hardware,
>   * but better to verify for pre silicon platforms. Set size to 0, when invalid.
> diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
> index a240e15ef77f..6c31768cdb83 100644
> --- a/include/linux/intel_tpmi.h
> +++ b/include/linux/intel_tpmi.h
> @@ -12,6 +12,19 @@
>  #define TPMI_MINOR_VERSION(val)	FIELD_GET(GENMASK(4, 0), val)
>  #define TPMI_MAJOR_VERSION(val)	FIELD_GET(GENMASK(7, 5), val)
>  
> +/*
> + * List of supported TMPI IDs.
> + * Some TMPI IDs are not used by Linux, so the numbers are not consecutive.
> + */
> +enum intel_tpmi_id {
> +	TPMI_ID_RAPL = 0, /* Running Average Power Limit */
> +	TPMI_ID_PEM = 1, /* Power and Perf excursion Monitor */
> +	TPMI_ID_UNCORE = 2, /* Uncore Frequency Scaling */
> +	TPMI_ID_SST = 5, /* Speed Select Technology */
> +	TPMI_CONTROL_ID = 0x80, /* Special ID for getting feature status */
> +	TPMI_INFO_ID = 0x81, /* Special ID for PCI BDF and Package ID information */
> +};

While at it, could you align the comments to start at the same column so 
it would slightly less messy to read.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-904996486-1701345664=:1808--
