Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9C478117A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378902AbjHRRQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357423AbjHRRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:16:16 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600753AB0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:16:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-689f1e81293so942571b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692378974; x=1692983774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NNq6LlN9NG5Z9ixvm9VM7Aws5YwlE9M4fTdMCaH4A3c=;
        b=gpqJEnSxRP7b7f6q2V4gq+qIn7IdwUMk3W76ChsvZp0cU1VzPlLCLS8FLcn7XQ076j
         Jis9J5F7fdTYmr61ZxkwDJtL2m8LmIVxZaih95688jEXusSlvcTVjaSoQKQO5X4Z/VMX
         0faSpYl4mG2FbQF2I64uoeFuN33mZgbYqGTjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692378974; x=1692983774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNq6LlN9NG5Z9ixvm9VM7Aws5YwlE9M4fTdMCaH4A3c=;
        b=K3bT0ylqMjKfhsCT6cDjG9zjEEMJH/h856aTW4GEj8c0mwK2q9DkYHmuMQPj72AT00
         eItYsMnrDyqTC+Mtc5vXlgZjU0qDFLMveqFmCWjcZsjGAHNUISry2D0RaZb8vXEAaz7+
         gjx4aLSRzQXmZqq3HAWZHL37wvhjepPKtJWwjUeqe0ryYYhZREuI4Bi/GNcV3IBM3iQd
         D56iLufFjJHm5jqBh4QD8atMxSDAcFJpreOZBTr1FMsRDaRZs3YwLr1DuqxT7nVL1jfx
         GZZTsxLCZHJqrRVEMpKHOJxmap1ujtZPwWK1/I3o3pS+rXI+dzRECtdxc7N3LuFeV2e7
         OCmQ==
X-Gm-Message-State: AOJu0Yyo/3HlqiBXdSvDGXHMyffHFuS2L8tDO7czb8Yn147ZAm3pal1S
        V8T4+oZnT3CBGDIIFao/jZU22w==
X-Google-Smtp-Source: AGHT+IGo+KoiwtYNz2QpPJ+wDSXrsUm6GewSPPNIpT+zwd/nOIVFEZrz1y8aqEeB/no1MYMoamQR7Q==
X-Received: by 2002:a05:6a20:12c9:b0:140:bd85:15a5 with SMTP id v9-20020a056a2012c900b00140bd8515a5mr4226284pzg.39.1692378973746;
        Fri, 18 Aug 2023 10:16:13 -0700 (PDT)
Received: from chromium.org (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id y8-20020aa78048000000b006661562429fsm1819434pfm.97.2023.08.18.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:16:13 -0700 (PDT)
Date:   Fri, 18 Aug 2023 17:16:12 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        bleung@chromium.org
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Message-ID: <ZN+nXGr3S0OL3Edn@chromium.org>
References: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
 <20230811210735.159529-4-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811210735.159529-4-utkarsh.h.patel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

Thanks for the patch. Please include the chrome-platform mailing list to each
patch in the series; at the very least, patches which touch drivers/platform/chrome
should definitely have the mailing list (chrome-platform@lists.linux.dev). Otherwise,
we don't have enough context about what changes are being made across the series.

On Aug 11 14:07, Utkarsh Patel wrote:
> Displayport Alternatemode 2.1 requires cable capabilities such as cable
> signalling, cable type, DPAM version which then will be used by mux
> driver for displayport configuration.
> 
> These capabilities can be derived from the Cable VDO data as well as from
> the existing EC PD host command interface.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 30 +++++++++++++++++++++++++
>  drivers/platform/chrome/cros_ec_typec.h |  1 +
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index d0b4d3fc40ed..eb4a1cb584a2 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -485,6 +485,32 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
>  	return typec_mux_set(port->mux, &port->state);
>  }
>  
> +static int cros_typec_dp21_support(struct cros_typec_port *port,
> +				   struct typec_displayport_data dp21_data,
> +				   struct ec_response_usb_pd_control_v2 *pd_ctrl)
> +{
> +	u32 cable_vdo = cros_typec_get_cable_vdo(port, USB_TYPEC_DP_SID);
> +
> +	if (cable_vdo & DP_CAP_DPAM_VERSION) {
> +		dp21_data.conf |= cable_vdo;
> +	} else {
> +		/* Cable Speed */
> +		dp21_data.conf |= pd_ctrl->cable_speed << DP_CONF_SIGNALLING_SHIFT;
> +
> +		/* Cable Type */
> +		if (pd_ctrl->cable_gen & USB_PD_CTRL_OPTICAL_CABLE)
> +			dp21_data.conf |= DP_CONF_CABLE_TYPE_OPTICAL << DP_CONF_CABLE_TYPE_SHIFT;
> +		else if (cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SID) & TBT_CABLE_RETIMER)
> +			dp21_data.conf |= DP_CONF_CABLE_TYPE_RE_TIMER << DP_CONF_CABLE_TYPE_SHIFT;
> +		else if (pd_ctrl->cable_gen & USB_PD_CTRL_ACTIVE_CABLE)
> +			dp21_data.conf |= DP_CONF_CABLE_TYPE_RE_DRIVER << DP_CONF_CABLE_TYPE_SHIFT;
> +	}

I don't understand why the conf VDO is being recreated here. cable_vdo should already contain the necessary
bits. Just use the cable_vdo that you get from cros_typec_get_cable_vdo(); it will have all the bits
set correctly already (the EC should be doing that).

The "if" condition should also be unnecessary.

You are already doing something similar in the other patch for "active retimer cable support" [1]

> +
> +	port->state.data = &dp21_data;
> +
> +	return typec_mux_set(port->mux, &port->state);

Note that now you have reversed the order in which the muxes are set (which leads to subtle timing issues with
Burnside Bridge and other similar retimers). So please don't do this.

> +}
> +
>  /* Spoof the VDOs that were likely communicated by the partner. */
>  static int cros_typec_enable_dp(struct cros_typec_data *typec,
>  				int port_num,
> @@ -524,6 +550,9 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
>  	port->state.data = &dp_data;
>  	port->state.mode = TYPEC_MODAL_STATE(ffs(pd_ctrl->dp_mode));
>  
> +	if (typec->typec_dp21_supported)
> +		return cros_typec_dp21_support(port, dp_data, pd_ctrl);
> +
>  	ret = cros_typec_retimer_set(port->retimer, port->state);
>  	if (!ret)
>  		ret = typec_mux_set(port->mux, &port->state);
> @@ -1196,6 +1225,7 @@ static int cros_typec_probe(struct platform_device *pdev)
>  
>  	typec->typec_cmd_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
>  	typec->needs_mux_ack = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
> +	typec->typec_dp21_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_DP2_1);

This entire feature isn't necessary. Regardless of whether dp2.1 is supported or not, the port driver
just needs to forward the cable_vdo it receives faithfully to the mux driver, which can deal with
internal details (based on whether *it* supports DP 2.1 or not).

Thanks,

-Prashant

[1] https://lore.kernel.org/linux-usb/20230718024703.1013367-1-utkarsh.h.patel@intel.com/T/#m950b24e7874d34f11081f252ba3ef4e752628529
