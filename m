Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21E176CFE1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjHBOSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjHBOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:18:20 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE6A2703;
        Wed,  2 Aug 2023 07:18:19 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3490f207680so22558435ab.2;
        Wed, 02 Aug 2023 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690985899; x=1691590699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HDamUHzXADwxKV3O1rLHZBhXQPnVsyNzpLMXKmxWPcg=;
        b=jjbyu2D/S6tF5S1IJ0g/KZ1/0mPYGeLjOe7rMHULDLqRl6V33cj3GtyGkMrY1OxhAs
         A0CH816MqwvZsbm9eOzYnqSustH+AwF02xemAPteQygnAbMyWm1CkD1e7ARSAMDXybX8
         jsjpsnUYyhtzLe7j1UbAp3stK14t/E9sRvEHz6JHDxObDzyfyJD+fhvgUkxLvmTy1oST
         iJB+Xlr+fvAqAI+Z64LPxNfF+wUuvuIpmF98Zw82UP5HDPmtekeHJ6Ov9gzys/2oTGMx
         VLx8eYeHu7Yz1fy2E3M5KPJx6w+k94r9aF7RTafVvEOPrFzfOsVvWDYik80yiCnFERtb
         Kd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690985899; x=1691590699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDamUHzXADwxKV3O1rLHZBhXQPnVsyNzpLMXKmxWPcg=;
        b=fg6nF5+zzogji96dWxtShT9QlIl0AvYpcX3AxsPjcw0TH9hz6lTx6nrg77fULdOQOY
         Orxv2aq6nqsdyYuQU2Uem66tfE+JwX7tHIetFKCuuAjhv3hbS8o/JOV/1Slam+IXxOiq
         CkqTiUxYtBPv87F+mdpYXjr1tdCnmrwHzH1tExaCKRJKZFpyvMFtJAd7eaIurZahJiR3
         T3KU7LZ0hMrFVVl7Jq37N6aw0R9friAlFSUYQG0aFd6cmtuOpKjGusOfpaZv5tyxJ/Lg
         oxAUQAszpLQz2zNoT7PYVsZG3hqWUcS9S2Vo6ebjJh/PczhW8nnOKcScA0l4XdhMHrpq
         7Z/Q==
X-Gm-Message-State: ABy/qLYAYNahZWzM6qtzfHfq7Tcic02Ie2gw1Kw1B9dJY6ZRYohjhl6z
        +uqP3X4pCMsn9S++UXD65KI=
X-Google-Smtp-Source: APBJJlHTgBXaJV9LsYa2PNIgrlJ0JCWqrN3N2nC0gJQWCt5u9fPPdYzVSOmEKqutdA1oQ9MAG3/OiA==
X-Received: by 2002:a6b:e817:0:b0:790:bc17:1c63 with SMTP id f23-20020a6be817000000b00790bc171c63mr5674372ioh.1.1690985898950;
        Wed, 02 Aug 2023 07:18:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h20-20020a056602009400b007836c7e8dccsm4461945iob.17.2023.08.02.07.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 07:18:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0ea7ae64-c4dd-929d-2ca1-68598af13bc4@roeck-us.net>
Date:   Wed, 2 Aug 2023 07:18:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: typec: tcpm: Refactor the PPS APDO selection
Content-Language: en-US
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230731162159.19483-1-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230731162159.19483-1-kyletso@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 09:21, Kyle Tso wrote:
> In current design of the PPS APDO selection, TCPM power supply only
> accepts the requested voltage which is inside the range of the selected
> PPS profile. To extend the flexibility and usability, remove the checks
> about the voltage range in current profile. And try to search all PPS
> APDOs of the Source that fit the requested voltage.
> 
> Also remove some redundant checks in tcpm_pd_build_pps_request.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/tcpm.c | 122 ++++++----------------------------
>   1 file changed, 21 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 829d75ebab42..9c496b8302b4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3253,23 +3253,12 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
>   	return ret;
>   }
>   
> -#define min_pps_apdo_current(x, y)	\
> -	min(pdo_pps_apdo_max_current(x), pdo_pps_apdo_max_current(y))
> -
>   static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>   {
> -	unsigned int i, j, max_mw = 0, max_mv = 0;
> -	unsigned int min_src_mv, max_src_mv, src_ma, src_mw;
> -	unsigned int min_snk_mv, max_snk_mv;
> -	unsigned int max_op_mv;
> -	u32 pdo, src, snk;
> -	unsigned int src_pdo = 0, snk_pdo = 0;
> +	unsigned int i, src_ma, max_temp_mw = 0, max_op_ma, op_mw;
> +	unsigned int src_pdo = 0;
> +	u32 pdo, src;
>   
> -	/*
> -	 * Select the source PPS APDO providing the most power while staying
> -	 * within the board's limits. We skip the first PDO as this is always
> -	 * 5V 3A.
> -	 */
>   	for (i = 1; i < port->nr_source_caps; ++i) {
>   		pdo = port->source_caps[i];
>   
> @@ -3280,54 +3269,17 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>   				continue;
>   			}
>   
> -			min_src_mv = pdo_pps_apdo_min_voltage(pdo);
> -			max_src_mv = pdo_pps_apdo_max_voltage(pdo);
> -			src_ma = pdo_pps_apdo_max_current(pdo);
> -			src_mw = (src_ma * max_src_mv) / 1000;
> -
> -			/*
> -			 * Now search through the sink PDOs to find a matching
> -			 * PPS APDO. Again skip the first sink PDO as this will
> -			 * always be 5V 3A.
> -			 */
> -			for (j = 1; j < port->nr_snk_pdo; j++) {
> -				pdo = port->snk_pdo[j];
> -
> -				switch (pdo_type(pdo)) {
> -				case PDO_TYPE_APDO:
> -					if (pdo_apdo_type(pdo) != APDO_TYPE_PPS) {
> -						tcpm_log(port,
> -							 "Not PPS APDO (sink), ignoring");
> -						continue;
> -					}
> -
> -					min_snk_mv =
> -						pdo_pps_apdo_min_voltage(pdo);
> -					max_snk_mv =
> -						pdo_pps_apdo_max_voltage(pdo);
> -					break;
> -				default:
> -					tcpm_log(port,
> -						 "Not APDO type (sink), ignoring");
> -					continue;
> -				}
> +			if (port->pps_data.req_out_volt > pdo_pps_apdo_max_voltage(pdo) ||
> +			    port->pps_data.req_out_volt < pdo_pps_apdo_min_voltage(pdo))
> +				continue;
>   
> -				if (min_src_mv <= max_snk_mv &&
> -				    max_src_mv >= min_snk_mv) {
> -					max_op_mv = min(max_src_mv, max_snk_mv);
> -					src_mw = (max_op_mv * src_ma) / 1000;
> -					/* Prefer higher voltages if available */
> -					if ((src_mw == max_mw &&
> -					     max_op_mv > max_mv) ||
> -					    src_mw > max_mw) {
> -						src_pdo = i;
> -						snk_pdo = j;
> -						max_mw = src_mw;
> -						max_mv = max_op_mv;
> -					}
> -				}
> +			src_ma = pdo_pps_apdo_max_current(pdo);
> +			max_op_ma = min(src_ma, port->pps_data.req_op_curr);
> +			op_mw = max_op_ma * port->pps_data.req_out_volt / 1000;
> +			if (op_mw > max_temp_mw) {
> +				src_pdo = i;
> +				max_temp_mw = op_mw;
>   			}
> -
>   			break;
>   		default:
>   			tcpm_log(port, "Not APDO type (source), ignoring");
> @@ -3337,16 +3289,10 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>   
>   	if (src_pdo) {
>   		src = port->source_caps[src_pdo];
> -		snk = port->snk_pdo[snk_pdo];
> -
> -		port->pps_data.req_min_volt = max(pdo_pps_apdo_min_voltage(src),
> -						  pdo_pps_apdo_min_voltage(snk));
> -		port->pps_data.req_max_volt = min(pdo_pps_apdo_max_voltage(src),
> -						  pdo_pps_apdo_max_voltage(snk));
> -		port->pps_data.req_max_curr = min_pps_apdo_current(src, snk);
> -		port->pps_data.req_out_volt = min(port->pps_data.req_max_volt,
> -						  max(port->pps_data.req_min_volt,
> -						      port->pps_data.req_out_volt));
> +
> +		port->pps_data.req_min_volt = pdo_pps_apdo_min_voltage(src);
> +		port->pps_data.req_max_volt = pdo_pps_apdo_max_voltage(src);
> +		port->pps_data.req_max_curr = pdo_pps_apdo_max_current(src);
>   		port->pps_data.req_op_curr = min(port->pps_data.req_max_curr,
>   						 port->pps_data.req_op_curr);
>   	}
> @@ -3464,32 +3410,16 @@ static int tcpm_pd_send_request(struct tcpm_port *port)
>   static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
>   {
>   	unsigned int out_mv, op_ma, op_mw, max_mv, max_ma, flags;
> -	enum pd_pdo_type type;
>   	unsigned int src_pdo_index;
> -	u32 pdo;
>   
>   	src_pdo_index = tcpm_pd_select_pps_apdo(port);
>   	if (!src_pdo_index)
>   		return -EOPNOTSUPP;
>   
> -	pdo = port->source_caps[src_pdo_index];
> -	type = pdo_type(pdo);
> -
> -	switch (type) {
> -	case PDO_TYPE_APDO:
> -		if (pdo_apdo_type(pdo) != APDO_TYPE_PPS) {
> -			tcpm_log(port, "Invalid APDO selected!");
> -			return -EINVAL;
> -		}
> -		max_mv = port->pps_data.req_max_volt;
> -		max_ma = port->pps_data.req_max_curr;
> -		out_mv = port->pps_data.req_out_volt;
> -		op_ma = port->pps_data.req_op_curr;
> -		break;
> -	default:
> -		tcpm_log(port, "Invalid PDO selected!");
> -		return -EINVAL;
> -	}
> +	max_mv = port->pps_data.req_max_volt;
> +	max_ma = port->pps_data.req_max_curr;
> +	out_mv = port->pps_data.req_out_volt;
> +	op_ma = port->pps_data.req_op_curr;
>   
>   	flags = RDO_USB_COMM | RDO_NO_SUSPEND;
>   
> @@ -5882,12 +5812,6 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 req_out_volt)
>   		goto port_unlock;
>   	}
>   
> -	if (req_out_volt < port->pps_data.min_volt ||
> -	    req_out_volt > port->pps_data.max_volt) {
> -		ret = -EINVAL;
> -		goto port_unlock;
> -	}
> -
>   	target_mw = (port->current_limit * req_out_volt) / 1000;
>   	if (target_mw < port->operating_snk_mw) {
>   		ret = -EINVAL;
> @@ -6440,11 +6364,7 @@ static int tcpm_psy_set_prop(struct power_supply *psy,
>   		ret = tcpm_psy_set_online(port, val);
>   		break;
>   	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> -		if (val->intval < port->pps_data.min_volt * 1000 ||
> -		    val->intval > port->pps_data.max_volt * 1000)
> -			ret = -EINVAL;
> -		else
> -			ret = tcpm_pps_set_out_volt(port, val->intval / 1000);
> +		ret = tcpm_pps_set_out_volt(port, val->intval / 1000);
>   		break;
>   	case POWER_SUPPLY_PROP_CURRENT_NOW:
>   		if (val->intval > port->pps_data.max_curr * 1000)

