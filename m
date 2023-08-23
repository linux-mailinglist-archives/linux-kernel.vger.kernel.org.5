Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0700278591F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjHWNZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjHWNZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:25:27 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C00A10DB;
        Wed, 23 Aug 2023 06:25:03 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a5457b930so2182823b3a.2;
        Wed, 23 Aug 2023 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692797102; x=1693401902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFIWzJPis1mfey+szFArc1kyDCfuN66o9aTmELpPLx8=;
        b=gP2CurR6oOivsDl6kiCnuEgYpEqRe1FUSVuFn/lN21ABeWjAPuOxLc+GimaALzIh52
         kVq6Cv8vfiMNwxfe7ef+y45PmFAPiqf5Qn74ZwSKHJiktHPGSbNcMmo7YgdNocTr8QIG
         oGghtjRh5NYwYqgu7tuUem1txaIhJnh0U9dvTx3Y3Rknjd1lV3yV1+TKOVi6xllbX65/
         +q5j+LjA0yVYMjoM+/wfo2iAl9c3gqw9B3MLsU8WNiuwNUxbkuNkDrbYwhBAC6IIOW7v
         XtI+f1QtpV+9PwFVp9H3WMDdPUvued/fZ1vVF8kQBvZoO96n32wXCTjVKUoaeBEg6YDS
         w05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797102; x=1693401902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFIWzJPis1mfey+szFArc1kyDCfuN66o9aTmELpPLx8=;
        b=MbyihtWXyNH00jjqqLVjvElsvTC1kZevBxFIiEQxL5+zV3RHtldYeIvCnPS/Ar62lU
         tOlkMMP592LbL0eiPX954Jqh4K4piDMYmdO1jARUA7URuhh9rSHVUa4+T9ujpSyjKbdD
         8pja5bZ73Y/Y+G/JNaEmnyaS7a1kVpYQoHc5lvpM1/Nj4JBL6nIbPwmmZ0wQ+BZWAyDG
         S4aO9Wzoln9o2kKIQAl0suKT1fBrRAtRUHSWkwC1jn+58dg5zyOOUJ1AwsfYb91IQcLE
         FQeAiCeMoCn9TCNOhzonu4EHp6kH5U/DNFoxynqOZvQqlsxtkTCHkPPtbLT2pzBu/FWS
         FO4w==
X-Gm-Message-State: AOJu0YyRxu2VLoQm2EfNIwqTd5+CS+FXMzPAElS1eYgqAl5dELIwJALj
        9MStwiGSbD1G3nbuqQczJP551suiLvM=
X-Google-Smtp-Source: AGHT+IFtT56ctITF2oXrv0/w1V2zUxggd05/jJW4eV5No+LgFqJcm5qo2/RU+ROhh4qqY9Q2b4bTjw==
X-Received: by 2002:a05:6a00:1501:b0:66a:2ff1:dee2 with SMTP id q1-20020a056a00150100b0066a2ff1dee2mr11415588pfu.10.1692797102175;
        Wed, 23 Aug 2023 06:25:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 7-20020aa79207000000b00689f8dc26bdsm4117042pfo.109.2023.08.23.06.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:25:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 06:25:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] tcpm: Avoid soft reset when partner does not support
 get_status
Message-ID: <77194753-902e-4ef5-82c7-8b2428a59aec@roeck-us.net>
References: <20230820044449.1005889-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820044449.1005889-1-badhri@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 04:44:48AM +0000, Badhri Jagan Sridharan wrote:
> When partner does not support get_status message, tcpm right now
> responds with soft reset message. This causes PD renegotiation to
> happen and resets PPS link. Avoid soft resetting the link when
> partner does not support get_status message to mitigate PPS resets.
> 
> [  208.926752] Setting voltage/current limit 9500 mV 2450 mA
> [  208.930407] set_auto_vbus_discharge_threshold mode:3 pps_active:y vbus:9500 ret:0
> [  208.930418] state change SNK_TRANSITION_SINK -> SNK_READY [rev3 POWER_NEGOTIATION]
> [  208.930455] AMS POWER_NEGOTIATION finished
> 
> // ALERT message from the Source
> [  213.948442] PD RX, header: 0x19a6 [1]
> [  213.948451] state change SNK_READY -> GET_STATUS_SEND [rev3 GETTING_SOURCE_SINK_STATUS]
> [  213.948457] PD TX, header: 0x492
> [  213.950402] PD TX complete, status: 0
> [  213.950427] pending state change GET_STATUS_SEND -> GET_STATUS_SEND_TIMEOUT @ 60 ms [rev3 GETTING_SOURCE_SINK_STATUS]
> 
> // NOT_SUPPORTED from the Source
> [  213.959954] PD RX, header: 0xbb0 [1]
> 
> // sink sends SOFT_RESET
> [  213.959958] state change GET_STATUS_SEND -> SNK_SOFT_RESET [rev3 GETTING_SOURCE_SINK_STATUS]
> [  213.959962] AMS GETTING_SOURCE_SINK_STATUS finished
> [  213.959964] AMS SOFT_RESET_AMS start
> [  213.959966] state change SNK_SOFT_RESET -> AMS_START [rev3 SOFT_RESET_AMS]
> [  213.959969] state change AMS_START -> SOFT_RESET_SEND [rev3 SOFT_RESET_AMS]
> 
> Cc: stable@vger.kernel.org
> Fixes: 8dea75e11380 ("usb: typec: tcpm: Protocol Error handling")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5639b9a1e0bf..280ce1bd7b53 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2753,6 +2753,13 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			port->sink_cap_done = true;
>  			tcpm_set_state(port, ready_state(port), 0);
>  			break;
> +		/*
> +		 * Some port partners do not support GET_STATUS, avoid soft reset the link to
> +		 * prevent redundant power re-negotiation
> +		 */
> +		case GET_STATUS_SEND:
> +			tcpm_set_state(port, ready_state(port), 0);
> +			break;
>  		case SRC_READY:
>  		case SNK_READY:
>  			if (port->vdm_state > VDM_STATE_READY) {
> 
> base-commit: bbb9e06d2c6435af9c62074ad7048910eeb2e7bc
> -- 
> 2.42.0.rc1.204.g551eb34607-goog
> 
