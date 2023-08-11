Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84865779AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbjHKWjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjHKWju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:39:50 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C49A2130;
        Fri, 11 Aug 2023 15:39:49 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77acb04309dso88828039f.2;
        Fri, 11 Aug 2023 15:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691793588; x=1692398388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=c+TXqEV8NQu771kL5LazpAJWWfJlDPxJd37NT7uHUws=;
        b=rhDboyym/dDLwCLkY8camD0FzQ1GzN8Lp7Yhwa3KZk7SlnftdJpbZkwAThK+UDqnVO
         ohgwRuqSQXu8Dx8q8KRmj7LRYUNmKLIMV1aLEM/RA5+jUCF0llaNCbDZN6f5tI3CqBh0
         IeN09H3Cy4Z1U9jgpLNUdFcK0IQrdxAN1UopJs4/eYjYrgVOWqOFhOLFYOEAwCToy00S
         qDGuE2gepzYFZ2VQ28RwnVUOupcgo+sNHiwqUKaydO0MILctn2GBiRPvphJN3pllAB1/
         CeTm9W8b3zAQD+9PKF734vLkMg/Qj2Hldv58DYtrn0RDyageJnvwEJmLAAsuTPhM9+Lt
         jdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691793588; x=1692398388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+TXqEV8NQu771kL5LazpAJWWfJlDPxJd37NT7uHUws=;
        b=blvzv+CbJsIJv2NywOWml6PUtY6coMue/8ZVm5VmYWuGLprZ4tGM9kx1xSjpJl83wR
         MzxbPnETCXNGE8nvmqQvFZ3yIw/o996jcYyv5t/yLPzQMqPf3RIoaQTG0kdmYozqyps4
         gWbKmy/Cyo2vkiXoAOObVxxL9IBzv6c5L26UVh+cDdX0qHMLTwNRFUazd01FDfKzw+UG
         PaBCmu//VUdKs0OWFfoSWuNEtAlCzoZFViKEvsyj05TPx8M7BAxnYopSLgkmRCmrfWgo
         xLoD19BLr/0RdiaQ/mGQea2vJPRh4hc1ZqDu16XZSFjbWEu9ZQxKnU9yu2EuVuskow4l
         r/Jg==
X-Gm-Message-State: AOJu0YxFrw1rkWy8kQgjZe6Iz0E4H3wKd/GY42rph9vCaSNqlc2mlosb
        tmC0tQKUlTehD+oNoQ/Oeqs=
X-Google-Smtp-Source: AGHT+IEo3qqY3Mv6Vl/VL1zlRqHZmYuFZipqU30ULf2l9nVXJr5KFRxUlam+bLfJi+WolG9KsJCXcA==
X-Received: by 2002:a05:6e02:1b0f:b0:349:1bcc:922a with SMTP id i15-20020a056e021b0f00b003491bcc922amr5221989ilv.5.1691793588548;
        Fri, 11 Aug 2023 15:39:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i17-20020a92c951000000b00348a5e95d47sm1406690ilq.14.2023.08.11.15.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 15:39:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5d97cb3a-aec4-1f53-0f33-fb31a9e598b2@roeck-us.net>
Date:   Fri, 11 Aug 2023 15:39:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] usb: typec: bus: verify partner exists in
 typec_altmode_attention
Content-Language: en-US
To:     RD Babiera <rdbabiera@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230811213732.3325896-1-rdbabiera@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230811213732.3325896-1-rdbabiera@google.com>
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

On 8/11/23 14:37, RD Babiera wrote:
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
> Verify the presence of a device's altmode partner before sending
> the Attention message to the Alt Mode driver.
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
> Changes since v2:
> * Changed tcpm_log message to accurately reflect error
> * Revised commit message

IMO the log message should be "no port partner", but I don't want this
to go on forever.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
> index 5a7d8cc04628..97b7b22e9cf1 100644
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
> +				tcpm_log(port, "typec_altmode_attention NULL port partner altmode");
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

