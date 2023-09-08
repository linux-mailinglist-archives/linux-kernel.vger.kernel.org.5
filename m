Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD2D798469
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjIHItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbjIHItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:49:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFFA1BF0;
        Fri,  8 Sep 2023 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694162944; x=1725698944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7cVzb2yOL63fVT104TCf9JL08t/cv38yvqwU2YkIGHA=;
  b=asiKFz86ZGlrUofp+CC3ga/hhszzq9/sDigkrsW6Hw8Ij6pjvifJK/wx
   K/PkZt7q1DYg88Biszb2twCCpUZOjbWPBLbalRLDp9+5BWNkr9RaUHGlo
   CX8L2BqY+NBvEpSciSX2BCdebfyJkJNpXzuOz7LlN+Hbrh1gha3avaxlh
   DsrPJmBWwY5qCeASF4cspxzZXLZ9YWwCs+RGaeFwUWLUInHcByUS2HSTG
   xP/mIqY10mlmFkNPEJu91gdZbobhqaJZE6h7fKhAWF7+aFhmkIXLT5Rdd
   i6J9tKvi7yZ7gsLES4r+4M6InZfesQ2cSy/bh7fXsiqc9zkC7Z+asAzUw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="357062080"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="357062080"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 01:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="745543592"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="745543592"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 08 Sep 2023 01:49:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 08 Sep 2023 11:49:00 +0300
Date:   Fri, 8 Sep 2023 11:49:00 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/5] usb: typec: tcpci_rt1711h: Add rxdz_sel variable
 to struct rt1711h_chip_info
Message-ID: <ZPrf/IVuVRU6Y1S8@kuha.fi.intel.com>
References: <20230906080619.36930-1-biju.das.jz@bp.renesas.com>
 <20230906080619.36930-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906080619.36930-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:06:17AM +0100, Biju Das wrote:
> The RT1715 needs 0.35V/0.75V rx threshold for rd/rp whereas it is 0.4V/0.7V
> for RT1711H. Add rxdz_sel variable to struct rt1711h_chip_info for
> handling this difference.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2->v3:
>  * Added Rb tag from Andy.
> v1->v2:
>  * Swapped the rxdz_sel variable in struct rt1711h_chip_info to avoid
>    holes.
> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 2b7258d3cb4e..40822bae9ae8 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -52,6 +52,7 @@
>  #define BMCIO_RXDZEN	BIT(0)
>  
>  struct rt1711h_chip_info {
> +	u32 rxdz_sel;
>  	u16 did;
>  };
>  
> @@ -204,10 +205,7 @@ static inline int rt1711h_init_cc_params(struct rt1711h_chip *chip, u8 status)
>  	if ((cc1 >= TYPEC_CC_RP_1_5 && cc2 < TYPEC_CC_RP_DEF) ||
>  	    (cc2 >= TYPEC_CC_RP_1_5 && cc1 < TYPEC_CC_RP_DEF)) {
>  		rxdz_en = BMCIO_RXDZEN;
> -		if (chip->info->did == RT1715_DID)
> -			rxdz_sel = RT1711H_BMCIO_RXDZSEL;
> -		else
> -			rxdz_sel = 0;
> +		rxdz_sel = chip->info->rxdz_sel;
>  	} else {
>  		rxdz_en = 0;
>  		rxdz_sel = RT1711H_BMCIO_RXDZSEL;
> @@ -400,6 +398,7 @@ static const struct rt1711h_chip_info rt1711h = {
>  };
>  
>  static const struct rt1711h_chip_info rt1715 = {
> +	.rxdz_sel = RT1711H_BMCIO_RXDZSEL,
>  	.did = RT1715_DID,
>  };
>  
> -- 
> 2.25.1

-- 
heikki
