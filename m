Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5237BF294
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442177AbjJJF7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442180AbjJJF66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:58:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E129F;
        Mon,  9 Oct 2023 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696917537; x=1728453537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0hvfx6b9dnQ2oV3bSyrplOZ5XbLFJIzuKxTSg1jyW7I=;
  b=Z5ghSNgHOe0fwQpclke0eG55LGFvVVzH7WzMRuh1fcpeNqYL85xxOhhr
   s7sV+uYrr39eSceAemw21U3/FCru1s5Zjs+GiR3aXJign0C9+nIP5YtkP
   8EQbrTmh+YX7ntAi9t7GYuPh0Qprb8ElBDi6aHdD7Z6ZwBOit3DWfK7VC
   h8nyHs3KzZXhif8OjrrVdpPWULfA94elfZSwQMSzeUm/SbPMd7/vXI9CB
   jngYrebxJLor8IYsj/LlGoLXM6ZwtGUAKp6ZNNkCcIPWVz2QFj5UbAXgz
   gBW9QDwikKpOwtb8DtaL1YP3mugF+EgZk0SB6XfeG9nbu67DxdmUJkbHn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="2904072"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="2904072"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 22:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084639496"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="1084639496"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga005.fm.intel.com with SMTP; 09 Oct 2023 22:58:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 10 Oct 2023 08:58:51 +0300
Date:   Tue, 10 Oct 2023 08:58:51 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v10 8/9] USB: typec: tps6598x: Add power status trace for
 tps25750
Message-ID: <ZSToG8oKLKZiV8zf@kuha.fi.intel.com>
References: <20231003155842.57313-1-alkuor@gmail.com>
 <20231003155842.57313-9-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003155842.57313-9-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 11:58:41AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> tps25750 power status register is a subset of tps6598x power status
> register.
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v10:
>   - Move 0013-USB-typec-tps6598x-Add-power-status-trace-for-tps257.patch to patch 8
>   - Remove power status trace prototype from device data
> Changes in v9:
>   - Move of_device_id to its original place
>   - Move device data structs to the top of of_device_id
>   - Use device_get_match_data to get device data
> Changes in v8:
>   - Populate of_device_id with device data
>   - Change tps->cb to tps->data
>   - Assign matched data to tps data
> Changes in v7:
>   - Add driver name to commit subject
>   - Create tps25750 interrupt handler
> Changes in v6:
>   - Create tipd callbacks factory 
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
>  drivers/usb/typec/tipd/core.c     |  1 +
>  drivers/usb/typec/tipd/tps6598x.h | 19 ++++++++++++++++++
>  drivers/usb/typec/tipd/trace.h    | 33 +++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index e0ff6fc9f256..7bdf1ef5dd1a 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1411,6 +1411,7 @@ static const struct tipd_data tps6598x_data = {
>  static const struct tipd_data tps25750_data = {
>  	.irq_handler = tps25750_interrupt,
>  	.register_port = tps25750_register_port,
> +	.trace_power_status = trace_tps25750_power_status,
>  	.apply_patch = tps25750_apply_patch,
>  };
>  
> diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
> index f86b5e96efba..01609bf509e4 100644
> --- a/drivers/usb/typec/tipd/tps6598x.h
> +++ b/drivers/usb/typec/tipd/tps6598x.h
> @@ -161,6 +161,25 @@
>  #define TPS_POWER_STATUS_BC12_STATUS_CDP 2
>  #define TPS_POWER_STATUS_BC12_STATUS_DCP 3
>  
> +/* TPS25750_REG_POWER_STATUS bits */
> +#define TPS25750_POWER_STATUS_CHARGER_DETECT_STATUS_MASK	GENMASK(7, 4)
> +#define TPS25750_POWER_STATUS_CHARGER_DETECT_STATUS(p) \
> +	TPS_FIELD_GET(TPS25750_POWER_STATUS_CHARGER_DETECT_STATUS_MASK, (p))
> +#define TPS25750_POWER_STATUS_CHARGER_ADVERTISE_STATUS_MASK	GENMASK(9, 8)
> +#define TPS25750_POWER_STATUS_CHARGER_ADVERTISE_STATUS(p) \
> +	TPS_FIELD_GET(TPS25750_POWER_STATUS_CHARGER_ADVERTISE_STATUS_MASK, (p))
> +
> +#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DISABLED	0
> +#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_IN_PROGRESS	1
> +#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_NONE		2
> +#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_SPD		3
> +#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_BC_1_2_CPD	4
> +#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_BC_1_2_DPD	5
> +#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_1_DCP	6
> +#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_2_DCP	7
> +#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_3_DCP	8
> +#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_1_2V_DCP	9
> +
>  /* TPS_REG_DATA_STATUS bits */
>  #define TPS_DATA_STATUS_DATA_CONNECTION	     BIT(0)
>  #define TPS_DATA_STATUS_UPSIDE_DOWN	     BIT(1)
> diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
> index 28725234a2d8..739b0a2a867d 100644
> --- a/drivers/usb/typec/tipd/trace.h
> +++ b/drivers/usb/typec/tipd/trace.h
> @@ -166,6 +166,19 @@
>  		{ TPS_POWER_STATUS_BC12_STATUS_CDP, "cdp" }, \
>  		{ TPS_POWER_STATUS_BC12_STATUS_SDP, "sdp" })
>  
> +#define show_tps25750_power_status_charger_detect_status(power_status) \
> +	__print_symbolic(TPS25750_POWER_STATUS_CHARGER_DETECT_STATUS(power_status), \
> +		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DISABLED,	"disabled"}, \
> +		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_IN_PROGRESS,	"in progress"}, \
> +		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_NONE,	"none"}, \
> +		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_SPD,		"spd"}, \
> +		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_BC_1_2_CPD,	"cpd"}, \
> +		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_BC_1_2_DPD,	"dpd"}, \
> +		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_1_DCP,	"divider 1 dcp"}, \
> +		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_2_DCP,	"divider 2 dcp"}, \
> +		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_3_DCP,	"divider 3 dpc"}, \
> +		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_1_2V_DCP,	"1.2V dpc"})
> +
>  #define TPS_DATA_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_DATA_STATUS_DP_PIN_ASSIGNMENT_MASK | \
>  						      TPS_DATA_STATUS_TBT_CABLE_SPEED_MASK | \
>  						      TPS_DATA_STATUS_TBT_CABLE_GEN_MASK))
> @@ -299,6 +312,26 @@ TRACE_EVENT(tps6598x_power_status,
>  		    )
>  );
>  
> +TRACE_EVENT(tps25750_power_status,
> +	    TP_PROTO(u16 power_status),
> +	    TP_ARGS(power_status),
> +
> +	    TP_STRUCT__entry(
> +			     __field(u16, power_status)
> +			     ),
> +
> +	    TP_fast_assign(
> +			   __entry->power_status = power_status;
> +			   ),
> +
> +	    TP_printk("conn: %d, pwr-role: %s, typec: %s, charger detect: %s",
> +		      !!TPS_POWER_STATUS_CONNECTION(__entry->power_status),
> +		      show_power_status_source_sink(__entry->power_status),
> +		      show_power_status_typec_status(__entry->power_status),
> +		      show_tps25750_power_status_charger_detect_status(__entry->power_status)
> +		    )
> +);
> +
>  TRACE_EVENT(tps6598x_data_status,
>  	    TP_PROTO(u32 data_status),
>  	    TP_ARGS(data_status),
> -- 
> 2.34.1

-- 
heikki
