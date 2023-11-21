Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F0F7F3186
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjKUOrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjKUOru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:47:50 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE33DD78;
        Tue, 21 Nov 2023 06:47:45 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cf59c07faeso15972805ad.2;
        Tue, 21 Nov 2023 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700578065; x=1701182865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hrIUaw040Q28vJ46MBku7kVoIioJDZQRuS5eLTGR9T8=;
        b=KFIyGPHVxWfgW4N9vo/fV6cpx+L8pfCdILAB3RZ/AmBauvV56tBhjUWV8eiCe0W+1a
         rLQce6Mi3iMkakJZA5bBXjHsPC2aOA+B77LNfL/7qDT0xYkdxqz7W03IWtwqphOSK50B
         MLWolTWHZ9pLOF8x8aBUA2g/6u6SFbKeQZppUxB8uPzHuZ+LLwngAT+0ad8R47TfqUn2
         y3F6E3caqtnFSw9dOaR2AW0berx6SNFDO7Btb8kRluyDku7G76LhtwfHqzt64BzLh4VK
         dhjLpeNrFDctY8rAFG48Ydr3H3jZQkoHB9h2VYFdpRknlSECVhr0QYt0p0sq9DpXbuTk
         8edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700578065; x=1701182865;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrIUaw040Q28vJ46MBku7kVoIioJDZQRuS5eLTGR9T8=;
        b=ttKmuSLEJrhUv8Yu3irwctEjnSH5cV+eM2FsnSvNaJNNyZNkb16+YR+HdwuM+Chd3b
         2NhPv7oyyJa6PQaPexJ3x5W0NdzmrjKGkoWU8rZcCs2r+XLosRWZ2fpz3FGq4pH/ONgK
         YDo0Ecei7Z2IwMvtRjqrriDHk7eDbTHFUq2UR8WH4dW1RbsxfHhjRzTm1qcl3Dms8oZe
         rZEWAACVnOXQjY8SLp/P99Aic3gvpM/YDBnE0YLUBj5V3IhSz5NYlja1F01t/ggtXWc8
         nQyQuc8epvha10YBMPaGTFTY77162yIv0XDTIuG2cAj+L/PrEHT2H2eRD8Z2QmfOtzNs
         7CBA==
X-Gm-Message-State: AOJu0YyBFQP9fQzcxiiSiSI2ZJI4tN78klgIHoWUjGf57lWfu6WjWHrd
        U9nIxUg8I1xfUwtAgGFA5aI=
X-Google-Smtp-Source: AGHT+IHSZFG4gzmlU6l9uvJ41jk6kx9e8yC2g3mSPO8zD4YmhAZSZiutJzOwnmtaTKmKiPDr7nRdfw==
X-Received: by 2002:a17:90b:3812:b0:281:3a9b:156 with SMTP id mq18-20020a17090b381200b002813a9b0156mr8922356pjb.1.1700578065007;
        Tue, 21 Nov 2023 06:47:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a1fca00b0028010142010sm10389086pjz.21.2023.11.21.06.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 06:47:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3c3fcc73-107f-4d88-977a-90a5465174b6@roeck-us.net>
Date:   Tue, 21 Nov 2023 06:47:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: tcpm: skip checking port->send_discover in
 PD3.0
Content-Language: en-US
To:     Guan-Yu Lin <guanyulin@google.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, kyletso@google.com, albertccwang@google.com
References: <20231116083221.1201892-1-guanyulin@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231116083221.1201892-1-guanyulin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 00:32, Guan-Yu Lin wrote:
> The original Collison Avoidance mechanism, port->send_discover, avoids
> the conflict when port partners start AMS almost the same time. However,
> this mechanism is replaced by SINK_TX_OK and SINK_TX_NG. Skip the check
> in PD3.0 to avoid the deadlock when source is requesting DR_SWAP where
> sink is requesting DISCOVER_IDENTITY.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/tcpm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 058d5b853b57..ff3c171a3a75 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2847,7 +2847,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>   					   PD_MSG_CTRL_NOT_SUPP,
>   					   NONE_AMS);
>   		} else {
> -			if (port->send_discover) {
> +			if (port->send_discover && port->negotiated_rev < PD_REV30) {
>   				tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
>   				break;
>   			}
> @@ -2863,7 +2863,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>   					   PD_MSG_CTRL_NOT_SUPP,
>   					   NONE_AMS);
>   		} else {
> -			if (port->send_discover) {
> +			if (port->send_discover && port->negotiated_rev < PD_REV30) {
>   				tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
>   				break;
>   			}
> @@ -2872,7 +2872,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>   		}
>   		break;
>   	case PD_CTRL_VCONN_SWAP:
> -		if (port->send_discover) {
> +		if (port->send_discover && port->negotiated_rev < PD_REV30) {
>   			tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
>   			break;
>   		}

