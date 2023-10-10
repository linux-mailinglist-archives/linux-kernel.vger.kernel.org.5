Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6D7BF28D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442168AbjJJF6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442130AbjJJF6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:58:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2BB9D;
        Mon,  9 Oct 2023 22:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696917496; x=1728453496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nTL36XXCm4TmPH1hS/JZY0/JhW83W2GCg/yDlzldyZA=;
  b=j2dCxEgiA1bzubNwx3+v063o5xblWq2eN2ayOLEvhiz0HtUtBzKdCXLC
   4QCxeA5hGPxhayiMkz2XWHgAFw7xQXiZ+SU16aZkj+PkwYqbYVe1nKVfV
   CzRV5J8sFE0gGYJV1ZqRfpTryyKoA+M+Zh3JDp7Z0PHX4r0QUGUKl6Z57
   bYlUV2FQytiia0p4W8LV/aI6rZnM2lRJdzZr+6sgqPxjVKzBdFvq2ThqR
   RhLkacgGHT03fEPQqlrv87oiyHtpb1qGmXT96i+R8PTUpVwy/V8/xIaOA
   fSg3C43NhKBSJx+9wHS/0dRZrb7TwXMEfNV20JxB1a8v6Df6f1F/cOQeK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369384655"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="369384655"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 22:58:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="877095816"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="877095816"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga004.jf.intel.com with SMTP; 09 Oct 2023 22:58:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 10 Oct 2023 08:58:11 +0300
Date:   Tue, 10 Oct 2023 08:58:11 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v10 7/9] USB: typec: tps6598x: Add trace for tps25750 irq
Message-ID: <ZSTn82ftBzUYVWPQ@kuha.fi.intel.com>
References: <20231003155842.57313-1-alkuor@gmail.com>
 <20231003155842.57313-8-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003155842.57313-8-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 11:58:40AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> tps25750 event1 register doesn't have all bits in tps6598x
> event registers, only show the events that are masked
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v10:
>   - Move 0012-USB-typec-tps6598x-Add-trace-for-tps25750-irq.patch to patch 7
> Changes in v9:
>   - No changes
> Changes in v8:
>   - Use device_is_compatible instead of of_device_is_compatible
> Changes in v7:
>   - Add driver name to commit subject
> Changes in v6:
>   - Check tps25750 using is_compatiable device node
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
>  drivers/usb/typec/tipd/core.c  |  1 +
>  drivers/usb/typec/tipd/trace.h | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 892432ad80a3..e0ff6fc9f256 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -589,6 +589,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
>  		dev_err(tps->dev, "%s: failed to read events\n", __func__);
>  		goto err_unlock;
>  	}
> +	trace_tps25750_irq(event[0]);
>  
>  	if (!(event[0] | event[1]))
>  		goto err_unlock;
> diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
> index 12cad1bde7cc..28725234a2d8 100644
> --- a/drivers/usb/typec/tipd/trace.h
> +++ b/drivers/usb/typec/tipd/trace.h
> @@ -74,6 +74,13 @@
>  		{ APPLE_CD_REG_INT_DATA_STATUS_UPDATE,		"DATA_STATUS_UPDATE" }, \
>  		{ APPLE_CD_REG_INT_STATUS_UPDATE,		"STATUS_UPDATE" })
>  
> +#define show_tps25750_irq_flags(flags) \
> +	__print_flags_u64(flags, "|", \
> +		{ TPS_REG_INT_PLUG_EVENT,			"PLUG_EVENT" }, \
> +		{ TPS_REG_INT_POWER_STATUS_UPDATE,		"POWER_STATUS_UPDATE" }, \
> +		{ TPS_REG_INT_STATUS_UPDATE,			"STATUS_UPDATE" }, \
> +		{ TPS_REG_INT_PD_STATUS_UPDATE,			"PD_STATUS_UPDATE" })
> +
>  #define TPS6598X_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
>  						      TPS_STATUS_PP_5V0_SWITCH_MASK | \
>  						      TPS_STATUS_PP_HV_SWITCH_MASK | \
> @@ -230,6 +237,21 @@ TRACE_EVENT(cd321x_irq,
>  		      show_cd321x_irq_flags(__entry->event))
>  );
>  
> +TRACE_EVENT(tps25750_irq,
> +	    TP_PROTO(u64 event),
> +	    TP_ARGS(event),
> +
> +	    TP_STRUCT__entry(
> +			     __field(u64, event)
> +			     ),
> +
> +	    TP_fast_assign(
> +			   __entry->event = event;
> +			   ),
> +
> +	    TP_printk("event=%s", show_tps25750_irq_flags(__entry->event))
> +);
> +
>  TRACE_EVENT(tps6598x_status,
>  	    TP_PROTO(u32 status),
>  	    TP_ARGS(status),
> -- 
> 2.34.1

-- 
heikki
