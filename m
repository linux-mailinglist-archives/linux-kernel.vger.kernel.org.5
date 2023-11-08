Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023347E5D67
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjKHSmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHSmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:42:00 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6282105;
        Wed,  8 Nov 2023 10:41:58 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7fb84f6ceso206267b3.1;
        Wed, 08 Nov 2023 10:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699468917; x=1700073717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+BbXRbAsp+NPpKrdmZggvoi57cHhfYvlMAtcCMHLnD0=;
        b=ZEQZIVdPSErSJ624z4fabvUM9v4MeX7t+OI4DodPjBxyZ7fobzWLUTG/IbyNswmOsC
         OcxwrrAHC7h2PlXmqSgOHTXZGAnFVuBYX402/9V9Z+yBrjAFs476BvoOg8Lv7VQo4YFJ
         0f6fmi4SCjR5taYaowzT9n83x2PhQRRCX1ilBD6SDgsA6/IuxtfNmdfmNqoUD+oth50B
         f5Vn8SSvONhm5W8WUupjcz+b4oLZytQvA6oss5M1Tzl7OXN/x34l5NDjBchTx7kU7gdx
         7JkmTw+H2hskShwvcA3tIz0DVKxxeCLAVzSFb7LlfjRH9Vj0tRuDHiabQ7c8CsP02OR+
         v4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699468917; x=1700073717;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BbXRbAsp+NPpKrdmZggvoi57cHhfYvlMAtcCMHLnD0=;
        b=kgNnyXUvHHUIReiLsl7xjfP1r8AzAo4R4qnSmOhZcr7bBP/JZg8q7d/0s3wVywZtCF
         5jRSVIe4d5EIauwhiFhxk3ybBSFp4rwno5g4I5TYJ5dsAlDlgCuVqofoycJqcgNe8/v5
         df99U1UcgchIkTt1IlkjNJzFMSUx9JQh9H9qHiHFVqLLqJWJoYlgKAduJl2XD+Bvq1/k
         ObvPJPtPLBzpHOeU3lRn1G1A4g5iUP6m1zUgHKYTVdL84GjPbYDSM5wIDiUt5n/bhx+3
         G9VwLevcC7++w3tDseuBc4OdhxD4UePtp5nme+KmsQkNse0TiGaFkbY+hCbPA3aSEjS7
         /I0g==
X-Gm-Message-State: AOJu0YxwUab6Jbs7rL8p+gTpevOQ9/XkZB6LjPgW8fwiVfggByvMK4TO
        mffNVFaDzpv3X427osRtxNI=
X-Google-Smtp-Source: AGHT+IEHkS1jSyto38h4sLFxXm4J55FVf9334ZttR+9wMs+z5iCBgLAtKGiecS9bqiWHMxFU1dkUBQ==
X-Received: by 2002:a0d:fb07:0:b0:5a2:15bc:b32c with SMTP id l7-20020a0dfb07000000b005a215bcb32cmr2511738ywf.42.1699468917138;
        Wed, 08 Nov 2023 10:41:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d7-20020a0ddb07000000b005a7bf9749c8sm7212241ywe.4.2023.11.08.10.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 10:41:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0b9df102-24c0-4b0d-a341-22891892e708@roeck-us.net>
Date:   Wed, 8 Nov 2023 10:41:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: typec: tcpm: Skip hard reset when in error
 recovery
Content-Language: en-US
To:     Badhri Jagan Sridharan <badhri@google.com>,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc:     kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdbabiera@google.com,
        amitsd@google.com, stable@vger.kernel.org
References: <20231101021909.2962679-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231101021909.2962679-1-badhri@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 19:19, Badhri Jagan Sridharan wrote:
> Hard reset queued prior to error recovery (or) received during
> error recovery will make TCPM to prematurely exit error recovery
> sequence. Ignore hard resets received during error recovery (or)
> port reset sequence.
> 
> ```
> [46505.459688] state change SNK_READY -> ERROR_RECOVERY [rev3 NONE_AMS]
> [46505.459706] state change ERROR_RECOVERY -> PORT_RESET [rev3 NONE_AMS]
> [46505.460433] disable vbus discharge ret:0
> [46505.461226] Setting usb_comm capable false
> [46505.467244] Setting voltage/current limit 0 mV 0 mA
> [46505.467262] polarity 0
> [46505.470695] Requesting mux state 0, usb-role 0, orientation 0
> [46505.475621] cc:=0
> [46505.476012] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms [rev3 NONE_AMS]
> [46505.476020] Received hard reset
> [46505.476024] state change PORT_RESET -> HARD_RESET_START [rev3 HARD_RESET]
> ```
> 
> Cc: stable@vger.kernel.org
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/tcpm.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 058d5b853b57..b386102f7a3a 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5391,6 +5391,15 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *port)
>   	if (port->bist_request == BDO_MODE_TESTDATA && port->tcpc->set_bist_data)
>   		port->tcpc->set_bist_data(port->tcpc, false);
>   
> +	switch (port->state) {
> +	case ERROR_RECOVERY:
> +	case PORT_RESET:
> +	case PORT_RESET_WAIT_OFF:
> +		return;
> +	default:
> +		break;
> +	}
> +
>   	if (port->ams != NONE_AMS)
>   		port->ams = NONE_AMS;
>   	if (port->hard_reset_count < PD_N_HARD_RESET_COUNT)
> 
> base-commit: c70793fb7632a153862ee9060e6d48131469a29c

