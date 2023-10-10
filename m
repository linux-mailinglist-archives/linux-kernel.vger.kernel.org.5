Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530757BF2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442181AbjJJGAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442161AbjJJF76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:59:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B129D;
        Mon,  9 Oct 2023 22:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696917597; x=1728453597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=THINrPfpttlZRtTWFpoj0pkcWumqQenOCJ3YusrWSnM=;
  b=KUCLIO/wk+T0uB0xAoGDkqHCHf+MH1GWpdLTh69qJpI+uVvoSXGbJsM0
   bll3jYLRvYrZVRiTw9ST9Vh2DK3OqIC5dg/bz5hvzG5VQ5iDLGu15ED+G
   Mu+s5OY1+xvOXx6v2iPaAaw6xkNjDYEINtgRGnH1bDm95yveTA6pkK4Cs
   ITgg8bvLLKZNTtTldqZJbDrNxi+gYW57aJZbtrv/x96vqCemga2hhY5al
   VL7RWst/SkcW5OUvXBDZai2P/ewPWVaCDep2EDCsfMesOSSpNtpKbnKFW
   edfBM1aIBLcBRYcNhcjIXB1sgv4g02BoNZ3XvKCB2fK818MgJjdICXbg+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="364610674"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="364610674"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 22:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="788448551"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="788448551"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga001.jf.intel.com with SMTP; 09 Oct 2023 22:59:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 10 Oct 2023 08:59:50 +0300
Date:   Tue, 10 Oct 2023 08:59:50 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v10 9/9] USB: typec: tps6598x: Add status trace for
 tps25750
Message-ID: <ZSToVhQHbPrlSeN3@kuha.fi.intel.com>
References: <20231003155842.57313-1-alkuor@gmail.com>
 <20231003155842.57313-10-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003155842.57313-10-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 11:58:42AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> tps25750 status register is a subset of tps6598x status register, hence
> a trace for tps25750 status register is added.
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v10:
>   - Move 0014-USB-typec-tps6598x-Add-status-trace-for-tps25750.patch to patch 9
>   - Remove status trace prototype from device data
> Changes in v9:
>   - No changes
> Changes in v8:
>   - No changes
> Changes in v7:
>   - Add driver name to commit subject
> Changes in v6:
>   - No changes
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
>  drivers/usb/typec/tipd/core.c  |  1 +
>  drivers/usb/typec/tipd/trace.h | 37 ++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 7bdf1ef5dd1a..0e867f531d34 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1412,6 +1412,7 @@ static const struct tipd_data tps25750_data = {
>  	.irq_handler = tps25750_interrupt,
>  	.register_port = tps25750_register_port,
>  	.trace_power_status = trace_tps25750_power_status,
> +	.trace_status = trace_tps25750_status,
>  	.apply_patch = tps25750_apply_patch,
>  };
>  
> diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
> index 739b0a2a867d..0669cca12ea1 100644
> --- a/drivers/usb/typec/tipd/trace.h
> +++ b/drivers/usb/typec/tipd/trace.h
> @@ -91,6 +91,14 @@
>  						      TPS_STATUS_USB_HOST_PRESENT_MASK | \
>  						      TPS_STATUS_LEGACY_MASK))
>  
> +#define TPS25750_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
> +						      GENMASK(19, 7) | \
> +						      TPS_STATUS_VBUS_STATUS_MASK | \
> +						      TPS_STATUS_USB_HOST_PRESENT_MASK | \
> +						      TPS_STATUS_LEGACY_MASK | \
> +						      BIT(26) | \
> +						      GENMASK(31, 28)))
> +
>  #define show_status_conn_state(status) \
>  	__print_symbolic(TPS_STATUS_CONN_STATE((status)), \
>  		{ TPS_STATUS_CONN_STATE_CONN_WITH_R_A,	"conn-Ra"  }, \
> @@ -148,6 +156,14 @@
>  		      { TPS_STATUS_HIGH_VOLAGE_WARNING,	"HIGH_VOLAGE_WARNING" }, \
>  		      { TPS_STATUS_HIGH_LOW_VOLTAGE_WARNING, "HIGH_LOW_VOLTAGE_WARNING" })
>  
> +#define show_tps25750_status_flags(flags) \
> +	__print_flags((flags & TPS25750_STATUS_FLAGS_MASK), "|", \
> +		      { TPS_STATUS_PLUG_PRESENT,	"PLUG_PRESENT" }, \
> +		      { TPS_STATUS_PLUG_UPSIDE_DOWN,	"UPSIDE_DOWN" }, \
> +		      { TPS_STATUS_PORTROLE,		"PORTROLE" }, \
> +		      { TPS_STATUS_DATAROLE,		"DATAROLE" }, \
> +		      { TPS_STATUS_BIST,		"BIST" })
> +
>  #define show_power_status_source_sink(power_status) \
>  	__print_symbolic(TPS_POWER_STATUS_SOURCESINK(power_status), \
>  		{ 1, "sink" }, \
> @@ -292,6 +308,27 @@ TRACE_EVENT(tps6598x_status,
>  		    )
>  );
>  
> +TRACE_EVENT(tps25750_status,
> +	    TP_PROTO(u32 status),
> +	    TP_ARGS(status),
> +
> +	    TP_STRUCT__entry(
> +			     __field(u32, status)
> +			     ),
> +
> +	    TP_fast_assign(
> +			   __entry->status = status;
> +			   ),
> +
> +	    TP_printk("conn: %s, vbus: %s, usb-host: %s, legacy: %s, flags: %s",
> +		      show_status_conn_state(__entry->status),
> +		      show_status_vbus_status(__entry->status),
> +		      show_status_usb_host_present(__entry->status),
> +		      show_status_legacy(__entry->status),
> +		      show_tps25750_status_flags(__entry->status)
> +		    )
> +);
> +
>  TRACE_EVENT(tps6598x_power_status,
>  	    TP_PROTO(u16 power_status),
>  	    TP_ARGS(power_status),
> -- 
> 2.34.1

-- 
heikki
