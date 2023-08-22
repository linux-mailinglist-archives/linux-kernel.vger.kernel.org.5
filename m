Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB878423C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjHVNjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjHVNju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:39:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1311018B;
        Tue, 22 Aug 2023 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692711589; x=1724247589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y1OTxgbGeAr+sq4oKE3VCclLzYN1bhwn+vqbXNQvBR8=;
  b=gWpBsd0iORaWIbpxLtMrxQEsRwjJXXUYi/Tb7qLUDMFLoKRyVOl4RsgU
   tAzgpYCk5uZmt82Ftjn68iq8kacD3XHdOGD/XbfroXlojHZlAJmPibnab
   De0yxrk7mIi+sjleA4v4poV+UU6tVTZxWPWxKSxNRQyhVQRgCKFXq42Hp
   esU7eJIvzlPLZiYUOXb6i01FRJKzX3mmwoXWc98Qo+kzEo6W1WQ542q0o
   xPWXZnSQxp4p00fdomVoJmC5tAYPY1pFpPdDlBoBRuH4PFyzy0/i79BYf
   wv4hkLM03K5vu4xG9IURFdiz80Ld2QlS1Ns7UudCb37AAUKlJexafaUpv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="440245483"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="440245483"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 06:39:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="879957267"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Aug 2023 06:39:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 22 Aug 2023 16:39:43 +0300
Date:   Tue, 22 Aug 2023 16:39:43 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] usb: typec: altmodes/displayport: add support for
 embedded DP cases
Message-ID: <ZOS6n0PFkXgsfYly@kuha.fi.intel.com>
References: <20230817150824.14371-1-dmitry.baryshkov@linaro.org>
 <20230817150824.14371-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817150824.14371-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 06:08:23PM +0300, Dmitry Baryshkov wrote:
> In the embedded cases, the DisplayPort connector is handled by the TCPM
> itself. It was proposed to add the "displayport" OF property to the DT
> bindings, but it  was rejected in favour of properly describing the
> electrical signal path using of_graph.
> 
> Fallback to the controller fwnode for HPD notifications to
> support such usecases without requiring additional DT properties.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/displayport.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index bc4af130940d..a4cf1045b535 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -594,7 +594,10 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	alt->ops = &dp_altmode_ops;
>  
>  	fwnode = dev_fwnode(alt->dev.parent->parent); /* typec_port fwnode */
> -	dp->connector_fwnode = fwnode_find_reference(fwnode, "displayport", 0);
> +	if (fwnode_property_present(fwnode, "displayport"))
> +		dp->connector_fwnode = fwnode_find_reference(fwnode, "displayport", 0);
> +	else
> +		dp->connector_fwnode = fwnode_handle_get(fwnode); /* embedded DP */
>  	if (IS_ERR(dp->connector_fwnode))
>  		dp->connector_fwnode = NULL;
>  
> -- 
> 2.39.2

-- 
heikki
