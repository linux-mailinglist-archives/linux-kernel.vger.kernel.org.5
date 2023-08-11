Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAD9779784
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbjHKTGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHKTGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:06:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C48E1BD;
        Fri, 11 Aug 2023 12:06:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdc8081147so1079635ad.1;
        Fri, 11 Aug 2023 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691780778; x=1692385578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mdisSygLrEFBuaKN/lnT3i8x0fHR+ZFOu4t7PQz6T/4=;
        b=dOJ4sr92EY6CvxViShyl0Qwq1fV2xEIu2dzpDQANqXEO/sm/Vl6KK0uxUeD2VxdBDx
         XInkWjAzhEmBS/PEixrAImArokjSLcQdYDG+64YfoxkJr1Pn4EDe8MKO7I5XeG1NL8lM
         6sv0IJSi6tmtKrLYH/WdrJLlqNuFKQ7l48HYImeKeUbc87M5H5Fj1DiEzwmha+zmoDRd
         WOdZlLqEnwUeoWuJOhAmDhb8uhohQtVHyXLG+YUutQSwO1BvnJQi63OWIycoCrJbBi2X
         gFOFdw0/dtED8RgjaTQTiTS7NI+Xcp1gEKkLpI6YJB0k0EsG7wRYROieCda8IlzUJ5le
         6lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691780778; x=1692385578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdisSygLrEFBuaKN/lnT3i8x0fHR+ZFOu4t7PQz6T/4=;
        b=FfkkJnWUFMCmgMsHClDT02wvOfvGB0r+2gu1DfF6myItPVZBFMgvi5YgwqeRaIvyyK
         y/WnLeIGzdXo69WJ4IAI+rlJoGfG/S2GPQMMzJZ9q9v1wSs4OxKA7Unc6AUoeZf2Fevt
         Jf2450ToDDabxtkxccvNfrfQkx31cNkDxsMsNwFi/Rb3OyzIit5BFmyAA2iUTQm7PTrZ
         FtCn+1efBG1O53ugigbpoptDBQVr6ssHUCshdpSogt73lrQNZTSQByPyGhYQjpTSJUNw
         InFZYJW52/fdy/dhfpBJNVE9Mp2Oohfkv81fQTjpEmoNTInfyimh1p9vp+aQGfR8SPTk
         WFvw==
X-Gm-Message-State: AOJu0YyRaC4PyXn7NwtozyEfiDFl05gjJWgAp+Eld0Ozzih7+QtskDzb
        ghMe955gL8/vHNmJlWPy6AE8+bYL1Wc=
X-Google-Smtp-Source: AGHT+IFYKwOSXUAJuweu1yxXC1+2vB8rvsMccvVLtZlsK58oRaIgI1FwKkbTF+9uHIstyEoIuArCzA==
X-Received: by 2002:a17:902:ea03:b0:1bd:c32e:df59 with SMTP id s3-20020a170902ea0300b001bdc32edf59mr1899914plg.9.1691780777622;
        Fri, 11 Aug 2023 12:06:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ea8300b001b672af624esm140338plb.164.2023.08.11.12.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 12:06:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b578e753-b2bf-93eb-ebd3-968d3183901d@roeck-us.net>
Date:   Fri, 11 Aug 2023 12:06:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] usb: typec: bus: verify partner exists in
 typec_altmode_attention
Content-Language: en-US
To:     RD Babiera <rdbabiera@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230811184754.1886458-1-rdbabiera@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230811184754.1886458-1-rdbabiera@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 11:47, RD Babiera wrote:
> Some usb hubs will negotiate DisplayPort Alt mode with the device
> but will then negotiate a data role swap after entering the alt
> mode. The data role swap causes the device to unregister all alt
> modes, however the usb hub will still send Attention messages
> even after failing to reregister the Alt Mode. type_altmode_attention
> currently does not verify whether or not a device's altmode partner
> exists, which results in a NULL pointer error when dereferencing
> the typec_altmode and typec_altmode_ops belonging to the altmode
> partner.
> 
> This patch verifies the presence of a device's altmode partner

s/This patch verifies/Verify/

> before sending the Attention message to the Alt Mode driver.
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
> Changes since v1:
> * Only assigns pdev if altmode partner exists in typec_altmode_attention
> * Removed error return in typec_altmode_attention if Alt Mode does
>    not implement Attention messages.
> * Changed tcpm_log message to indicate that altmode partner does not exist,
>    as it only logs in that case.
> ---
>   drivers/usb/typec/bus.c           | 12 ++++++++++--
>   drivers/usb/typec/tcpm/tcpm.c     |  5 ++++-
>   include/linux/usb/typec_altmode.h |  2 +-
>   3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index fe5b9a2e61f5..e95ec7e382bb 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -183,12 +183,20 @@ EXPORT_SYMBOL_GPL(typec_altmode_exit);
>    *
>    * Notifies the partner of @adev about Attention command.
>    */
> -void typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
> +int typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
>   {
> -	struct typec_altmode *pdev = &to_altmode(adev)->partner->adev;
> +	struct altmode *partner = to_altmode(adev)->partner;
> +	struct typec_altmode *pdev;
> +
> +	if (!partner)
> +		return -ENODEV;
> +
> +	pdev = &partner->adev;
>   
>   	if (pdev->ops && pdev->ops->attention)
>   		pdev->ops->attention(pdev, vdo);
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(typec_altmode_attention);
>   
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5a7d8cc04628..b0328e922989 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1791,6 +1791,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>   	u32 p[PD_MAX_PAYLOAD];
>   	u32 response[8] = { };
>   	int i, rlen = 0;
> +	int ret;
>   
>   	for (i = 0; i < cnt; i++)
>   		p[i] = le32_to_cpu(payload[i]);
> @@ -1877,7 +1878,9 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>   			}
>   			break;
>   		case ADEV_ATTENTION:
> -			typec_altmode_attention(adev, p[1]);
> +			ret = typec_altmode_attention(adev, p[1]);
> +			if (ret)
> +				tcpm_log(port, "typec_altmode_attention invalid port partner");

Invalid ? The code suggests that there is no port partner.

Guenter

>   			break;
>   		}
>   	}
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index 350d49012659..28aeef8f9e7b 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -67,7 +67,7 @@ struct typec_altmode_ops {
>   
>   int typec_altmode_enter(struct typec_altmode *altmode, u32 *vdo);
>   int typec_altmode_exit(struct typec_altmode *altmode);
> -void typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
> +int typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
>   int typec_altmode_vdm(struct typec_altmode *altmode,
>   		      const u32 header, const u32 *vdo, int count);
>   int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,
> 
> base-commit: f176638af476c6d46257cc3303f5c7cf47d5967d

