Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B649A7A76E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjITJKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjITJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:10:31 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93E91;
        Wed, 20 Sep 2023 02:10:25 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c012232792so46063511fa.0;
        Wed, 20 Sep 2023 02:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695201024; x=1695805824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2h7cs036UrR/eQjftEBWFTHYb+KQvYnSOLcHTnPuW8s=;
        b=OCK4EQGI1LT1YorN75EJHABksvlHSWHSVTHv+NyWB000qjc8D1gTneiJ5LrXiKfvrk
         YgkEpOsSZv6YulvqiSp+GlA5LC1VuCUOFCQheckjQGGxNObDIVWmxE5HhBaXW4xknXhW
         q2HRSEyERX+VapSf7ARM6ZqLMuxYVCV5tWkXVaTvpbBA0dyAapMufDnPgiEltHjsfpnJ
         /ch7XMXdlBbBNneUe2AZPOwtF2OGsw3CtONch34WE0P5TUNJmCpLiL3WNJW2/S1YqyZc
         bPauSUwrT0HDzNiJMVw20VeXzCsB0yahK6NMrqEqSIwZ1AT3O0Hcn9LSVppBRrAXMN6U
         fhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695201024; x=1695805824;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2h7cs036UrR/eQjftEBWFTHYb+KQvYnSOLcHTnPuW8s=;
        b=l3HCmOMktK2hYpkS+5TDtlpk0rcAf8NEZSmCbwhpa+bChDW7US+3sz9YX7B+5JxfKc
         011W77dF4Y78YyyvfV4+iRq3oMw/EQefjKb9eElOygnAnnfotPofWud1uVHKchnKQJAw
         83SmRDNcDJ53idrZmj6eMmsBJ/k9sF4YQIrjo9G866Uka+0X5+9IBRcVSR77lO0ftwYQ
         ITWpTbe+iOqmhLQZXNxxqZriIF2WJ99dg1nm27uXNbLtPlzAcL+s2ajMmsxNDQ2HS+vL
         3SRA+gaNOistz9uAHxIp9KCW4IpgY/1fmi86dR0qPyuV2ePWu0W3zlxgH6DIj+DSw9kA
         BPkQ==
X-Gm-Message-State: AOJu0YyHqsy9c/TNPqldVpErIAxLDAZ5R5WsB3ct+qI3Uyshk1XjWIey
        LrGQaIxEsDDUh77AiSw9cgw=
X-Google-Smtp-Source: AGHT+IE61TkCmGwn0OosPff6JVitQ32jcllylkHwIbApW8CSo7sYCCWxxzkmjYV95OPAVmm3JOoIIQ==
X-Received: by 2002:ac2:5041:0:b0:503:2623:7cfc with SMTP id a1-20020ac25041000000b0050326237cfcmr1489636lfm.34.1695201023290;
        Wed, 20 Sep 2023 02:10:23 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.76.10])
        by smtp.gmail.com with ESMTPSA id p12-20020ac246cc000000b004ff9ee35739sm2609505lfo.283.2023.09.20.02.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 02:10:22 -0700 (PDT)
Subject: Re: [PATCH v4 5/5] usb: typec: intel_pmc_mux: Configure Displayport
 Alternate mode 2.1
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        chrome-platform@lists.linux.dev, andriy.shevchenko@linux.intel.com,
        bleung@chromium.org
References: <20230920023243.2494410-1-utkarsh.h.patel@intel.com>
 <20230920023243.2494410-6-utkarsh.h.patel@intel.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <086a35c5-6402-3e3e-1ac4-fade2797b63a@gmail.com>
Date:   Wed, 20 Sep 2023 12:10:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230920023243.2494410-6-utkarsh.h.patel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 5:32 AM, Utkarsh Patel wrote:

> Mux agent driver can configure cable details such as cable type and
> cable speed received as a part of displayport configuration to support
> Displayport Alternate mode 2.1.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> ---
> Changes in v4:
> - No change.
> 
> Changes in v3:
> - No change.
> 
> Changes in v2:
> - No change.
> 
>  drivers/usb/typec/mux/intel_pmc_mux.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 60ed1f809130..233958084b43 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
[...]
> @@ -293,6 +299,24 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
>  	req.mode_data |= (state->mode - TYPEC_STATE_MODAL) <<
>  			 PMC_USB_ALTMODE_DP_MODE_SHIFT;
>  
> +	if (!is_pmc_mux_tbt(port->pmc->iom_adev)) {
> +		u8 cable_speed = (data->conf & DP_CONF_SIGNALLING_MASK) >>
> +				  DP_CONF_SIGNALLING_SHIFT;
> +
> +		u8 cable_type = (data->conf & DP_CONF_CABLE_TYPE_MASK) >>
> +				 DP_CONF_CABLE_TYPE_SHIFT;
> +
> +		req.mode_data |= PMC_USB_ALTMODE_CABLE_SPD(cable_speed);
> +
> +		if (cable_type == DP_CONF_CABLE_TYPE_OPTICAL)
> +			req.mode_data |= PMC_USB_ALTMODE_CABLE_TYPE;
> +		else if (cable_type == DP_CONF_CABLE_TYPE_RE_TIMER)
> +			req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE |
> +					 PMC_USB_ALTMODE_RETIMER_CABLE;
> +		else if (cable_type == DP_CONF_CABLE_TYPE_RE_DRIVER)
> +			req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;

   Why not *switch* instead of string of *if*s?

> +	}
> +
>  	ret = pmc_usb_command(port, (void *)&req, sizeof(req));
>  	if (ret)
>  		return ret;

MBR, Sergey
