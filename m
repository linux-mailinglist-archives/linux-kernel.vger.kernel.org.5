Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAEA761F56
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjGYQrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjGYQq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:46:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5E42D66;
        Tue, 25 Jul 2023 09:45:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 558F64AD;
        Tue, 25 Jul 2023 18:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690303449;
        bh=538alV7s2PX/R3tvrDzDUEk/djNXQuW9KoD0F4UL7as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vYNcj6YYI+yvazkkgrvscOkh3E9Trb7Cxw9TQQxAub5QWDa66+h3Utwf8pPWxnskV
         MX/WzHFNEUYM4Mtw2SEVy7h2k6zpPYo68xUywNa3Zdr2MGa/Y8RRAN7wMLC9I7Lml/
         pgExlMlS561xCxzM5/mzT+ByBunv+OJzVBuR3qNE=
Date:   Tue, 25 Jul 2023 19:45:15 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] media: i2c: ds90ub960: Rename
 RXPORT_MODE_CSI2_ASYNC to RXPORT_MODE_CSI2_NONSYNC
Message-ID: <20230725164515.GN31069@pendragon.ideasonboard.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
 <20230720-fpdlink-additions-v2-8-b91b1eca2ad3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720-fpdlink-additions-v2-8-b91b1eca2ad3@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Thu, Jul 20, 2023 at 01:30:39PM +0300, Tomi Valkeinen wrote:
> FPD-Link has an operating mode that used to be called "asynchronous" in
> the hardware documentation, but that has been changed to non-synchronous
> already quite a while back. The ub960 driver still had one instance of
> the old naming, so let's rename it.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ds90ub960.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
> index ea819fb6e99b..2ed4d4763a02 100644
> --- a/drivers/media/i2c/ds90ub960.c
> +++ b/drivers/media/i2c/ds90ub960.c
> @@ -415,8 +415,8 @@ enum ub960_rxport_mode {
>  	RXPORT_MODE_RAW12_HF = 1,
>  	RXPORT_MODE_RAW12_LF = 2,
>  	RXPORT_MODE_CSI2_SYNC = 3,
> -	RXPORT_MODE_CSI2_ASYNC = 4,
> -	RXPORT_MODE_LAST = RXPORT_MODE_CSI2_ASYNC,
> +	RXPORT_MODE_CSI2_NONSYNC = 4,
> +	RXPORT_MODE_LAST = RXPORT_MODE_CSI2_NONSYNC,
>  };
>  
>  enum ub960_rxport_cdr {
> @@ -1609,7 +1609,7 @@ static unsigned long ub960_calc_bc_clk_rate_ub960(struct ub960_data *priv,
>  		div = 1;
>  		break;
>  
> -	case RXPORT_MODE_CSI2_ASYNC:
> +	case RXPORT_MODE_CSI2_NONSYNC:
>  		mult = 2;
>  		div = 5;
>  		break;
> @@ -1633,7 +1633,7 @@ static unsigned long ub960_calc_bc_clk_rate_ub9702(struct ub960_data *priv,
>  	case RXPORT_MODE_CSI2_SYNC:
>  		return 47187500;
>  
> -	case RXPORT_MODE_CSI2_ASYNC:
> +	case RXPORT_MODE_CSI2_NONSYNC:
>  		return 9437500;
>  
>  	default:
> @@ -1840,7 +1840,7 @@ static void ub960_init_rx_port_ub960(struct ub960_data *priv,
>  		bc_freq_val = 0;
>  		break;
>  
> -	case RXPORT_MODE_CSI2_ASYNC:
> +	case RXPORT_MODE_CSI2_NONSYNC:
>  		bc_freq_val = 2;
>  		break;
>  
> @@ -1878,7 +1878,7 @@ static void ub960_init_rx_port_ub960(struct ub960_data *priv,
>  		return;
>  
>  	case RXPORT_MODE_CSI2_SYNC:
> -	case RXPORT_MODE_CSI2_ASYNC:
> +	case RXPORT_MODE_CSI2_NONSYNC:
>  		/* CSI-2 Mode (DS90UB953-Q1 compatible) */
>  		ub960_rxport_update_bits(priv, nport, UB960_RR_PORT_CONFIG, 0x3,
>  					 0x0);
> @@ -1938,7 +1938,7 @@ static void ub960_init_rx_port_ub9702_fpd3(struct ub960_data *priv,
>  		fpd_func_mode = 2;
>  		break;
>  
> -	case RXPORT_MODE_CSI2_ASYNC:
> +	case RXPORT_MODE_CSI2_NONSYNC:
>  		bc_freq_val = 2;
>  		fpd_func_mode = 2;
>  		break;
> @@ -2032,7 +2032,7 @@ static void ub960_init_rx_port_ub9702_fpd4(struct ub960_data *priv,
>  		bc_freq_val = 6;
>  		break;
>  
> -	case RXPORT_MODE_CSI2_ASYNC:
> +	case RXPORT_MODE_CSI2_NONSYNC:
>  		bc_freq_val = 2;
>  		break;
>  
> @@ -2098,7 +2098,7 @@ static void ub960_init_rx_port_ub9702(struct ub960_data *priv,
>  		return;
>  
>  	case RXPORT_MODE_CSI2_SYNC:
> -	case RXPORT_MODE_CSI2_ASYNC:
> +	case RXPORT_MODE_CSI2_NONSYNC:
>  
>  		break;
>  	}
> @@ -2444,7 +2444,7 @@ static int ub960_configure_ports_for_streaming(struct ub960_data *priv,
>  
>  		/* For the rest, we are only interested in parallel busses */
>  		if (rxport->rx_mode == RXPORT_MODE_CSI2_SYNC ||
> -		    rxport->rx_mode == RXPORT_MODE_CSI2_ASYNC)
> +		    rxport->rx_mode == RXPORT_MODE_CSI2_NONSYNC)
>  			continue;
>  
>  		if (rx_data[nport].num_streams > 2)
> @@ -2508,7 +2508,7 @@ static int ub960_configure_ports_for_streaming(struct ub960_data *priv,
>  			break;
>  
>  		case RXPORT_MODE_CSI2_SYNC:
> -		case RXPORT_MODE_CSI2_ASYNC:
> +		case RXPORT_MODE_CSI2_NONSYNC:
>  			if (!priv->hw_data->is_ub9702) {
>  				/* Map all VCs from this port to the same VC */
>  				ub960_rxport_write(priv, nport, UB960_RR_CSI_VC_MAP,
> 

-- 
Regards,

Laurent Pinchart
