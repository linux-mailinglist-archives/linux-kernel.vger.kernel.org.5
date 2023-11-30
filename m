Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481CB7FED7B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345093AbjK3LDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjK3LC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:02:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF29010D1;
        Thu, 30 Nov 2023 03:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701342184; x=1732878184;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i2Wr7ecNtRJAY/DgRAZzaqURca1WxdM6DU2/209vyHI=;
  b=dGIohfdPkOmgj617HMPSaSrEWaz3MD8Lk6EF7HALjB3ntJDv4OFNtwYh
   5B91E613xiO9O6M3DSsoEZHwYJPqV0u3FaVROjKKHZsjo84hebZ5cjPOj
   Zdc18jg54scvreXzhzjvLwsXAFvOiKEWLptow3g8YWT84aykhDvSh6E5h
   JnEDUbM2KyV9wMnrKc9kFrtxkanzHhiUAnvrsrKEsyRzBZif/sgmolfc9
   oLeOZb6z5s3NXGi7WictFJv5ecR81NpDKL1OJrGL3YF/l/nB/BX2GSVbR
   n4jn3yNxfDuyksxjswqVMiitaV8DcUqoTcshOlz76qtUosDnyA/JdcpiP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="397199510"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="397199510"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 03:03:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="887203934"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="887203934"
Received: from bergler-mobl.ger.corp.intel.com ([10.249.33.30])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 03:03:02 -0800
Date:   Thu, 30 Nov 2023 13:03:00 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V6 02/20] platform/x86/intel/vsec: Remove unnecessary
 return
In-Reply-To: <20231129222132.2331261-3-david.e.box@linux.intel.com>
Message-ID: <2e5e96d-a061-b47d-b08d-ce12fa60baf4@linux.intel.com>
References: <20231129222132.2331261-1-david.e.box@linux.intel.com> <20231129222132.2331261-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1328502515-1701342183=:1808"
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

--8323329-1328502515-1701342183=:1808
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 29 Nov 2023, David E. Box wrote:

> In intel_vsec_add_aux(), just return from the last call to
> devm_add_action_or_reset() instead of checking its return value.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V6 - New patch
> 
>  drivers/platform/x86/intel/vsec.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index 2d568466b4e2..340562ae2041 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -174,12 +174,8 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
>  		return ret;
>  	}
>  
> -	ret = devm_add_action_or_reset(parent, intel_vsec_remove_aux,
> +	return devm_add_action_or_reset(parent, intel_vsec_remove_aux,
>  				       auxdev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1328502515-1701342183=:1808--
