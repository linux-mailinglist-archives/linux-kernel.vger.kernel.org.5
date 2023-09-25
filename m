Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0B7ADC57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjIYPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjIYPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:52:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915D1126;
        Mon, 25 Sep 2023 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695657123; x=1727193123;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aq3M8GDPMNoTrk7Xc3ttpQTC6f+Zw5+A0BsEIRwW4WA=;
  b=NATo0lAR369luzDtJXe8XvVyoDUguZZnRlyu5m1BBJ5Y59gtnhJhtyaM
   atg3ZOMQgki6I1RC3M0OCT2G6mDT/XA8h1AIc/Jgnh1Boxy8kFR1ccehK
   ndlPQz5Fhk+4fQTTLW2yC+DTdkfwwLrxoZEj3qiMn6CJLsQL0+dyacTGz
   EbRlY0SfQIJxI78lDlD1kLFJ1GyX4rC1FPaT9/35/BYPPmaokFCVpATwG
   hkvRBqguIhlnuysY4DR2gFFn8sD6U4Y6CTvqbHaqnpGEzDtelc+2IcrlA
   jsXgfsJCIOkXQ9nx+yp7ecJaGdw0cXGFexs0i0tiq8mHokskObwj7+GZX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447775594"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="447775594"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079260050"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="1079260050"
Received: from stamengx-mobl1.ger.corp.intel.com ([10.249.32.149])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:51:58 -0700
Date:   Mon, 25 Sep 2023 18:51:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH v2 8/9] platform/x86/intel/ifs: Add new error code
In-Reply-To: <20230922232606.1928026-9-jithu.joseph@intel.com>
Message-ID: <1a459161-4c36-813a-49a-4323d57b9b5@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230922232606.1928026-1-jithu.joseph@intel.com> <20230922232606.1928026-9-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-490873389-1695657122=:2147"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-490873389-1695657122=:2147
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 22 Sep 2023, Jithu Joseph wrote:

> Make driver aware of a newly added error code so that it can provide a
> more appropriate error message.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/runtest.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index 94d486e5d263..a29f7b8fa48e 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -40,6 +40,8 @@ enum ifs_status_err_code {
>  	IFS_UNASSIGNED_ERROR_CODE		= 7,
>  	IFS_EXCEED_NUMBER_OF_THREADS_CONCURRENT	= 8,
>  	IFS_INTERRUPTED_DURING_EXECUTION	= 9,
> +	IFS_UNASSIGNED_ERROR_CODE_0xA		= 0xA,
> +	IFS_CORRUPTED_CHUNK		= 0xB,
>  };
>  
>  static const char * const scan_test_status[] = {
> @@ -55,6 +57,8 @@ static const char * const scan_test_status[] = {
>  	[IFS_EXCEED_NUMBER_OF_THREADS_CONCURRENT] =
>  	"Exceeded number of Logical Processors (LP) allowed to run Scan-At-Field concurrently",
>  	[IFS_INTERRUPTED_DURING_EXECUTION] = "Interrupt occurred prior to SCAN start",
> +	[IFS_UNASSIGNED_ERROR_CODE_0xA] = "Unassigned error code 0xA",
> +	[IFS_CORRUPTED_CHUNK] = "Scan operation aborted due to corrupted image. Try reloading",
>  };
>  
>  static void message_not_tested(struct device *dev, int cpu, union ifs_status status)
> @@ -123,6 +127,8 @@ static bool can_restart(union ifs_status status)
>  	case IFS_MISMATCH_ARGUMENTS_BETWEEN_THREADS:
>  	case IFS_CORE_NOT_CAPABLE_CURRENTLY:
>  	case IFS_UNASSIGNED_ERROR_CODE:
> +	case IFS_UNASSIGNED_ERROR_CODE_0xA:
> +	case IFS_CORRUPTED_CHUNK:
>  		break;
>  	}
>  	return false;
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-490873389-1695657122=:2147--
